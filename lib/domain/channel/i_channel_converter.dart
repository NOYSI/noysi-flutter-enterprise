import 'package:code/domain/channel/channel_model.dart';

abstract class IChannelConverter {
  Map<String, dynamic> toJsonCreate(ChannelModelCreate model);

  ChannelModel fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(ChannelModel model);

  ChannelLinkModel fromJsonChannelLink(Map<String, dynamic> json);

  ChannelLinkWrappedModel fromJsonChannelLinkWrapped(Map<String, dynamic> json);

  NotificationModel fromJsonNotification(Map<String, dynamic> json);

  Map<String, dynamic> toJsonNotification(NotificationModel model);

  ChannelMentionModel fromJsonChannelMention(Map<String, dynamic> json);

  ChannelMentionWrappedModel fromJsonChannelMentionWrapped(Map<String, dynamic> json);
}
