import 'dart:io';

import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:code/ui/task_create/model_ui.dart';
import 'package:code/utils/toast_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

import '../../domain/channel/channel_model.dart';
import '../../domain/team/i_team_repository.dart';
import '../../domain/team/team_model.dart';
import '../../global_regexp.dart';
import '../home/home_ui_model.dart';

class TaskDetailBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final ITaskRepository _iTaskRepository;
  final ITeamRepository _iTeamRepository;
  final IUserRepository _iUserRepository;
  final SharedPreferencesManager _prefs;
  final InMemoryData inMemoryData;

  TaskDetailBloC(this._iTaskRepository, this._prefs, this.inMemoryData, this._iTeamRepository, this._iUserRepository);

  @override
  void dispose() {
    _taskDetailController.close();
    _pageTabController.close();
    _editNameController.close();
    _closeReopenController.close();
    _editDescriptionController.close();
    _externalEmailsController.close();
    _editLocationController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<int> _pageTabController = new BehaviorSubject();

  Stream<int> get pageTabResult => _pageTabController.stream;

  BehaviorSubject<TaskDetailUIModel> _taskDetailController =
      new BehaviorSubject();

  Stream<TaskDetailUIModel> get taskDetailResult =>
      _taskDetailController.stream;

  BehaviorSubject<bool> _closeReopenController = new BehaviorSubject();

  Stream<bool> get closeReopenResult => _closeReopenController.stream;

  BehaviorSubject<bool> _editNameController = new BehaviorSubject();

  Stream<bool> get editNameResult => _editNameController.stream;

  BehaviorSubject<bool> _editDescriptionController = new BehaviorSubject();

  Stream<bool> get editDescriptionResult => _editDescriptionController.stream;

  BehaviorSubject<bool> _editLocationController = new BehaviorSubject();

  Stream<bool> get editLocationResult => _editLocationController.stream;

  void changeEditModeName(bool value) => _editNameController.sinkAddSafe(value);

  void changeEditModeDescription(bool value) =>
      _editDescriptionController.sinkAddSafe(value);

  void changeEditModeLocation(bool value) =>
      _editLocationController.sinkAddSafe(value);

  BehaviorSubject<List<ExternalEmailsModelUI>> _externalEmailsController =
      BehaviorSubject();

  Stream<List<ExternalEmailsModelUI>> get externalEmailsResult =>
      _externalEmailsController.stream;

  String currentTeamId = "";
  String currentMemberId = "";
  late TaskDetailUIModel taskDetailUIModel;
  bool reload = false;
  bool isPersonalNote = false;

  bool taskUpdateProtected = false;

  List<ExternalEmailsModelUI> externalEmails = [];

  void get refreshDataExternalEmail =>
      _externalEmailsController.sinkAddSafe(externalEmails);

  void get refreshTask => _taskDetailController.sinkAddSafe(taskDetailUIModel);

  void initDataView(TaskModel? taskModel, String taskId) async {
    isLoading = true;
    final currentTeamName = await _prefs.getStringValue(_prefs.currentTeamName);
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    currentMemberId = await _prefs.getStringValue(_prefs.userId);
    final resJoinedTeam = await _iTeamRepository.joinTeam(currentTeamName, teamId: currentTeamId);
    if(resJoinedTeam is ResultSuccess<TeamJoinedModel>) {
      _loadChannelsGroups(channels: resJoinedTeam.value.channels, groups: resJoinedTeam.value.groups);
    }
    if (taskModel == null) {
      final res = await _iTaskRepository.getTask(currentTeamId, taskId);
      if (res is ResultSuccess<TaskModel>) {
        taskModel = res.value;
      } else if (res is ResultError && (res as ResultError).code == RemoteConstants.code_not_found) {
        showErrorMessageFromString(R.string.taskNotFound);
      } else {
        showErrorMessage(res);
      }
    }
    if(taskModel != null) {
      isPersonalNote = taskModel.cid == null || taskModel.cid?.isEmpty == true;
      if(!isPersonalNote && !taskModel.marked) markAsRead(taskModel.uut!.id);

      for (var element in taskModel.assignees) {
        if (element.contains('@')) {
          externalEmails.add(ExternalEmailsModelUI(
              emailController: TextEditingController(text: element)));
        }
      }

      taskUpdateProtected = inMemoryData.currentTeam!.taskUpdateProtected == true &&
          inMemoryData.currentMember!.userRol != UserRol.Admin &&
          inMemoryData.currentMember!.id != taskModel.uid;

      taskDetailUIModel = TaskDetailUIModel(
          taskModel: taskModel, isEditingTitle: false, files: []);

      await inMemoryData.resolveMembersAsync([
        taskDetailUIModel.taskModel.uid ?? "",
        ...taskDetailUIModel.taskModel.assignees,
        ...taskDetailUIModel.taskModel.participants.map((e) => e.uid).toList(),
      ]);

      _taskDetailController.sinkAddSafe(taskDetailUIModel);
      refreshDataExternalEmail;
    }
    isLoading = false;
  }

  void updateDateRange(DateTimeRange range) async {
    final start = taskDetailUIModel.taskModel.isAllDay
        ? DateTime(
            range.start.year, range.start.month, range.start.day, 0, 0, 0)
        : range.start;
    final end = taskDetailUIModel.taskModel.isAllDay
        ? DateTime(range.end.year, range.end.month, range.end.day, 0, 0, 0)
        : range.end;

    final res = await _iTaskRepository.putTaskCalendarDates(
        currentTeamId,
        taskDetailUIModel.taskModel.id,
        start,
        taskDetailUIModel.taskModel.isMeetingAppointment ? end : start,
        taskDetailUIModel.taskModel.isAllDay,
        type: taskDetailUIModel.taskModel.type);
    if (res is ResultSuccess<bool>) {
      taskDetailUIModel.taskModel.due = range.start;
      taskDetailUIModel.taskModel.end =
          taskDetailUIModel.taskModel.isMeetingAppointment
              ? range.end
              : range.start;
      refreshTask;
    }
  }

  void changeIsAllDay(bool value) {
    taskDetailUIModel.taskModel.isAllDay = value;
    refreshTask;
    updateDateRange(DateTimeRange(
        start: taskDetailUIModel.taskModel.due!,
        end: taskDetailUIModel.taskModel.end!));
  }

  void changePageTab(int tab) async {
    _pageTabController.sinkAddSafe(tab);
  }

  void attachFile(File file) async {
    isLoading = true;
    final res = await _iTaskRepository.attachFile(file);
    if (res is ResultSuccess<String>) {
      String fileName = file.path.split("/").last;
      String comment = "![$fileName](${res.value})";
      postTaskComment(comment);
    } else {
      isLoading = false;
      showErrorMessage(res);
    }
  }

  void postTaskComment(String comment) async {
    isLoading = true;
    final res = await _iTaskRepository.postTaskComment(
        currentTeamId, taskDetailUIModel.taskModel.id, comment);
    if (res is ResultSuccess<bool>) {
      await getTask();
    } else {
      showErrorMessage(res);
    }
    isLoading = false;
  }

  void putTaskComment(String comment, int commentPos) async {
    isLoading = true;
    final res = await _iTaskRepository.putTaskComment(
        currentTeamId, taskDetailUIModel.taskModel.id, comment, commentPos);
    if (res is ResultSuccess<bool>) {
      await getTask();
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void deleteTaskComment(int commentPos) async {
    isLoading = true;
    final res = await _iTaskRepository.deleteTaskComment(
        currentTeamId, taskDetailUIModel.taskModel.id, commentPos);
    if (res is ResultSuccess<bool>) {
      getTask();
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void attachDetachLabel(TaskLabelModel model) async {
    List<TaskLabelModel> labels = taskDetailUIModel.taskModel.labels;
    final containLabel =
        labels.firstWhereOrNull((element) => element.id == model.id);
    if (containLabel == null) {
      final res = await _iTaskRepository.attachLabel(
          currentTeamId, taskDetailUIModel.taskModel.id, model.id);
      if (res is ResultSuccess<bool>) {
        getTask();
      }
    } else {
      final res = await _iTaskRepository.detachLabel(
          currentTeamId, taskDetailUIModel.taskModel.id, model.id);
      if (res is ResultSuccess<bool>) {
        getTask();
      }
    }
  }

  void attachMilestone(TaskMileStoneModel model) async {
    final res = await _iTaskRepository.attachMilestone(
        taskDetailUIModel.taskModel.tid ?? "",
        taskDetailUIModel.taskModel.id,
        model.id);
    if (res is ResultSuccess<bool>) {
      getTask();
    }
  }

  void deleteTask() async {
    isLoading = true;
    final res = await _iTaskRepository.deleteEventMeeting(
        currentTeamId, taskDetailUIModel.taskModel.id,
        type: taskDetailUIModel.taskModel.type);
    if (res is ResultSuccess<bool>)
      _closeReopenController.sinkAddSafe(res.value);
    else
      showErrorMessage(res);
    isLoading = false;
  }

  void closeTask() async {
    isLoading = true;
    final res = await _iTaskRepository.putTaskClose(
        currentTeamId, taskDetailUIModel.taskModel.id);
    if (res is ResultSuccess<bool>)
      _closeReopenController.sinkAddSafe(res.value);
    else
      showErrorMessage(res);
    isLoading = false;
  }

  void reopenTask() async {
    isLoading = true;
    final res = await _iTaskRepository.putTaskReOpen(
        currentTeamId, taskDetailUIModel.taskModel.id);
    if (res is ResultSuccess<bool>)
      _closeReopenController.sinkAddSafe(res.value);
    else
      showErrorMessage(res);
    isLoading = false;
  }

  void updateName(String name) async {
    final res = await _iTaskRepository.putTask(
        currentTeamId, taskDetailUIModel.taskModel.id, name,
        type: taskDetailUIModel.taskModel.type);
    if (res is ResultSuccess<bool>) {
      taskDetailUIModel.taskModel.title = name;
      _editNameController.sinkAddSafe(false);
      refreshTask;
    } else if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_forbidden) {
      ToastUtil.showToast(R.string.permissionDenied,
          toastLength: Toast.LENGTH_LONG);
    } else
      showErrorMessage(res);
  }

  String encodeUrl(String text) {
    return text.replaceAllMapped(
        GlobalRegexp.genericLink, (match) => Uri.encodeFull(match.group(0)!));
  }

  void updateLocation(String? location) async {
    if (location == null) location = "";
    location = encodeUrl(location);
    isLoading = true;
    final res = await _iTaskRepository.putTaskCalendarLocation(
        currentTeamId, taskDetailUIModel.taskModel.id, location,
        type: taskDetailUIModel.taskModel.type);
    if (res is ResultSuccess<bool>) {
      _editLocationController.sinkAddSafe(false);
      // if(taskDetailUIModel.taskModel.isNativeGoogleCalendar || taskDetailUIModel.taskModel.isNativeGoogleCalendar) {
      //   taskDetailUIModel.taskModel.location = location;
      //   taskDetailUIModel.taskModel.htmlLocation = null;
      // } else {
      await getTask();
      //}
    } else if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_forbidden) {
      ToastUtil.showToast(R.string.permissionDenied,
          toastLength: Toast.LENGTH_LONG);
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void updateDescription(String? description) async {
    if (description == null) description = '';
    description = encodeUrl(description);
    isLoading = true;
    final res = await _iTaskRepository.putTaskCalendarDescription(
        currentTeamId, taskDetailUIModel.taskModel.id, description,
        type: taskDetailUIModel.taskModel.type);
    if (res is ResultSuccess<bool>) {
      _editDescriptionController.sinkAddSafe(false);
      // if(taskDetailUIModel.taskModel.isNativeGoogleCalendar || taskDetailUIModel.taskModel.isNativeGoogleCalendar) {
      //   taskDetailUIModel.taskModel.description = description;
      //   taskDetailUIModel.taskModel.htmlDescription = null;
      // } else {
      await getTask();
      //}
    } else if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_forbidden) {
      ToastUtil.showToast(R.string.permissionDenied,
          toastLength: Toast.LENGTH_LONG);
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void updateExternalMails({bool checkIfEmpty = true}) async {
    if ((checkIfEmpty && externalEmails.isNotEmpty) || !checkIfEmpty) {
      isLoading = true;
      taskDetailUIModel.taskModel.assignees
          .removeWhere((element) => element.contains("@"));
      externalEmails.forEach((element) {
        taskDetailUIModel.taskModel.assignees.add(element.emailController.text);
      });
      final res = await _iTaskRepository.putTaskCalendarAssignees(currentTeamId,
          taskDetailUIModel.taskModel.id, taskDetailUIModel.taskModel.assignees,
          type: taskDetailUIModel.taskModel.type);
      if (res is ResultSuccess<bool>) {
        await getTask();
      } else if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_forbidden) {
        ToastUtil.showToast(R.string.permissionDenied,
            toastLength: Toast.LENGTH_LONG);
      } else
        showErrorMessage(res);
      isLoading = false;
    }
  }

  Future<void> getTask() async {
    final taskRes = await _iTaskRepository.getTask(
        currentTeamId, taskDetailUIModel.taskModel.id,
        type: taskDetailUIModel.taskModel.type);
    if (taskRes is ResultSuccess<TaskModel>) {
      externalEmails.clear();
      taskRes.value.assignees.forEach((element) {
        if (element.contains('@'))
          externalEmails.add(ExternalEmailsModelUI(
              emailController: TextEditingController(text: element)));
      });
      taskDetailUIModel.taskModel = taskRes.value;
      _taskDetailController.sinkAddSafe(taskDetailUIModel);
      refreshDataExternalEmail;
    }
  }

  // void updateDueDate(DateTime dateTime) async {
  //   final res = await _iTaskRepository.putDueTask(
  //       currentTeamId, taskDetailUIModel.taskModel.id, dateTime,
  //       type: taskDetailUIModel.taskModel.type);
  //   if (res is ResultSuccess<bool>) {
  //     taskDetailUIModel.taskModel.due = dateTime;
  //     _taskDetailController.sinkAddSafe(taskDetailUIModel);
  //   }
  // }

  void addMultiAssigneesFromChannel(String cid) async {
    isLoading = true;
    final resMembers = await _iUserRepository.getChannelMembers(currentTeamId, cid, active: true, all: true);
    if(resMembers is ResultSuccess<MemberWrapperModel>) {
      resMembers.value.list.removeWhere((element) => element.id == RemoteConstants.noysiRobot);
      taskDetailUIModel.taskModel.assignees.addAll(resMembers.value.list.map((e) => e.id).toList());
      taskDetailUIModel.taskModel.assignees = taskDetailUIModel.taskModel.assignees.toSet().toList();
      final res = await _iTaskRepository.putTaskCalendarAssignees(currentTeamId,
          taskDetailUIModel.taskModel.id, taskDetailUIModel.taskModel.assignees,
          type: taskDetailUIModel.taskModel.type);
      if (res is ResultSuccess<bool>) {
        await getTask();
      } else if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_forbidden) {
        ToastUtil.showToast(R.string.permissionDenied,
            toastLength: Toast.LENGTH_LONG);
      } else
        showErrorMessage(res);
    }
    isLoading = false;
  }

  void addRemoveAssignee(String userId) async {
    isLoading = true;
    if (taskDetailUIModel.taskModel.assignees.contains(userId)) {
      final res = await _iTaskRepository.removeAssignee(
          currentTeamId, taskDetailUIModel.taskModel.id, userId,
          type: taskDetailUIModel.taskModel.type);
      if (res is ResultSuccess<bool>) {
        await getTask();
      }
    } else {
      final res = await _iTaskRepository.addAssignee(
          currentTeamId, taskDetailUIModel.taskModel.id, userId,
          type: taskDetailUIModel.taskModel.type);
      if (res is ResultSuccess<bool>) {
        await getTask();
      }
    }
    isLoading = false;
  }

  Future<void> markAsRead(String uutId) async {
    await _iTaskRepository.markAppointmentAsRead(currentTeamId, uutId);
  }

  List<DrawerChatModel> channelsGroups = [];
  void _loadChannelsGroups({required List<ChannelModel> channels, required List<ChannelModel> groups}) {
    List<DrawerChatModel> list = [];
    ///Adding channels header
    list.add(DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Channel,
      isChild: false,
      title: R.string.openChannels.toUpperCase(),
      childrenCount: channels.length,
    ));

    ///Adding channels
    channels.sort((c1, c2) => c1.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2.titleFixed.toLowerCase().trim()));

    list.addAll(channels.map((element) => DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Channel,
      isChild: true,
      channelModel: element,
      title: element.titleFixed,
    )).toList());

    ///Adding private groups header
    list.add(DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
      isChild: false,
      title: R.string.privateGroups.toUpperCase(),
      childrenCount: groups!.length,
    ));

    ///Adding private groups
    groups.sort((c1, c2) => c1.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2.titleFixed.toLowerCase().trim()));

    list.addAll(groups.map((element) => DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
      isChild: true,
      channelModel: element,
      title: element.titleFixed,
    )).toList());

    channelsGroups = list;
  }
}
