import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_converter.dart';
import 'package:code/domain/message/i_message_converter.dart';

class ChannelConverter implements IChannelConverter {
  final IMessageConverter _iMessageConverter;

  ChannelConverter(this._iMessageConverter);

  @override
  ChannelModel fromJson(Map<String, dynamic> json) {
    final ChannelModel model = ChannelModel(
        id: json["id"],
        uid: json["uid"],
        created: json["created"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["created"], isUtc: true)
                .toLocal()
            : null,
        tid: json["tid"],
        name: json.containsKey("name") ? json["name"] : null,
        title: json.containsKey("title") ? json["title"] : null,
        general: json.containsKey("general") ? json["general"] : false,
        other: json.containsKey("other") ? json["other"] : "",
        readonly: json.containsKey("readonly") ? json["readonly"] : false,
        joined: json["joined"],
        open: json["open"],
        mark: json["mark"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["mark"], isUtc: true)
                .toLocal()
            : null,
        totalMembers: json["totalMembers"],
        unreadCount: json["unread_count"],
        unreadMessages: json.containsKey("unread_msg")
            ? (json["unread_msg"] as List<dynamic>)
                .map((e) => _iMessageConverter.fromJson(e))
                .toList()
            : [],
        isFavorite: json.containsKey("favorite") ? json["favorite"] : false,
        notifications: fromJsonNotification(json["notifications"]));
    return model;
  }

  @override
  Map<String, dynamic> toJson(ChannelModel model) {
    final map = {
      "id": model.id,
      "uid": model.uid,
      "tid": model.tid,
      "created": model.created?.millisecondsSinceEpoch,
      "name": model.name,
      "title": model.title,
      "general": model.general,
      "other": model.other,
      "readonly": model.readonly,
      "joined": model.joined,
      "open": model.open,
      "mark": model.mark?.millisecondsSinceEpoch,
      "totalMembers": model.totalMembers,
      "unread_count": model.unreadCount,
      "favorite": model.isFavorite,
      "notifications": toJsonNotification(model.notifications!)
    };
    return map;
  }

  @override
  Map<String, dynamic> toJsonCreate(ChannelModelCreate model) {
    final map = {
      "type": model.type,
      "name": model.name,
      "users": model.users,
      "readonly": model.readOnly
    };
    return map;
  }

  @override
  NotificationModel fromJsonNotification(Map<String, dynamic> json) {
    final NotificationModel model = NotificationModel(
        sounds: json["sounds"],
        emails: json["emails"],
        alwaysPush: json.containsKey("always_push")
            ? (json["always_push"] ?? false)
            : false);
    return model;
  }

  @override
  Map<String, dynamic> toJsonNotification(NotificationModel model) {
    final map = {
      "sounds": model.sounds,
      "emails": model.emails,
      "always_push": model.alwaysPush
    };
    return map;
  }

  @override
  ChannelLinkModel fromJsonChannelLink(Map<String, dynamic> json) {
    ChannelLinkModel model = ChannelLinkModel(
        tid: json["tid"],
        uid: json["uid"],
        cid: json["cid"],
        mid: json["mid"],
        text: json["text"],
        url: json["url"],
        ts: json.containsKey("ts") && json["ts"] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    int.tryParse(json["ts"]["\$numberLong"])!,
                    isUtc: true)
                .toLocal()
            : null);
    return model;
  }

  @override
  ChannelLinkWrappedModel fromJsonChannelLinkWrapped(
      Map<String, dynamic> json) {
    ChannelLinkWrappedModel model = ChannelLinkWrappedModel(
        list: (json["list"] as List<dynamic>)
            .map((e) => fromJsonChannelLink(e))
            .toList(),
        total: json["total"]);
    return model;
  }

  @override
  ChannelMentionModel fromJsonChannelMention(Map<String, dynamic> json) {
    ChannelMentionModel model = ChannelMentionModel(
        tid: json["tid"],
        uid: json["uid"],
        cid: json["cid"],
        mid: json["mid"],
        text: json["text"],
        html: json["html"],
        ts: json.containsKey("ts") && json["ts"] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    int.tryParse(json["ts"]["\$numberLong"])!,
                    isUtc: true)
                .toLocal()
            : null);
    return model;
  }

  @override
  ChannelMentionWrappedModel fromJsonChannelMentionWrapped(
      Map<String, dynamic> json) {
    ChannelMentionWrappedModel model = ChannelMentionWrappedModel(
        list: (json["list"] as List<dynamic>)
            .map((e) => fromJsonChannelMention(e))
            .toList(),
        total: json["total"]);
    return model;
  }
}
