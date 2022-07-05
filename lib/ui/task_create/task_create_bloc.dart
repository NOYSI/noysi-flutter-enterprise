import 'dart:io';

import 'dart:math';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/global_regexp.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/task_create/model_ui.dart';
import 'package:code/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class TaskCreateBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;

  TaskCreateBloC(this._iTaskRepository, this._prefs);

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _taskCreateController.close();
    _initController.close();
    _customUrlSwitchController.close();
    _eventRelatedToGroupSwitchController.close();
    _roomTextController.close();
    _externalEmailsController.close();
  }

  BehaviorSubject<TaskCreateUIModel> _initController = new BehaviorSubject();

  Stream<TaskCreateUIModel> get initResult => _initController.stream;

  BehaviorSubject<TaskModel> _taskCreateController = new BehaviorSubject();

  Stream<TaskModel> get taskCreateResult => _taskCreateController.stream;

  BehaviorSubject<bool> _customUrlSwitchController = BehaviorSubject();

  Stream<bool> get customUrlSwitchStatus => _customUrlSwitchController.stream;

  BehaviorSubject<bool> _eventRelatedToGroupSwitchController = BehaviorSubject();

  Stream<bool> get eventRelatedToGroupSwitchStatus => _eventRelatedToGroupSwitchController.stream;

  BehaviorSubject<String> _roomTextController = BehaviorSubject();

  Stream<String> get roomTextResult => _roomTextController.stream;

  BehaviorSubject<List<ExternalEmailsModelUI>> _externalEmailsController =
      BehaviorSubject();

  Stream<List<ExternalEmailsModelUI>> get externalEmailsResult =>
      _externalEmailsController.stream;

  void get refreshData => _initController.sinkAddSafe(taskCreateUIModel);

  void get refreshDataExternalEmail =>
      _externalEmailsController.sinkAddSafe(externalEmails);

  late TaskCreateUIModel taskCreateUIModel;

  late String currentUserId;
  late String currentTeamId;

  List<ExternalEmailsModelUI> externalEmails = [];

  String selectedChannelId = '';

  void initViewData(String? channelId,
      {isMeeting = false, createdForCalendar = false}) async {
    isLoading = true;
    currentUserId = await _prefs.getStringValue(_prefs.userId);
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    isLoading = false;

    final startDate = DateTime.now();
    final endDate = startDate.add(Duration(hours: 1));

    taskCreateUIModel = TaskCreateUIModel(
      labels: [],
      cid: channelId,
      assignees: [],
      filePaths: [],
      milestone: TaskMileStoneModel(title: ""),
      due: startDate,
      end: endDate,
    );
    if (createdForCalendar) {
      taskCreateUIModel.assignees.add(currentUserId);
    }
    _initController.sinkAddSafe(taskCreateUIModel);
  }

  void updateDateRange(DateTimeRange range) {
    taskCreateUIModel.due = range.start;
    taskCreateUIModel.end = range.end;
    refreshData;
  }

  void changeIsAllDay(bool value) {
    taskCreateUIModel.isAllDay = value;
    refreshData;
  }

  void switchChangeCustomUrl(bool status) => _customUrlSwitchController.sinkAddSafe(status);

  void switchChangeEventRelatedToGroup(bool status) => _eventRelatedToGroupSwitchController.sinkAddSafe(status);

  String encodeUrl(String text) {
    return text.replaceAllMapped(
        GlobalRegexp.genericLink, (match) => Uri.encodeFull(match.group(0)!));
  }

  void createTask(String title, String? description,
      {isMeetingAppointment = false, String? location}) async {
    if (taskCreateUIModel.assignees.isEmpty == true) {
      taskCreateUIModel.assignees.add(currentUserId);
    }
    if (taskCreateUIModel.isAllDay) {
      taskCreateUIModel.due = DateTime(taskCreateUIModel.due!.year,
          taskCreateUIModel.due!.month, taskCreateUIModel.due!.day, 0, 0, 0);
      taskCreateUIModel.end = DateTime(taskCreateUIModel.end!.year,
          taskCreateUIModel.end!.month, taskCreateUIModel.end!.day, 0, 0, 0);
    }
    description = encodeUrl(description ?? "");
    location = encodeUrl(location ?? "");
    isLoading = true;
    TaskCreateModel taskCreateModel = TaskCreateModel(
      meetingUrl: isMeetingAppointment
          ? Uri.encodeFull(_roomTextController.valueOrNull?.trim() ?? '')
          : '',
      cid: taskCreateUIModel.cid,
      title: title,
      text: description,
      labels: taskCreateUIModel.labels.map((e) => e.id).toList(),
      milestone: taskCreateUIModel.milestone!.id,
      due: taskCreateUIModel.due,
      end: isMeetingAppointment ? taskCreateUIModel.end : taskCreateUIModel.due,
      isAllDay: taskCreateUIModel.isAllDay,
      assignees: taskCreateUIModel.assignees,
      location: location,
    );

    if (isMeetingAppointment) {
      final externalEmailList = externalEmails
          .where((element) => element.emailController.text.trim().isNotEmpty)
          .toList();
      externalEmailList.forEach((element) {
        final texts = element.emailController.text.split(',');
        texts.forEach((element2) {
          if (element2.trim().isNotEmpty) {
            taskCreateModel.assignees.add(element2.trim());
          }
        });
      });
    }

    final res = await _iTaskRepository.createTask(currentTeamId, taskCreateModel);
    if (res is ResultSuccess<TaskModel>) {
      if (taskCreateUIModel.filePaths.isNotEmpty) {
        await _attachFiles(res.value);
        isLoading = false;
      } else {
        isLoading = false;
      }
      _taskCreateController.sinkAddSafe(res.value);
    } else {
      showErrorMessage(res);
      isLoading = false;
    }
  }

  Future<void> _attachFiles(TaskModel taskModel) async {
    await Future.forEach(taskCreateUIModel.filePaths, (filePath) async {
      if(filePath != null){
        final res = await _iTaskRepository.attachFile(File(filePath as String));
        if (res is ResultSuccess<String>) {
          String fileName = filePath.split("/").last;
          String comment = "![$fileName](${res.value})";
          await _iTaskRepository.postTaskComment(
              taskModel.tid ?? "", taskModel.id, comment);
        }
      }

    });
  }

  void addFile(String filePath) {
    taskCreateUIModel.filePaths.add(filePath);
    _initController.sinkAddSafe(taskCreateUIModel);
  }

  void removeFile(String filePath) {
    taskCreateUIModel.filePaths.removeWhere((element) => element == filePath);
    _initController.sinkAddSafe(taskCreateUIModel);
  }

  void createRoom({String roomName = ''}) {
    if (roomName.isEmpty)
      assignRoomName(_getRandomString(15));
    else
      assignRoomName(roomName);
  }

  void assignRoomName(String room) => _roomTextController.sinkAddSafe(room);

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
