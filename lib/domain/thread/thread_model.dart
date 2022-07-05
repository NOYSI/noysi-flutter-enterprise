import 'package:code/domain/message/message_model.dart';

class ThreadModel {
  String tid;
  String? cid;
  String? uid;
  String pmid;
  int numReplies;
  List<String> participants;
  DateTime? tsLastReply;
  DateTime? tsLastReadByUser;
  MessageModel? parentMessage;
  List<MessageModel> childMessages;

  ThreadModel(
      {this.tid = '',
      this.cid,
      this.uid,
      this.pmid = '',
      this.numReplies = 0,
      this.tsLastReply,
      this.participants = const [],
      this.tsLastReadByUser,
      this.parentMessage,
      this.childMessages = const []});
}

class ThreadParentMessage {
  String? id;
  String? type;
  String? uid;
  String? tid;
  String? cid;
  String? mid;
  String text;
  String html;
  bool? translate;
  DateTime? ts;
  int comments;
  DateTime? edited;

  ThreadMetaParent? threadMeta;

  ThreadParentMessage(
      {this.id,
      this.type,
      this.uid,
      this.tid,
      this.cid,
      this.mid,
      this.text = '',
      this.html = '',
      this.translate,
      this.ts,
      this.comments = 0,
      this.edited,
      this.threadMeta});
}

class ThreadMetaParent {
  bool? root;
  DateTime? tsLastReply;
  int numReplies;
  List<String> participants;
  String message;

  ThreadMetaParent(
      {this.root, this.tsLastReply, this.numReplies = 0, this.participants = const [], this.message = ""});
}

class ThreadChildMessage {
  String? id;
  String? type;
  String? uid;
  String? tid;
  String? cid;
  String? mid;
  String text;
  String html;
  bool? translate;
  DateTime? ts;
  int comments;
  DateTime? edited;
  ThreadMetaChild? threadMeta;

  ThreadChildMessage(
      {this.id,
      this.type,
      this.uid,
      this.tid,
      this.cid,
      this.mid,
      this.text = '',
      this.html = '',
      this.translate,
      this.ts,
      this.comments = 0,
      this.edited,
      this.threadMeta});
}

class ThreadMetaChild {
  bool? root;
  String? pmid;
  bool showOnChannel;

  ThreadMetaChild({this.root, this.pmid, this.showOnChannel = false});
}

class ThreadCreateModel {}
