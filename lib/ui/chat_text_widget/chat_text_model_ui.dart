import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/enums.dart';

class ChatTextMentionModel {
  String? url;
  bool? isMember;
  String displayName;
  UserPresence userPresence;
  bool isActive;

  ChatTextMentionModel(
      {this.url,
      this.isMember,
      this.displayName = '',
      this.userPresence = UserPresence.offline,
      this.isActive = true});

  static ChatTextMentionModel getChannelMention() => ChatTextMentionModel(
      url: "", isMember: false, displayName: RemoteConstants.channel);

  static ChatTextMentionModel getAllMention() => ChatTextMentionModel(
      url: "", isMember: false, displayName: RemoteConstants.all);
}
