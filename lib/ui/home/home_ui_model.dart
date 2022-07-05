import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/user/user_model.dart';

import '../../enums.dart';

class DrawerChatModel {
  DrawerHeaderChatType drawerHeaderChatType;
  bool isChild;
  bool isSelected;
  String title;
  String subtitle;
  int childrenCount;
  int unreadMessagesCount;
  ChannelModel? channelModel;
  MemberModel? memberModel;

  DrawerChatModel(
      {this.isChild = true,
      required this.drawerHeaderChatType,
      this.isSelected = false,
      this.title = "",
      this.subtitle = "",
      this.memberModel,
      this.channelModel,
      this.childrenCount = 0,
      this.unreadMessagesCount = 0});
}

class ChatRoomUIModel {
  MessageWrapperModel messageWrapperModel;

  ChatRoomUIModel({required this.messageWrapperModel});
}

class ChannelCreatedUI {
  ChannelModel channelModel;
  List<MemberModel> members;
  MessageModel? lastReadMessage;
  bool fromSearchMessage;
  bool newCreated;

  ChannelCreatedUI({required this.channelModel, this.members = const [], this.lastReadMessage, this.fromSearchMessage = false, this.newCreated = false});
}
