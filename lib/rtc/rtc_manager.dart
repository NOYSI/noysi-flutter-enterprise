import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:code/_res/values/config.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/connectivity_manager.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/activity/activity_model.dart';
import 'package:code/domain/activity/i_activity_converter.dart';
import 'package:code/domain/app_common_model.dart';
import 'package:code/domain/channel/i_channel_converter.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_converter.dart';
import 'package:code/domain/message/i_message_converter.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/task/i_task_converter.dart';
import 'package:code/domain/team/i_team_converter.dart';
import 'package:code/domain/user/i_user_converter.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:code/utils/extensions.dart';

import '../domain/task/task_model.dart';
import 'i_rtc_manager.dart';

PublishSubject<MessageModel> onMessageReceivedController = PublishSubject();
PublishSubject<ChannelCreatedUI> changeChannelAutoController = PublishSubject();
PublishSubject<MessageDeletedModel> onMessageDeletedController =
    PublishSubject();
PublishSubject<MessageDeletedModel> onNotifyThreadController = PublishSubject();
PublishSubject<RTCPresenceChangeModel> onUserPresenceChangeController =
    PublishSubject();
PublishSubject<RTCUserTypingModel> onUserTypingChannelController =
    PublishSubject();
PublishSubject<RTCUserTypingModel> onUserTypingThreadController =
    PublishSubject();
PublishSubject<RTCTaskCreatedUpdated> onTaskCreatedUpdated = PublishSubject();
PublishSubject<UutModel> onTaskEventMarked = PublishSubject();
PublishSubject<RTCChannelRenamed> onChannelRenamed = PublishSubject();
PublishSubject<RTCChannelMarked> onChannelMarked = PublishSubject();
PublishSubject<RTCChannelLeftDeleted> onChannelLeftDeleted = PublishSubject();
PublishSubject<RTCChannelOpened> onChannelOpened = PublishSubject();
PublishSubject<RTCChannelCreated> onChannelCreated = PublishSubject();
PublishSubject<FolderModel?> onFolderRenamedController = PublishSubject();
PublishSubject<FolderModel?> onFolderDeletedController = PublishSubject();
PublishSubject<RTCFileDeletedModel?> onFileDeletedController = PublishSubject();
PublishSubject<FileModel?> onFileFolderCreatedController = PublishSubject();
PublishSubject<RTCMemberDisabledEnabledModel?> onMemberDisabledEnabled =
    PublishSubject();
PublishSubject<RTCActivityModel?> onActivityEventArrived = PublishSubject();
PublishSubject<SessionModel> onSignedIn = PublishSubject();
PublishSubject<String> onSignedOut = PublishSubject();
PublishSubject<RTCStatusSet> onStatusSet = PublishSubject();
PublishSubject<RTCChannelNotificationUpdated> onChannelNotificationsUpdated =
    PublishSubject();
PublishSubject<RTCMemberNotificationsUpdated> onMemberNotificationsUpdated =
    PublishSubject();
PublishSubject<RTCMemberRoleUpdated> onMemberRoleUpdated = PublishSubject();
PublishSubject<String> onTeamDisabled = PublishSubject();
PublishSubject<RTCTeamUpdated> onTeamUpdatedController = PublishSubject();
PublishSubject<RTCTeamThemeUpdated> onTeamThemeUpdatedController =
    PublishSubject();
PublishSubject<RTCTeamPhotoUpdated> onTeamPhotoUpdatedController =
    PublishSubject();
PublishSubject<RTCMessagePinnedUnpinned> onMessagePinnedUnpinned =
    PublishSubject();

//PublishSubject<MessageModel> onThreadMessageReceivedController = PublishSubject();
//PublishSubject<MessageModel> onThreadSingleMessageReceivedController = PublishSubject();

PublishSubject<RTCUserTypingModel> onUserPhotoUploadedController =
    PublishSubject();

PublishSubject<RTCMemberUpdated> onMemberProfileUpdatedController =
    PublishSubject();

PublishSubject<RTCCallModel> onWebRTCEventController = PublishSubject();

PublishSubject<RTCTeamJoinedModel> onTeamJoined = PublishSubject();

PublishSubject<RTCUserDeleted> onUserDeleted = PublishSubject();

BehaviorSubject<bool> onWSSReconnected = BehaviorSubject.seeded(false);

class RTCManager implements IRTCManager {
  final SharedPreferencesManager _prefs;
  final IMessageConverter _iMessageConverter;
  final IUserConverter _iUserConverter;
  final IFileConverter _iFileConverter;
  final IChannelConverter _iChannelConverter;
  final IActivityConverter _iActivityConverter;
  final ITeamConverter _iTeamConverter;
  final ITaskConverter _iTaskConverter;
  final InMemoryData _inMemoryData;
  final ConnectivityManager _connectivityManager;
  final NetworkHandler _networkHandler;

  RTCManager(
      this._prefs,
      this._iMessageConverter,
      this._inMemoryData,
      this._connectivityManager,
      this._iChannelConverter,
      this._iUserConverter,
      this._iFileConverter,
      this._networkHandler,
      this._iTeamConverter,
      this._iTaskConverter,
      this._iActivityConverter);

  IOWebSocketChannel? _channel;
  String wssUrl = "";
  List<MessageModel> _pendingMessages = [];
  // List<MessageModel> _pendingThreadMessages = [];

  bool firstInitCompleted = false;

  StreamSubscription? wssStreamSubscription;

  @override
  void initRTC() async {
    wssUrl = await _prefs.getStringValue(_prefs.wss);
    try {
      if (_channel == null) {
        _channel = IOWebSocketChannel.connect(wssUrl,
            pingInterval: Duration(seconds: 10));
        _listenRTC();
      }
    } catch (ex) {
      // print("WSS ERROR => DISCONECTED. initRT");
      // Fluttertoast.showToast(msg: "WSS ERROR => DISCONECTED. initRT");
    }
  }

  @override
  void disposeRTC() {
    Future.delayed(Duration(milliseconds: 200), () {
      sendWssPresence(UserPresence.offline);
      Future.delayed(Duration(milliseconds: 200), () {
        _channel?.innerWebSocket?.close();
        wssStreamSubscription?.cancel();
        _channel = null;
      });
    });
  }

  Future<void> resolveMember(String memberId, {String? teamId}) async {
    final member = _inMemoryData.getMember(memberId);
    if (member == null) {
      await _inMemoryData.resolveMembersAsync([memberId], teamId: teamId);
    }
  }

  void _listenRTC() async {
    wssStreamSubscription = _channel?.stream.listen((wssData) async {
//      print("WSS => RECEIVING INFO");
      final json = jsonDecode(wssData);
      String type = json["type"];
      print(json);

      if (type == 'hello') {
        if (!firstInitCompleted) {
          firstInitCompleted = true;
        } else {
          print("WSS BACK ONLINE!");
          onWSSReconnected.sinkAddSafe(true);
        }
      } else if (type == 'error') {
        final error = json['error'];
        final wss = await _prefs.getStringValue(_prefs.wss);
        if (error['status'] == RemoteConstants.code_un_authorized &&
            wss.isNotEmpty) {
          _networkHandler.onTokenExpired();
        }
      } else if (type == RemoteConstants.rtSignedOut.toUpperCase()) {
        AndroidDeviceInfo androidInfo;
        IosDeviceInfo iosInfo;
        String? deviceId;
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.androidId;
        } else {
          iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor;
        }
        onSignedOut.sinkAddSafe(json['data']['uuid']);
        if (deviceId == json['data']['uuid']) _networkHandler.onTokenExpired();
      } else if (type == RemoteConstants.rtSignedIn.toUpperCase()) {
        onSignedIn.sinkAddSafe(
            _iActivityConverter.fromJsonSessionModel(json['data']));
      } else if (type == RemoteConstants.rtMessage) {
        final message = _iMessageConverter.fromJson(json);
        _resolveMessageArrived(message);
      } else if (type == RemoteConstants.rtMessageUpdated) {
        final message = _iMessageConverter.fromJson(json["message"]);
        message.messageStatus = MessageStatus.Updated;
        if (_inMemoryData.currentTeam?.id == message.tid)
          await resolveMember(message.uid);
        onMessageReceivedController.sinkAddSafe(message);
      } else if (type == RemoteConstants.rtMessageDeleted) {
        final messageDeleted = MessageDeletedModel(
            tid: json["tid"],
            cid: json["cid"],
            id: json["id"],
            pmid: json["pmid"]);
        onMessageDeletedController.sinkAddSafe(messageDeleted);
      } else if (type == RemoteConstants.rtPresenceChange) {
        final presenceModel = RTCPresenceChangeModel(
            tid: json["tid"], uid: json["uid"], presence: json["presence"]);
        if (_inMemoryData.currentTeam?.id == presenceModel.tid)
          await resolveMember(presenceModel.uid!);
        onUserPresenceChangeController.sinkAddSafe(presenceModel);
      } else if (type == RemoteConstants.rtUserTyping) {
        final userTypingModel = RTCUserTypingModel(
            tid: json["tid"], cid: json["cid"], uid: json["uid"]);
        if (_inMemoryData.currentTeam?.id == userTypingModel.tid)
          await resolveMember(userTypingModel.uid!);
        onUserTypingChannelController.sinkAddSafe(userTypingModel);
        onUserTypingThreadController.sinkAddSafe(userTypingModel);
      } else if (type == RemoteConstants.rtMemberPhotoUpdated) {
//        final userTypingModel = RTUserTypingModel(
//            tid: json["tid"], cid: json["cid"], uid: json["uid"]);
//        onUserTypingController.sinkAddSafe(userTypingModel);
      } else if (type == RemoteConstants.rtMemberUpdated) {
        MemberProfile memberProfile =
            _iUserConverter.fromJsonMemberProfile(json['profile']);
        if (json['uid'] == (await _prefs.getStringValue(_prefs.userId)) &&
            memberProfile.language?.isNotEmpty == true) {
          changeLang(memberProfile.language);
        }
        onMemberProfileUpdatedController.sinkAddSafe(RTCMemberUpdated(
            profile: memberProfile, uid: json['uid'], tid: json['tid']));
      } else if (type == RemoteConstants.rtTaskCreated) {
        final taskCreatedUpdatedEvent =
            RTCTaskCreatedUpdated(payloadId: json['payload']['id']);
        onTaskCreatedUpdated.sinkAddSafe(taskCreatedUpdatedEvent);
      } else if (type == RemoteConstants.rtTaskUpdated) {
        final taskCreatedUpdatedEvent = RTCTaskCreatedUpdated(
            payloadId: json['payload']['id'], updated: true);
        onTaskCreatedUpdated.sinkAddSafe(taskCreatedUpdatedEvent);
      } else if (type == RemoteConstants.rtUutDeleted) {
        onTaskEventMarked
            .sinkAddSafe(_iTaskConverter.fromJsonUut(json['data']));
      } else if (type == RemoteConstants.rtChannelDeleted) {
        final channelDeleted = RTCChannelLeftDeleted(
          tid: json['tid'],
          cid: json['cid'],
          deleted: true,
        );
        onChannelLeftDeleted.sinkAddSafe(channelDeleted);
      } else if (type == RemoteConstants.rtChannelLeft) {
        final channelLeft = RTCChannelLeftDeleted(
          tid: json['tid'],
          cid: json['cid'],
          uid: json['uid'],
        );
        onChannelLeftDeleted.sinkAddSafe(channelLeft);
      } else if (type == RemoteConstants.rtChannelOpened ||
          (type == RemoteConstants.rtChannelJoined &&
              (await _prefs.getStringValue(_prefs.userId)) == json['uid'])) {
        onChannelOpened
            .sinkAddSafe(RTCChannelOpened(tid: json['tid'], cid: json['cid']));
      } else if (type == RemoteConstants.rtChannelCreated) {
        final channel = _iChannelConverter.fromJson(json['channel']);
        channel.tid = json['tid'];
        onChannelCreated.sinkAddSafe(RTCChannelCreated(
            tid: json['tid'],
            cid: json['cid'],
            uid: json['uid'],
            channel: channel));
      } else if (type == RemoteConstants.rtChannelClosed) {
        final channelClosed = RTCChannelLeftDeleted(
          tid: json['tid'],
          cid: json['cid'],
          closed: true,
        );
        onChannelLeftDeleted.sinkAddSafe(channelClosed);
      } else if (type == RemoteConstants.rtChannelMarked) {
        final uid = await _prefs.getStringValue(_prefs.userId);
        if (uid == json['uid']) {
          onChannelMarked.sinkAddSafe(RTCChannelMarked(
              cid: json['cid'],
              tid: json['tid'],
              uid: uid,
              marked: json['ts'] != null
                  ? DateTime.fromMillisecondsSinceEpoch(json['ts'])
                  : DateTime.now()));
        }
      } else if (type == RemoteConstants.rtChannelRenamed) {
        final currentTeam = await _prefs.getStringValue(_prefs.currentTeamId);
        if (json['tid'] == currentTeam) {
          onChannelRenamed.sinkAddSafe(RTCChannelRenamed(
              uid: json['uid'],
              tid: json['tid'],
              cid: json['cid'],
              name: json['name'],
              title: json['title']));
        }
      } else if (type == RemoteConstants.rtFolderRenamed) {
        if (json is Map<String, dynamic>) {
          onFolderRenamedController.sinkAddSafe(FolderModel(
            id: json['id'],
            cid: json['cid'],
            tid: json['tid'],
            path: json['path'],
            renamed: json.containsKey('renamed')
                ? DateTime.fromMillisecondsSinceEpoch(json["renamed"],
                        isUtc: true)
                    .toLocal()
                : null,
          ));
        }
      } else if (type == RemoteConstants.rtFolderDeleted) {
        if (json is Map<String, dynamic>) {
          onFolderDeletedController.sinkAddSafe(FolderModel(
              id: json['id'],
              cid: json['cid'],
              tid: json['tid'],
              path: json['path']));
        }
      } else if (type == RemoteConstants.rtFileDeleted) {
        onFileDeletedController.sinkAddSafe(RTCFileDeletedModel(
          path: json['path'],
          cid: json['cid'],
          id: json['id'],
          tid: json['tid'],
        ));
      } else if (type == RemoteConstants.rtFolderCreated ||
          type == RemoteConstants.rtFileCreated) {
        if (json['tid'] ==
            (await _prefs.getStringValue(_prefs.currentTeamId))) {
          onFileFolderCreatedController
              .sinkAddSafe(_iFileConverter.fromJson(json['data']));
        }
      } else if (type == RemoteConstants.rtMemberDisabled) {
        onMemberDisabledEnabled.sinkAddSafe(RTCMemberDisabledEnabledModel(
          tid: json['tid'],
          uid: json['uid'],
        ));
      } else if (type == RemoteConstants.rtMemberActivated) {
        onMemberDisabledEnabled.sinkAddSafe(RTCMemberDisabledEnabledModel(
          tid: json['tid'],
          uid: json['uid'],
          enable: true,
        ));
      } else if (type == RemoteConstants.rtTeamJoined) {
        final data = json['user'];
        onTeamJoined.sinkAddSafe(RTCTeamJoinedModel(
          tid: data['tid'],
          uid: data['id'],
          profile: _iUserConverter.fromJsonMemberProfile(data['profile']),
        ));
      } else if (type == RemoteConstants.rtActivityCreated) {
        onActivityEventArrived.sinkAddSafe(RTCActivityModel(
            model: _iActivityConverter.fromJson(json['data'])));
      } else if (type == RemoteConstants.rtActivityDeleted) {
        onActivityEventArrived.sinkAddSafe(RTCActivityModel(
            model: _iActivityConverter.fromJson(json['data']), deleted: true));
      } else if (type == RemoteConstants.rtWebRTC) {
        final model = RTCCallModel(
            tid: json['tid'],
            uid: json['uid'],
            cid: json['cid'],
            sdp: json['sdp'],
            action: json['action'] == "tok_call"
                ? CALL_ACTION.CALL
                : CALL_ACTION.HANG_DOWN);
        onWebRTCEventController.sinkAddSafe(model);
      } else if (type == RemoteConstants.rtStatusSet) {
        final model = RTCStatusSet(
            tid: json['tid'],
            uid: json['uid'],
            statusText: json['status_txt'],
            statusIcon: json['status_icon'].replaceAll("-", "-200d-"));
        if (model.statusIcon.isEmpty && model.statusText.isNotEmpty)
          model.statusIcon = "1F4AC";
        onStatusSet.sinkAddSafe(model);
      } else if (type == RemoteConstants.rtChannelNotificationsUpdated) {
        final model = RTCChannelNotificationUpdated(
            tid: json['tid'],
            uid: json['uid'],
            cid: json['cid'],
            notifications:
                _iChannelConverter.fromJsonNotification(json['notifications']));
        onChannelNotificationsUpdated.sinkAddSafe(model);
      } else if (type == RemoteConstants.rtMemberNotificationsUpdated) {
        if ((await _prefs.getStringValue(_prefs.currentTeamId)) ==
            json['tid']) {
          final model = RTCMemberNotificationsUpdated(
              tid: json['tid'],
              notifications: _iUserConverter
                  .fromJsonMemberNotification(json['notifications']));
          onMemberNotificationsUpdated.sinkAddSafe(model);
        }
      } else if (type == RemoteConstants.rtMemberRoleUpdated) {
        final model = RTCMemberRoleUpdated(
            tid: json['tid'], uid: json['uid'], role: json['role']);
        onMemberRoleUpdated.sinkAddSafe(model);
      } else if (type == RemoteConstants.rtTeamDisabled) {
        onTeamDisabled.sinkAddSafe(json['tid']);
      } else if (type == RemoteConstants.rtTeamUpdated) {
        onTeamUpdatedController.sinkAddSafe(RTCTeamUpdated(
          tid: json['tid'],
          uid: json['uid'],
          adminsCanDelete: json['adminscandelete'],
          allMentionProtected: json['adminscandelete'],
          channelMentionProtected: json['channelmentionprotected'],
          taskUpdateProtected: json['taskupdateprotected'],
          updateUsernameBlocked: json['updateusernameblocked'],
          onlyAdminInvitesAllowed: json['onlyadmininvitesallowed'],
          alwaysPush: json['alwaysPush'],
          showPhoneNumbers: json['show-phone-numbers'],
          showEmails: json['show-emails'],
          name: json['name'],
          title: json['title'],
        ));
      } else if (type == RemoteConstants.rtTeamThemeUpdated) {
        onTeamThemeUpdatedController.sinkAddSafe(RTCTeamThemeUpdated(
            tid: json['tid'],
            theme: _iTeamConverter.fromJsonTheme(json['theme'])));
      } else if (type == RemoteConstants.rtTeamPhotoUpdated) {
        onTeamPhotoUpdatedController.sinkAddSafe(
            RTCTeamPhotoUpdated(tid: json['tid'], photo: json['photo']));
      } else if (type == RemoteConstants.rtMessagePinned ||
          type == RemoteConstants.rtMessageUnpinned) {
        onMessagePinnedUnpinned.sinkAddSafe(RTCMessagePinnedUnpinned(
            pinnedMessage: _iMessageConverter.fromJson(json['data']),
            unpinned: type == RemoteConstants.rtMessageUnpinned));
      } else if (type == RemoteConstants.rtUserDeleted) {
        onUserDeleted.sinkAddSafe(RTCUserDeleted(uid: json["uid"], tid: json["tid"]));
      }
    }, onError: (error) async {
      print("WSS ERROR => DISCONECTED. _listenRT");
      _channel = null;
      final status = await _connectivityManager.checkConnectivity();
      if (status != ConnectivityAppStatus.none) {
        initRTC();
      } else {
        _checkForConnectivity();
      }
//      Future.delayed(Duration(seconds: 5), () async {
//        final wss = await _prefs.getStringValue(_prefs.wss);
//        _channel = IOWebSocketChannel.connect(wss,
//            pingInterval: Duration(seconds: 10));
//        _listenRT();
//      });
    }, onDone: () async {
      _channel = null;
      final status = await _connectivityManager.checkConnectivity();
      if (status != ConnectivityAppStatus.none) {
        initRTC();
      } else {
        _checkForConnectivity();
      }
    });
    _processPendingMessages();
  }

  void changeLang(String? code) {
    if (code?.isNotEmpty == true) {
      if (AppConfig.localeCode != code) {
        final res = languageCodeController.valueOrNull;
        if (res != null) {
          res.languageCode = code!;
        }
        _prefs.setStringValue(_prefs.language, code!);
        languageCodeController.sinkAddSafe(res ??
            AppSettingsModel(
              isDarkMode: false,
              languageCode: code,
            ));
        localeChangedController.sinkAddSafe(true);
      }
    }
  }

  void _resolveMessageArrived(MessageModel message) async {
    message.messageStatus = MessageStatus.Sent;
    await resolveMember(message.uid, teamId: message.tid);
    onMessageReceivedController.sinkAddSafe(message);
  }

  void _checkForConnectivity() {
    Future.delayed(Duration(seconds: 3), () async {
      final status = await _connectivityManager.checkConnectivity();
      if (status != ConnectivityAppStatus.none)
        initRTC();
      else {
        _checkForConnectivity();
      }
    });
  }

  void _processPendingMessages() async {
    final result = await _connectivityManager.checkConnectivity();
    if (result != ConnectivityAppStatus.none) {
      if (_pendingMessages.isNotEmpty) {
        final messageModel = _pendingMessages[0];
        final body = encodeSendMessage(messageModel);
        _channel?.sink.add(body);
        _pendingMessages.removeAt(0);
        _processPendingMessages();
      }
    }
  }

  String encodeSendMessage(MessageModel messageModel) {
    return jsonEncode({
      "type": "message",
      "id": messageModel.id,
      "tid": messageModel.tid,
      "cid": messageModel.cid,
      "text": messageModel.text,
      "html": messageModel.html,
      "ts": DateTime.now().toUtc().millisecondsSinceEpoch
    });
  }

  @override
  Future<void> sendFolderLinkMessage(
      String text, List<Map<String, String>> folders,
      {MessageModel? answerMessage, String? channelId}) async {
    final ts = DateTime.now();
    var uuid = Uuid();
    final currentTeamId = _inMemoryData.currentTeam?.id;
    final currentChatId = channelId ?? _inMemoryData.currentChannel?.id;
    final currentUserId = _inMemoryData.currentMember?.id;
    String? id = uuid.v1();
    MessageModel messageModel = MessageModel(
        id: id,
        answerMessage: answerMessage,
        messageStatus: MessageStatus.Sending,
        tid: currentTeamId!,
        cid: currentChatId!,
        text: text,
        html: text,
        uid: currentUserId!,
        ts: ts);

    final f = {
      'id': id,
      'type': 'folder:link',
      'cid': currentChatId,
      'tid': currentTeamId,
      'uid': currentUserId,
      'text': text,
      'folders': folders,
    };
    final body = jsonEncode(f);
    messageModel.ts = messageModel.ts?.toLocal();
    onMessageReceivedController.sinkAddSafe(messageModel);
    _channel?.sink.add(body);
  }

  @override
  Future<void> sendMessage(String text,
      {MessageModel? answerMessage, String? teamId, String? channelId}) async {
    final ts = DateTime.now();
    var uuid = Uuid();
    final currentTeamId = teamId ?? _inMemoryData.currentTeam?.id;
    final currentChatId = channelId ?? _inMemoryData.currentChannel?.id;
    final currentUserId = _inMemoryData.currentMember?.id;

    MessageModel messageModel = MessageModel(
        id: uuid.v1(),
        answerMessage: answerMessage,
        messageStatus: MessageStatus.Sending,
        tid: currentTeamId!,
        cid: currentChatId!,
        text: text,
        html: text,
        uid: currentUserId!,
        ts: ts);
//    final body = encodeSendMessage(messageModel);

    messageModel.ts = messageModel.ts?.toLocal();
    onMessageReceivedController.sinkAddSafe(messageModel);

    addPendingMessage(messageModel);
    _processPendingMessages();
  }

//  @override
//  void reSendMessage(MessageModel messageModel) async {
//    final body = jsonEncode({
//      "type": "message",
//      "id": messageModel.id,
//      "tid": messageModel.tid,
//      "cid": messageModel.cid,
//      "text": messageModel.text,
//      "html": messageModel.html,
//      "ts": messageModel.ts.toUtc().millisecondsSinceEpoch
//    });
//
//    try {
//      final wss = await _prefs.getStringValue(_prefs.wss);
//      _channel =
//          IOWebSocketChannel.connect(wss, pingInterval: Duration(seconds: 10));
//      _listenRT();
//      messageModel.messageStatus = MessageStatus.Sending;
//      messageModel.ts = messageModel.ts.toLocal();
//      onMessageReceivedController.sinkAddSafe(messageModel);
//      _channel?.sink?.add(body);
////      print("WSS RE-SENDING => $body");
//    } catch (ex) {
//      print("WSS ERROR => DISCONECTED. initRT");
//      Fluttertoast.showToast(msg: "WSS ERROR => DISCONECTED. initRT");
//    }
//  }

  @override
  void sendMessageThread(
      String text, String pmid, bool showOnChannel, String channelId,
      {List<Map<String, String>>? folders}) async {
    final ts = DateTime.now().toUtc();
    var uuid = Uuid();
    final currentTeamId = _inMemoryData.currentTeam?.id;
    final currentUserId = _inMemoryData.currentMember?.id;
    final body = jsonEncode(folders != null && folders.isNotEmpty
        ? {
            'id': uuid.v1(),
            'type': 'folder:link',
            'cid': channelId,
            'tid': currentTeamId,
            'uid': currentUserId,
            'text': text,
            "pmid": pmid,
            "showOnChannel": showOnChannel,
            'folders': folders,
          }
        : {
            "type": "message",
            "id": uuid.v1(),
            "tid": currentTeamId,
            "cid": channelId,
            "text": text,
            "html": text,
            "ts": ts.millisecondsSinceEpoch,
            "pmid": pmid,
            "showOnChannel": showOnChannel,
            "uid": currentUserId
          });

    _channel?.sink.add(body);
//    print("WSS SENDING MESSAGE IN THREAD => $body");
  }

  @override
  void sendWssPresence(UserPresence presence) {
    String code = presence == UserPresence.offline
        ? "offline"
        : presence == UserPresence.online
            ? "online"
            : "out";
    final body = jsonEncode({"type": "presence", "presence": "$code"});
//    print("WSS SENDING PRESENCE => $body");
    _channel?.sink.add(body);
  }

  @override
  void sendWssFileFolderDownloaded(String objectId) {
    final body =
        jsonEncode({"type": "notification:downloaded", "_id": objectId});
    _channel?.sink.add(body);
  }

  @override
  void sendWssTyping() async {
    final currentTeamId = _inMemoryData.currentTeam?.id;
    final currentChatId = _inMemoryData.currentChannel?.id;
    final body = jsonEncode(
        {"type": "typing", "tid": "$currentTeamId", "cid": "$currentChatId"});
//    print("WSS SENDING TYPING => $body");
    _channel?.sink.add(body);
  }

  @override
  void addPendingMessage(MessageModel messageModel) {
    _pendingMessages.add(messageModel);
  }

  @override
  void sendCallEventStart() async {
    String tid = await _prefs.getStringValue(_prefs.currentTeamId);
    String cid = await _prefs.getStringValue(_prefs.currentChatId);

    final body = jsonEncode({
      "type": "webrtc",
      "tid": tid,
      "cid": cid,
      "text": "",
      "action": "tok_call"
    });
    _channel?.sink.add(body);
  }

  void sendCallEventReject(String teamId, String channelId) async {
    String tid = teamId;
    String cid = channelId;

    if (tid.isNotEmpty && cid.isNotEmpty) {
      final body = jsonEncode({
        "type": "webrtc",
        "tid": tid,
        "cid": cid,
        "text": "",
        "action": "tok_hang_down"
      });
      _channel?.sink.add(body);
    }
  }
}
