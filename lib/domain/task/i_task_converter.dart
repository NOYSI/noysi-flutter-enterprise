import 'package:code/domain/task/task_model.dart';

import '../integration_status.dart';

abstract class ITaskConverter {
  TaskStatsModel fromJson(Map<String, dynamic> json);

  TaskStatsStatisticsModel fromJsonTaskStatsStatisticsModel(
      Map<String, dynamic> json);

  TaskModel fromJsonTask(Map<String, dynamic> json, {bool mapFromCreateAction = false});

  UutModel fromJsonUut(Map<String, dynamic> json);

  TaskMileStoneModel fromJsonTaskMilestone(Map<String, dynamic> json);

  HTMLTaskModel fromJsonHtml(Map<String, dynamic> json);

  TaskLabelModel fromJsonTaskLabel(Map<String, dynamic> json);

  CalendarIntegrationStatus fromJsonCalendarIntegrationStatus(Map<String, dynamic> json);

  TaskParticipantsModel fromJsonTaskParticipants(Map<String, dynamic> json);

  TaskTimeLineModel fromJsonTaskTimeLine(Map<String, dynamic> json);

  TaskTimeLineMemberModel fromJsonTaskTimeLineMember(Map<String, dynamic> json);

  TaskTimeLineMilestoneModel fromJsonTaskTimeLineMilestone(
      Map<String, dynamic> json);

  TaskTimeLineLabelModel fromJsonTaskTimeLineLabel(Map<String, dynamic> json);

  Map<String, dynamic> toJsonCreate(TaskCreateModel model);

  Map<String, dynamic> toJsonTaskMilestoneCreate(TaskMilestoneCreateModel model);

  Map<String, dynamic> toJsonTaskLabelCreate(TaskLabelCreateModel model);
  Map<String, dynamic> toJsonTaskLabel(TaskLabelModel model);

  Map<String, dynamic> toJsonTaskMilestone(TaskMileStoneModel model);
}
