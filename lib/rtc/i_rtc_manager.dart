import 'package:code/domain/message/message_model.dart';

import '../enums.dart';

abstract class IRTCManager {
  void initRTC();

  void disposeRTC();

  void sendWssTyping();

  void sendWssPresence(UserPresence presence);

  void sendWssFileFolderDownloaded(String objectId);

  Future<void> sendMessage(String text, {MessageModel? answerMessage, String? teamId, String? channelId});

  Future<void> sendFolderLinkMessage(String text, List<Map<String, String>> folders, {MessageModel? answerMessage, String? channelId});

  void sendMessageThread(String text, String pmid, bool showOnChannel, String channelId, {List<Map<String, String>> folders});

//  void reSendMessage(MessageModel messageModel);

  void addPendingMessage(MessageModel messageModel);

  void sendCallEventStart();

  void sendCallEventReject(String teamId, String channelId);
}
