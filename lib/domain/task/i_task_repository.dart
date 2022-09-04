import 'dart:io';

import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/integration_status.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:dio/dio.dart';

abstract class ITaskRepository {
  Future<Result<TaskStatsModel>> getTasks(String teamId,
      {String channelId,
        String? assignee,
        String? authors,
        List<String> labels,
        String? milestone,
        String sort,
      int max,
      int offset,
      String status});

  Future<Result<TaskStatsModel>> getAppointments(String teamId, DateTime first, DateTime last, {String type = ""});

  Future<Result<TaskModel>> getTask(String teamId, String taskId, {String type = "noysi-calendar"});

  Future<Result<TaskModel>> createTask(String teamId, TaskCreateModel model);

  Future<Result<bool>> putTask(String teamId, String taskId, String text, {String type = "noysi-calendar"});

  Future<Result<bool>> putTaskCalendarDescription(String teamId, String taskId, String description, {String type = "noysi-calendar"});

  Future<Result<bool>> putTaskCalendarLocation(String teamId, String taskId, String location, {String type = "noysi-calendar"});

  Future<Result<bool>> putTaskCalendarAssignees(String teamId, String taskId, List<String> assignees, {String type = "noysi-calendar"});

 // Future<Result<bool>> putDueTask(
 //     String teamId, String taskId, DateTime dateTime, {String type = "noysi-calendar"});

  Future<Result<bool>> putTaskCalendarDates(String tid, String taskId, DateTime start, DateTime end, bool isAllDay, {String type = "noysi-calendar"});

  Future<Result<bool>> postTaskComment(
      String teamId, String taskId, String comment);

  Future<Result<bool>> putTaskComment(String teamId, String taskId, String comment, int commentPos);

  Future<Result<bool>> deleteTaskComment(
      String teamId, String taskId, int index);

  Future<Result<bool>> deleteEventMeeting(String teamId, String taskId, {String type = 'noysi-calendar'});

  Future<Result<bool>> putTaskClose(String teamId, String taskId);

  Future<Result<bool>> putTaskReOpen(String teamId, String taskId);

  Future<Result<int>> getTasksCount(String teamId);

  Future<Result<int>> getAppointmentsCount(String teamId);

  Future<Result<bool>> markAppointmentAsRead(String teamId, uutId);

  Future<Result<String>> attachFile(
      File file,
      {ProgressCallback? onProgress, CancelToken? cancelToken});

  Future<Result<List<TaskLabelModel>>> getLabels(
      String teamId, String channelId,
      {int max = 25, offset = 0, String query = ""});

  Future<Result<bool>> attachLabel(
      String teamId, String taskId, String labelId);

  Future<Result<bool>> detachLabel(
      String teamId, String taskId, String labelId);

  Future<Result<TaskLabelModel>> addLabel(
      String teamId, String channelId, TaskLabelCreateModel model);

  Future<Result<bool>> updateLabel(
      String teamId, String channelId, TaskLabelModel model);

  Future<Result<bool>> deleteLabel(
      String teamId, String channelId, String labelId);

  Future<Result<List<TaskMileStoneModel>>> getMilestones(
      String teamId, String channelId,
      {int max, offset, String query, String status});

  Future<Result<TaskMileStoneModel>> addMilestone(
      String teamId, String channelId, TaskMilestoneCreateModel model);

  Future<Result<bool>> closeMilestone(
      String teamId, String channelId, String milestoneId);

  Future<Result<bool>> reopenMilestone(
      String teamId, String channelId, String milestoneId);

  Future<Result<bool>> updateMilestone(
      String teamId, String channelId, TaskMileStoneModel model);

  Future<Result<bool>> attachMilestone(
      String teamId, String taskId, String milestoneId);

  Future<Result<bool>> deleteMilestone(
      String teamId, String channelId, String milestoneId);

  Future<Result<bool>> addAssignee(String teamId, String taskId, String userId, {type = "noysi-calendar"});

  Future<Result<bool>> removeAssignee(
      String teamId, String taskId, String userId, {type = "noysi-calendar"});

  Future<Result<CalendarIntegrationStatus>> getCalendarIntegrationStatus();
}
