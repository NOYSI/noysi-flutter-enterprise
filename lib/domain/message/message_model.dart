import 'dart:convert';
import 'dart:io';

import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/thread/thread_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/text_parser_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

import '../../enums.dart';
import 'package:code/utils/extensions.dart';

class MessageWrapperModel {
  List<MessageModel> list;
  bool? more;
  BulkLoadMessages? bulkLoadMessages;

  MessageWrapperModel({this.list = const [], this.more = false, this.bulkLoadMessages});
}

class FolderModel {
  String tid;
  String cid;
  String id;
  String path;
  DateTime? renamed;
  bool deleted;

  FolderModel(
      {this.id = '',
      this.path = '',
      this.tid = '',
      this.cid = '',
      this.renamed,
      this.deleted = false,});
}

class MessageModel {
  String id;
  String type;
  String uid;
  String tid;
  String cid;
  String? mid;
  String text;
  DateTime? ts;
  String? html;
  bool translate;
  bool favorite;
  int comments;
  List<String> announcements;
  List<String> mentions;
  List<String> links;
  List<ReactionsModel> reactions;
  Arguments? args;
  List<MessageExtraModel> extra;
  MessageStatus? messageStatus;
  String? ack;
  String? from;
  DateTime? edited;
  ThreadMetaParent? threadMetaParent;
  ThreadMetaChild? threadMetaChild;
  MessageModel? answerMessage;

  String? subType;
  FileModel? fileModel;

  List<FolderModel> folders;

  bool get isTaskNotification =>
      (subType ?? "") == RemoteConstants.taskNotification;

  String get taskEvent {
    String event = "";
    switch (args?.event) {
      case RemoteConstants.task_created:
        {
          event = "${R.string.hasCreatedTask}:";
          break;
        }
      case RemoteConstants.task_closed:
        {
          event = "${R.string.hasClosedTask}:";
          break;
        }
      case RemoteConstants.task_reopened:
        {
          event = "${R.string.hasReopenedTask}:";
          break;
        }
      case RemoteConstants.task_title_edited:
        {
          event = "${R.string.hasEditedTask}:";
          break;
        }
      case RemoteConstants.task_due_updated:
        {
          if (args?.newDue != null && args?.oldDue == null) {
            event =
                "${R.string.hasAssignedNewDueDateFor} ${CalendarUtils.showInFormat(R.string.dateFormat5, args!.newDue!)?.toLowerCase()}";
          } else {
            event =
                "${args?.newDue == null ? R.string.hasRemovedEndDateTask : R.string.hasUpdatedDateTask}: ${CalendarUtils.showInFormat(R.string.dateFormat5, args?.oldDue ?? DateTime.now())}";
            if (args?.newDue != null) {
              event =
                  "$event ${R.string.to.toLowerCase()} ${CalendarUtils.showInFormat(R.string.dateFormat5, args!.newDue!)?.toLowerCase()}";
            }
          }
          event = "$event ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
      case RemoteConstants.task_comment_added:
        {
          event =
              "${R.string.hasCommentedTask} ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
      case RemoteConstants.task_comment_deleted:
        {
          event =
              "${R.string.hasDeletedCommentTask} ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
      case RemoteConstants.task_comment_edited:
        {
          event =
              "${R.string.hasEditedCommentTask} ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
      case RemoteConstants.task_milestone_set:
        {
          event =
              "${R.string.hasSetMilestone} ${args?.name} ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
      case RemoteConstants.task_assignee_added:
        {
          event =
              "${R.string.hasAssignedUser} @${args?.assigneeName} ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
      case RemoteConstants.task_assignee_deleted:
        {
          event =
              "${R.string.hasUnAssignedUser} @${args?.assigneeName} ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
      case RemoteConstants.task_label_deleted:
        {
          event =
              "${R.string.hasDeleteTag} ${args?.name} ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
      case RemoteConstants.task_label_added:
        {
          event =
              "${R.string.hasAddedTag} ${args?.name} ${R.string.inTheTask.toLowerCase()}:";
          break;
        }
    }

    return event;
  }

  bool get isFileComment => (subType ?? "") == RemoteConstants.fileComment;

  bool get isFile => fileModel != null;

  bool get isNoysiRobotMessage => uid == RemoteConstants.noysiRobot;

  bool get isNoysiWelcomeMessageFirstName =>
      isNoysiRobotMessage && text == RemoteConstants.welcomeFirstName;

  String get getNoysiWelcomeMessageFirstName =>
      R.string.welcomeToNoysiFirstName;

  bool get isNoysiWelcomeMessageLastName =>
      isNoysiRobotMessage && text == RemoteConstants.welcomeLastName;

  String get getNoysiWelcomeMessageLastName => R.string.welcomeToNoysiLastName(
      Injector.instance.inMemoryData.currentMember?.profile?.firstName ?? '');

  bool get isNoysiWelcomeMessageDescription =>
      isNoysiRobotMessage && text == RemoteConstants.welcomeDescriptions;

  String get getNoysiWelcomeMessageDescription =>
      R.string.welcomeToNoysiDescription;

  bool get isNoysiWelcomeMessageTimeOut =>
      isNoysiRobotMessage && text == RemoteConstants.welcomeTimeout;

  String get getNoysiWelcomeMessageTimeoutContent =>
      "${R.string.welcomeToNoysiTimeout} \n ${R.string.downloadAppsAndSynchronizer}";

  bool get isNoysiWelcomeMessageInvite =>
      isNoysiRobotMessage && text == RemoteConstants.welcomeInvite;

  String get getNoysiWelcomeMessageInvite => R.string.welcomeToNoysiInvite;

  bool get isNoysiWelcomeMessageDownloads =>
      isNoysiRobotMessage && text == RemoteConstants.welcomeDownloads;

  String get getNoysiWelcomeMessageDownloads =>
      R.string.downloadAppsAndSynchronizer;

  bool get isChannelsMemberJoined =>
      text.trim().toLowerCase() == RemoteConstants.channelMemberJoined;

  String getChannelsMemberJoinedContent(MemberModel? member) =>
      R.string.userHasJoined(CommonUtils.getMemberUsername(member) ?? "");

  bool get isChannelsMemberLeft =>
      text.trim().toLowerCase() == RemoteConstants.channelMemberLeft;

  String getChannelsMemberLeftContent(MemberModel? member) =>
      R.string.userHasLeft(CommonUtils.getMemberUsername(member) ?? "");

  bool get isPinnedMessageNotification => text.trim().toLowerCase() == RemoteConstants.channelMessagePinned;

  String getChannelMessagePinned(MemberModel? member) => R.string.userHasPinnedMessage(CommonUtils.getMemberUsername(member) ?? "");

  bool get isUnpinnedMessageNotification => text.trim().toLowerCase() == RemoteConstants.channelMessageUnpinned;

  String getChannelMessageUnpinned(MemberModel? member) => R.string.userHasUnpinnedMessage(CommonUtils.getMemberUsername(member) ?? "");

  bool get hasAnswerMessage =>
      links.isNotEmpty == true &&
      text.contains(links[0]) &&
      links[0].contains("a/#/messages");

  String get getAnswerMessageId =>
      links.isNotEmpty == true ? links[0].split("/").last : "";

  String get getAnswerMessageContent =>
      links.isNotEmpty == true && text.contains(links[0]) && links[0].contains("#/messages")
          ? parsedMessage.replaceAll(links[0], "").trim()
          : parsedMessage;

  bool get isThreadDeletedMessage =>
      text == RemoteConstants.threadMessageDeleted;

  bool get hasYoutubeVideos => links.firstWhereOrNull((element) => element.toLowerCase().contains("youtu.be") || element.toLowerCase().contains("youtube.com/watch")) != null;

  List<String> get getYoutubeLinks => links.where((element) => element.toLowerCase().contains("youtu.be") || element.toLowerCase().contains("youtube.com/watch")).toList();

  bool get isIntegrationMessage =>
      text.startsWith(RemoteConstants.integrationMessage) &&
      (uid.startsWith(RemoteConstants.integrationMessageGithub) ||
          uid.startsWith(RemoteConstants.integrationMessageTrello) ||
          uid.startsWith(RemoteConstants.integrationMessageZendesk));

  String get getIntegrationMessageContent {
    switch (text) {
      case RemoteConstants.integration_zendesk_ticket_updated:
        {
          return R.string.zendeskTicketUpdated(
              args?.zendeskTicket?.username ?? '',
              args?.zendeskTicket?.status ?? '',
              args?.zendeskTicket?.type ?? '',
              args?.zendeskTicket?.title ?? '',
              args?.zendeskTicket?.url ?? '');
        }
      case RemoteConstants.integration_github_push:
        {
          return R.string
              .newPush(args?.user ?? '', args?.repository?.name ?? '', args?.repository?.url ?? '');
        }
      case RemoteConstants.integration_github_issue_unassigned:
        {
          return R.string
              .unassignedTask(args?.repository?.name ?? '', args?.repository?.url ?? '');
        }
      case RemoteConstants.integration_trello_card_create:
        {
          return R.string.cardTrelloCreate(
              args?.trelloBoardModel?.name ?? '',
              args?.trelloBoardModel?.url ?? '',
              args?.trelloCardModel?.name ?? '',
              args?.trelloCardModel?.url ?? '',
              args?.trelloListModel?.name ?? '');
        }
      case RemoteConstants.integration_trello_card_archive:
        {
          return R.string.cardTrelloArchive(
              args?.trelloBoardModel?.name ?? '',
              args?.trelloBoardModel?.url ?? '',
              args?.trelloCardModel?.name ?? '',
              args?.trelloCardModel?.url ?? '',
              args?.trelloListModel?.name ?? '');
        }
      case RemoteConstants.integration_trello_card_description_change:
        {
          return R.string.cardTrelloDescriptionChange(
              args?.trelloBoardModel?.name ?? '',
              args?.trelloBoardModel?.url ?? '',
              args?.trelloCardModel?.name ?? '',
              args?.trelloCardModel?.url ?? '',
              args?.trelloListModel?.name ?? '',
              args?.trelloExtraModel?.description ?? '');
        }
      case RemoteConstants.integration_trello_card_moveToOtherList:
        {
          return R.string.cardTrelloMoveToOtherList(
              args?.trelloBoardModel?.name ?? '',
              args?.trelloBoardModel?.url ?? '',
              args?.trelloCardModel?.name ?? '',
              args?.trelloCardModel?.url ?? '',
              args?.trelloExtraModel?.listSource ?? '',
              args?.trelloExtraModel?.listTarget ?? '');
        }
      case RemoteConstants.integration_trello_card_rename:
        {
          return R.string.cardTrelloRename(
              args?.trelloBoardModel?.name ?? '',
              args?.trelloBoardModel?.url ?? '',
              args?.trelloExtraModel?.oldName ?? '',
              args?.trelloExtraModel?.newName ?? '',
              args?.trelloListModel?.name ?? '');
        }
      default:
        return text;
    }
  }

  bool get isFolderShareMessage =>
      subType != null && subType == RemoteConstants.folder_share;

  bool get isFolderUploadMessage =>
      subType != null && subType == RemoteConstants.folder_upload;

  bool get isFolderLinkMessage =>
      (subType != null && subType == RemoteConstants.folder_link) ||
      folders.isNotEmpty;

  String getFolderEventText() {
    if (subType != null) {
      switch (subType) {
        case RemoteConstants.folder_share:
          return R.string.folderShared;
        case RemoteConstants.folder_upload:
          return R.string.folderUploaded;
        default:
          return R.string.folderLinked;
      }
    }
    return '';
  }

  String get parsedMessage => TextUtilsParser.emojiParser(html ?? text);

  bool get isAdaptiveCard =>
      args?.attachments.isNotEmpty == true &&
      args?.attachments[0].contentType == "application/vnd.noysi.card.hero";

  MessageModel(
      {this.id = '',
      this.type = '',
      this.uid = '',
      this.messageStatus,
      this.answerMessage,
      this.threadMetaParent,
      this.threadMetaChild,
      this.ack = '',
      this.from = '',
      this.tid = '',
      this.ts,
      this.subType,
      this.fileModel,
      this.cid = '',
      this.mid,
      this.text = '',
      this.edited,
      this.html,
      this.translate = false,
      this.favorite = false,
      this.comments = 0,
      this.announcements = const [],
      this.mentions = const [],
      this.links = const [],
      this.reactions = const [],
      this.args,
      this.extra = const [],
      this.folders = const []});
}

class MessageComment {
  String id;
  String type;
  String? subtype;
  String uid;
  String tid;
  String cid;
  String? mid;
  String text;
  String? html;
  DateTime? ts;
  int comments;
  bool translate;
  List<String> announcements;
  List<String> mentions;
  List<String> links;
  Arguments? args;
  List<MessageExtraModel> extra;
  List<ReactionsModel> reactions;

  List<FolderModel> folders;

  bool get isFolderShareMessage =>
      subtype != null && subtype == RemoteConstants.folder_share;

  bool get isFolderUploadMessage =>
      subtype != null && subtype == RemoteConstants.folder_upload;

  bool get isFolderLinkMessage =>
      (subtype != null && subtype == RemoteConstants.folder_link) ||
      folders.isNotEmpty;

  MessageComment(
      {this.id = '',
      this.type = '',
      this.subtype,
      this.uid = '',
      this.tid = '',
      this.cid = '',
      this.mid,
      this.text = '',
      this.html,
      this.ts,
      this.comments = 0,
      this.translate = false,
      this.announcements = const [],
      this.mentions = const [],
      this.links = const [],
      this.args,
      this.extra = const [],
      this.reactions = const [],
      this.folders = const []});
}

class MessageExtraModel {
  String? providerUrl;
  String? description;
  String? title;
  double? thumbnailWidth, thumbnailHeight;
  String? url;
  String? html;
  String? thumbnailUrl;
  String? version;
  String? providerName;
  String type;

  MessageExtraModel(
      {this.providerName = '',
      this.providerUrl = '',
      this.description = '',
      this.title = '',
      this.url = '',
      this.html = '',
      this.thumbnailHeight,
      this.thumbnailWidth,
      this.thumbnailUrl = '',
      this.version = '',
      this.type = ''});
}

class Arguments {
  String event;
  String uid;
  String title;
  String ref;
  String taskId;
  String id;
  String name;
  String background;
  String color;
  String assignee;
  String assigneeName;
  String comment;
  DateTime? newDue;
  DateTime? oldDue;
  List<TaskLabelModel> labels;
  TaskMileStoneModel? milestone;
  List<String> assignees;

  DateTime? date;
  RepositoryModel? repository;
  List<CommitModel> commits;
  String url;
  String user;
  List<ArgumentAttachment> attachments;
  TrelloBoardModel? trelloBoardModel;
  TrelloCardModel? trelloCardModel;
  TrelloListModel? trelloListModel;
  TrelloExtraModel? trelloExtraModel;

  ZendeskTicketModel? zendeskTicket;

  ///Folders
  String tid;
  String cid;
  String path;
  String? channelOriginId;
  bool folder;
  DateTime? folderRenamed;
  bool? folderDeleted;

  String get parsedComment => TextUtilsParser.emojiParser(comment);

  Arguments({
    this.title = '',
    this.uid = '',
    this.event = '',
    this.ref = '',
    this.taskId = '',
    this.attachments = const [],
    this.id = '',
    this.name = '',
    this.background = '',
    this.color = '',
    this.assignee = '',
    this.assigneeName = '',
    this.comment = '',
    this.newDue,
    this.oldDue,
    this.labels = const [],
    this.milestone,
    this.assignees = const [],
    this.date,
    this.commits = const [],
    this.repository,
    this.url = '',
    this.user = '',
    this.trelloBoardModel,
    this.trelloCardModel,
    this.trelloListModel,
    this.trelloExtraModel,
    this.zendeskTicket,
    this.tid = '',
    this.cid = '',
    this.path = '',
    this.folder = false,
    this.channelOriginId = '',
    this.folderRenamed,
    this.folderDeleted = false,
  });
}

class ArgumentAttachment {
  String contentType;
  ArgumentAttachmentContent? content;

  ArgumentAttachment({this.contentType = '', this.content});
}

class ArgumentAttachmentContent {
  List<ArgumentAttachmentContentButton> buttons;
  ArgumentAttachmentContentButton? tap;
  String? bgColor;
  String? title;
  String? text;

  ArgumentAttachmentContent(
      {this.buttons = const [], this.bgColor, this.title = '', this.text = '', this.tap});

  bool get isGroupBtn => title.isNullOrEmpty();

  int? get getColorCode => int.tryParse(bgColor == "#f00"
      ? "0xfff44336"
      : (bgColor?.replaceAll("#", "0xff") ?? "0xff"));
}

class ArgumentAttachmentContentButton {
  String type;
  String title;
  String value;

  ArgumentAttachmentContentButton({this.type = '', this.title = '', this.value = ''});
}

class MessageCreateModel {
  String type;
  String text;
  String? id;

  MessageCreateModel({this.type = '', this.text = '', this.id});
}

class MessageDeletedModel {
  String tid;
  String cid;
  String id;
  String? pmid;

  MessageDeletedModel({this.tid = '', this.cid = '', this.id = '', this.pmid});
}

class ReactionsModel {
  String reactionKey;
  List<String> userIds;

  ReactionsModel({this.reactionKey = '', this.userIds = const []});

  static List<ReactionsModel> getReactions() {
    List<ReactionsModel> reactions = [];
    reactions.add(ReactionsModel(reactionKey: "1F600", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F601", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F62C", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F602", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F605", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F613", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F618", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F60D", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F60E", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F614", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F616", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F622", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F62D", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F621", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F592", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F593", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F44F", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F58F", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F590", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F4AA", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F480", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F47B", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F389", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F441", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F4A9", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F575", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F445", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "274E", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "2705", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0030-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0031-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0032-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0033-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0034-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0035-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0036-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0037-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0038-20E3", userIds: []));
    reactions
        .add(ReactionsModel(reactionKey: "0039-20E3", userIds: []));
    reactions.add(ReactionsModel(reactionKey: "1F51F", userIds: []));
    return reactions;
  }
}

class RepositoryModel {
  String name;
  String url;

  RepositoryModel({this.name = '', this.url = ''});
}

class CommitModel {
  CommitMemberModel? author;
  CommitMemberModel? committer;
  bool? distinct;
  String id;
  String message;
  String url;

  CommitModel(
      {this.author,
      this.committer,
      this.distinct,
      this.id = '',
      this.message = '',
      this.url = ''});
}

class CommitMemberModel {
  String email;
  String name;

  CommitMemberModel({this.email = '', this.name = ''});
}

class TrelloBoardModel {
  String id;
  String name;
  String url;

  TrelloBoardModel({this.id = '', this.name = '', this.url = ''});
}

class TrelloCardModel {
  String id;
  String name;
  String url;

  TrelloCardModel({this.id = '', this.name = '', this.url = ''});
}

class TrelloListModel {
  String id;
  String name;

  TrelloListModel({this.id = '', this.name = ''});
}

class TrelloExtraModel {
  String description, oldName, newName, listSource, listTarget;

  TrelloExtraModel({
    this.description = '',
    this.oldName = '',
    this.newName = '',
    this.listSource = '',
    this.listTarget = '',
  });
}

class ZendeskTicketModel {
  String username, title, status, type, ticketId, url;

  ZendeskTicketModel(
      {this.url = '',
      this.status = '',
      this.title = '',
      this.ticketId = '',
      this.type = '',
      this.username = ''});
}
