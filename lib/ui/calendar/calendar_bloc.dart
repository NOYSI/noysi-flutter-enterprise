import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/integration_status.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/_res/R.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/domain/task/i_task_repository.dart';
import '../../enums.dart';
import 'calendar_ui_model.dart';

import 'package:collection/collection.dart';

enum CalendarPlatforms { all, google, outlook, noysi }
enum CalendarFilter { all, created, assigned }

class CalendarBloc extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;
  final InMemoryData inMemoryData;

  CalendarBloc(this._iTaskRepository, this._prefs, this.inMemoryData);

  @override
  void dispose() {
    _calendarViewController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<CalendarUIModel> _calendarViewController =
      new BehaviorSubject();

  Stream<CalendarUIModel> get calendarViewResult =>
      _calendarViewController.stream;

  late CalendarUIModel calendarUIModel;

  void refreshData() => _calendarViewController.sinkAddSafe(calendarUIModel);

  String teamId = "";
  String currentUserId = "";

  void init() async {
    calendarUIModel = CalendarUIModel(
      currentDisplayDate: DateTime.now(),
      appointments: [],
    );
    isLoading = true;
    currentUserId = await _prefs.getStringValue(_prefs.userId);
    teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    await loadIntegrationStatus();
    await loadTasks();
    isLoading = false;
  }

  Future<void> loadIntegrationStatus() async {
    final res = await _iTaskRepository.getCalendarIntegrationStatus();
    if (res is ResultSuccess<CalendarIntegrationStatus>)
      calendarUIModel.calendarIntegrationStatus = res.value;
    else
      calendarUIModel.calendarIntegrationStatus = CalendarIntegrationStatus();
  }

  void changePlatform(CalendarPlatforms selected) {
    if (selected != calendarUIModel.selectedCalendar) {
      calendarUIModel.selectedCalendar = selected;
      loadTasks(load: true);
    }
  }

  // List<AppointmentModel> getTempList() {
  //   List<AppointmentModel> list = [];
  //   AppointmentModel appointmentModel = AppointmentModel(
  //       from: DateTime.now().add(Duration(days: 10)),
  //       to: DateTime.now().add(Duration(days: 10)),
  //       eventName: "First event",
  //       isAllDay: true,
  //       background: R.color.secondaryColor);
  //   list.add(appointmentModel);
  //
  //   return list;
  // }

  // Future<void> _loadGoogle() async {
  //   List<AppointmentModel> list = [];
  //   final res =
  //       await _iTaskRepository.getAppointments(teamId, type: "google-calendar");
  //   if (res is ResultSuccess<TaskStatsModel>) {
  //     res.value.list.forEach((element) {
  //       if (element.created != null || element.due != null) {
  //         AppointmentModel appointmentModel = AppointmentModel(
  //           taskId: element.id,
  //           from: element.due ?? element.created!,
  //           description: element.description,
  //           location: element.location,
  //           uid: element.uid,
  //           to: element.end ??
  //               element.due?.add(Duration(hours: 1)) ??
  //               element.created!.add(Duration(hours: 1)),
  //           eventName:
  //               element.title.isNotEmpty ? element.title : R.string.noTitle,
  //           meetingUrl: element.meetingUrl ?? '',
  //           backgroundColor: !element.marked
  //               ? R.color.calendarButton
  //               : currentUserId != element.uid
  //               ? R.color.primaryLightColor
  //               : R.color.secondaryColor,
  //           isAllDay: element.due == null || element.isAllDay,
  //           task: element,
  //           marked: element.marked
  //         );
  //         list.add(appointmentModel);
  //       }
  //     });
  //     if (calendarUIModel.selectedCalendar == CalendarPlatforms.all) {
  //       calendarUIModel.appointments.addAll(list);
  //
  //       ///Delete duplicates that exists in noysi and google
  //       final ids = calendarUIModel.appointments.map((e) => e.taskId).toSet();
  //       calendarUIModel.appointments
  //           .retainWhere((x) => ids.remove(x.taskId));
  //
  //       _calendarViewController.sinkAddSafe(calendarUIModel);
  //     }
  //   }
  // }

  // Future<void> _loadOutlook() async {
  //   List<AppointmentModel> list = [];
  //   final res = await _iTaskRepository.getAppointments(teamId,
  //       type: "outlook-calendar");
  //   if (res is ResultSuccess<TaskStatsModel>) {
  //     res.value.list.forEach((element) {
  //       if (element.created != null || element.due != null) {
  //         AppointmentModel appointmentModel = AppointmentModel(
  //           taskId: element.id,
  //           description: element.description,
  //           location: element.location,
  //           uid: element.uid,
  //           from: element.due ?? element.created!,
  //           to: element.end ??
  //               element.due?.add(Duration(hours: 1)) ??
  //               element.created!.add(Duration(hours: 1)),
  //           eventName:
  //               element.title.isNotEmpty ? element.title : R.string.noTitle,
  //           meetingUrl: element.meetingUrl ?? '',
  //           backgroundColor: !element.marked
  //               ? R.color.calendarButton
  //               : currentUserId != element.uid
  //               ? R.color.primaryLightColor
  //               : R.color.secondaryColor,
  //           isAllDay: element.due == null || element.isAllDay,
  //           task: element,
  //           marked: element.marked
  //         );
  //         list.add(appointmentModel);
  //       }
  //     });
  //
  //     if (calendarUIModel.selectedCalendar == CalendarPlatforms.all) {
  //       calendarUIModel.appointments.addAll(list);
  //
  //       ///Delete duplicates that exists in noysi and outlook
  //       final ids = calendarUIModel.appointments.map((e) => e.taskId).toSet();
  //       calendarUIModel.appointments
  //           .retainWhere((x) => ids.remove(x.taskId));
  //
  //       _calendarViewController.sinkAddSafe(calendarUIModel);
  //     }
  //   }
  // }

  void changeFilter(CalendarFilter filter) {
    if (calendarUIModel.calendarFilter != filter) {
      calendarUIModel.calendarFilter = filter;
      _filter();
    }
  }

  void _filter() {
    calendarUIModel.appointments =
        calendarUIModel.calendarFilter == CalendarFilter.created
            ? unfilteredList
                .where((element) =>
                    element.task?.isNativeGoogleCalendar == true ||
                    element.task?.isNativeOutlookCalendar == true ||
                    element.uid == currentUserId)
                .toList()
            : calendarUIModel.calendarFilter == CalendarFilter.assigned
                ? unfilteredList
                    .where((element) =>
                        element.task?.isNativeGoogleCalendar == true ||
                        element.task?.isNativeOutlookCalendar == true ||
                        element.uid != currentUserId)
                    .toList()
                : unfilteredList;

    ///Delete duplicates that exists in noysi and outlook
    final ids = calendarUIModel.appointments.map((e) => e.taskId).toSet();
    calendarUIModel.appointments.retainWhere((x) => ids.remove(x.taskId));
    _calendarViewController.sinkAddSafe(calendarUIModel);
  }

  DateTimeRange? loadedRange;
  bool loadingMore = false;
  List<AppointmentModel> unfilteredList = [];
  Future<void> loadTasks(
      {load = false, DateTime? first, DateTime? last}) async {
    loadingMore = true;
    List<AppointmentModel> list = [];
    final start = first == null || last == null
        ? calendarUIModel.currentDisplayDate.subtract(Duration(days: 365))
        : first;
    final end = first == null || last == null
        ? calendarUIModel.currentDisplayDate.add(Duration(days: 365))
        : last;
    if (load) isLoading = true;
    final res = await _iTaskRepository.getAppointments(teamId, start, end,
        type: calendarUIModel.selectedCalendar == CalendarPlatforms.all
            ? "all-platforms"
            : calendarUIModel.selectedCalendar == CalendarPlatforms.google
                ? "google-calendar"
                : calendarUIModel.selectedCalendar == CalendarPlatforms.outlook
                    ? "outlook-calendar"
                    : "noysi-calendar");
    if (res is ResultSuccess<TaskStatsModel>) {
      loadedRange = loadedRange == null || first == null || last == null
          ? DateTimeRange(start: start, end: end)
          : DateTimeRange(
              start: start.isBefore(loadedRange!.start)
                  ? start
                  : loadedRange!.start,
              end: end.isAfter(loadedRange!.end) ? end : loadedRange!.end);
      print("Loaded Range: $loadedRange");
      res.value.list.forEach((element) {
        if (element.created != null || element.due != null) {
          AppointmentModel appointmentModel = AppointmentModel(
              taskId: element.id,
              description: element.description,
              location: element.location,
              uid: element.uid,
              from: element.due ?? element.created!,
              to: element.end ??
                  element.due?.add(Duration(hours: 1)) ??
                  element.created!.add(Duration(hours: 1)),
              eventName:
                  element.title.isNotEmpty ? element.title : R.string.noTitle,
              meetingUrl: element.meetingUrl ?? '',
              isAllDay: element.due == null || element.isAllDay,
              color: element.marked
                  ? element.backgroundColor(currentUserId)
                  : R.color.accentColor,
              task: element);
          list.add(appointmentModel);
        }
      });
      load ? unfilteredList = list : unfilteredList.addAll(list);

      _filter();

      // if (calendarUIModel.selectedCalendar == CalendarPlatforms.all) {
      // if (calendarUIModel.calendarIntegrationStatus!.googleCalendar)
      //   _loadGoogle();
      // if (calendarUIModel.calendarIntegrationStatus!.outlookCalendar)
      //   _loadOutlook();
      // }

    }
    if (load) isLoading = false;
    loadingMore = false;
  }

  void checkLoadMore(DateTime? dateTime) {
    if (dateTime != null) {
      calendarUIModel.currentDisplayDate = dateTime;
      if (!loadingMore && loadedRange != null) {
        if (dateTime.isBefore(loadedRange!.start) ||
            dateTime.difference(loadedRange!.start).inDays < 271) {
          loadTasks(
              first: dateTime.isBefore(loadedRange!.start)
                  ? dateTime.subtract(Duration(days: 365))
                  : loadedRange!.start.subtract(Duration(days: 365)),
              last: loadedRange!.start);
        } else if (dateTime.isAfter(loadedRange!.end) ||
            loadedRange!.end.difference(dateTime).inDays < 271) {
          loadTasks(
              first: loadedRange!.end,
              last: dateTime.isAfter(loadedRange!.end)
                  ? dateTime.add(Duration(days: 365))
                  : loadedRange!.end.add(Duration(days: 365)));
        }
      }
    }
  }

  void removeAppointment(String taskId) {
    unfilteredList.removeWhere((element) => element.taskId == taskId);
    _filter();
  }

  Future<void> refreshTask(String taskId, {TaskModel? task}) async {
    if (task == null) {
      isLoading = true;
      final res = await _iTaskRepository.getTask(teamId, taskId);
      if (res is ResultSuccess<TaskModel>) {
        final appointment =
            unfilteredList.firstWhere((element) => element.taskId == taskId);
        appointment.eventName =
            res.value.title.isNotEmpty ? res.value.title : R.string.noTitle;
        appointment.from = res.value.due ?? res.value.created!;
        appointment.to = res.value.end ??
            res.value.due?.add(Duration(hours: 1)) ??
            res.value.created!.add(Duration(hours: 1));
        appointment.meetingUrl = res.value.meetingUrl ?? '';
        appointment.isAllDay = res.value.due == null || res.value.isAllDay;
        appointment.color = res.value.marked
            ? res.value.backgroundColor(currentUserId)
            : R.color.accentColor;
        appointment.task = res.value;
        _filter();
      }
      isLoading = false;
    } else {
      if (!task.marked)
        task.uuts.removeWhere((element) => element.taskId == task.id);
      final appointment =
          unfilteredList.firstWhere((element) => element.taskId == taskId);
      appointment.eventName =
          task.title.isNotEmpty ? task.title : R.string.noTitle;
      appointment.from = task.due ?? task.created!;
      appointment.to = task.end ??
          task.due?.add(Duration(hours: 1)) ??
          task.created!.add(Duration(hours: 1));
      appointment.meetingUrl = task.meetingUrl ?? '';
      appointment.isAllDay = task.due == null || task.isAllDay;
      appointment.color = task.marked
          ? task.backgroundColor(currentUserId)
          : R.color.accentColor;
      appointment.task = task;
      _filter();
    }
  }

  void addAppointment(TaskModel element) {
    unfilteredList.add(AppointmentModel(
      taskId: element.id,
      from: element.due ?? element.created!,
      to: element.end ??
          element.due?.add(Duration(hours: 1)) ??
          element.created!.add(Duration(hours: 1)),
      eventName: element.title.isNotEmpty ? element.title : R.string.noTitle,
      description: element.description,
      location: element.location,
      uid: element.uid,
      meetingUrl: element.meetingUrl ?? '',
      isAllDay: element.due == null || element.isAllDay,
      color: element.marked
          ? element.backgroundColor(currentUserId)
          : R.color.accentColor,
      task: element,
    ));
    _filter();
  }

  List<DrawerChatModel> currentChannelList = [];

  void loadChannels(
      {List<ChannelModel>? channels,
      List<ChannelModel>? groups,
      List<ChannelModel>? ims,
      List<MemberModel>? members}) {
    List<DrawerChatModel> list = [];

    final favoritesM1x1 =
        ims?.where((element) => element.isFavorite == true).toList();

    final favoritesOpenChannels =
        channels?.where((element) => element.isFavorite == true).toList();

    final favoritesPrivateGroup =
        groups?.where((element) => element.isFavorite == true).toList();

    favoritesOpenChannels?.sort((c1, c2) => c1.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2.titleFixed.toLowerCase().trim()));

    favoritesPrivateGroup?.sort((c1, c2) => c1.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2.titleFixed.toLowerCase().trim()));

    List<DrawerChatModel> tempFavIms = [];
    favoritesM1x1?.forEach((element) {
      final member = members?.firstWhereOrNull(
          (member) => element.other == member.id && (member.active));
      if (member != null)
        tempFavIms.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
          isChild: true,
          channelModel: element,
          title: element.titleFixed,
          memberModel: member,
        ));
    });

    tempFavIms.sort((c1, c2) => c1.memberModel!.profile!.name
        .toLowerCase()
        .trim()
        .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim()));

    ///Adding favorites header
    list.add(DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Favorite,
      isChild: false,
      title: R.string.favorites.toUpperCase(),
      childrenCount: favoritesPrivateGroup!.length +
          favoritesOpenChannels!.length +
          favoritesM1x1!.length,
    ));

    ///AddingFavorites
    list.addAll(tempFavIms);

    favoritesOpenChannels.forEach((element) {
      list.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.Channel,
        isChild: true,
        channelModel: element,
        title: element.titleFixed,
      ));
    });

    favoritesPrivateGroup.forEach((element) {
      list.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
        isChild: true,
        channelModel: element,
        title: element.titleFixed,
      ));
    });

    ///Adding channels header
    list.add(DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Channel,
      isChild: false,
      title: R.string.openChannels.toUpperCase(),
      childrenCount: channels!.length,
    ));

    ///Adding channels
    channels.sort((c1, c2) => c1.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2.titleFixed.toLowerCase().trim()));

    channels.forEach((element) {
      if (!(element.isFavorite == true)) {
        list.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Channel,
          isChild: true,
          channelModel: element,
          title: element.titleFixed,
        ));
      }
    });

    ///Adding messages 1x1 header
    list.add(DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
      isChild: false,
      title: R.string.message1x1.toUpperCase(),
      childrenCount: ims?.length ?? members!.length,
    ));

    ///Adding messages 1x1
    List<DrawerChatModel> tempIms = [];

    ims?.forEach((element) {
      if (!(element.isFavorite)) {
        final member = members?.firstWhereOrNull(
            (member) => element.other == member.id && (member.active));
        if (member != null)
          tempIms.add(DrawerChatModel(
              drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
              isChild: true,
              channelModel: element,
              title: element.titleFixed,
              memberModel: member));
      }
    });

    tempIms.sort((c1, c2) => c1.memberModel!.profile!.name
        .toLowerCase()
        .trim()
        .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim()));

    list.addAll(tempIms);

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

    groups.forEach((element) {
      if (!(element.isFavorite == true)) {
        list.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
          isChild: true,
          channelModel: element,
          title: element.titleFixed,
        ));
      }
    });

    currentChannelList = list;
  }
}
