import 'dart:ui';

import 'package:code/utils/text_parser_utils.dart';
import 'package:collection/collection.dart';

import '../../_res/R.dart';

class TaskStatsModel {
  List<TaskModel> list;
  int offset;
  int total;
  TaskStatsStatisticsModel? statistics;

  TaskStatsModel(
      {this.list = const [], this.offset = 0, this.total = 0, this.statistics});
}

class TaskStatsStatisticsModel {
  int open;
  int closed;

  TaskStatsStatisticsModel({this.open = 0, this.closed = 0});
}

class HTMLTaskModel {
  String? html;
  List<String> links;

  HTMLTaskModel({this.html = '', this.links = const []});
}

class UutModel {
  String id, tid, uid, taskId, type;

  UutModel(this.id, this.tid, this.uid, this.taskId, this.type);
}

class TaskModel {
  String id;
  String? tid;
  String? cid;
  String? uid;
  String title;
  DateTime? created;
  int? code;
  String state;
  DateTime? due;
  DateTime? end;
  int comments;
  List<String> assignees;
  List<TaskLabelModel> labels;
  List<TaskParticipantsModel> participants;
  TaskMileStoneModel? milestone;
  List<TaskTimeLineModel> timeLine;
  List<dynamic> assets;
  String? meetingUrl;
  String description;
  HTMLTaskModel? htmlDescription;
  HTMLTaskModel? htmlLocation;
  String type;
  String location;
  bool isAllDay;
  List<UutModel> uuts;

  bool get marked =>
      this.uuts.firstWhereOrNull((element) => element.taskId == this.id) ==
      null;

  UutModel? get uut =>
      this.uuts.firstWhereOrNull((element) => element.taskId == this.id);

  bool get isOpen => state == 'open';

  bool get isMeetingAppointment => meetingUrl?.isNotEmpty == true;

  bool get isGoogleCalendar => type == "google-calendar";

  bool get isOutlookCalendar => type == "outlook-calendar";

  bool get isNativeGoogleCalendar => type == "google-calendar-native";

  bool get isNativeOutlookCalendar => type == "outlook-calendar-native";

  bool get isAllPlatforms => type == "all-platforms";

  bool get isNoysiCalendar =>
      !isGoogleCalendar &&
      !isOutlookCalendar &&
      !isNativeGoogleCalendar &&
      !isNativeOutlookCalendar &&
      !isAllPlatforms;

  Color backgroundColor(String uid) =>
      isGoogleCalendar || isNativeGoogleCalendar
          ? Color(0xffDB4437)
          : isOutlookCalendar || isNativeOutlookCalendar
              ? Color(0xff0072c6)
              : uid != this.uid
                  ? R.color.secondaryHeaderColor
                  : R.color.secondaryColor;

  TaskModel(
      {this.id = '',
      this.tid = '',
      this.cid,
      this.uid = '',
      this.created,
      this.code,
      this.state = '',
      this.title = '',
      this.description = '',
      this.due,
      this.end,
      this.uuts = const [],
      this.comments = 0,
      this.assignees = const [],
      this.participants = const [],
      this.milestone,
      this.labels = const [],
      this.timeLine = const [],
      this.htmlDescription,
      this.htmlLocation,
      this.location = '',
      this.assets = const [],
      this.meetingUrl,
      this.type = '',
      this.isAllDay = false});
}

class TaskParticipantsModel {
  String uid;
  String name;
  String photo;

  TaskParticipantsModel({this.uid = '', this.name = '', this.photo = ''});
}

class TaskMileStoneModel {
  String id;
  String tid;
  String cid;
  String title;
  String description;
  DateTime? due;
  String state;
  DateTime? updated;
  TaskStatsStatisticsModel? statistics;

  TaskMileStoneModel(
      {this.id = '',
      this.tid = '',
      this.cid = '',
      this.title = '',
      this.statistics,
      this.description = '',
      this.due,
      this.state = '',
      this.updated});
}

class TaskLabelModel {
  String id;
  String? tid;
  String? cid;
  String name;
  String background;
  String text;
  int taskCount;

  TaskLabelModel(
      {this.id = '',
      this.tid,
      this.cid,
      this.name = '',
      this.background = '',
      this.text = '',
      this.taskCount = 0});
}

class TaskLabelCreateModel {
  String background;
  String name;
  String text;

  TaskLabelCreateModel({this.background = '', this.name = '', this.text = ''});
}

class TaskTimeLineModel {
  String type;
  DateTime? created;
  TaskTimeLineMemberModel? creator;
  String text;
  String? oldTitle;
  String? newTitle;
  DateTime? oldDue;
  DateTime? newDue;
  DateTime? lastUpdated;
  TaskTimeLineMemberModel? assignee;
  TaskTimeLineLabelModel? label;
  TaskTimeLineMilestoneModel? milestone;

  String get parsedComment => TextUtilsParser.emojiParser(text, removeUploadedFilesExpression: false);

  TaskTimeLineModel(
      {this.type = '',
      this.text = '',
      this.lastUpdated,
      this.creator,
      this.created,
      this.milestone,
      this.oldTitle = '',
      this.oldDue,
      this.newDue,
      this.newTitle = '',
      this.label,
      this.assignee});
}

class TaskTimeLineMemberModel {
  String uid;
  String name;

  TaskTimeLineMemberModel({this.uid = '', this.name = ''});
}

class TaskTimeLineMilestoneModel {
  String? id;
  String title;

  TaskTimeLineMilestoneModel({this.id, this.title = ''});
}

class TaskTimeLineLabelModel {
  String? id;
  String name;
  String background;
  String text;

  TaskTimeLineLabelModel(
      {this.id, this.name = '', this.background = '', this.text = ''});
}

class TaskCreateUIModel {
  List<TaskLabelModel> labels;
  DateTime? due;
  DateTime? end;
  bool isAllDay;
  TaskMileStoneModel? milestone;
  List<String> assignees;
  String? cid;
  List<String> filePaths;

  TaskCreateUIModel(
      {this.labels = const [],
      this.due,
      this.milestone,
      this.assignees = const [],
      this.end,
      this.isAllDay = false,
      this.cid,
      this.filePaths = const []});
}

class TaskCreateModel {
  String title;
  String text;
  List<String> labels;
  DateTime? due;
  DateTime? end;
  bool isAllDay;
  String milestone;
  List<String> assignees;
  String? cid;
  String meetingUrl;
  String location;

  TaskCreateModel(
      {this.title = '',
      this.text = '',
      this.labels = const [],
      this.due,
      this.end,
      this.isAllDay = false,
      this.assignees = const [],
      this.milestone = '',
      this.cid,
      this.meetingUrl = '',
      this.location = ''});
}

class TaskMilestoneCreateModel {
  String description;
  DateTime? due;
  String title;

  TaskMilestoneCreateModel({this.description = '', this.due, this.title = ''});
}
