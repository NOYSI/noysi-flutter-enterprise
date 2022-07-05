import 'package:code/_res/R.dart';
import 'package:flutter/material.dart';

enum ACTIVITY_TYPE {
  message_sent,
  mentioned,
  task_created,
  task_assigned,
  task_assigned_deleted,
  file_uploaded,
  file_downloaded,
  signed_in
}

class ActivityWrapperModel {
  List<ActivityModel> list;
  int total;
  int offset;

  ActivityWrapperModel({this.list = const [], this.total = 0, this.offset = 0});
}

class ActivityModel {
  String id;
  String uid;
  String? tid;
  ACTIVITY_TYPE? type;
  DateTime? ts;
  String? cid;
  String? sourceId;
  ActivityMetaModel? metaData;

  bool get isMessageSentActivity => type == ACTIVITY_TYPE.message_sent;

  bool get isMentionedActivity => type == ACTIVITY_TYPE.mentioned;

  bool get isTaskCreatedActivity => type == ACTIVITY_TYPE.task_created;

  bool get isTaskAssignedActivity => type == ACTIVITY_TYPE.task_assigned;

  bool get isTaskAssignedDeletedActivity =>
      type == ACTIVITY_TYPE.task_assigned_deleted;

  bool get isFileUploadedActivity => type == ACTIVITY_TYPE.file_uploaded;

  bool get isFileDownloadedActivity => type == ACTIVITY_TYPE.file_downloaded;

  bool get isSignedInActivity => type == ACTIVITY_TYPE.signed_in;

  String get icon => isMessageSentActivity
      ? R.image.messageSent
      : isMentionedActivity
          ? R.image.mentioned
          : isSignedInActivity
              ? R.image.signedIn
              : isFileUploadedActivity
                  ? (metaData as FileUploadedMetaModel).isFolder
                      ? R.image.folderUploaded
                      : R.image.fileUploaded
                  : isFileDownloadedActivity
                      ? (metaData as FileUploadedMetaModel).isFolder
                          ? R.image.folderDownloaded
                          : R.image.fileDownloaded
                      : isTaskCreatedActivity
                          ? R.image.taskCreated
                          : isTaskAssignedActivity
                              ? R.image.taskAssigned
                              : R.image.taskUnassigned;

  ActivityModel(
      {this.id = '',
      this.uid = '',
      this.tid = '',
      this.cid = '',
      this.type,
      this.ts,
      this.metaData,
      this.sourceId = ''});
}

abstract class ActivityMetaModel {}

class MessageSentMetaModel extends ActivityMetaModel {
  String channelType, channelName, username, otherName;
  String? other;

  bool get is1x1Message => channelType == 'direct';

  bool get isOpenChannelMessage => channelType == 'channel';

  bool get isPrivateGroupMessage => channelType == 'group';

  MessageSentMetaModel(
      {this.channelName = '',
      this.username = '',
      this.channelType = '',
      this.other = '',
      this.otherName = ''});
}

class MentionedMetaModel extends ActivityMetaModel {
  String mentionOwnerName,
      mentionOwnerId,
      username,
      channelType,
      channelName,
      otherName;
  String? other;

  bool get is1x1Message => channelType == 'direct';

  bool get isOpenChannelMessage => channelType == 'channel';

  bool get isPrivateGroupMessage => channelType == 'group';

  MentionedMetaModel(
      {this.username = '',
      this.channelName = '',
      this.channelType = '',
      this.other = '',
      this.mentionOwnerId = '',
      this.mentionOwnerName = '',
      this.otherName = ''});
}

class TaskCreatedMetaModel extends ActivityMetaModel {
  String
      taskTitle,
      username,
      channelType;
  String? other, channelName, ownerId,
      ownerName,
      otherName;

  bool get is1x1Message => channelType == 'direct';

  bool get isOpenChannelMessage => channelType == 'channel';

  bool get isPrivateGroupMessage => channelType == 'group';

  TaskCreatedMetaModel(
      {this.username = '',
      this.channelName = '',
      this.taskTitle = '',
      this.channelType = '',
      this.ownerId = '',
      this.ownerName = '',
      this.other = '',
      this.otherName = ''});
}

class TaskAssignedMetaModel extends ActivityMetaModel {
  String channelName,
      taskTitle,
      channelType,
      username,
      ownerId,
      ownerName,
      otherName;
  String? other;

  bool get is1x1Message => channelType == 'direct';

  bool get isOpenChannelMessage => channelType == 'channel';

  bool get isPrivateGroupMessage => channelType == 'group';

  TaskAssignedMetaModel(
      {this.taskTitle = '',
      this.channelName = '',
      this.username = '',
      this.ownerId = '',
      this.ownerName = '',
      this.channelType = '',
      this.otherName = '',
      this.other = ''});
}

class TaskAssignedDeletedMetaModel extends ActivityMetaModel {
  String channelName,
      taskTitle,
      username,
      channelType,
      ownerId,
      ownerName,
      otherName;
  String? other;

  bool get is1x1Message => channelType == 'direct';

  bool get isOpenChannelMessage => channelType == 'channel';

  bool get isPrivateGroupMessage => channelType == 'group';

  TaskAssignedDeletedMetaModel(
      {this.taskTitle = '',
      this.channelName = '',
      this.username = '',
      this.ownerId = '',
      this.ownerName = '',
      this.channelType = '',
      this.otherName = '',
      this.other = ''});
}

class FileUploadedMetaModel extends ActivityMetaModel {
  String channelName,
      fileName,
      path,
      creator,
      otherName,
      channelType;
  String? parentId, other;
  bool isFolder;

  bool get is1x1Message => channelType == 'direct';

  bool get isOpenChannelMessage => channelType == 'channel';

  bool get isPrivateGroupMessage => channelType == 'group';

  FileUploadedMetaModel({
    this.path = '',
    this.channelName = '',
    this.isFolder = false,
    this.creator = '',
    this.fileName = '',
    this.parentId = '',
    this.otherName = '',
    this.other = '',
    this.channelType = '',
  });
}

class SignedInMetaModel extends ActivityMetaModel {
  String ipAddress;
  String name;
  String os;
  String version;
  String type;
  String? model;
  String? appVersion;

  bool get isDesktop => type == "desktop";

  bool get isWeb => type == "web";

  bool get isMobile => !isDesktop && !isWeb;

  SignedInMetaModel(
      {this.name = '',
      this.ipAddress = '',
      this.os = '',
      this.type = '',
      this.version = '',
      this.model = '',
      this.appVersion = ''});
}

class ActivityFilter {
  DateTimeRange? dateRange;
  List<ACTIVITY_TYPE> types;

  ActivityFilter({
    this.dateRange,
    this.types = const [],
  });
}

class SessionModel {
  String id;
  String? ipAddress;
  String? name;
  String? os;
  String? version;
  String? appVersion;
  String? type;
  String? model;
  DateTime? ts;
  bool current;

  bool get isDesktop => type == "desktop";

  bool get isWeb => type == "web";

  bool get isMobile => !isDesktop && !isWeb;

  String get icon => isDesktop
      ? R.image.desktop
      : isWeb
          ? R.image.web
          : type == "android"
              ? R.image.android
              : R.image.iphone;

  SessionModel(
      {this.name = '',
      this.ts,
      this.id = '',
      this.version = '',
      this.type = '',
      this.appVersion = '',
      this.ipAddress = '',
      this.model = '',
      this.current = false,
      this.os = ''});
}
