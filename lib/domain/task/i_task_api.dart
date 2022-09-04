import 'dart:io';
import 'package:code/domain/task/task_model.dart';
import 'package:dio/dio.dart';

import '../integration_status.dart';

abstract class ITaskApi {
  Future<TaskStatsModel> getTasks(String teamId,
      {String channelId = "",
      String? assignee,
      String? authors,
      List<String> labels = const [],
      String? milestone,
      String sort,
      int max,
      int offset,
      String status});

  Future<TaskStatsModel> getAppointments(String teamId, DateTime first, DateTime last, {String type = ""});

  Future<TaskModel> getTask(String teamId, String taskId, {String type = "noysi-calendar"});

  Future<TaskModel> createTask(String teamId, TaskCreateModel model);

  Future<bool> putTask(String teamId, String taskId, String text, {String type = "noysi-calendar"});

  Future<bool> putTaskCalendarDescription(String teamId, String taskId, String description, {String type = "noysi-calendar"});

  Future<bool> putTaskCalendarLocation(String teamId, String taskId, String location, {String type = "noysi-calendar"});

  Future<bool> putTaskCalendarDates(String tid, String taskId, DateTime? start, DateTime? end, bool? isAllDay, {String type = "noysi-calendar"});

  Future<bool> putTaskCalendarAssignees(String teamId, String taskId, List<String> assignees, {String type = "noysi-calendar"});

  Future<CalendarIntegrationStatus> getCalendarIntegrationStatus();

  //Future<bool> putDueTask(String teamId, String taskId, DateTime dateTime, {String type = "noysi-calendar"});

  Future<bool> postTaskComment(String teamId, String taskId, String comment);

  Future<bool> putTaskComment(String teamId, String taskId, String comment, int commentPos);

  Future<bool> deleteTaskComment(String teamId, String taskId, int index);

  Future<bool> deleteEventMeeting(String teamId, String taskId, {String type = 'noysi-calendar'});

  Future<bool> putTaskClose(String teamId, String taskId);

  Future<bool> putTaskReOpen(String teamId, String taskId);

  Future<int> getTasksCount(String teamId);

  Future<int> getUncheckedAppointments(String teamId);

  Future<String> attachFile(
      File file,
      {ProgressCallback? onProgress, CancelToken? cancelToken});

  Future<List<TaskMileStoneModel>> getMilestones(
      String teamId, String channelId,
      {int max, offset, String query, String status});

  Future<TaskMileStoneModel> addMilestone(
      String teamId, String channelId, TaskMilestoneCreateModel model);

  Future<bool> updateMilestone(
      String teamId, String channelId, TaskMileStoneModel model);

  Future<bool> deleteMilestone(
      String teamId, String channelId, String milestoneId);

  Future<bool> attachMilestone(
      String teamId, String taskId, String milestoneId);

  Future<bool> closeMilestone(
      String teamId, String channelId, String milestoneId);

  Future<bool> reopenMilestone(
      String teamId, String channelId, String milestoneId);

  Future<List<TaskLabelModel>> getLabels(String teamId, String channelId,
      {int max, offset, String query});

  Future<TaskLabelModel> addLabel(
      String teamId, String channelId, TaskLabelCreateModel model);

  Future<bool> updateLabel(
      String teamId, String channelId, TaskLabelModel model);

  Future<bool> deleteLabel(String teamId, String channelId, String labelId);

  Future<bool> attachLabel(String teamId, String taskId, String labelId);

  Future<bool> detachLabel(String teamId, String taskId, String labelId);

  Future<bool> attachAssignee(String teamId, String taskId, String userId, {type = "noysi-calendar"});

  Future<bool> detachAssignee(String teamId, String taskId, String userId, {type = "noysi-calendar"});

  Future<bool> markAppointmentAsRead(String teamId, uutId);
}
