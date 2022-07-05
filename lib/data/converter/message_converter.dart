import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/file/i_file_converter.dart';
import 'package:code/domain/message/i_message_converter.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/task/i_task_converter.dart';
import 'package:code/domain/thread/i_thread_converter.dart';

class MessageConverter implements IMessageConverter {
  final IFileConverter _iFileConverter;
  final IThreadConverter _iThreadConverter;
  final ITaskConverter _taskConverter;

  MessageConverter(
      this._iFileConverter, this._iThreadConverter, this._taskConverter);

  @override
  MessageModel fromJson(Map<String, dynamic> json) {
    String? subType = json.containsKey("subtype") ? json["subtype"] : "";
    final MessageModel model = MessageModel(
      id: json["id"],
      type: json["type"],
      subType: subType,
      fileModel: subType != null && subType == 'file'
          ? _iFileConverter.fromJson(json)
          : null,
      uid: json["uid"],
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
              ? _iThreadConverter.fromJsonThreadMetaParent(json["threadmeta"])
              : null)
          : null,
      threadMetaChild: json.containsKey("threadmeta")
          ? (json["threadmeta"]["root"] == false
              ? _iThreadConverter.fromJsonThreadMetaChild(json["threadmeta"])
              : null)
          : null,
      ack: json.containsKey("ack") ? json["ack"] : null,
      from: json.containsKey("from") ? json["from"] : null,
      translate: json.containsKey("translate") && json["translate"] != null ? json["translate"] : false,
      favorite: json.containsKey("favorite") && json["favorite"] != null ? json["favorite"] : false,
      comments: json.containsKey("comments") && json["comments"] != null ? json["comments"] : 0,
      links: json.containsKey("links") && json["links"] != null ? List.from(json["links"]) : [],
      reactions: json.containsKey("reactions")
          ? fromJsonReaction(json["reactions"])
          : [],
      announcements: json.containsKey("announcements")
          ? List.from(json["announcements"])
          : [],
      extra: json.containsKey("extra")
          ? (json["extra"] as List<dynamic>)
              .map((e) => fromJsonExtra(e))
              .toList()
          : [],
      folders: json.containsKey('folders')
          ? (json["folders"] as List<dynamic>)
              .map((e) => _iFileConverter.fromJsonFolder(e))
              .toList()
          : [],
      args: json.containsKey("args") && json["args"] != null
          ? subType != null &&
                  (subType == RemoteConstants.folder_share ||
                      subType == RemoteConstants.folder_upload)
              ? fromJsonMessageFolderArguments(json["args"])
              : fromJsonMessageArguments(json["args"])
          : null,
      mentions: json.containsKey("mentions") ? List.from(json["mentions"]) : [],
    );
    return model;
  }

  @override
  MessageExtraModel fromJsonExtra(Map<String, dynamic> json) {
    final MessageExtraModel model = MessageExtraModel(
        providerUrl: json["provider_url"],
        providerName: json["provider_name"],
        description: json["description"],
        title: json["title"],
        url: json["url"],
        html: json["html"],
        version: json["version"],
        thumbnailWidth: json['thumbnail_width'] != null
            ? json['thumbnail_width'] * 1.0
            : null,
        thumbnailHeight: json['thumbnail_height'] != null
            ? json['thumbnail_height'] * 1.0
            : null,
        thumbnailUrl: json['thumbnail_url'],
        type: json["type"]);
    return model;
  }

  @override
  MessageWrapperModel fromJsonWrapper(Map<String, dynamic> json) {
    MessageWrapperModel model = MessageWrapperModel(
        list: (json["list"] as List<dynamic>).map((e) => fromJson(e)).toList(),
        more: json["more"]);
    return model;
  }

  @override
  MessageComment fromJsonComment(Map<String, dynamic> json) {
    MessageComment model = MessageComment(
      id: json["id"],
      type: json["type"],
      subtype: json.containsKey("subtype") ? json["subtype"] : null,
      uid: json["uid"],
      tid: json["tid"],
      cid: json["cid"],
      mid: json["mid"],
      text: json["text"],
      html: json["html"],
      folders: json.containsKey('folders')
          ? (json["folders"] as List<dynamic>)
              .map((e) => _iFileConverter.fromJsonFolder(e))
              .toList()
          : [],
      ts: json.containsKey("ts") && json["ts"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["ts"], isUtc: true)
              .toLocal()
          : null,
      translate: json["translate"],
      announcements: json.containsKey("announcements")
          ? List.from(json["announcements"])
          : [],
      extra: json.containsKey("extra")
          ? (json["extra"] as List<dynamic>)
              .map((e) => fromJsonExtra(e))
              .toList()
          : [],
      args: json.containsKey("args") && json["args"] != null
          ? fromJsonMessageArguments(json["args"])
          : null,
      mentions: json.containsKey("mentions") ? List.from(json["mentions"]) : [],
      links: json.containsKey("links") ? List.from(json["links"]) : [],
      reactions: json.containsKey("reactions")
          ? fromJsonReaction(json["reactions"])
          : [],
    );
    return model;
  }

  // @override
  // Map<String, dynamic> toJsonCreate(MessageCreateModel model) {
  //   throw UnimplementedError();
  // }

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
  Arguments fromJsonMessageFolderArguments(Map<String, dynamic> json) {
    return Arguments(
      cid: json['cid'],
      tid: json['tid'],
      uid: json['uid'],
      folder: true,
      id: json['id'],
      path: json['path'],
      folderRenamed: json.containsKey('renamed')
          ? DateTime.fromMillisecondsSinceEpoch(json["renamed"], isUtc: true)
              .toLocal()
          : null,
      channelOriginId: json.containsKey('origin') ? json['origin'] : null,
    );
  }

  @override
  Arguments fromJsonMessageArguments(Map<String, dynamic> json) {
    DateTime? newDue;
    DateTime? oldDue;
    DateTime? date;
    if (json.containsKey("newDue") && json["newDue"] != null) {
      final map = json["newDue"];
      final long = int.tryParse(map["\$numberLong"]);
      newDue = long != null
          ? DateTime.fromMillisecondsSinceEpoch(long, isUtc: true).toLocal()
          : null;
    }
    if (json.containsKey("oldDue") && json["oldDue"] != null) {
      final map = json["oldDue"];
      final long = int.tryParse(map["\$numberLong"]);
      oldDue = long != null
          ? DateTime.fromMillisecondsSinceEpoch(long, isUtc: true).toLocal()
          : null;
    }
    if (json.containsKey("date") && json["date"] != null) {
      bool isStandard = (json["date"]).toString().contains('-');
      date = isStandard
          ? DateTime.tryParse(json["date"])?.toLocal()
          : DateTime.fromMillisecondsSinceEpoch(json["date"], isUtc: true)
              .toLocal();
    }
    Arguments model = Arguments(
      id: json["id"] ?? "",
      ref: json["ref"] ?? "",
      event: json["event"] ?? "",
      uid: json["uid"] ?? "",
      title: json["title"] ?? "",
      taskId: json["taskId"] ?? "",
      name: json["name"] ?? "",
      background: json["background"] ?? "",
      color: json["color"] ?? "",
      assignee: json["assignee"] ?? "",
      assigneeName: json["assigneeName"] ?? "",
      comment: json["comment"] ?? "",
      milestone: json.containsKey("milestone") && json["milestone"] != null
          ? _taskConverter.fromJsonTaskMilestone(json["milestone"])
          : null,
      newDue: newDue,
      oldDue: oldDue,
      labels: json.containsKey("labels") && json["labels"] != null
          ? (json["labels"] as List<dynamic>)
              .map((e) => _taskConverter.fromJsonTaskLabel(e))
              .toList()
          : [],
      assignees: json.containsKey("assignees") && json["assignees"] != null
          ? List.from(json["assignees"])
          : [],
      date: date,
      repository: json.containsKey("repository")
          ? fromJsonRepositoryModel(json["repository"])
          : null,
      commits: json.containsKey("commits")
          ? (json["commits"] as List<dynamic>)
              .map((e) => fromJsonCommitModel(e))
              .toList()
          : [],
      url: json["url"] ??  "",
      user: json["user"] ?? "",
      zendeskTicket: json.containsKey('ticket')
          ? fromJsonZendeskTicketModel(json['ticket'])
          : null,
      trelloBoardModel: json.containsKey("board")
          ? fromJsonTrelloBoardModel(json["board"])
          : null,
      trelloCardModel: json.containsKey("card")
          ? fromJsonTrelloCardModel(json["card"])
          : null,
      trelloListModel: json.containsKey("list")
          ? fromJsonTrelloListModel(json["list"])
          : null,
      trelloExtraModel: TrelloExtraModel(
        description: json.containsKey("desc") && json["desc"] != null ? json["desc"] : '',
        oldName: json.containsKey("old") && json["old"] != null ? json["old"] : '',
        newName: json.containsKey("new") && json["new"] != null ? json["new"] : '',
        listSource: json.containsKey("source") && json["source"] != null ? json["source"] : '',
        listTarget: json.containsKey("target") && json["target"] != null ? json["target"] : '',
      ),
      attachments: json.containsKey("attachments")
          ? (json["attachments"] as List<dynamic>)
              .map((e) => fromJsonMessageArgumentsAttachments(e))
              .toList()
          : [],
    );
    return model;
  }

  @override
  CommitMemberModel fromJsonCommitMemberModel(Map<String, dynamic> json) {
    final CommitMemberModel model =
        CommitMemberModel(email: json["email"], name: json["name"]);
    return model;
  }

  @override
  CommitModel fromJsonCommitModel(Map<String, dynamic> json) {
    final CommitModel model = CommitModel(
        author: fromJsonCommitMemberModel(json["author"]),
        committer: fromJsonCommitMemberModel(json["committer"]),
        distinct: json["distinct"],
        id: json["id"],
        message: json["message"],
        url: json["url"]);
    return model;
  }

  @override
  RepositoryModel fromJsonRepositoryModel(Map<String, dynamic> json) {
    RepositoryModel model =
        RepositoryModel(name: json["name"], url: json["url"]);
    return model;
  }

  @override
  TrelloBoardModel fromJsonTrelloBoardModel(Map<String, dynamic> json) {
    TrelloBoardModel model =
        TrelloBoardModel(id: json["id"], name: json["name"], url: json["url"]);
    return model;
  }

  @override
  TrelloCardModel fromJsonTrelloCardModel(Map<String, dynamic> json) {
    TrelloCardModel model =
        TrelloCardModel(id: json["id"], name: json["name"], url: json["url"]);
    return model;
  }

  @override
  TrelloListModel fromJsonTrelloListModel(Map<String, dynamic> json) {
    TrelloListModel model = TrelloListModel(id: json["id"], name: json["name"]);
    return model;
  }

  @override
  ZendeskTicketModel fromJsonZendeskTicketModel(Map<String, dynamic> json) {
    return ZendeskTicketModel(
        title: json['title'],
        status: json['status'],
        ticketId: json['id'],
        type: json['type'],
        url: json['url'],
        username: json['username']);
  }

  @override
  ArgumentAttachment fromJsonMessageArgumentsAttachments(
      Map<String, dynamic> json) {
    ArgumentAttachment model = ArgumentAttachment(
        contentType: json["contentType"],
        content: fromJsonMessageArgumentsAttachmentsContent(json["content"]));
    return model;
  }

  @override
  ArgumentAttachmentContent fromJsonMessageArgumentsAttachmentsContent(
      Map<String, dynamic> json) {
    ArgumentAttachmentContent model = ArgumentAttachmentContent(
      buttons: json.containsKey("buttons")
          ? (json["buttons"] as List<dynamic>)
              .map((e) => fromJsonMessageArgumentsAttachmentsContentButton(e))
              .toList()
          : [],
      tap: json.containsKey("tap")
          ? fromJsonMessageArgumentsAttachmentsContentButton(json["tap"])
          : null,
      bgColor: json.containsKey("bgcolor") ? json["bgcolor"] : null,
      title: json["title"],
      text: json.containsKey("text") ? json["text"] : "",
    );
    return model;
  }

  @override
  ArgumentAttachmentContentButton
      fromJsonMessageArgumentsAttachmentsContentButton(
          Map<String, dynamic> json) {
    ArgumentAttachmentContentButton model = ArgumentAttachmentContentButton(
        type: json["type"] ?? "",
        title: json["title"] ?? "",
        value: json["value"] ?? "");
    return model;
  }
}
