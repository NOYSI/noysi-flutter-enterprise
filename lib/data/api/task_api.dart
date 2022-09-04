import 'dart:convert';
import 'dart:io';

import 'package:code/_di/injector.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/_base_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/integration_status.dart';
import 'package:code/domain/task/i_task_api.dart';
import 'package:code/domain/task/i_task_converter.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:dio/dio.dart';

import '../../utils/file_manager.dart';

class TaskApi extends BaseApi implements ITaskApi {
  final NetworkHandler _networkHandler;
  final ITaskConverter _iTaskConverter;
  final SharedPreferencesManager _prefs;

  TaskApi(this._networkHandler, this._iTaskConverter, this._prefs);

  @override
  Future<int> getTasksCount(String teamId) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.tasks}/count");
    if (res.statusCode == RemoteConstants.code_success) {
      return res.data["count"];
    }
    throw serverException(res);
  }

  Future<int> getUncheckedAppointments(String teamId) async {
    final res = await _networkHandler.get(path: "${Endpoint.teams}/$teamId/user-unchecked-tasks/count");
    if (res.statusCode == RemoteConstants.code_success) {
      return res.data["count"];
    }
    throw serverException(res);
  }

  @override
  Future<TaskStatsModel> getTasks(String teamId,
      {String channelId = "",
      int max = 100,
      String? assignee,
      String? authors,
      List<String> labels = const [],
      String? milestone,
      String sort = "",
      int offset = 0,
      String status = "open"}) async {
    String path = "${Endpoint.teams}/$teamId${Endpoint.tasks}?";
    path = "$path${"max="}$max";
    path = "$path${"&offset="}$offset";
    path = "$path${"&status="}$status";

    if (assignee?.isNotEmpty == true) path = "$path${"&assignee="}$assignee";
    if (authors?.isNotEmpty == true) path = "$path${"&authors="}$authors";
    if (milestone?.isNotEmpty == true) path = "$path${"&milestone="}$milestone";
    if (sort.isNotEmpty == true) path = "$path${"&sort="}$sort";
    if (labels.isNotEmpty) {
      path =
          "$path${"&labels="}${labels.length > 1 ? labels.join("=").toString() : labels[0]}";
    }

    if (channelId.isNotEmpty) path = "$path${"&cid="}$channelId";

    final res = await _networkHandler.get(path: path);
    if (res.statusCode == RemoteConstants.code_success) {
      final taskStats = _iTaskConverter.fromJson(res.data);
      return taskStats;
    }
    throw serverException(res);
  }

  @override
  Future<TaskStatsModel> getAppointments(String teamId, DateTime first, DateTime last,
      {String type = ""}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/calendar/all?status=open${type.isNotEmpty ? "&type=$type" : ""}&first=${first.millisecondsSinceEpoch}&last=${last.millisecondsSinceEpoch}");
    if (res.statusCode == RemoteConstants.code_success) {
      final taskStats = _iTaskConverter.fromJson(res.data);
      return taskStats;
    }
    throw serverException(res);
  }

  @override
  Future<TaskModel> createTask(String teamId, TaskCreateModel model) async {
    final body = _iTaskConverter.toJsonCreate(model);
    final res = await _networkHandler.post(
        path: "${Endpoint.teams}/$teamId${Endpoint.tasks}",
        body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success_created) {
      TaskModel model =
          _iTaskConverter.fromJsonTask(res.data, mapFromCreateAction: true);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<TaskModel> getTask(String teamId, String taskId,
      {String type = "noysi-calendar"}) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId?type=$type");
    if (res.statusCode == RemoteConstants.code_success) {
      final task = _iTaskConverter.fromJsonTask(res.data);
      return task;
    }
    throw serverException(res);
  }

  @override
  Future<bool> putTask(String teamId, String taskId, String text,
      {String type = "noysi-calendar"}) async {
    final body = jsonEncode({"title": text, "type": type});
    final res = await _networkHandler.put(
        body: body, path: "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> putTaskCalendarLocation(
      String teamId, String taskId, String location,
      {String type = "noysi-calendar"}) async {
    final body = jsonEncode({"location": location, "type": type});
    final res = await _networkHandler.put(
        body: body,
        path: "${Endpoint.teams}/$teamId${Endpoint.tasks}/calendar/$taskId");
    if (res.statusCode == RemoteConstants.code_success) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> putTaskCalendarDescription(
      String teamId, String taskId, String description,
      {String type = "noysi-calendar"}) async {
    final body = jsonEncode({"description": description, "type": type});
    final res = await _networkHandler.put(
        body: body,
        path: "${Endpoint.teams}/$teamId${Endpoint.tasks}/calendar/$taskId");
    if (res.statusCode == RemoteConstants.code_success) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> putTaskCalendarDates(
      String tid, String taskId, DateTime? start, DateTime? end, bool? isAllDay,
      {String type = "noysi-calendar"}) async {
    if(!(isAllDay ?? false)) {
      start = DateTime.tryParse(start?.toIso8601String().replaceAll("Z", "") ?? '');
      end = DateTime.tryParse(end?.toIso8601String().replaceAll("Z", "") ?? '');
    }
    final body = jsonEncode({
      "type": type,
      "due": (isAllDay ?? false) ? start?.millisecondsSinceEpoch : start?.toUtc().millisecondsSinceEpoch,
      "end": (isAllDay ?? false) ? end?.millisecondsSinceEpoch : end?.toUtc().millisecondsSinceEpoch,
      "isAllDay": (isAllDay ?? false)
    });
    final res = await _networkHandler.put(
        body: body,
        path: "${Endpoint.teams}/$tid${Endpoint.tasks}/calendar/$taskId");
    if (res.statusCode == RemoteConstants.code_success) {
      return true;
    }
    throw serverException(res);
  }

  Future<bool> putTaskCalendarAssignees(
      String teamId, String taskId, List<String> assignees,
      {String type = "noysi-calendar"}) async {
    final body = jsonEncode({"assignees": assignees, "type": type});
    final res = await _networkHandler.put(
        body: body,
        path: "${Endpoint.teams}/$teamId${Endpoint.tasks}/calendar/$taskId");
    if (res.statusCode == RemoteConstants.code_success) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deleteEventMeeting(String teamId, String taskId,
      {String type = 'noysi-calendar'}) async {
    final res = await _networkHandler.delete(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/calendar/$taskId?type=$type");
    if (res.statusCode == RemoteConstants.code_success_no_content) return true;
    throw serverException(res);
  }

  @override
  Future<bool> putTaskClose(String teamId, String taskId) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId${Endpoint.action_close}");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> putTaskReOpen(String teamId, String taskId) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId${Endpoint.action_reopen}");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deleteTaskComment(
      String teamId, String taskId, int index) async {
    final res = await _networkHandler.delete(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId${Endpoint.comments}/$index");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> postTaskComment(
      String teamId, String taskId, String comment) async {
    final body = jsonEncode({"text": comment});
    final res = await _networkHandler.post(
        body: body,
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId${Endpoint.comments}");
    if (res.statusCode == RemoteConstants.code_success_created) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> putTaskComment(
      String teamId, String taskId, String comment, int commentPos) async {
    final body = jsonEncode({"text": comment});
    final res = await _networkHandler.put(
        body: body,
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId${Endpoint.comments}/$commentPos");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<CalendarIntegrationStatus> getCalendarIntegrationStatus() async {
    final tid = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _networkHandler.get(path: "${Endpoint.teams}/$tid${Endpoint.accounts}/status/data");
    if(res.statusCode == RemoteConstants.code_success) {
      return _iTaskConverter.fromJsonCalendarIntegrationStatus(jsonDecode(res.data));
    }
    throw serverException(res);
  }

  //@override
 // Future<bool> putDueTask(String teamId, String taskId, DateTime dateTime,
 //      {String type = "noysi-calendar"}) async {
 //    final body = jsonEncode(
 //        {"due": dateTime.toUtc().millisecondsSinceEpoch, "type": type});
 //    final res = await _networkHandler.put(
 //        body: body,
 //        path: "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId/due");
 //    if (res.statusCode == RemoteConstants.code_success_no_content) {
 //      return true;
 //    }
 //    throw serverException(res);
 //  }

  @override
  Future<String> attachFile(File file,
      {ProgressCallback? onProgress, CancelToken? cancelToken}) async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);

    final FileCreateModel fileCreateModel = FileCreateModel(
        size: file.lengthSync(),
        mime: FileManager.lookupMime(file.path),
        type: 'file',
        path: file.path);
    final res = await _networkHandler.postFile(
      path:
          "${Injector.instance.baseUrl}${Endpoint.apiVersion}${Endpoint.teams}/$currentTeamId${Endpoint.tasks}/upload",
      file: file,
      fileCreateModel: fileCreateModel,
      method: 'post',
      useTokenAuthorization: true,
      onSendProgress: onProgress,
      cancelToken: cancelToken
    );
    if (res.statusCode == RemoteConstants.code_success_created) {
      final uri = res.headers["location"]![0];
      return uri;
    }
    throw serverException(res);
  }

  @override
  Future<List<TaskLabelModel>> getLabels(String teamId, String channelId,
      {int max = 50, offset = 0, String query = ""}) async {
    String path =
        "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/labels?max=$max&offset=$offset&q=${Uri.encodeFull(query)}";

    final res = await _networkHandler.get(path: path);
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = res.data["list"];
      return l
          .map((model) => _iTaskConverter.fromJsonTaskLabel(model))
          .toList();
    }
    throw serverException(res);
  }

  @override
  Future<bool> detachLabel(String teamId, String taskId, String labelId) async {
    final res = await _networkHandler.delete(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId/labels/$labelId");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> attachLabel(String teamId, String taskId, String labelId) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId/labels/$labelId");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<TaskLabelModel> addLabel(
      String teamId, String channelId, TaskLabelCreateModel model) async {
    final body = _iTaskConverter.toJsonTaskLabelCreate(model);
    final res = await _networkHandler.post(
        path: "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/labels",
        body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success_created) {
      TaskLabelModel model = _iTaskConverter.fromJsonTaskLabel(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deleteLabel(
      String teamId, String channelId, String labelId) async {
    final res = await _networkHandler.delete(
      path:
          "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/labels/$labelId",
    );
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> updateLabel(
      String teamId, String channelId, TaskLabelModel model) async {
    final body = _iTaskConverter.toJsonTaskLabel(model);
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/labels/${model.id}",
        body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<List<TaskMileStoneModel>> getMilestones(
      String teamId, String channelId,
      {int max = 50, offset = 0, String query = "", String status = ""}) async {
    String path =
        "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/milestones?max=$max&offset=$offset&q=${Uri.encodeFull(query)}&status=$status";

    final res = await _networkHandler.get(path: path);
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = res.data["list"];
      return l
          .map((model) => _iTaskConverter.fromJsonTaskMilestone(model))
          .toList();
    }
    throw serverException(res);
  }

  @override
  Future<TaskMileStoneModel> addMilestone(
      String teamId, String channelId, TaskMilestoneCreateModel model) async {
    final body = _iTaskConverter.toJsonTaskMilestoneCreate(model);
    final res = await _networkHandler.post(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/milestones",
        body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success_created) {
      TaskMileStoneModel milestone =
          _iTaskConverter.fromJsonTaskMilestone(res.data);
      return milestone;
    }
    throw serverException(res);
  }

  @override
  Future<bool> attachMilestone(
      String teamId, String taskId, String milestoneId) async {
    final body = {"milestone": milestoneId};
    final res = await _networkHandler.put(
        path: "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId/milestone",
        body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> closeMilestone(
      String teamId, String channelId, String milestoneId) async {
    final res = await _networkHandler.put(
      path:
          "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/milestones/$milestoneId/actions/close",
    );
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deleteMilestone(
      String teamId, String channelId, String milestoneId) async {
    final res = await _networkHandler.delete(
      path:
          "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/milestones/$milestoneId",
    );
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> reopenMilestone(
      String teamId, String channelId, String milestoneId) async {
    final res = await _networkHandler.put(
      path:
          "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/milestones/$milestoneId/actions/reopen",
    );
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> updateMilestone(
      String teamId, String channelId, TaskMileStoneModel model) async {
    final body = _iTaskConverter.toJsonTaskMilestone(model);
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/milestones/${model.id}",
        body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> attachAssignee(String teamId, String taskId, String userId,
      {type = "noysi-calendar"}) async {
    final body = {
      "type": type,
    };
    final res = await _networkHandler.put(
      path:
          "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId/assignees/$userId",
      body: jsonEncode(body),
    );
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> detachAssignee(String teamId, String taskId, String userId,
      {type = "noysi-calendar"}) async {
    final body = {
      "type": type,
    };
    final res = await _networkHandler.delete(
      path:
          "${Endpoint.teams}/$teamId${Endpoint.tasks}/$taskId/assignees/$userId",
      body: jsonEncode(body),
    );
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  Future<bool> markAppointmentAsRead(String teamId, uutId) async {
    final res = await _networkHandler.delete(path: "${Endpoint.teams}/$teamId/user-unchecked-tasks/$uutId");
    if(res.statusCode == RemoteConstants.code_success) {
      return true;
    }
    throw serverException(res);
  }
}
