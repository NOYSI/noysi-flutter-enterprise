import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/calendar/calendar_ui_model.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../_di/injector.dart';
import '../../data/api/remote/remote_constants.dart';

class TXCalendarViewWidget extends StatefulWidget {
  final CalendarController controller;
  final CalendarUIModel calendarUIModel;
  final ValueChanged<AppointmentModel>? onTap;

  const TXCalendarViewWidget(
      {Key? key,
      required this.controller,
      required this.calendarUIModel,
      this.onTap})
      : super(key: key);

  @override
  _TXCalendarViewWidgetState createState() => _TXCalendarViewWidgetState();
}

class _TXCalendarViewWidgetState extends State<TXCalendarViewWidget> {
  List<AppointmentModel> appointmentList = [];
  DateTime? date;

  // List<int> mostFrequent(List<int> list) {
  //   list.sort();
  //   List<int> popularNumbers = [];
  //   List<Map<int, int>> data = [];
  //   var maxOccurrence = 0;
  //
  //   var i = 0;
  //   while (i < list.length) {
  //     var number = list[i];
  //     var occurrence = 1;
  //     for (int j = 0; j < list.length; j++) {
  //       if (j == i) {
  //         continue;
  //       } else if (number == list[j]) {
  //         occurrence++;
  //       }
  //     }
  //     list.removeWhere((it) => it == number);
  //     data.add({number: occurrence});
  //     if (maxOccurrence < occurrence) {
  //       maxOccurrence = occurrence;
  //     }
  //   }
  //
  //   data.forEach((map) {
  //     if (map[map.keys.toList()[0]] == maxOccurrence) {
  //       popularNumbers.add(map.keys.toList()[0]);
  //     }
  //   });
  //   return popularNumbers;
  // }
  //
  // void sortMonthViewCellElements(List<AppointmentModel> elements) {
  //   elements.sort((a, b) {
  //     if (a.to.difference(a.from).inDays > b.to.difference(b.from).inDays)
  //       return -1;
  //     else if (a.to.difference(a.from).inDays < b.to.difference(b.from).inDays)
  //       return 1;
  //     return a.eventName.compareTo(b.eventName);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    appointmentList.clear();
    date = widget.controller.selectedDate;
    if (date != null)
      appointmentList
          .addAll(widget.calendarUIModel.appointments.where((element) {
        return element.from != null && element.to != null && ((element.from!.day == date!.day &&
            element.from!.month == date!.month &&
            element.from!.year == date!.year) ||
            (element.to!.day == date!.day &&
                element.to!.month == date!.month &&
                element.to!.year == date!.year) ||
            (date!.isAfter(element.from!) && date!.isBefore(element.to!)));
      }));
    return Column(
      children: [
        Expanded(
          child: SfCalendar(
            appointmentTimeTextFormat: R.string.dateFormat2,
            todayHighlightColor: R.color.secondaryColor,
            selectionDecoration: BoxDecoration(
            border: Border.all(color: R.color.secondaryColor)),
            controller: widget.controller,
            view: widget.calendarUIModel.currentView,
            headerHeight: 0,
            dataSource:
                AppointmentsDataSource(widget.calendarUIModel.appointments),
            scheduleViewSettings: ScheduleViewSettings(
              monthHeaderSettings: MonthHeaderSettings(
                textAlign: TextAlign.start,
                height: 60,
                backgroundColor: R.color.grayLightestColor,
                monthTextStyle: TextStyle(
                    fontFamily: RemoteConstants.fontFamily,
                    color: R.color.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              appointmentTextStyle: TextStyle(
                  fontFamily: RemoteConstants.fontFamily, color: R.color.whiteColor),
              dayHeaderSettings: DayHeaderSettings(
                  dateTextStyle: TextStyle(
                      fontFamily: RemoteConstants.fontFamily, color: R.color.blackColor),
                  dayTextStyle: TextStyle(
                      fontFamily: RemoteConstants.fontFamily, color: R.color.blackColor)),
              weekHeaderSettings: WeekHeaderSettings(
                  weekTextStyle: TextStyle(
                      fontFamily: RemoteConstants.fontFamily,
                      color: R.color.blackColor,
                      fontSize: 18)),
            ),
            monthViewSettings: MonthViewSettings(
              monthCellStyle: MonthCellStyle(
                textStyle: TextStyle(
                    fontFamily: RemoteConstants.fontFamily, color: R.color.blackColor, fontSize: 16),
                leadingDatesTextStyle: TextStyle(
                    fontFamily: RemoteConstants.fontFamily, color: R.color.grayColor, fontSize: 16),
                trailingDatesTextStyle: TextStyle(
                    fontFamily: RemoteConstants.fontFamily, color: R.color.grayColor, fontSize: 16),
              ),
              showAgenda: false,
              appointmentDisplayCount: 8,
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            ),
            headerStyle: CalendarHeaderStyle(
              textStyle: TextStyle(
                  fontFamily: RemoteConstants.fontFamily,
                  color: R.color.blackColor,
                  fontSize: 18),
            ),
            viewHeaderStyle: ViewHeaderStyle(
                dayTextStyle: TextStyle(
                    fontFamily: RemoteConstants.fontFamily,
                    color: R.color.blackColor,
                    fontSize: 18),
                dateTextStyle: TextStyle(
                    fontFamily: RemoteConstants.fontFamily,
                    color: R.color.blackColor,
                    fontSize: 18)),
            appointmentTextStyle: TextStyle(
                fontFamily: RemoteConstants.fontFamily,
                color: R.color.whiteColor,
                fontSize: 14),
            timeSlotViewSettings: TimeSlotViewSettings(
              timelineAppointmentHeight: 42,
              timeTextStyle: TextStyle(
                  fontFamily: RemoteConstants.fontFamily,
                  color: R.color.blackColor,
                  fontSize: 16),
              timeFormat: R.string.dateFormat2,
              dateFormat: 'd',
              dayFormat: 'EEE',
              minimumAppointmentDuration: Duration(minutes: 30),
            ),
            // monthCellBuilder: (context, details) {
            //   List<AppointmentModel> appointments = details.appointments.cast<AppointmentModel>();
            //   final currentMonthInt =
            //       mostFrequent(details.visibleDates.map((e) => e.month).toList())
            //           .first;
            //   final isToday = DateTime.now().day == details.date.day &&
            //       DateTime.now().month == details.date.month &&
            //       DateTime.now().year == details.date.year;
            //   final screenWidth = MediaQuery.of(context).size.width;
            //   final isAtBorderRight = details.bounds.right == screenWidth;
            //   final isAtBorderLeft = details.bounds.left == 0.0;
            //   List<Widget> widgets = [];
            //   sortMonthViewCellElements(appointments);
            //   appointments.forEach((element) {
            //     AppointmentModel model = element;
            //     final isMultipleDays =
            //         model != null && model.from.day != model.to.day;
            //     final differenceDays =
            //         isMultipleDays ? model.to.day - model.from.day : 0;
            //     widgets.add(Column(
            //       children: [
            //         SizedBox(
            //           height: 2,
            //         ),
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 5),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.horizontal(
            //                 left: model.from.year == details.date.year &&
            //                         model.from.month == details.date.month &&
            //                         model.from.day == details.date.day
            //                     ? Radius.circular(7)
            //                     : Radius.zero,
            //                 right: model.to.year == details.date.year &&
            //                         model.to.month == details.date.month &&
            //                         model.to.day == details.date.day
            //                     ? Radius.circular(7)
            //                     : Radius.zero,
            //               ),
            //               color: model.backgroundColor),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                 child: TXTextWidget(
            //                   text: model.eventName,
            //                   color: R.color.whiteColor,
            //                   size: 14,
            //                   textOverflow: TextOverflow.ellipsis,
            //                 ),
            //               ),
            //               model.marked
            //                   ? Container()
            //                   : _getUnmarkedWidget(R.color.calendarButton)
            //             ],
            //           ),
            //         ),
            //       ],
            //     ));
            //   });
            //   return Stack(
            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //             border:
            //                 Border.all(width: .5, color: R.color.grayLightestColor)),
            //       ),
            //       Column(
            //         children: [
            //           SizedBox(
            //             height: 2,
            //           ),
            //           Container(
            //             height: 26,
            //             width: 26,
            //             alignment: Alignment.center,
            //             decoration: isToday
            //                 ? BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: R.color.secondaryColor,
            //                   )
            //                 : null,
            //             child: TXTextWidget(
            //               size: 14,
            //               text: details.date.day.toString(),
            //               color: isToday
            //                   ? Colors.white
            //                   : currentMonthInt == details.date.month
            //                       ? R.color.blackColor
            //                       : R.color.grayColor,
            //             ),
            //           ),
            //           ...widgets
            //         ],
            //       )
            //     ],
            //   );
            // },
            appointmentBuilder: CalendarView.month == widget.controller.view
                ? null
                : (context, details) {
                    AppointmentModel model = details.appointments.first;
                    return appointmentWidget(
                        model,
                        widget.controller.view == CalendarView.day && widget.controller.displayDate != null
                            ? widget.controller.displayDate!
                            : details.date);
                  },
            onTap: (details) {
              if (details.targetElement == CalendarElement.calendarCell &&
                  widget.controller.view == CalendarView.month) {
                // appointmentList.clear();
                // appointmentList.addAll(
                //     details?.appointments?.cast<AppointmentModel>() ?? []);
                // date = details.date;
                // setState(() {});
                //showAgenda(context, details.appointments.cast<AppointmentModel>());
              } else {
                final appointment = details.appointments?.cast<AppointmentModel>().first;
               if(widget.onTap != null && appointment != null) widget.onTap!(appointment);
              }
            },
          ),
        ),
        widget.controller.view == CalendarView.month
            ? Expanded(
                child: appointmentList.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        child: TXTextWidget(
                          text: R.string.noEvents,
                        ),
                      )
                    : SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20, top: 5, left: 15, right: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          TXTextWidget(text: CalendarUtils.showInFormat("EEE", date)?.toUpperCase() ?? "", size: 14,),
                          TXTextWidget(text: "${date?.day ?? ""}", color: R.color.grayDarkestColor, size: 20,),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () => showAgenda(context, appointmentList),
                            child: Icon(
                              Icons.timeline,
                              color: R.color.grayDarkestColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: date != null ? Column(
                          children: [
                            ...appointmentList.map((e) => appointmentWidget(e, date!, isAgenda: true, margin: EdgeInsets.only(bottom: 5))).toList()
                          ],
                        ) : Container(),
                      ),
                    ],
                  )
                ),
        )
            : Container()
      ],
    );
  }

  Widget appointmentWidget(AppointmentModel model, DateTime renderingDate,
      {bool isAgenda = false, margin = EdgeInsets.zero}) {
    final bool showTimesExceptions = model.isAllDay ||
        widget.controller.view == CalendarView.week ||
        (widget.controller.view == CalendarView.month && !isAgenda) ||
        widget.controller.view == CalendarView.day ||
        (model.from!.month != model.to!.month ||
            (model.from!.month == model.to!.month &&
                model.from!.day != model.to!.day));

    final isMultipleDays =
        (model.from!.day + model.from!.month + model.from!.year) !=
            (model.to!.day + model.to!.month + model.to!.year);
    final differenceInDays = isMultipleDays
        ? DateTimeRange(
                start:
                    DateTime(model.from!.year, model.from!.month, model.from!.day),
                end: DateTime(model.to!.year, model.to!.month, model.to!.day))
            .duration
            .inDays
        : 0;

    return InkWell(
      onTap: () {
        if(widget.onTap != null) widget.onTap!(model);
      },
      child: Container(
        margin: margin,
        constraints: BoxConstraints(maxHeight: showTimesExceptions ? 22 : 42),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            border: model.task?.marked == true
                ? null
                : Border.all(width: 2, color: R.color.accentColor),
            borderRadius: BorderRadius.circular(4),
            color:  model.task?.backgroundColor(Injector.instance.inMemoryData.currentMember?.id ?? "")),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TXTextWidget(
                    text:
                        "${model.eventName} ${isMultipleDays && widget.controller.view != CalendarView.week ? "(${R.string.day.toCapitalize()} ${DateTimeRange(start: DateTime(model.from!.year, model.from!.month, model.from!.day), end: DateTime(renderingDate.year, renderingDate.month, renderingDate.day)).duration.inDays + 1}/${differenceInDays + 1})" : ""}",
                    color: R.color.whiteColor,
                    size: 16,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  showTimesExceptions
                      ? Container()
                      : TXTextWidget(
                          color: R.color.whiteColor,
                          textOverflow: TextOverflow.ellipsis,
                          size: 16,
                          text:
                              "${CalendarUtils.showInFormat(R.string.dateFormat2, model.from)}${model.from != model.to ? " - ${CalendarUtils.showInFormat(R.string.dateFormat2, model.to)}" : ""}")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _getUnmarkedWidget(Color color) => Container(
  //       width: 12,
  //       height: 12,
  //       child: Stack(
  //         children: <Widget>[
  //           Container(
  //             decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 border: Border.all(color: color, width: 1.5)),
  //           ),
  //           Center(
  //             child: Container(
  //               margin: EdgeInsets.all(2.5),
  //               decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  void showAgenda(BuildContext context, List<AppointmentModel> models,
      {CalendarView view = CalendarView.timelineDay}) {
    CalendarController controller = CalendarController();
    controller.view = view;
    controller.selectedDate = widget.controller.selectedDate;
    controller.displayDate = widget.controller.selectedDate;
    return showTXModalBottomSheet(
        context: context,
        builder: (context) {
          return SfCalendar(
            appointmentTimeTextFormat: R.string.dateFormat2,
            todayHighlightColor: R.color.secondaryColor,
            allowViewNavigation: false,
            allowedViews: [view],
            controller: controller,
            selectionDecoration: BoxDecoration(
                border: Border.all(color: R.color.secondaryColor)),
            headerHeight: 0,
            dataSource: AppointmentsDataSource(models),
            headerStyle: CalendarHeaderStyle(
              textStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color: R.color.blackColor,
                  fontSize: 15),
            ),
            viewHeaderStyle: ViewHeaderStyle(
                dayTextStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: R.color.blackColor,
                    fontSize: 15),
                dateTextStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: R.color.blackColor,
                    fontSize: 15)),
            appointmentTextStyle: TextStyle(
                fontFamily: 'Montserrat',
                color: R.color.whiteColor,
                fontSize: 14),
            appointmentBuilder: (context, details) {
              AppointmentModel model = details.appointments.first;
              return appointmentWidget(model, details.date);
            },
            timeSlotViewSettings: TimeSlotViewSettings(
              timelineAppointmentHeight: 42,
              timeTextStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color: R.color.blackColor,
                  fontSize: 15),
              timeFormat: R.string.dateFormat2,
              dateFormat: 'd',
              dayFormat: 'EEE',
              minimumAppointmentDuration: Duration(minutes: 60),
            ),
            onTap: (details) {
              final appointment = details.appointments?.cast<AppointmentModel>().first;
              if(widget.onTap != null && appointment != null) widget.onTap!(appointment);
            },
          );
        });
  }
}
