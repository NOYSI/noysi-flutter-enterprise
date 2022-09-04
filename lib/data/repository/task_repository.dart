import 'dart:io';

import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/integration_status.dart';
import 'package:code/domain/task/i_task_api.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:dio/dio.dart';

class TaskRepository extends BaseRepository implements ITaskRepository {
  final ITaskApi _iTaskApi;
  final InMemoryData _inMemoryData;

  TaskRepository(this._iTaskApi, this._inMemoryData);

  @override
  Future<Result<TaskStatsModel>> getTasks(String teamId,
      {String channelId = "",
      int max = 100,
      int offset = 0,
      String? assignee,
      String? authors,
      List<String> labels = const [],
      String? milestone,
      String sort = "",
      String status = "open"}) async {
    try {
      final res = await _iTaskApi.getTasks(teamId,
          channelId: channelId,
          max: max,
          offset: offset,
          status: status,
          assignee: assignee,
          authors: authors,
          labels: labels,
          milestone: milestone,
          sort: sort);
      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.uid ?? "").toList());
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TaskStatsModel>> getAppointments(String teamId, DateTime first, DateTime last, {String type = ""}) async {
    try {
      final res = await _iTaskApi.getAppointments(teamId, first, last, type: type);
      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.uid ?? "").toList());
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> deleteTaskComment(
      String teamId, String taskId, int index) async {
    try {
      final res = await _iTaskApi.deleteTaskComment(teamId, taskId, index);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TaskModel>> getTask(String teamId, String taskId, {String type = "noysi-calendar"}) async {
    try {
      final res = await _iTaskApi.getTask(teamId, taskId, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> getTasksCount(String teamId) async {
    try {
      final res = await _iTaskApi.getTasksCount(teamId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  Future<Result<int>> getAppointmentsCount(String teamId) async {
    try {
      final res = await _iTaskApi.getUncheckedAppointments(teamId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  Future<Result<bool>> markAppointmentAsRead(String teamId, uutId) async {
    try {
      final res = await _iTaskApi.markAppointmentAsRead(teamId, uutId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<String>> attachFile(File file,
      {ProgressCallback? onProgress, CancelToken? cancelToken}) async {
    try {
      final res = await _iTaskApi.attachFile(file, onProgress: onProgress, cancelToken: cancelToken);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> postTaskComment(
      String teamId, String taskId, String comment) async {
    try {
      final res = await _iTaskApi.postTaskComment(teamId, taskId, comment);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTaskComment(
      String teamId, String taskId, String comment, int commentPos) async {
    try {
      final res =
          await _iTaskApi.putTaskComment(teamId, taskId, comment, commentPos);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  // @override
  // Future<Result<bool>> putDueTask(
  //     String teamId, String taskId, DateTime dateTime, {String type = "noysi-calendar"}) async {
  //   try {
  //     final res = await _iTaskApi.putDueTask(teamId, taskId, dateTime, type: type);
  //     return ResultSuccess(value: res);
  //   } catch (ex) {
  //     return resultError(ex);
  //   }
  // }

  @override
  Future<Result<bool>> putTaskCalendarDates(String tid, String taskId, DateTime start, DateTime end, bool isAllDay, {String type = "noysi-calendar"}) async {
    try {
      final res = await _iTaskApi.putTaskCalendarDates(tid, taskId, start, end, isAllDay, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTask(
      String teamId, String taskId, String text, {String type = "noysi-calendar"}) async {
    try {
      final res = await _iTaskApi.putTask(teamId, taskId, text, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTaskCalendarDescription(String teamId, String taskId, String description, {String type = "noysi-calendar"}) async {
    try {
      final res = await _iTaskApi.putTaskCalendarDescription(teamId, taskId, description, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTaskCalendarLocation(String teamId, String taskId, String location, {String type = "noysi-calendar"}) async {
    try {
      final res = await _iTaskApi.putTaskCalendarLocation(teamId, taskId, location, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTaskCalendarAssignees(String teamId, String taskId, List<String> assignees, {String type = "noysi-calendar"}) async {
    try {
      final res = await _iTaskApi.putTaskCalendarAssignees(teamId, taskId, assignees, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> deleteEventMeeting(String teamId, String taskId, {String type = 'noysi-calendar'}) async {
    try {
      final res = await _iTaskApi.deleteEventMeeting(teamId, taskId, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTaskClose(String teamId, String taskId) async {
    try {
      final res = await _iTaskApi.putTaskClose(teamId, taskId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTaskReOpen(String teamId, String taskId) async {
    try {
      final res = await _iTaskApi.putTaskReOpen(teamId, taskId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<TaskLabelModel>>> getLabels(
      String teamId, String channelId,
      {int max = 25, offset = 0, String query = ""}) async {
    try {
      final res = await _iTaskApi.getLabels(teamId, channelId,
          max: max, offset: offset, query: query);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<TaskMileStoneModel>>> getMilestones(
      String teamId, String channelId,
      {int max = 50, offset = 0, String query = "", String status = ""}) async {
    try {
      final res = await _iTaskApi.getMilestones(teamId, channelId,
          max: max, offset: offset, query: query, status: status);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TaskModel>> createTask(
      String teamId, TaskCreateModel model) async {
    try {
      final res = await _iTaskApi.createTask(teamId, model);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> deleteLabel(
      String teamId, String channelId, String labelId) async {
    try {
      final res = await _iTaskApi.deleteLabel(teamId, channelId, labelId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> attachLabel(
      String teamId, String taskId, String labelId) async {
    try {
      final res = await _iTaskApi.attachLabel(teamId, taskId, labelId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> detachLabel(
      String teamId, String taskId, String labelId) async {
    try {
      final res = await _iTaskApi.detachLabel(teamId, taskId, labelId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TaskLabelModel>> addLabel(
      String teamId, String channelId, TaskLabelCreateModel model) async {
    try {
      final res = await _iTaskApi.addLabel(teamId, channelId, model);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> addAssignee(
      String teamId, String taskId, String userId, {type = "noysi-calendar"}) async {
    try {
      final res = await _iTaskApi.attachAssignee(teamId, taskId, userId, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> removeAssignee(
      String teamId, String taskId, String userId, {type = "noysi-calendar"}) async {
    try {
      final res = await _iTaskApi.detachAssignee(teamId, taskId, userId, type: type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TaskMileStoneModel>> addMilestone(
      String teamId, String channelId, TaskMilestoneCreateModel model) async {
    try {
      final res = await _iTaskApi.addMilestone(teamId, channelId, model);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> closeMilestone(
      String teamId, String channelId, String milestoneId) async {
    try {
      final res =
          await _iTaskApi.closeMilestone(teamId, channelId, milestoneId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> deleteMilestone(
      String teamId, String channelId, String milestoneId) async {
    try {
      final res =
          await _iTaskApi.deleteMilestone(teamId, channelId, milestoneId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> reopenMilestone(
      String teamId, String channelId, String milestoneId) async {
    try {
      final res =
          await _iTaskApi.reopenMilestone(teamId, channelId, milestoneId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> attachMilestone(
      String teamId, String taskId, String milestoneId) async {
    try {
      final res = await _iTaskApi.attachMilestone(teamId, taskId, milestoneId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> updateLabel(
      String teamId, String channelId, TaskLabelModel model) async {
    try {
      final res = await _iTaskApi.updateLabel(teamId, channelId, model);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> updateMilestone(
      String teamId, String channelId, TaskMileStoneModel model) async {
    try {
      final res = await _iTaskApi.updateMilestone(teamId, channelId, model);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<CalendarIntegrationStatus>> getCalendarIntegrationStatus() async {
    try {
      final res = await _iTaskApi.getCalendarIntegrationStatus();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
