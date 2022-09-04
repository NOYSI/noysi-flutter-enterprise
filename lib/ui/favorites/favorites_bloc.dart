import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/message/i_message_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';

import '../home/home_ui_model.dart';

class FavoritesBloC extends BaseBloC with ErrorHandlerBloC, LoadingBloC {
  final IMessageRepository _iMessageRepository;
  final IChannelRepository _iChannelRepository;
  final IUserRepository _iUserRepository;
  final IFileRepository _iFileRepository;
  final SharedPreferencesManager _prefs;
  final InMemoryData inMemoryData;

  FavoritesBloC(this._iMessageRepository, this._prefs, this.inMemoryData,
      this._iChannelRepository, this._iUserRepository, this._iFileRepository);

  BehaviorSubject<List<FavoriteItem>> _favoritesController = BehaviorSubject();

  Stream<List<FavoriteItem>> get favoritesResult => _favoritesController.stream;

  BehaviorSubject<bool> popToHome = new BehaviorSubject();

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _favoritesController.close();
    popToHome.close();
  }

  String currentTeamId = '';
  List<ChannelModel> channels = [];
  List<MemberModel> members = [];
  MessageModel? currentMessageSelected;

  void initView(TeamJoinedModel joinedTeam) async {
    isLoading = true;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    channels.addAll(
        joinedTeam.channels + joinedTeam.groups + joinedTeam.messages1x1);
    members.addAll(joinedTeam.memberWrapperModel.list);
    List<FavoriteItem> l = [];
    final res = await _iMessageRepository.getFavorites();
    if (res is ResultSuccess<List<MessageModel>>) {
      final resolved = await _resolveFolderReferences(res.value);
      resolved.sort((a, b) {
        if(a.ts != null && b.ts != null) return b.ts!.compareTo(a.ts!);
        else if (a.ts == null && b.ts != null) return 1;
        else if (a.ts != null && b.ts == null) return -1;
        else return 0;
      });
      resolved.forEach((message) {
        message.messageStatus = MessageStatus.Sent;
        message.favorite = true;
        l.add(FavoriteItem(
          message: message,
          channel: channels.firstWhereOrNull((element) => element.id == message.cid) ?? ChannelModel(),
          member: members.firstWhereOrNull((element) => element.id == message.uid) ?? MemberModel(),
        ));
      });
    }
    _favoritesController.sinkAddSafe(l);
    isLoading = false;
  }

  void unsetFavorite(String mid) {
    _iMessageRepository.setFavorite(mid);
  }

  void onMessageEdited(MessageModel message) {
    if (message.tid == currentTeamId) {
      final favorites = _favoritesController.valueOrNull ?? [];
      final editedFav = favorites.firstWhereOrNull(
          (element) => element.message.id == message.id);
      if (editedFav != null) {
        editedFav.message = message;
      } else if (message.favorite) {
        favorites.add(FavoriteItem(
            message: message,
            channel: channels.firstWhereOrNull((element) => element.id == message.cid) ?? ChannelModel(),
          member: members.firstWhereOrNull((element) => element.id == message.uid) ?? MemberModel(),
        ));
        favorites.sort((a, b) {
          if(a.message.ts != null && b.message.ts != null) return b.message.ts!.compareTo(a.message.ts!);
          else if(a.message.ts == null && b.message.ts != null) return 1;
          else if(a.message.ts != null && b.message.ts == null) return -1;
          else return 0;
        });
      }
      _favoritesController.sinkAddSafe(favorites);
    }
  }

  void addRemoveReaction(String reactionKey) async {
    if(currentMessageSelected != null) {
      _iMessageRepository.addRemoveReaction(currentMessageSelected?.tid ?? "",
          currentMessageSelected?.cid ?? "", currentMessageSelected?.id ?? "", reactionKey);
    }
  }

  void onMessageTap(MessageModel messageModel) async {
    final res = await _iChannelRepository.getChannel(currentTeamId, messageModel.cid);
    if (res is ResultSuccess<ChannelModel>) {
      popToHome.sinkAddSafe(true);
      changeChannelAutoController.sinkAddSafe(ChannelCreatedUI(
          members: [],
          channelModel: res.value,
          lastReadMessage: messageModel,
          fromSearchMessage: true));
    } else
      showErrorMessage(res);
  }

  void onMentionClicked(String username) async {
    if (username.isNotEmpty &&
        username != 'channel' &&
        username != 'all' &&
        username != inMemoryData.currentMember?.profile?.name) {
      final membersInMemory =
          inMemoryData.getMembers(excludeMe: true, teamId: currentTeamId);
      final memberIsInMemory = membersInMemory.firstWhereOrNull(
          (element) => element.profile?.name == username);
      if (memberIsInMemory == null) {
        final membersQuery = await _iUserRepository.getTeamMembers(
            currentTeamId,
            max: 1,
            offset: 0,
            action: "search",
            active: true,
            query: username);
        if (membersQuery is ResultSuccess<MemberWrapperModel> &&
            membersQuery.value.list.isNotEmpty &&
            membersQuery.value.list[0].profile?.name == username) {
          final member = membersQuery.value.list[0];
          final res = await _iChannelRepository.create1x1Channel(member);
          if (res is ResultSuccess<ChannelModel>) {
            popToHome.sinkAddSafe(true);
            changeChannelAutoController.sinkAddSafe(
                ChannelCreatedUI(members: [member], channelModel: res.value));
          } else {
            //showErrorMessage(res);
          }
        }
      } else {
        final res =
            await _iChannelRepository.create1x1Channel(memberIsInMemory);
        if (res is ResultSuccess<ChannelModel>) {
          popToHome.sinkAddSafe(true);
          changeChannelAutoController.sinkAddSafe(ChannelCreatedUI(
              members: [memberIsInMemory], channelModel: res.value));
        } else {
          //showErrorMessage(res);
        }
      }
    }
  }

  Future<FolderModel?> resolveFolderReference(
      String tid, String cid, String id) async {
    isLoading = true;
    final res = await _iFileRepository.getFolderReference(tid, cid, id);
    isLoading = false;
    if (res is ResultSuccess<FolderModel>) {
      return res.value;
    }
    return null;
  }

  ///Resolving folder reference
  Map<String, FolderModel> loadedFolders = Map();
  Future<List<MessageModel>> _resolveFolderReferences(
      List<MessageModel> messages) async {
    await Future.forEach<MessageModel>(messages,
            (element) async {
          if (element.isFolderUploadMessage || element.isFolderShareMessage) {
            final folder = loadedFolders[element.args?.id ?? ""];
            if (folder == null) {
              final resF = await _iFileRepository.getFolderReference(
                  element.args?.tid ?? "", element.args?.cid ?? "", element.args?.id ?? "");
              if (resF is ResultSuccess<FolderModel>) {
                element.args?.path = resF.value.path;
                element.args?.folderRenamed = resF.value.renamed;
              } else if (resF is ResultError && (resF as ResultError).code == RemoteConstants.code_not_found) {
                element.args?.folderDeleted = true;
              }
              loadedFolders[element.args?.id ?? ""] = FolderModel(
                id: element.args?.id ?? "",
                cid: element.args?.cid ?? "",
                tid: element.args?.tid ?? "",
                renamed: element.args?.folderRenamed,
                path: element.args?.path ?? "",
                deleted: element.args?.folderDeleted ?? false,
              );
            } else {
              element.args?.path = folder.path;
              element.args?.folderRenamed = folder.renamed;
              element.args?.folderDeleted = folder.deleted;
            }
          } else if (element.isFolderLinkMessage) {
            await Future.forEach<FolderModel>(element.folders, (folder) async {
              final f = loadedFolders[folder.id];
              if (f == null) {
                final resM = await _iFileRepository.getFolderReference(
                    folder.tid, folder.cid, folder.id);
                if (resM is ResultSuccess<FolderModel>) {
                  folder.path = resM.value.path;
                  folder.renamed = resM.value.renamed;
                } else if (resM is ResultError && (resM as ResultError).code == RemoteConstants.code_not_found) {
                  folder.deleted = true;
                }
                loadedFolders[folder.id] = FolderModel(
                  id: folder.id,
                  cid: folder.cid,
                  tid: folder.tid,
                  renamed: folder.renamed,
                  path: folder.path,
                  deleted: folder.deleted,
                );
              } else {
                folder.path = f.path;
                folder.renamed = f.renamed;
                folder.deleted = f.deleted;
              }
            });
          }
        });
    return messages;
  }

  void onFolderDeleted(FolderModel folder) {
    final favorites = _favoritesController.valueOrNull ?? [];
    folder.deleted = true;
    favorites.forEach((item) {
      final message = item.message;
      if (message.isFolderLinkMessage) {
        message.folders.forEach((element) {
          if (element.id == folder.id) element.deleted = true;
        });
      } else if (message.isFolderUploadMessage ||
          message.isFolderShareMessage) {
        if (message.args?.id == folder.id) message.args?.folderDeleted = true;
      }
    });
    loadedFolders[folder.id] = folder;
    _favoritesController.sinkAddSafe(favorites);
  }

  void onFolderRenamed(FolderModel folder) {
    final favorites = _favoritesController.valueOrNull ?? [];
    favorites.forEach((item) {
      final message = item.message;
      if (message.isFolderLinkMessage) {
        message.folders.forEach((element) {
          if (element.id == folder.id) {
            element.renamed = folder.renamed;
            element.path = folder.path;
          }
        });
      } else if (message.isFolderUploadMessage ||
          message.isFolderShareMessage) {
        if (message.args?.id == folder.id) {
          message.args?.folderRenamed = folder.renamed;
          message.args?.path = folder.path;
        }
      }
    });
    loadedFolders[folder.id] = folder;
    _favoritesController.sinkAddSafe(favorites);
  }

  Future<ChannelModel?> getChannelFromId(String cid) async {
    final res = await _iChannelRepository.getChannel(currentTeamId, cid);
    if(res is ResultSuccess<ChannelModel>)
      return res.value;
    return null;
  }
}

class FavoriteItem {
  MessageModel message;
  ChannelModel channel;
  MemberModel member;

  FavoriteItem({required this.message, required this.channel, required this.member});
}
