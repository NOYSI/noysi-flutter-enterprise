import 'package:code/domain/integration_status.dart';
import 'package:code/domain/task/i_task_converter.dart';
import 'package:code/domain/task/task_model.dart';

class TaskConverter implements ITaskConverter {
  @override
  TaskStatsModel fromJson(Map<String, dynamic> json) {
    final TaskStatsModel model = TaskStatsModel(
        list: (json["list"] as List<dynamic>)
                .map((e) => fromJsonTask(e))
                .toList(),
        offset: json["offset"] ?? 0,
        total: json["total"] ?? 0,
        statistics: json.containsKey("statistics") && json["statistics"] != null
            ? fromJsonTaskStatsStatisticsModel(json["statistics"])
            : null);
    return model;
  }

  @override
  HTMLTaskModel fromJsonHtml(Map<String, dynamic> json) {
    return HTMLTaskModel(
      html: json.containsKey('html') ? json['html'] : null,
      links: json.containsKey('links') && json['links'] != null
          ? (json['links'] as List<dynamic>).map((e) => e.toString()).toList()
          : [],
    );
  }

  UutModel fromJsonUut(Map<String, dynamic> json) {
    return UutModel(json['id'], json['tid'], json['uid'], json['taskId'], json['type']);
  }

  @override
  TaskModel fromJsonTask(Map<String, dynamic> json,
      {bool mapFromCreateAction = false}) {
      final isAllDay = json.containsKey('isAllDay') && json['isAllDay'] != null
          ? json['isAllDay']
          : false;
      final TaskModel model = TaskModel(
          id: json["id"],
          tid: json.containsKey('tid') ? json["tid"] : null,
          cid: json.containsKey('cid') ? json["cid"] : null,
          uid: json.containsKey('uid') ? json["uid"] : null,
          title: json["title"] ?? "",
          location: json.containsKey("location") && json["location"] != null
              ? json["location"]
              : "",
          description: json.containsKey("description") && json['description'] != null
              ? json["description"]
              : "",
          htmlDescription:
          json.containsKey('html_description') && json['html_description'] != null
              ? fromJsonHtml(json['html_description'])
              : null,
          htmlLocation: json.containsKey('html_location') && json['html_location'] != null
              ? fromJsonHtml(json['html_location'])
              : null,
          type: json.containsKey('type') && json['type'] != null ? json['type'] : "noysi-calendar",
          meetingUrl:
          json.containsKey('meeting_url') ? json['meeting_url'] : null,
          created: json.containsKey("created") && json["created"] != null
              ? DateTime.fromMillisecondsSinceEpoch(json["created"], isUtc: true)
              .toLocal()
              : null,
          code: json.containsKey('code') ? json["code"] : null,
          state: json.containsKey('state') && json["state"] != null ? json["state"] : "open",
          due: (json.containsKey("due") && json["due"] != null)
              ? isAllDay
              ? DateTime.fromMillisecondsSinceEpoch(json["due"], isUtc: true)
              : DateTime.fromMillisecondsSinceEpoch(json["due"], isUtc: true)
              .toLocal()
              : null,
          end: (json.containsKey("end") && json["end"] != null)
              ? isAllDay
              ? DateTime.fromMillisecondsSinceEpoch(json["end"], isUtc: true)
              : DateTime.fromMillisecondsSinceEpoch(json["end"], isUtc: true)
              .toLocal()
              : null,
          isAllDay: isAllDay,
          comments: json.containsKey('comments') && json["comments"] != null ? json["comments"] : 0,
          milestone: (json.containsKey("milestone") && json["milestone"] != null)
              ? mapFromCreateAction
              ? null
              : fromJsonTaskMilestone(json["milestone"])
              : null,
          assignees: List.from(json["assignees"] ?? []),
          assets: List.from(json["assets"] ?? []),
          uuts: json['uut'] != null ? (json['uut'] as List<dynamic>).map((e) => fromJsonUut(e)).toList() : [],
          labels: json.containsKey("labels") && json['labels'] != null
              ? mapFromCreateAction
              ? []
              : (json["labels"] as List<dynamic>)
              .map((e) => fromJsonTaskLabel(e))
              .toList()
              : [],
          participants: (json.containsKey("participants") && json["participants"] != null)
              ? (json["participants"] as List<dynamic>).map((e) => fromJsonTaskParticipants(e)).toList()
              : [],
          timeLine: (json.containsKey("timeline") && json["timeline"] != null) ? (json["timeline"] as List<dynamic>).map((e) => fromJsonTaskTimeLine(e)).toList() : []);
      String? dueString = model.due?.toIso8601String().replaceAll("Z", "") ??
          model.created?.toIso8601String().replaceAll("Z", "");
      if(dueString != null) model.due = DateTime.tryParse(dueString);
      String? endString = model.end?.toIso8601String().replaceAll("Z", "");
      if(endString != null) model.end = model.end == null ? model.due : DateTime.tryParse(endString);
      return model;
  }

  @override
  CalendarIntegrationStatus fromJsonCalendarIntegrationStatus(
      Map<String, dynamic> json) {
    return CalendarIntegrationStatus(
        googleCalendar: json.containsKey('google-calendar')
            ? (json['google-calendar'] ?? false)
            : false,
        outlookCalendar: json.containsKey('outlook-calendar')
            ? (json['outlook-calendar'] ?? false)
            : false);
  }

  @override
  TaskLabelModel fromJsonTaskLabel(Map<String, dynamic> json) {
    final TaskLabelModel model = TaskLabelModel(
        id: json["id"],
        tid: json["tid"],
        cid: json["cid"],
        name: json["name"] ?? "",
        background: json["background"] ?? "",
        text: json["text"] ?? "",
        taskCount: json.containsKey("taskCount") ? (json["taskCount"] ?? 0) : 0);
    return model;
  }

  @override
  TaskMileStoneModel fromJsonTaskMilestone(Map<String, dynamic> json) {
    final TaskMileStoneModel model = TaskMileStoneModel(
        id: json["id"] ?? '',
        tid: json["tid"] ?? '',
        cid: json["cid"] ?? '',
        statistics: json.containsKey("statistics") && json["statistics"] != null
            ? fromJsonTaskStatsStatisticsModel(json["statistics"])
            : null,
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        due: (json.containsKey("due") && json["due"] != null)
            ? DateTime.fromMillisecondsSinceEpoch(json["due"], isUtc: true)
                .toLocal()
            : null,
        state: json["state"] ?? '',
        updated: json.containsKey("updated") && json["updated"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["updated"], isUtc: true)
                .toLocal()
            : null);
    return model;
  }

  @override
  TaskParticipantsModel fromJsonTaskParticipants(Map<String, dynamic> json) {
    final TaskParticipantsModel model = TaskParticipantsModel(
        uid: json["uid"] ?? "", name: json["name"] ?? "", photo: json["photo"] ?? "");
    return model;
  }

  @override
  TaskStatsStatisticsModel fromJsonTaskStatsStatisticsModel(
      Map<String, dynamic> json) {
    final TaskStatsStatisticsModel model =
        TaskStatsStatisticsModel(open: json["open"] ?? 0, closed: json["closed"] ?? 0);
    return model;
  }

  @override
  TaskTimeLineModel fromJsonTaskTimeLine(Map<String, dynamic> json) {
    try {
      final TaskTimeLineModel model = TaskTimeLineModel(
        type: json["type"],
        creator: json.containsKey("creator") && json["creator"] != null ? fromJsonTaskTimeLineMember(json["creator"]) : null,
        created: json.containsKey("created") && json["created"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["created"], isUtc: true)
                .toLocal()
            : null,
        text: (json.containsKey("text") && json["text"] != null)
            ? json["text"]
            : "",
        oldTitle: json.containsKey("oldTitle") ? json["oldTitle"] : null,
        newTitle: json.containsKey("newTitle") ? json["newTitle"] : null,
        oldDue: (json.containsKey("oldDue") && json["oldDue"] != null)
            ? DateTime.fromMillisecondsSinceEpoch(json["oldDue"], isUtc: true)
                .toLocal()
            : null,
        newDue: (json.containsKey("newDue") && json["newDue"] != null)
            ? DateTime.fromMillisecondsSinceEpoch(json["newDue"], isUtc: true)
                .toLocal()
            : null,
        lastUpdated:
            (json.containsKey("lastUpdated")) && json["lastUpdated"] != null
                ? DateTime.fromMillisecondsSinceEpoch(json["lastUpdated"],
                        isUtc: true)
                    .toLocal()
                : null,
        label: (json.containsKey("label") && json["label"] != null)
            ? fromJsonTaskTimeLineLabel(json["label"])
            : null,
        assignee: (json.containsKey("assignee") && json["assignee"] != null)
            ? fromJsonTaskTimeLineMember(json["assignee"])
            : null,
        milestone: (json.containsKey("milestone") && json["milestone"] != null)
            ? fromJsonTaskTimeLineMilestone(json["milestone"])
            : null,
      );

      return model;
    } catch (ex) {
//      print(ex);
      throw ex;
    }
  }

  @override
  TaskTimeLineLabelModel fromJsonTaskTimeLineLabel(Map<String, dynamic> json) {
    final TaskTimeLineLabelModel model = TaskTimeLineLabelModel(
        id: json["id"],
        name: json["name"] ?? "",
        background: json["background"] ?? "",
        text: json["text"] ?? "");
    return model;
  }

  @override
  TaskTimeLineMemberModel fromJsonTaskTimeLineMember(
      Map<String, dynamic> json) {
    final TaskTimeLineMemberModel model =
        TaskTimeLineMemberModel(uid: json["uid"] ?? "", name: json["name"] ?? "");
    return model;
  }

  @override
  TaskTimeLineMilestoneModel fromJsonTaskTimeLineMilestone(
      Map<String, dynamic> json) {
    final TaskTimeLineMilestoneModel model =
        TaskTimeLineMilestoneModel(id: json["id"], title: json["title"] ?? "");
    return model;
  }

  @override
  Map<String, dynamic> toJsonCreate(TaskCreateModel model) {
    final map = {
      "title": model.title,
      "description": model.text,
      "labels": model.labels,
      "due": (model.isAllDay == true)
          ? model.due?.millisecondsSinceEpoch
          : model.due?.toUtc().millisecondsSinceEpoch,
      "end": (model.isAllDay == true)
          ? model.end?.millisecondsSinceEpoch
          : model.end?.toUtc().millisecondsSinceEpoch,
      "isAllDay": model.isAllDay,
      "milestone":
          model.milestone.trim().isEmpty == true ? null : model.milestone,
      "assignees": model.assignees,
      "cid": model.cid,
      "meeting_url": model.meetingUrl,
      "location": model.location,
    };
    return map;
  }

  @override
  Map<String, dynamic> toJsonTaskMilestoneCreate(
      TaskMilestoneCreateModel model) {
    final map = {
      "title": model.title,
      "due": model.due?.toUtc().millisecondsSinceEpoch,
      "description": model.description
    };
    return map;
  }

  @override
  Map<String, dynamic> toJsonTaskMilestone(TaskMileStoneModel model) {
    final map = {
      "id": model.id,
      "description": model.description,
      "title": model.title,
      "cid": model.cid,
      "tid": model.tid,
      "due": model.due?.toUtc().millisecondsSinceEpoch,
    };
    return map;
  }

  @override
  Map<String, dynamic> toJsonTaskLabel(TaskLabelModel model) {
    final map = {
      "id": model.id,
      "tid": model.tid,
      "cid": model.cid,
      "name": model.name,
      "background": model.background,
      "text": model.text,
      "taskCount": model.taskCount
    };
    return map;
  }

  @override
  Map<String, dynamic> toJsonTaskLabelCreate(TaskLabelCreateModel model) {
    final map = {
      "background": model.background,
      "name": model.name,
      "text": model.text
    };
    return map;
  }
}
