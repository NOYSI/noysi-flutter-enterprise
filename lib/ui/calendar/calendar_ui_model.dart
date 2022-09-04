import 'dart:ui';
import 'package:code/domain/integration_status.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/calendar/calendar_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarUIModel {
  CalendarView currentView;
  DateTime currentDisplayDate;
  List<AppointmentModel> appointments;
  CalendarPlatforms selectedCalendar;
  CalendarIntegrationStatus? calendarIntegrationStatus;
  CalendarFilter calendarFilter;

  CalendarUIModel({
    this.currentView = CalendarView.schedule,
    required this.currentDisplayDate,
    required this.appointments,
    this.selectedCalendar = CalendarPlatforms.all,
    this.calendarIntegrationStatus,
    this.calendarFilter = CalendarFilter.all
  });
}

class AppointmentModel {
  String? taskId;
  String? eventName;
  String? description;
  DateTime? from;
  DateTime? to;
  bool isAllDay;
  String meetingUrl;
  String? location;
  TaskModel? task;
  String? uid;
  Color? color;

  AppointmentModel(
      {this.taskId,
      this.uid,
      this.eventName = '',
      this.from,
      this.to,
      this.task,
      this.isAllDay = true,
      this.color,
      this.meetingUrl = '',
      this.location = '',
      this.description});
}

class AppointmentsDataSource extends CalendarDataSource {
  AppointmentsDataSource(List<AppointmentModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getLocation(int index) {
    return appointments![index].location;
  }

  @override
  String getNotes(int index) {
    return appointments![index].description;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}
