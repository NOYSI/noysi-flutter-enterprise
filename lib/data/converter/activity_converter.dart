import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/activity/activity_model.dart';
import 'package:code/domain/activity/i_activity_converter.dart';

class ActivityConverter implements IActivityConverter {
  @override
  ActivityWrapperModel fromJsonWrapperModel(Map<String, dynamic> json) {
    return ActivityWrapperModel(
      list: (json['list'] as List<dynamic>).map((e) => fromJson(e)).toList(),
      total: json.containsKey('count') ? json['count'] : 0,
    );
  }

  @override
  ActivityModel fromJson(Map<String, dynamic> json) {
    ACTIVITY_TYPE type = _getTypeFromString(json['type']);
    return ActivityModel(
      id: json['id'],
      tid: json.containsKey('tid') ? json['tid'] : null,
      ts: json.containsKey('ts') && json['ts'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['ts'], isUtc: true)
              .toLocal()
          : null,
      uid: json['uid'],
      cid: json.containsKey('cid') && json['cid'] != null ? json['cid'] : null,
      type: type,
      sourceId: json.containsKey('source_id') && json['source_id'] != null
          ? json['source_id']
          : null,
      metaData: _fromJsonMetaData(json['metadata'], type),
    );
  }

  ActivityMetaModel _fromJsonMetaData(
      Map<String, dynamic> json, ACTIVITY_TYPE type) {
    switch (type) {
      case ACTIVITY_TYPE.file_uploaded:
        return _fromJsonFileUploadedMetaData(json);
      case ACTIVITY_TYPE.file_downloaded:
        return _fromJsonFileUploadedMetaData(json);
      case ACTIVITY_TYPE.mentioned:
        return _fromJsonMentionedMetaData(json);
      case ACTIVITY_TYPE.message_sent:
        return _fromJsonMessageSentMetaData(json);
      case ACTIVITY_TYPE.signed_in:
        return _fromJsonSignedInMetaData(json);
      case ACTIVITY_TYPE.task_assigned:
        return _fromJsonTaskAssignedMetaData(json);
      case ACTIVITY_TYPE.task_assigned_deleted:
        return _fromJsonTaskAssignedDeletedMetaData(json);
      default:
        return _fromJsonTaskCreatedMetaData(json);
    }
  }

  FileUploadedMetaModel _fromJsonFileUploadedMetaData(
      Map<String, dynamic> json) {
    return FileUploadedMetaModel(
        path: json['path'],
        isFolder: json.containsKey('folder') ? json['folder'] : false,
        channelName:
            json.containsKey('channel_name') ? json['channel_name'] : "",
        creator: json['username'],
        fileName: json['file_name'],
        parentId: json.containsKey('parent') && json['parent'] != null
            ? json['parent']
            : null,
        other: json.containsKey('other') ? json['other'] : null,
        otherName: json.containsKey('other_name') ? json['other_name'] : "",
        channelType: json['channel_type']);
  }

  MentionedMetaModel _fromJsonMentionedMetaData(Map<String, dynamic> json) {
    return MentionedMetaModel(
      channelName: json.containsKey('channel_name') ? json['channel_name'] : "",
      channelType: json['channel_type'],
      mentionOwnerId: json['mentioner'],
      mentionOwnerName: json['mentioner_name'],
      username: json['username'],
      other: json.containsKey('other') ? json['other'] : null,
      otherName: json.containsKey('other_name') ? json['other_name'] : "",
    );
  }

  MessageSentMetaModel _fromJsonMessageSentMetaData(Map<String, dynamic> json) {
    return MessageSentMetaModel(
        username: json['username'],
        channelType: json['channel_type'],
        other: json.containsKey('other') ? json['other'] : null,
        otherName: json.containsKey('other_name') ? json['other_name'] : "",
        channelName:
            json.containsKey('channel_name') ? json['channel_name'] : "");
  }

  SignedInMetaModel _fromJsonSignedInMetaData(Map<String, dynamic> json) {
    return SignedInMetaModel(
      ipAddress: json['address'],
      os: json['os'],
      version: json['version'],
      name: json['name'],
      type: json['type'],
      model: json.containsKey('model') ? json['model'] : null,
      appVersion: json.containsKey('appversion') ? json['appversion'] : null,
    );
  }

  TaskAssignedMetaModel _fromJsonTaskAssignedMetaData(
      Map<String, dynamic> json) {
    return TaskAssignedMetaModel(
        channelType: json['channel_type'],
        channelName:
            json.containsKey('channel_name') ? json['channel_name'] : "",
        other: json.containsKey('other') ? json['other'] : null,
        otherName: json.containsKey('other_name') ? json['other_name'] : "",
        username: json['username'],
        ownerId: json['owner'],
        ownerName: json['owner_name'],
        taskTitle: json['task_title']);
  }

  TaskAssignedDeletedMetaModel _fromJsonTaskAssignedDeletedMetaData(
      Map<String, dynamic> json) {
    return TaskAssignedDeletedMetaModel(
        channelType: json['channel_type'],
        channelName:
            json.containsKey('channel_name') ? json['channel_name'] : "",
        other: json.containsKey('other') ? json['other'] : null,
        otherName: json.containsKey('other_name') ? json['other_name'] : "",
        username: json['username'],
        ownerId: json['owner'],
        ownerName: json['owner_name'],
        taskTitle: json['task_title']);
  }

  TaskCreatedMetaModel _fromJsonTaskCreatedMetaData(Map<String, dynamic> json) {
    return TaskCreatedMetaModel(
        channelType: json['channel_type'],
        channelName:
            json.containsKey('channel_name') ? json['channel_name'] : "",
        other: json.containsKey('other') ? json['other'] : null,
        otherName: json.containsKey('other_name') ? json['other_name'] : "",
        username: json['username'],
        ownerId: json['owner'],
        ownerName: json['owner_name'],
        taskTitle: json['task_title']);
  }

  ACTIVITY_TYPE _getTypeFromString(String type) {
    switch (type) {
      case RemoteConstants.activity_file_uploaded:
        return ACTIVITY_TYPE.file_uploaded;
      case RemoteConstants.activity_file_downloaded:
        return ACTIVITY_TYPE.file_downloaded;
      case RemoteConstants.activity_mentioned:
        return ACTIVITY_TYPE.mentioned;
      case RemoteConstants.activity_message_sent:
        return ACTIVITY_TYPE.message_sent;
      case RemoteConstants.activity_signed_in:
        return ACTIVITY_TYPE.signed_in;
      case RemoteConstants.activity_task_assigned:
        return ACTIVITY_TYPE.task_assigned;
      case RemoteConstants.activity_task_assigned_deleted:
        return ACTIVITY_TYPE.task_assigned_deleted;
      default:
        return ACTIVITY_TYPE.task_created;
    }
  }

  @override
  SessionModel fromJsonSessionModel(Map<String, dynamic> json) {
    return SessionModel(
      name: json['name'] ?? "",
      model: json.containsKey('model') ? json['model'] : null,
      type: json['type'] ?? "",
      current: json.containsKey('current') && json['current'] != null
          ? json['current']
          : false,
      id: json['uuid'] ?? '',
      ipAddress: json['address'] ?? "",
      os: json['os'] ?? "",
      version: json['version'] ?? "",
      appVersion: json.containsKey('appversion') ? json['appversion'] : null,
      ts: json.containsKey('ts') && json['ts'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['ts'], isUtc: true)
              .toLocal()
          : null,
    );
  }
}
