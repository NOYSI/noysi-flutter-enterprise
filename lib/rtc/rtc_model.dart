import 'package:code/domain/activity/activity_model.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/user_model.dart';

import '../domain/message/message_model.dart';
import '../enums.dart';

class RTCMessageSendModel {
  RTCMessageType rtcMessageType;
  MessageStatus messageStatus;
  String? type, id, tid, cid, text, html, pmid, uid;
  DateTime? ts;
  bool showOnChannel;

  RTCMessageSendModel(
      {this.rtcMessageType = RTCMessageType.message,
      this.messageStatus = MessageStatus.Sending,
      this.type = "message",
      this.id,
      this.tid,
      this.cid,
      this.text,
      this.html,
      this.ts,
      this.pmid,
      this.showOnChannel = false,
      this.uid});
}

class RTCPresenceChangeModel {
  String? uid, tid;
  String presence;

  RTCPresenceChangeModel({this.uid, this.tid, this.presence = 'out'});
}

class RTCUserTypingModel {
  String? uid, tid, cid;

  RTCUserTypingModel({this.uid, this.tid, this.cid});
}

class RTCUnreadModel {
  int count;

  RTCUnreadModel({this.count = 0});
}

class RTCTypingModel {
  String? tid, cid;

  RTCTypingModel({this.tid, this.cid});
}

class RTCPresenceModel {
  String? presence;

  RTCPresenceModel({this.presence});
}

class RTCMemberPhotoUpdated {
  String? uid, tid, photo;

  RTCMemberPhotoUpdated({this.uid, this.tid, this.photo});
}

class RTCMemberUpdated {
  String uid, tid;
  MemberProfile? profile;

  RTCMemberUpdated({this.profile, required this.uid, required this.tid});
}

class RTCTaskCreatedUpdated {
  bool updated;
  String? payloadId;

  RTCTaskCreatedUpdated({this.payloadId, this.updated = false});
}

class RTCFileDeletedModel {
  String? tid, cid, id, path;

  RTCFileDeletedModel({this.tid, this.id, this.path, this.cid});
}

class RTCMemberDisabledEnabledModel {
  String tid, uid;
  bool enable;

  RTCMemberDisabledEnabledModel({required this.tid, required this.uid, this.enable = false});
}

class RTCTeamJoinedModel {
  String? tid, uid;
  MemberProfile? profile;

  RTCTeamJoinedModel({this.tid, this.uid, this.profile});
}

class RTCActivityModel {
  bool deleted;
  ActivityModel? model;

  RTCActivityModel({this.deleted = false, this.model});
}

class RTCChannelOpened {
  String tid, cid;

  RTCChannelOpened({this.cid = '', this.tid = ''});
}

class RTCChannelCreated {
  ChannelModel? channel;
  String tid, uid, cid;

  RTCChannelCreated(
      {this.channel, this.tid = '', this.cid = '', this.uid = ''});
}

class RTCChannelLeftDeleted {
  bool deleted, closed;
  String cid, tid;
  String uid;

  RTCChannelLeftDeleted({
    required this.cid,
    required this.tid,
    this.uid = '',
    this.deleted = false,
    this.closed = false,
  });
}

enum CALL_ACTION { CALL, HANG_DOWN, UNDEFINED }

class RTCCallModel {
  String cid, tid, uid, sdp;
  CALL_ACTION action;

  RTCCallModel(
      {this.uid = '',
      this.tid = '',
      this.cid = '',
      this.action = CALL_ACTION.UNDEFINED,
      this.sdp = ""});
}

class RTCChannelMarked {
  String tid, cid, uid;
  DateTime? marked;

  RTCChannelMarked({this.cid = '', this.tid = '', this.marked, this.uid = ''});
}

class RTCChannelRenamed {
  String tid, cid, uid, name, title;

  RTCChannelRenamed(
      {this.tid = '',
      this.cid = '',
      this.uid = '',
      this.name = '',
      this.title = ''});
}

class RTCStatusSet {
  String tid, uid, statusText, statusIcon;

  RTCStatusSet(
      {this.statusText = '',
      this.statusIcon = '',
      this.uid = '',
      this.tid = ''});
}

class RTCChannelNotificationUpdated {
  String? tid, cid, uid;
  NotificationModel? notifications;

  RTCChannelNotificationUpdated(
      {this.tid, this.cid, this.uid, this.notifications});
}

class RTCMemberNotificationsUpdated {
  String? tid;
  MemberNotification? notifications;

  RTCMemberNotificationsUpdated({this.tid, this.notifications});
}

class RTCMemberRoleUpdated {
  String uid, tid, role;

  RTCMemberRoleUpdated({required this.role, required this.tid, required this.uid});
}

class RTCTeamUpdated {
  String tid;
  String? uid, name, title;
  bool adminsCanDelete,
      allMentionProtected,
      channelMentionProtected,
      taskUpdateProtected,
      updateUsernameBlocked,
      onlyAdminInvitesAllowed,
      alwaysPush,
      showPhoneNumbers,
      showEmails;

  RTCTeamUpdated({
    this.uid,
    required this.tid,
    this.name,
    this.title,
    this.adminsCanDelete = false,
    this.allMentionProtected = false,
    this.channelMentionProtected = false,
    this.onlyAdminInvitesAllowed = false,
    this.taskUpdateProtected = false,
    this.updateUsernameBlocked = false,
    this.alwaysPush = false,
    this.showPhoneNumbers = true,
    this.showEmails = true
  });
}

class RTCTeamThemeUpdated {
  TeamTheme theme;
  String tid;

  RTCTeamThemeUpdated({required this.tid, required this.theme});
}

class RTCTeamPhotoUpdated {
  String tid, photo;

  RTCTeamPhotoUpdated({required this.tid, required this.photo});
}

class RTCMessagePinnedUnpinned {
  bool unpinned;
  MessageModel pinnedMessage;

  RTCMessagePinnedUnpinned({this.unpinned = false, required this.pinnedMessage});
}

class RTCUserDeleted {
  String uid, tid;

  RTCUserDeleted({required this.uid, required this.tid});
}
