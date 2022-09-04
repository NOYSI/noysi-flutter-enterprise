import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_calendar_view_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/calendar/calendar_bloc.dart';
import 'package:code/ui/calendar/calendar_ui_model.dart';
import 'package:code/ui/calendar/overlay_datepicker.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/task_create/task_create_page.dart';
import 'package:code/ui/task_detail/task_detail_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:code/utils/extensions.dart';

import '../_tx_widget/tx_divider_widget.dart';

class CalendarPage extends StatefulWidget {
  final TeamJoinedModel joinedTeam;

  const CalendarPage({required this.joinedTeam});

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends StateWithBloC<CalendarPage, CalendarBloc> {
  CalendarController controller = CalendarController();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    bloc.init();
    controller.displayDate = DateTime.now();
    bloc.loadChannels(
        members: widget.joinedTeam.memberWrapperModel.list,
        ims: widget.joinedTeam.messages1x1,
        groups: widget.joinedTeam.groups,
        channels: widget.joinedTeam.channels);
    controller.addPropertyChangedListener((data) {
      bloc.checkLoadMore(controller.displayDate);
      bloc.refreshData();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Stack(
        children: [
          StreamBuilder<CalendarUIModel>(
              stream: bloc.calendarViewResult,
              initialData: bloc.calendarUIModel,
              builder: (context, snapshot) {
                CalendarUIModel calendar = snapshot.data!;
                return TXMainAppBarWidget(
                    title:
                        "${CalendarUtils.showInFormat(R.string.dateFormat7, controller.displayDate).toCapitalize()}",
                    floatingActionButton: SpeedDial(
                      openCloseDial: isDialOpen,
                      children: [..._getDialWidgets(context)],
                      icon: Icons.add,
                      activeIcon: Icons.close,
                      backgroundColor: R.color.calendarButton,
                      iconTheme: IconThemeData(color: R.color.whiteColor),
                    ),
                    actions: [
                      OverlayDatePicker(
                        onDateSelected: (datetime) {
                          controller.displayDate = datetime;
                        },
                        isMonthView: controller.view == CalendarView.month,
                      ),
                      PopupMenuButton(
                        icon: Icon(
                          Icons.view_comfy,
                        ),
                        itemBuilder: (ctx) {
                          return [..._getPopupActionsCalendarView()];
                        },
                        onSelected: (key) {
                          bloc.calendarUIModel.currentView =
                              key as CalendarView;
                          controller.view = key;
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.filter_list,
                        ),
                        onPressed: () {
                          showTXModalBottomSheetAutoAdjustable(
                              context: context,
                              builder: (context) {
                                return _launchFilters(context);
                              });
                        },
                      ),
                    ],
                    body: Container(
                      child: TXCalendarViewWidget(
                        controller: controller,
                        calendarUIModel: calendar,
                        onTap: (AppointmentModel appointment) async {
                          if (appointment.task != null) {
                            navigateToDetails(appointment.task!);
                          }
                        },
                      ),
                    ));
              }),
          TXLoadingWidget(loadingStream: bloc.isLoadingStream)
        ],
      ),
    );
  }

  void navigateToDetails(TaskModel task) async {
    NavigationUtils.push(
        context,
        TaskDetailPage(
          taskModel: task,
        )).then((value) {
      if (value is bool && value) {
        // if(task.isMeetingAppointment) bloc.removeAppointment(task.id);
        // else bloc.refreshTask(task.id);
        bloc.removeAppointment(task.id);
      } else if (value is TaskModel) {
        bloc.refreshTask(task.id, task: value);
      } else {
        bloc.refreshTask(task.id);
      }
    });
  }

  // Widget _showTasks(List<dynamic> appointments) {
  //   return Container(
  //     child: ListView.builder(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 10,
  //       ).copyWith(bottom: 30),
  //       physics: BouncingScrollPhysics(),
  //       itemBuilder: (ctx, index) {
  //         if (index == 0) {
  //           return Container(
  //             padding: EdgeInsets.symmetric(vertical: 10),
  //             margin: EdgeInsets.only(left: 15),
  //             child: TXTextWidget(
  //               text: R.string.selectEvent.toUpperCase(),
  //             ),
  //           );
  //         }
  //         index -= 1;
  //         final model = appointments[index] as AppointmentModel;
  //         return Container(
  //           child: InkWell(
  //             onTap: () async {
  //               await NavigationUtils.pop(context);
  //               navigateToDetails(model.task);
  //             },
  //             child: Container(
  //               padding: EdgeInsets.symmetric(vertical: 10),
  //               margin: EdgeInsets.only(left: 15),
  //               child: TXTextWidget(
  //                 text: model.eventName,
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //       itemCount: appointments.length + 1,
  //     ),
  //   );
  // }

  List<SpeedDialChild> _getDialWidgets(BuildContext context) {
    List<SpeedDialChild> list = [
      SpeedDialChild(
        child: Icon(Icons.developer_board),
        label: R.string.createTask,
        labelStyle: TextStyle(fontSize: 20),
        onTap: () async {
          showTXModalBottomSheet(
              context: context,
              builder: (context) {
                return _showChannels();
              });
        },
        // labelStyle: TextStyle(
        //     color: MediaQuery.of(context).platformBrightness == Brightness.dark
        //         ? R.color.whiteColor
        //         : R.color.blackColor),
      ),
      SpeedDialChild(
        child: Icon(Icons.developer_board),
        label: R.string.createNewPersonalNote,
        labelStyle: TextStyle(fontSize: 20),
        onTap: () async {
          final result = await NavigationUtils.push(
              context,
              TaskCreatePage(
                fromCalendar: true,
                joinedTeam: widget.joinedTeam,
              ));
          if (result != null && result is TaskModel) {
            bloc.addAppointment(result);
          }
        },
        // labelStyle: TextStyle(
        //     color: MediaQuery.of(context).platformBrightness == Brightness.dark
        //         ? R.color.whiteColor
        //         : R.color.blackColor),
        // backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark
        //     ? R.color.blackColor
        //     : R.color.whiteColor
      ),
      SpeedDialChild(
        child: Image.asset(
          R.image.meetingDrawer,
          // color: MediaQuery.of(context).platformBrightness == Brightness.dark
          //     ? R.color.blackColor
          //     : R.color.whiteColor,
          height: 20,
          width: 20,
        ),
        label: R.string.createMeetingEvent,
        labelStyle: TextStyle(fontSize: 20),
        onTap: () async {
          final result = await NavigationUtils.push(
              context,
              TaskCreatePage(
                  isMeetingAppointment: true,
                  fromCalendar: true,
                  joinedTeam: widget.joinedTeam,));
          if (result != null && result is TaskModel) {
            if (result.due == null) result.due = result.created;
            bloc.addAppointment(result);
          }
        },
        // labelStyle: TextStyle(
        //     color: MediaQuery.of(context).platformBrightness == Brightness.dark
        //         ? R.color.whiteColor
        //         : R.color.blackColor),
      ),
    ];

    return list;
  }

  Widget _launchFilters(BuildContext context) {
    return StreamBuilder<CalendarUIModel>(
        stream: bloc.calendarViewResult,
        initialData: bloc.calendarUIModel,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TXTextWidget(
                    text: R.string.filters,
                    color: R.color.grayDarkestColor,
                    size: 18,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TXDividerWidget(),
                Container(
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    trailing: snapshot.data!.selectedCalendar ==
                            CalendarPlatforms.google
                        ? Image.asset(R.image.googleRed, height: 35)
                        : snapshot.data!.selectedCalendar ==
                                CalendarPlatforms.outlook
                            ? Image.asset(
                                R.image.outlookBlue,
                                height: 35,
                              )
                            : snapshot.data!.selectedCalendar ==
                                    CalendarPlatforms.noysi
                                ? Image.asset(R.image.logo, height: 35)
                                : TXTextWidget(
                                    text: R.string.all,
                                    fontWeight: FontWeight.bold),
                    icon: Icon(Icons.calendar_today, color: R.color.grayColor),
                    text: R.string.calendar,
                    onTap: () async {
                      showTXModalBottomSheetAutoAdjustable(
                          context: context,
                          builder: (context) {
                            return _launchPlatformOptions(
                                context, snapshot.data!);
                          });
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: TXDividerWidget(),
                    ),
                  ],
                ),
                snapshot.data!.selectedCalendar == CalendarPlatforms.google ||
                        snapshot.data!.selectedCalendar ==
                            CalendarPlatforms.outlook
                    ? Container()
                    : Container(
                        height: 45,
                        child: TXMenuOptionItemWidget(
                          trailing: Row(
                            children: [
                              TXTextWidget(
                                  text: snapshot.data!.calendarFilter ==
                                          CalendarFilter.created
                                      ? R.string.created
                                      : snapshot.data!.calendarFilter ==
                                              CalendarFilter.assigned
                                          ? R.string.assigned
                                          : R.string.all,
                                  color: snapshot.data!.calendarFilter ==
                                          CalendarFilter.created
                                      ? R.color.secondaryColor
                                      : snapshot.data!.calendarFilter ==
                                              CalendarFilter.assigned
                                          ? R.color.secondaryHeaderColor
                                          : null,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          icon: Icon(Icons.category, color: R.color.grayColor),
                          text: R.string.category,
                          onTap: () async {
                            showTXModalBottomSheetAutoAdjustable(
                                context: context,
                                builder: (context) {
                                  return _launchCategoryOptions(
                                      context, snapshot.data!);
                                });
                          },
                        ),
                      ),
                snapshot.data!.selectedCalendar == CalendarPlatforms.google ||
                        snapshot.data!.selectedCalendar ==
                            CalendarPlatforms.outlook
                    ? Container()
                    : Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: TXDividerWidget(),
                          ),
                        ],
                      ),
              ],
            ),
          );
        });
  }

  _launchPlatformOptions(BuildContext context, CalendarUIModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: TXTextWidget(
              text: R.string.calendar,
              color: R.color.grayDarkestColor,
              size: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TXDividerWidget(),
          ..._getPlatformWidgets(model.selectedCalendar),
        ],
      ),
    );
  }

  _launchCategoryOptions(BuildContext context, CalendarUIModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: TXTextWidget(
              text: R.string.category,
              color: R.color.grayDarkestColor,
              size: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TXDividerWidget(),
          ..._getCategoryWidgets(model.calendarFilter),
        ],
      ),
    );
  }

  List<Widget> _getPlatformWidgets(CalendarPlatforms selectedPlatform) {
    return CalendarPlatforms.values.map((e) {
      final isSelected = e == selectedPlatform;
      return Column(
        children: [
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              text: e == CalendarPlatforms.google
                  ? R.string.googleCalendar
                  : e == CalendarPlatforms.outlook
                      ? R.string.outlookCalendar
                      : e == CalendarPlatforms.noysi
                          ? R.string.noysiCalendar
                          : R.string.all,
              trailing: isSelected
                  ? Container(
                      child: Icon(Icons.check),
                    )
                  : Container(),
              onTap: () async {
                NavigationUtils.pop(context);
                if (!isSelected) bloc.changePlatform(e);
              },
            ),
          ),
          TXDividerWidget(),
        ],
      );
    }).toList();
  }

  List<Widget> _getCategoryWidgets(CalendarFilter selectedFilter) {
    return CalendarFilter.values.map((e) {
      final isSelected = e == selectedFilter;
      return Column(
        children: [
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              text: e == CalendarFilter.assigned
                  ? R.string.assigned
                  : e == CalendarFilter.created
                      ? R.string.created
                      : R.string.all,
              trailing: isSelected
                  ? Container(
                      child: Icon(Icons.check),
                    )
                  : Container(),
              onTap: () async {
                NavigationUtils.pop(context);
                if (!isSelected) bloc.changeFilter(e);
              },
            ),
          ),
          TXDividerWidget(),
        ],
      );
    }).toList();
  }

  // List<PopupMenuEntry> _getPopupActionsCalendarFilter() {
  //   List<PopupMenuEntry> list = [];
  //   final allPlatforms = PopupMenuItem(
  //     value: CalendarPlatforms.all,
  //     child: TXMenuOptionItemWidget(
  //       text: R.string.all,
  //       trailing: CalendarPlatforms.all == bloc.calendarUIModel.selectedCalendar
  //           ? Icon(Icons.check, color: R.color.darkColor)
  //           : null,
  //     ),
  //   );
  //   final google = PopupMenuItem(
  //     value: CalendarPlatforms.google,
  //     child: TXMenuOptionItemWidget(
  //       text: R.string.googleCalendar,
  //       icon: Image.asset(R.image.google, height: 20, width: 20),
  //       trailing:
  //           CalendarPlatforms.google == bloc.calendarUIModel.selectedCalendar
  //               ? Icon(Icons.check, color: R.color.darkColor)
  //               : null,
  //     ),
  //   );
  //   final outlook = PopupMenuItem(
  //     value: CalendarPlatforms.outlook,
  //     child: TXMenuOptionItemWidget(
  //       text: R.string.outlookCalendar,
  //       icon: Image.asset(R.image.outlook, height: 20, width: 20),
  //       trailing:
  //           CalendarPlatforms.outlook == bloc.calendarUIModel.selectedCalendar
  //               ? Icon(Icons.check, color: R.color.darkColor)
  //               : null,
  //     ),
  //   );
  //   final noysi = PopupMenuItem(
  //     value: CalendarPlatforms.noysi,
  //     child: TXMenuOptionItemWidget(
  //       text: R.string.noysiCalendar,
  //       icon: CircleAvatar(
  //         radius: 10,
  //         backgroundColor: R.color.grayDarkestColor,
  //         child: Image.asset(R.image.logoWhite, height: 12, width: 12),
  //       ),
  //       trailing:
  //           CalendarPlatforms.noysi == bloc.calendarUIModel.selectedCalendar
  //               ? Icon(Icons.check, color: R.color.darkColor)
  //               : null,
  //     ),
  //   );
  //   final allFilter = PopupMenuItem(
  //     value: CalendarFilter.all,
  //     child: TXMenuOptionItemWidget(
  //       text: R.string.all,
  //       trailing: CalendarFilter.all == bloc.calendarUIModel.calendarFilter
  //           ? Icon(Icons.check, color: R.color.darkColor)
  //           : null,
  //     ),
  //   );
  //   final assigned = PopupMenuItem(
  //     value: CalendarFilter.assigned,
  //     child: TXMenuOptionItemWidget(
  //       text: R.string.assigned,
  //       trailing: CalendarFilter.assigned == bloc.calendarUIModel.calendarFilter
  //           ? Icon(Icons.check, color: R.color.darkColor)
  //           : null,
  //     ),
  //   );
  //   final created = PopupMenuItem(
  //     value: CalendarFilter.created,
  //     child: TXMenuOptionItemWidget(
  //       text: R.string.created,
  //       trailing: CalendarFilter.created == bloc.calendarUIModel.calendarFilter
  //           ? Icon(Icons.check, color: R.color.darkColor)
  //           : null,
  //     ),
  //   );
  //   list.add(allPlatforms);
  //   list.add(noysi);
  //   if (bloc.calendarUIModel.calendarIntegrationStatus!.googleCalendar)
  //     list.add(google);
  //   if (bloc.calendarUIModel.calendarIntegrationStatus!.outlookCalendar)
  //     list.add(outlook);
  //   list.add(PopupMenuDivider());
  //   list.add(allFilter);
  //   list.add(created);
  //   list.add(assigned);
  //   return list;
  // }

  List<PopupMenuItem> _getPopupActionsCalendarView() {
    List<PopupMenuItem> list = [];
    final day = PopupMenuItem(
      value: CalendarView.day,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.calendar_view_day, color: R.color.grayColor),
        text: R.string.day,
        trailing: CalendarView.day == bloc.calendarUIModel.currentView
            ? Icon(Icons.check, color: R.color.darkColor)
            : null,
      ),
    );
    final week = PopupMenuItem(
      value: CalendarView.week,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.calendar_view_day, color: R.color.grayColor),
        text: R.string.week,
        trailing: CalendarView.week == bloc.calendarUIModel.currentView
            ? Icon(Icons.check, color: R.color.darkColor)
            : null,
      ),
    );
    // final weekWork = PopupMenuItem(
    //   value: CalendarView.workWeek,
    //   child: TXMenuOptionItemWidget(
    //     icon: Icon(Icons.view_week, color: R.color.grayColor),
    //     text: R.string.week,
    //     trailing: CalendarView.workWeek == bloc.calendarUIModel.currentView
    //         ? Icon(Icons.check, color: R.color.darkColor)
    //         : null,
    //   ),
    // );
    final month = PopupMenuItem(
      value: CalendarView.month,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.view_carousel, color: R.color.grayColor),
        text: R.string.month,
        trailing: CalendarView.month == bloc.calendarUIModel.currentView
            ? Icon(Icons.check, color: R.color.darkColor)
            : null,
      ),
    );
    final schedule = PopupMenuItem(
      value: CalendarView.schedule,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.calendar_today, color: R.color.grayColor),
        text: R.string.calendar,
        trailing: CalendarView.schedule == bloc.calendarUIModel.currentView
            ? Icon(Icons.check, color: R.color.darkColor)
            : null,
      ),
    );
    list.add(day);
    list.add(week);
    // list.add(weekWork);
    list.add(month);
    list.add(schedule);
    return list;
  }

  Widget _showChannels() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(bottom: 30),
        physics: BouncingScrollPhysics(),
        itemBuilder: (ctx, index) {
          final model = bloc.currentChannelList[index];
          return Container(
            child: model.isChild
                ? _getChildWidget(model)
                : _getHeaderWidget(model),
          );
        },
        itemCount: bloc.currentChannelList.length,
      ),
    );
  }

  Widget _getHeaderWidget(DrawerChatModel model) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TXTextWidget(
        text: model.title,
        color: R.color.grayColor,
      ),
    );
  }

  Widget _getChildWidget(DrawerChatModel model) {
    return InkWell(
      onTap: () async {
        await NavigationUtils.pop(context);
        final result = await NavigationUtils.push(
            context,
            TaskCreatePage(
              channelId: model.channelModel?.id,
              joinedTeam: widget.joinedTeam,
              fromCalendar: true,
            ));
        if (result != null && result is TaskModel) {
          bloc.addAppointment(result);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(left: 15),
        child: TXTextWidget(
          text: model.channelModel?.isM1x1 == true
              ? "@${CommonUtils.getMemberUsername(model.memberModel) ?? ""}"
              : model.title.toLowerCase().trim(),
          color: R.color.blackColor,
        ),
      ),
    );
  }
}
