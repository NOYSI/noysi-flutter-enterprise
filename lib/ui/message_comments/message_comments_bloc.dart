import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
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
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';
import 'package:collection/collection.dart';

import '../../global_regexp.dart';

class MessageCommentsBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IMessageRepository _iMessageRepository;
  final InMemoryData inMemoryData;
  final IUserRepository _iUserRepository;
  final IFileRepository _iFileRepository;
  final IChannelRepository _iChannelRepository;
  final SharedPreferencesManager _prefs;

  MessageCommentsBloC(
      this._iMessageRepository,
      this.inMemoryData,
      this._iChannelRepository,
      this._iUserRepository,
      this._iFileRepository,
      this._prefs);

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _messageCommentsController.close();
    _parentMessageController.close();
    popToHome.close();
  }

  BehaviorSubject<List<MessageComment>?> _messageCommentsController =
      new BehaviorSubject();

  Stream<List<MessageComment>?> get messageCommentsResult =>
      _messageCommentsController.stream;

  BehaviorSubject<MessageModel> _parentMessageController = BehaviorSubject();

  Stream<MessageModel> get parentMessageResult =>
      _parentMessageController.stream;

  BehaviorSubject<bool> popToHome = new BehaviorSubject.seeded(false);

  List<MemberModel> members = [];
  MessageModel? currentMessageSelected;
  MessageModel? parentMessage;

  void getMessageComments({
    MessageModel? messageModel,
    String tid = '',
    String cid = '',
    String mid = '',
  }) async {
    isLoading = true;
    if (messageModel == null) {
      final res = await _iMessageRepository.getMessage(tid, cid, mid);
      if (res is ResultSuccess<MessageModel>) parentMessage = res.value;
    } else {
      parentMessage = messageModel;
    }
    _parentMessageController.sinkAddSafe(parentMessage!);
    members = inMemoryData.getMembers();
    final res = await _iMessageRepository.getMessageComments(
        parentMessage?.tid ?? "",
        parentMessage?.cid ?? "",
        parentMessage?.isFile == true
            ? parentMessage?.fileModel?.id ?? ""
            : parentMessage?.tid ?? "");
    if (res is ResultSuccess<List<MessageComment>>) {
      List<MessageComment> l = await _resolveFolderReferences(res.value);
      _messageCommentsController.sinkAddSafe(l);
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void postMessageComment(String text, TeamJoinedModel joinedTeam,
      List<DrawerChatModel> drawerChatList) async {
    isLoading = true;
    Iterable<RegExpMatch> matches =
        GlobalRegexp.folderLink.allMatches(text).toList();
    List<Map<String, String>> folders = [];
    if (matches.isNotEmpty) {
      matches.forEach((element) {
        final fullUrl = element.group(0);
        final team = Uri.decodeFull(element.group(5)!);
        if (team == joinedTeam.team.name) {
          final channel = Uri.decodeFull(element.group(6)!);
          String path = Uri.decodeFull(element.group(7)!);
          if (!path.endsWith('/')) path = "$path/";
          final folderName = path.split('/')[path.split('/').length - 2];
          String? cid;
          for (int i = 0; i < drawerChatList.length && cid == null; i++) {
            final d = drawerChatList[i];
            if (d.isChild) {
              if (d.title == channel)
                cid = d.channelModel?.id;
              else if (d.subtitle == channel) cid = d.channelModel?.id;
            }
          }
          if (cid != null && cid.isNotEmpty) {
            bool found = false;
            for (int i = 0; i < folders.length && !found; i++) {
              if (folders[i]['path'] == path) found = true;
            }
            if (!found) {
              folders.add({
                'cid': cid,
                'path': path,
              });
            }
            text = text.replaceFirst(fullUrl!, "*$folderName*");
          } else {
            text =
                text.replaceFirst(fullUrl!, "*(${R.string.folderNotFound})*");
          }
        } else {
          text = text.replaceFirst(fullUrl!, "*(${R.string.folderNotFound})*");
        }
      });
    }
    final res = await _iMessageRepository.postMessageComment(
        parentMessage!.tid, parentMessage!.cid, parentMessage!.id, text,
        folders: folders);
    if (res is ResultSuccess<bool>) {
      getMessageComments(messageModel: parentMessage);
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  ///Conform permanent link
  Future<String> conformMessageLink() async {
    final teamId = inMemoryData.currentTeam?.id;
    final messageId = currentMessageSelected?.id;
    final cname = await _prefs.getStringValue(_prefs.currentTeamCname);
    final baseUrl =
        cname.isNotEmpty ? "https://$cname" : Injector.instance.baseUrl;
    return "$baseUrl/a/#/messages/$teamId/${inMemoryData.currentChannel?.id}/$messageId";
  }

  void updateMessageTextAfterEdit(MessageModel model) {
    final list = _messageCommentsController.valueOrNull ?? [];
    final mIndex = list.indexWhere((element) => element.id == model.id);
    list[mIndex].text = model.text;
    list[mIndex].html = model.html;
    _messageCommentsController.sinkAddSafe(list);
  }

  void addRemoveReaction(String reactionKey) async {
    if(currentMessageSelected != null) {
      await _iMessageRepository.addRemoveReaction(currentMessageSelected!.tid,
          currentMessageSelected!.cid, currentMessageSelected!.id, reactionKey);
      getMessageComments(messageModel: parentMessage);
    }
  }

  void deleteMessage() async {
    final list = _messageCommentsController.valueOrNull ?? [];
    if (currentMessageSelected != null) {
      final res = await _iMessageRepository.deleteMessage(
          inMemoryData.currentTeam!.id,
          inMemoryData.currentChannel!.id,
          currentMessageSelected!.id);
      if (res is ResultSuccess<bool> && res.value) {
        list.removeWhere((element) => element.id == currentMessageSelected!.id);
        _messageCommentsController.sinkAddSafe(list);
        currentMessageSelected = null;
      } else {
        showErrorMessage(res);
      }
    }
  }

  void onMentionClicked(String username) async {
    if (username.isNotEmpty &&
        username != 'channel' &&
        username != 'all' &&
        username != inMemoryData.currentMember!.profile!.name) {
      final membersInMemory = inMemoryData.getMembers(
          excludeMe: true, teamId: inMemoryData.currentTeam?.id);
      final memberIsInMemory = membersInMemory
          .firstWhereOrNull((element) => element.profile?.name == username);
      if (memberIsInMemory == null) {
        final membersQuery = await _iUserRepository.getTeamMembers(
            inMemoryData.currentTeam!.id,
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

  void onFolderDeleted(FolderModel folder) {
    List<MessageComment> comments = _messageCommentsController.valueOrNull ?? [];
    folder.deleted = true;
    comments.forEach((message) {
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
    _messageCommentsController.sinkAddSafe(comments);
  }

  void onFolderRenamed(FolderModel folder) {
    List<MessageComment> comments = _messageCommentsController.valueOrNull ?? [];
    comments.forEach((message) {
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
    _messageCommentsController.sinkAddSafe(comments);
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

  Future<List<MessageComment>> _resolveFolderReferences(
      List<MessageComment> messages) async {
    await Future.forEach<MessageComment>(messages, (element) async {
      if (element.isFolderUploadMessage || element.isFolderShareMessage) {
        final folder = loadedFolders[element.args?.id];
        if (folder == null) {
          final resF = await _iFileRepository.getFolderReference(
              element.args!.tid, element.args!.cid, element.args!.id);
          if (resF is ResultSuccess<FolderModel>) {
            element.args?.path = resF.value.path;
            element.args?.folderRenamed = resF.value.renamed;
          } else if (resF is ResultError &&
              (resF as ResultError).code == RemoteConstants.code_not_found) {
            element.args?.folderDeleted = true;
          }
          loadedFolders[element.args!.id] = FolderModel(
            id: element.args!.id,
            cid: element.args!.cid,
            tid: element.args!.tid,
            renamed: element.args!.folderRenamed,
            path: element.args!.path,
            deleted: element.args!.folderDeleted!,
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
            } else if (resM is ResultError &&
                (resM as ResultError).code == RemoteConstants.code_not_found) {
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
}
