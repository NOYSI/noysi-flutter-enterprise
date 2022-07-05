import 'package:code/domain/message/message_model.dart';
import 'package:code/enums.dart';

class ChannelModel {
  String id;
  String? uid;
  String? tid;
  String? name;
  String? title;
  DateTime? created;
  String other;
  bool? general;
  bool? readonly;
  bool? joined;
  bool? open;
  DateTime? mark;
  NotificationModel? notifications;
  int? unreadCount;
  List<MessageModel> unreadMessages;
  int? totalMembers;
  bool isFavorite;

  String get titleFixed => title?.trim().isNotEmpty == true ? title! : name ?? "";

  bool get isM1x1 => id.startsWith("i");

  bool get isOpenChannel => id.startsWith("c");

  bool get isPrivateGroup => id.startsWith("g");

  ChannelModel(
      {this.id = '',
      this.uid,
      this.tid,
      this.name = '',
      this.other = '',
      this.title,
      this.created,
      this.unreadCount = 0,
      this.unreadMessages = const [],
      this.totalMembers = 0,
      this.isFavorite = false,
      this.general,
      this.readonly,
      this.joined,
      this.open,
      this.mark,
      this.notifications});
}

class NotificationModel {
  bool? sounds;
  bool? emails;
  bool? alwaysPush;

  NotificationModel({this.emails, this.sounds, this.alwaysPush});
}

class ChannelModelCreate {
  String type;
  String name;
  List<String> users;
  bool? readOnly;

  ChannelModelCreate({this.type = '', this.name = '', this.users = const [], this.readOnly});
}

class ChannelLinkWrappedModel {
  List<ChannelLinkModel> list;
  int total;
  CommonSort sort;

  ChannelLinkWrappedModel({this.list = const [], this.total = 0, this.sort = CommonSort.desc});
}

class ChannelLinkModel {
  String uid;
  String tid;
  String cid;
  String mid;
  String text;
  String url;
  DateTime? ts;
  String get channelLinkId => "$tid-$cid-$mid-$uid";

  ChannelLinkModel(
      {this.uid = '', this.tid = '', this.cid = '', this.mid = '', this.text = '', this.url = '', this.ts});
}

class ChannelMentionWrappedModel {
  List<ChannelMentionModel> list;
  CommonSort sort;
  int total;

  ChannelMentionWrappedModel({this.list = const [], this.total = 0, this.sort = CommonSort.desc});
}

class ChannelMentionModel {
  String uid;
  String tid;
  String cid;
  String mid;
  String text;
  String? html;
  DateTime? ts;

  String get channelMentionId => "$tid-$cid-$mid-$uid";

  ChannelMentionModel(
      {this.uid = '', this.tid = '', this.cid = '', this.mid = '', this.text = '', this.html, this.ts});
}
