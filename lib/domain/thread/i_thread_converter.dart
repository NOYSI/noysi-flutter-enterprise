import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/thread/thread_model.dart';

abstract class IThreadConverter {
  ThreadModel fromJson(Map<String, dynamic> json);

  MessageModel fromJsonThreadMessage(Map<String, dynamic> json);

  List<ReactionsModel> fromJsonReaction(Map<String, dynamic> json);

  ThreadMetaParent fromJsonThreadMetaParent(Map<String, dynamic> json);

  ThreadMetaChild fromJsonThreadMetaChild(Map<String, dynamic> json);

  Map<String, dynamic> toJsonCreate(ThreadCreateModel model);
}
