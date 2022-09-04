import 'dart:io';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:collection/collection.dart';
import 'package:open_file/open_file.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/message/i_message_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/thread/i_thread_repository.dart';
import 'package:code/domain/thread/thread_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/i_rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';

import '../../global_regexp.dart';

class ThreadTypeBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final IThreadRepository _iThreadRepository;
  final InMemoryData inMemoryData;
  final SharedPreferencesManager _prefs;
  final IRTCManager _irtcManager;
  final IMessageRepository _iMessageRepository;
  final IFileRepository _iFileRepository;
  final IUserRepository _iUserRepository;
  final IChannelRepository _iChannelRepository;

  ThreadTypeBloC(
      this._iThreadRepository,
      this.inMemoryData,
      this._prefs,
      this._irtcManager,
      this._iMessageRepository,
      this._iFileRepository,
      this._iChannelRepository,
      this._iUserRepository);

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _threadController.close();
    messageArrivedForThisThread.close();
    popToHome.close();
  }

  BehaviorSubject<ThreadModel> _threadController = new BehaviorSubject();

  Stream<ThreadModel> get threadResult => _threadController.stream;

  BehaviorSubject<bool> popToHome = new BehaviorSubject();

  bool isBeingFollowed = false;

  MessageModel? currentMessageSelected;

  List<MemberModel> members = [];
  bool publishInChannel = false;
  late ChannelModel channelModel;
  MessageModel? messageModel;
  String currentTeamId = '';

  void loadThread(String threadId, ChannelModel channelModel,
      {MessageModel? messageModel}) async {
    members = inMemoryData.getMembers();
    this.channelModel = channelModel;
    this.messageModel = messageModel;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (messageModel != null) {
      final ThreadModel threadModel = ThreadModel(
          tid: currentTeamId,
          cid: channelModel.id,
          pmid: messageModel.id,
          uid: messageModel.uid,
          participants: [],
          tsLastReadByUser: DateTime.now(),
          tsLastReply: DateTime.now(),
          numReplies: 0,
          parentMessage: messageModel,
          childMessages: []);
      _threadController.sinkAddSafe(threadModel);
    } else {
      final res = await _iThreadRepository.getThread(currentTeamId, threadId);
      if (res is ResultSuccess<ThreadModel>) {
        res.value.childMessages =
            await _resolveFolderReferences(res.value.childMessages);
        res.value.childMessages.forEach((element) {
          element.messageStatus = MessageStatus.Sent;
        });
        _threadController.sinkAddSafe(res.value);
      }
      markAsRead(threadId);
    }
  }

  void checkIsBeingFollowed(String threadId, bool comeFromThreadPage) async {
    if (!comeFromThreadPage) {
      isLoading = true;
      final res = await _iThreadRepository.getThreads();
      if (res is ResultSuccess<List<ThreadModel>>) {
        res.value.forEach((element) {
          if (threadId == element.pmid) {
            isBeingFollowed = true;
            isLoading = false;
            return;
          }
        });
      }
      isLoading = false;
    } else {
      isBeingFollowed = true;
    }
  }

  void sendMessageThread(String text, TeamJoinedModel joinedTeam,
      List<DrawerChatModel> drawerChatList) async {
    Iterable<RegExpMatch> matches =
        GlobalRegexp.folderLink.allMatches(text).toList();
    final thread = _threadController.valueOrNull;
    if (thread != null) {
      if (matches.isEmpty) {
        _irtcManager.sendMessageThread(
            text, thread.pmid, publishInChannel, channelModel.id);
      } else {
        List<Map<String, String>> folders = [];
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
                  cid = d.channelModel!.id;
                else if (d.subtitle == channel) cid = d.channelModel!.id;
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
            text =
                text.replaceFirst(fullUrl!, "*(${R.string.folderNotFound})*");
          }
        });
        _irtcManager.sendMessageThread(
            text, thread.pmid, publishInChannel, channelModel.id,
            folders: folders);
      }
    }
  }

  BehaviorSubject<bool> messageArrivedForThisThread = BehaviorSubject();
  void onMessageArrived(MessageModel messageModel) async {
    final thread = _threadController.valueOrNull;
    if (messageModel.threadMetaChild == null || thread == null) return;
    if (thread.pmid == messageModel.threadMetaChild?.pmid) {
      if (messageModel.messageStatus == MessageStatus.Updated) {
        final index = thread.childMessages
            .indexWhere((element) => element.id == messageModel.id);
        if (index >= 0) {
          thread.childMessages[index] = messageModel;
        }
        // streamData.messageWrapperModel.list.forEach((element) {
        //   if (element.threadMetaParent != null &&
        //       element.threadMetaChild != null &&
        //       element.threadMetaChild.pmid == message.id) {
        //     element.threadMetaParent.message = message.text;
        //   }
        // });
      } else {
        thread.childMessages.add(messageModel);
      }
      _threadController.sinkAddSafe(thread);
      messageArrivedForThisThread.sinkAddSafe(true);
      if ((thread.tsLastReadByUser
                  ?.compareTo(messageModel.edited ?? messageModel.ts!) ??
              -1) <
          0) markAsRead(thread.pmid);
    }
  }

  Future<bool> markAsRead(String threadId) async {
    final res = await _iThreadRepository.markAsRead(currentTeamId, threadId);
    if (res is ResultSuccess<bool> && res.value) {
      return true;
    }
    return false;
  }

  Future<bool> unfollow(String threadId) async {
    isLoading = true;
    final res = await _iThreadRepository.unFollow(currentTeamId, threadId);
    isLoading = false;
    if (res is ResultSuccess<bool> && res.value) {
      return true;
    }
    showErrorMessageFromString("Operation Error");
    return false;
  }

  Future<bool> follow(String threadId) async {
    final res = await _iThreadRepository.follow(currentTeamId, threadId);
    if (res is ResultSuccess<bool> && res.value) {
      return true;
    }
    showErrorMessageFromString("Operation Error");
    return false;
  }

  void onThreadDeleted(MessageDeletedModel model) {
    final streamData = _threadController.valueOrNull;
    if (streamData != null && streamData.pmid == model.pmid) {
      streamData.childMessages.removeWhere((element) => element.id == model.id);
      _threadController.sinkAddSafe(streamData);
    }
  }

  void deleteThreadMessage() async {
    final streamData = _threadController.valueOrNull;
    if (streamData != null && currentMessageSelected != null) {
      final res = await _iMessageRepository.deleteMessage(
          inMemoryData.currentTeam!.id,
          inMemoryData.currentChannel!.id,
          currentMessageSelected!.id);
      if (res is ResultSuccess<bool> && res.value) {
        streamData.childMessages.removeWhere(
          (element) => element.id == currentMessageSelected?.id,
        );
        _threadController.sinkAddSafe(streamData);
        currentMessageSelected = null;
      } else {
        showErrorMessage(res);
      }
    }
  }

  void downloadFile() async {
    final threadsList = _threadController.valueOrNull;
    if (threadsList != null) {
      final mIndex = threadsList.childMessages
          .indexWhere((element) => element.id == currentMessageSelected?.id);
      currentMessageSelected?.fileModel?.isUploadingDownloading = true;
      threadsList.childMessages[mIndex] = currentMessageSelected!;
      _threadController.sinkAddSafe(threadsList);

      final res = await _iFileRepository
          .downloadFile(currentMessageSelected!.fileModel!);
      if (res is ResultSuccess<File>) {
        await OpenFile.open(res.value.path);
      }
      final mIndex1 = threadsList.childMessages
          .indexWhere((element) => element.id == currentMessageSelected?.id);
      currentMessageSelected?.fileModel?.isUploadingDownloading = false;
      threadsList.childMessages[mIndex1] = currentMessageSelected!;
      _threadController.sinkAddSafe(threadsList);
    }
  }

  void addRemoveReaction(String reactionKey) async {
    if(currentMessageSelected != null) {
      _iMessageRepository.addRemoveReaction(currentMessageSelected!.tid,
          currentMessageSelected!.cid, currentMessageSelected!.id, reactionKey);
    }
  }

  void updateMessageTextAfterEdit(MessageModel model) {
    final threadList = _threadController.valueOrNull;
    if (threadList != null) {
      final mIndex = threadList.childMessages
          .indexWhere((element) => element.id == model.id);
      threadList.childMessages[mIndex].text = model.text;
      threadList.childMessages[mIndex].html = model.html;
      _threadController.sinkAddSafe(threadList);
    }
  }

  void onMentionClicked(String username) async {
    if (username.isNotEmpty &&
        username != 'channel' &&
        username != 'all' &&
        username != inMemoryData.currentMember?.profile?.name) {
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
    ThreadModel? threadModel = _threadController.valueOrNull;
    if (threadModel != null) {
      folder.deleted = true;
      threadModel.childMessages.forEach((message) {
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
      _threadController.sinkAddSafe(threadModel);
    }
  }

  void onFolderRenamed(FolderModel folder) {
    ThreadModel? threadModel = _threadController.valueOrNull;
    if (threadModel != null) {
      threadModel.childMessages.forEach((message) {
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
      _threadController.sinkAddSafe(threadModel);
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
    await Future.forEach<MessageModel>(messages, (element) async {
      if (element.isFolderUploadMessage || element.isFolderShareMessage) {
        final folder = loadedFolders[element.args?.id];
        if (folder == null) {
          final resF = await _iFileRepository.getFolderReference(
              element.args!.tid, element.args!.cid, element.args!.id);
          if (resF is ResultSuccess<FolderModel>) {
            element.args!.path = resF.value.path;
            element.args!.folderRenamed = resF.value.renamed;
          } else if (resF is ResultError &&
              (resF as ResultError).code == RemoteConstants.code_not_found) {
            element.args!.folderDeleted = true;
          }
          loadedFolders[element.args!.id] = FolderModel(
            id: element.args!.id,
            cid: element.args!.cid,
            tid: element.args!.tid,
            renamed: element.args!.folderRenamed,
            path: element.args!.path,
            deleted: element.args!.folderDeleted ?? false,
          );
        } else {
          element.args!.path = folder.path;
          element.args!.folderRenamed = folder.renamed;
          element.args!.folderDeleted = folder.deleted;
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
