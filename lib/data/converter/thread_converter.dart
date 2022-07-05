import 'package:code/domain/file/i_file_converter.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/thread/i_thread_converter.dart';
import 'package:code/domain/thread/thread_model.dart';

class ThreadConverter implements IThreadConverter {
  final IFileConverter _iFileConverter;

  ThreadConverter(this._iFileConverter);

  @override
  ThreadModel fromJson(Map<String, dynamic> json) {
    ThreadModel model = ThreadModel(
      uid: json["uid"],
      tid: json["tid"],
      cid: json["cid"],
      pmid: json["pmid"],
      numReplies: json["numReplies"],
      participants: List.from(json["participants"]),
      tsLastReply:
          json.containsKey("tsLastReply") && json["tsLastReply"] != null
              ? DateTime.fromMillisecondsSinceEpoch(json["tsLastReply"],
                      isUtc: true)
                  .toLocal()
              : null,
      tsLastReadByUser: (json.containsKey("tsLastReadByUser") &&
              json["tsLastReadByUser"] != null)
          ? DateTime.fromMillisecondsSinceEpoch(json["tsLastReadByUser"],
                  isUtc: true)
              .toLocal()
          : null,
      parentMessage: fromJsonThreadMessage(json["parentMessage"]),
      childMessages: (json["childMessages"] as List<dynamic>)
          .map((e) => fromJsonThreadMessage(e))
          .toList(),
    );
    return model;
  }

  @override
  MessageModel fromJsonThreadMessage(Map<String, dynamic> json) {
    String? subType = json.containsKey("subtype") ? json["subtype"] : "";
    final MessageModel model = MessageModel(
      id: json["id"],
      type: json["type"],
      subType: subType,
      fileModel: subType != null && subType == 'file'
          ? _iFileConverter.fromJson(json)
          : null,
      uid: json["uid"],
      folders: json.containsKey('folders')
          ? (json["folders"] as List<dynamic>)
          .map((e) => _iFileConverter.fromJsonFolder(e))
          .toList()
          : [],
      tid: json["tid"],
      cid: json["cid"],
      mid: json["mid"],
      text: json["text"],
      html: json["html"],
      edited: json.containsKey("edited") && json["edited"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["edited"], isUtc: true)
              .toLocal()
          : null,
      ts: json.containsKey("ts") && json["ts"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["ts"], isUtc: true)
              .toLocal()
          : null,
      threadMetaParent: json.containsKey("threadmeta")
          ? (json["threadmeta"]["root"] == true
              ? fromJsonThreadMetaParent(json["threadmeta"])
              : null)
          : null,
      threadMetaChild: json.containsKey("threadmeta")
          ? (json["threadmeta"]["root"] == false
              ? fromJsonThreadMetaChild(json["threadmeta"])
              : null)
          : null,
      ack: json.containsKey("ack") ? json["ack"] : null,
      from: json.containsKey("from") ? json["from"] : null,
      translate: json.containsKey("translate") ? json["translate"] : false,
      favorite: json.containsKey("favorite") ? json["favorite"] : false,
      comments: json.containsKey("comments") ? json["comments"] : 0,
      links: json.containsKey("links") ? List.from(json["links"]) : [],
      reactions: json.containsKey("reactions")
          ? fromJsonReaction(json["reactions"])
          : [],
      announcements: json.containsKey("announcements")
          ? List.from(json["announcements"])
          : [],
    );
    return model;
  }

  @override
  List<ReactionsModel> fromJsonReaction(Map<String, dynamic> json) {
    List<ReactionsModel> list = [];
    json.forEach((key, value) {
      final model = ReactionsModel(reactionKey: key, userIds: List.from(value));
      list.add(model);
    });
    return list;
  }

  @override
  ThreadMetaParent fromJsonThreadMetaParent(Map<String, dynamic> json) {
    final ThreadMetaParent model = ThreadMetaParent(
        root: json["root"],
        tsLastReply:
            json.containsKey("tslastreply") && json["tslastreply"] != null
                ? DateTime.fromMillisecondsSinceEpoch(json["tslastreply"],
                        isUtc: true)
                    .toLocal()
                : null,
        numReplies: json["numreplies"],
        participants: List.from(json["participants"]));
    return model;
  }

  @override
  ThreadMetaChild fromJsonThreadMetaChild(Map<String, dynamic> json) {
    final ThreadMetaChild model = ThreadMetaChild(
        root: json["root"],
        pmid: json["pmid"],
        showOnChannel: json["showonchannel"]);
    return model;
  }

  @override
  Map<String, dynamic> toJsonCreate(json) {
    // TODO: implement toJsonCreate
    throw UnimplementedError();
  }
}
