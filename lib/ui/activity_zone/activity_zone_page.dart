import 'dart:async';
import 'package:code/_res/R.dart';
import 'package:code/domain/activity/activity_model.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_html_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/activity_zone/activity_zone_bloc.dart';
import 'package:code/ui/activity_zone/sessions/sessions_page.dart';
import 'package:code/ui/files_explorer/files_explorer_page.dart';
import 'package:code/ui/task_detail/task_detail_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'dart:math' as math;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:timeline_tile/timeline_tile.dart';

import '../../enums.dart';

class ActivityZonePage extends StatefulWidget {
  final TeamJoinedModel joinedTeam;
  final MemberModel currentUser;

  ActivityZonePage({required this.joinedTeam, required this.currentUser});

  @override
  State<StatefulWidget> createState() => _ActivityZoneState();
}

class _ActivityZoneState
    extends StateWithBloC<ActivityZonePage, ActivityZoneBloC> {
  ScrollController? scrollController;
  StreamSubscription? ssActivityEvent;

  bool get teamIsTrial => widget.joinedTeam.team.trial ?? true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController?.addListener(onScrollEnds);
    bloc.popToHomeController.listen((value) {
      if (value ?? false) {
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
      }
    });
    bloc.changeToFolderController.listen((value) {
      if (value != null) {
        navigateToFiles(context,
            selectedFolder: value.parent, channelModel: value.channel);
      }
    });
    bloc.changeToTaskController.listen((value) {
      if (value != null && value.isNotEmpty) {
        NavigationUtils.push(
            context,
            TaskDetailPage(
              taskId: value,
            ));
      }
    });
    ssActivityEvent = onActivityEventArrived.listen((value) {
      if (value != null) {
        onActivityEventArrived.sink.add(null);
        value.deleted
            ? bloc.onActivityDeleted(value.model!)
            : bloc.onActivityCreated(value.model!);
      }
    });
    bloc.loadUserActivities(
        isAdmin: widget.currentUser.userRol == UserRol.Admin);
  }

  void onScrollEnds() {
    if (scrollController!.position.pixels >
        scrollController!.position.maxScrollExtent - 100) bloc.loadMore();
  }

  @override
  void dispose() {
    scrollController?.removeListener(onScrollEnds);
    scrollController?.dispose();
    ssActivityEvent?.cancel();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) => Stack(
        children: [
          TXMainAppBarWidget(
            title: R.string.activityZone,
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showTXModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return _launchOptions(context);
                      });
                },
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                ),
                itemBuilder: (context) {
                  return [..._popupActions()];
                },
                onSelected: (key) {
                  switch (key) {
                    case ActivityZoneMenu.sessions:
                      NavigationUtils.push(context, SessionsPage());
                      break;
                    case ActivityZoneMenu.memberUsage:
                      txShowWarningDialogBlur(context,
                          title: Row(
                            children: [
                              TXTextWidget(
                                text: R.string.userDataUsage,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                color: R.color.darkColor,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.info_outline,
                                  color: R.color.grayColor),
                            ],
                          ),
                          yesNo: false,
                          content: _getUserUsageInfo());
                      break;
                    case ActivityZoneMenu.teamUsage:
                      txShowWarningDialogBlur(context,
                          title: Row(
                            children: [
                              TXTextWidget(
                                text: R.string.teamDataUsage,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                color: R.color.darkColor,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.info_outline,
                                  color: R.color.grayColor),
                            ],
                          ),
                          yesNo: false,
                          content: _getTeamUsageInfo());
                      break;
                  }
                },
              ),
            ],
            body: Container(
              child: StreamBuilder<ActivityWrapperModel?>(
                initialData:
                    ActivityWrapperModel(list: [], offset: 0, total: 0),
                stream: bloc.activitiesResult,
                builder: (context, snapshot) {
                  snapshot.data?.list
                      .sort((c1, c2) => c2.ts!.compareTo(c1.ts!));
                  return Container(
                    child: snapshot.data!.list.isNotEmpty
                        ? ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.only(
                                top: 20, bottom: 10, left: 10, right: 10),
                            itemCount: snapshot.data?.list.length,
                            itemBuilder: (context, index) {
                              final activity = snapshot.data?.list[index];
                              final showDateDivider = index == 0 ||
                                  snapshot.data?.list[math.max(0, index - 1)]
                                          .ts!.day !=
                                      activity?.ts?.day;
                              final nextHasDateDivider =
                                  index < snapshot.data!.list.length - 1 &&
                                      snapshot.data?.list[index + 1].ts!.day !=
                                          activity?.ts?.day;
                              return index == 0 && !bloc.isFiltered
                                  ? Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TXTextWidget(
                                            text: R.string.activityZone,
                                            color: R.color.blackColor,
                                            fontWeight: FontWeight.bold,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TXTextWidget(
                                            textAlign: TextAlign.center,
                                            text: R.string.activityZoneHeader,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            child: _getActivityItem(
                                                activity!,
                                                showDateDivider,
                                                index ==
                                                    snapshot.data!.list.length -
                                                        1,
                                                nextHasDateDivider),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      child: _getActivityItem(
                                          activity!,
                                          showDateDivider,
                                          index ==
                                              snapshot.data!.list.length - 1,
                                          nextHasDateDivider),
                                    );
                            },
                          )
                        : !bloc.isFiltered
                            ? SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    top: 20, bottom: 10, left: 10, right: 10),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TXTextWidget(
                                        text: R.string.activityZone,
                                        color: R.color.blackColor,
                                        fontWeight: FontWeight.bold,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TXTextWidget(
                                        textAlign: TextAlign.center,
                                        text: R.string.activityZoneHeader,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                  );
                },
              ),
            ),
          ),
          TXLoadingWidget(
            loadingStream: bloc.isLoadingStream,
          )
        ],
      );

  Widget _getActivityItem(ActivityModel model, bool showDateDivider,
      bool isLastOne, bool nextHasDivider) {
    return Column(
      children: [
        showDateDivider ? _getDateDivider(model) : Container(),
        TimelineTile(
          alignment: TimelineAlign.start,
          axis: TimelineAxis.vertical,
          isFirst: showDateDivider,
          isLast: nextHasDivider || isLastOne,
          beforeLineStyle: LineStyle(
            color: R.color.grayLightColor,
          ),
          afterLineStyle: LineStyle(
            color: R.color.grayLightColor,
          ),
          indicatorStyle: IndicatorStyle(
            height: 40,
            width: 40,
            drawGap: true,
            indicatorXY: 0.25,
            indicator: Container(
              padding: EdgeInsets.all(3).copyWith(left: 5, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: R.color.secondaryColor, width: 1),
              ),
              child: Image.asset(
                model.icon,
                fit: BoxFit.contain,
                width: 30,
                height: 30,
              ),
            ),
          ),
          endChild: InkWell(
            onTap: () {
              model.type == ACTIVITY_TYPE.signed_in
                  ? txShowWarningDialogBlur(context,
                      title: Row(
                        children: [
                          TXTextWidget(
                            text: R.string.moreInfo,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.bold,
                            color: R.color.darkColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.info_outline, color: R.color.grayColor),
                        ],
                      ),
                      yesNo: false,
                      content: _getMoreInfoWidget(model))
                  : bloc.onTapActivity(model, widget.joinedTeam);
            },
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Container(
                        child: TXTextWidget(
                          fontWeight: FontWeight.bold,
                          color: R.color.blackColor,
                          size: 18,
                          text: SingleSelectionModel.getActivityNameByType(
                              model.type!,
                              isFolder:
                                  (model.type == ACTIVITY_TYPE.file_uploaded ||
                                          model.type ==
                                              ACTIVITY_TYPE.file_downloaded) &&
                                      (model.metaData as FileUploadedMetaModel)
                                          .isFolder),
                        ),
                      ),
                      Container(
                        child: TXTextWidget(
                          fontWeight: FontWeight.w500,
                          color: R.color.grayColor,
                          size: 16,
                          text: CalendarUtils.showInFormat(
                                  R.string.dateFormat2, model.ts) ??
                              '',
                        ),
                      ),
                    ],
                    spacing: 3,
                    crossAxisAlignment: WrapCrossAlignment.center,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 50,
                    ),
                    child: TXHtmlWidget(
                      shrinkWrap: true,
                      style: {
                        "div.activity-body": Style(
                            color: R.color.primaryDarkColor, fontSize: FontSize(20)),
                        ".mention-generic": Style(
                          textDecoration: TextDecoration.none,
                          color: R.color.secondaryColor,
                        ),
                        "p, body": Style(margin: EdgeInsets.zero)
                      },
                      body: _getActivityText(model),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getActivityText(ActivityModel model) {
    final part1 = "<div class=\"activity-body\">";
    String part2 = "";
    final part3 = "</div>";
    if (model.type == ACTIVITY_TYPE.task_created &&
        model.metaData is TaskCreatedMetaModel) {
      final meta = model.metaData as TaskCreatedMetaModel;
      part2 = R.string.activityTaskCreated(meta.username, meta.taskTitle,
          meta.is1x1Message ? (meta.otherName ?? "") : (meta.channelName ?? ""),
          isDirect: meta.is1x1Message);
    } else if (model.type == ACTIVITY_TYPE.task_assigned &&
        model.metaData is TaskAssignedMetaModel) {
      final meta = model.metaData as TaskAssignedMetaModel;
      part2 = R.string.activityTaskAssigned(meta.username, meta.taskTitle,
          meta.is1x1Message ? meta.otherName : meta.channelName,
          isDirect: meta.is1x1Message);
    } else if (model.type == ACTIVITY_TYPE.task_assigned_deleted &&
        model.metaData is TaskAssignedDeletedMetaModel) {
      final meta = model.metaData as TaskAssignedDeletedMetaModel;
      part2 = R.string.activityTaskUnassigned(meta.username, meta.taskTitle,
          meta.is1x1Message ? meta.otherName : meta.channelName,
          isDirect: meta.is1x1Message);
    } else if (model.type == ACTIVITY_TYPE.signed_in &&
        model.metaData is SignedInMetaModel) {
      SignedInMetaModel? meta = model.metaData as SignedInMetaModel?;
      part2 = R.string.activitySignedIn(
          meta!.isMobile
              ? "${meta.os} ${meta.version} ${meta.model}"
              : "${meta.name} ${meta.version} ${meta.os}",
          meta.ipAddress);
    } else if (model.type == ACTIVITY_TYPE.message_sent &&
        model.metaData is MessageSentMetaModel) {
      final meta = model.metaData as MessageSentMetaModel;
      part2 = R.string.activityMessageSent(
          meta.username, meta.is1x1Message ? meta.otherName : meta.channelName,
          isDirect: meta.is1x1Message);
    } else if (model.type == ACTIVITY_TYPE.mentioned &&
        model.metaData is MentionedMetaModel) {
      final meta = model.metaData as MentionedMetaModel;
      part2 = R.string.activityMentioned(
          meta.username, meta.is1x1Message ? meta.otherName : meta.channelName,
          isDirect: meta.is1x1Message);
    } else if ((model.type == ACTIVITY_TYPE.file_uploaded ||
            model.type == ACTIVITY_TYPE.file_downloaded) &&
        model.metaData is FileUploadedMetaModel) {
      final meta = model.metaData as FileUploadedMetaModel;
      part2 = R.string.activityFileFolderUploadedDownloaded(
          meta.creator,
          _getFixedPath(meta.path).split('/').last,
          meta.is1x1Message ? meta.otherName : meta.channelName,
          download: model.type == ACTIVITY_TYPE.file_downloaded,
          isDirect: meta.is1x1Message,
          isFolder: meta.isFolder);
    }
    return "$part1$part2$part3";
  }

  String _getFixedPath(String path) => path.trim().endsWith('/')
      ? path.trim().replaceRange(path.length - 1, path.length, '')
      : path.trim();

  // Widget _getActivityItem(ActivityModel model, bool showDateDivider,
  //     bool isLastOne, bool nextHasDivider) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       showDateDivider
  //           ? _getDateDivider(model)
  //           // ? Container(
  //           //     padding: EdgeInsets.only(left: 10, bottom: 10),
  //           //     child: TXTextWidget(
  //           //       text: CalendarUtils.showInFormat(
  //           //           R.string.dateFormat3, model.ts),
  //           //       color: R.color.blackColor,
  //           //       fontWeight: FontWeight.bold,
  //           //       size: 18,
  //           //     ),
  //           //   )
  //           : Container(),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             padding: EdgeInsets.all(3).copyWith(left: 5, right: 5),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(4)),
  //               border: Border.all(color: R.color.grayLightColor, width: 1),
  //             ),
  //             child: Image.asset(
  //               model.icon,
  //               fit: BoxFit.contain,
  //               width: 30,
  //               height: 30,
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   child: TXTextWidget(
  //                     fontWeight: FontWeight.w500,
  //                     color: R.color.grayColor,
  //                     size: 14,
  //                     text: CalendarUtils.showInFormat(
  //                             R.string.dateFormat2, model.ts)
  //                         .toLowerCase(),
  //                   ),
  //                 ),
  //                 TXTextWidget(
  //                   text:
  //                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  //                   textAlign: TextAlign.justify,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         height: 5,
  //       ),
  //       nextHasDivider
  //           ? Container()
  //           : Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     SizedBox(
  //                       width: isLastOne ? 0 : 50,
  //                     ),
  //                     Expanded(
  //                       child: TXDividerWidget(),
  //                     )
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //               ],
  //             )
  //     ],
  //   );
  // }

  Widget _getDateDivider(ActivityModel model) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TXDividerWidget(),
          ),
          SizedBox(
            width: 5,
          ),
          TXTextWidget(
            text: CalendarUtils.showInFormat(R.string.dateFormat3, model.ts) ??
                '',
            color: R.color.blackColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: TXDividerWidget(),
          ),
        ],
      ),
    );
  }

  List<PopupMenuItem> _popupActions() {
    PopupMenuItem sessions = PopupMenuItem(
      value: ActivityZoneMenu.sessions,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.important_devices, color: R.color.grayColor),
        text: R.string.openSessions,
      ),
    );
    PopupMenuItem memberUsage = PopupMenuItem(
      value: ActivityZoneMenu.memberUsage,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.data_usage, color: R.color.grayColor),
        text: R.string.userDataUsage,
      ),
    );
    PopupMenuItem teamUsage = PopupMenuItem(
      value: ActivityZoneMenu.teamUsage,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.supervised_user_circle, color: R.color.grayColor),
        text: R.string.teamDataUsage,
      ),
    );
    return widget.currentUser.userRol == UserRol.Admin
        ? [sessions, memberUsage, teamUsage]
        : [sessions, memberUsage];
  }

  Widget _launchOptions(BuildContext context) {
    return StreamBuilder<ActivityFilter?>(
        stream: bloc.filterResult,
        initialData: ActivityFilter(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              constraints: BoxConstraints(maxHeight: 180),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: TXTextWidget(
                            text: R.string.filters,
                            color: R.color.grayDarkestColor,
                            size: 18,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            if (bloc.isFiltered)
                              bloc.removeFilter(
                                  removeDate: true, removeType: true);
                          },
                          child: Container(
                            child: TXTextWidget(
                              text: R.string.clearAll,
                              color: bloc.isFiltered
                                  ? R.color.grayDarkestColor
                                  : R.color.grayLightColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TXDividerWidget(),
                  Container(
                    height: 45,
                    child: TXMenuOptionItemWidget(
                      trailing: snapshot.data!.types.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                NavigationUtils.pop(context);
                                bloc.removeFilter(removeType: true);
                              },
                              child: Container(
                                padding: EdgeInsets.all(3)
                                    .copyWith(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border: Border.all(
                                      color: R.color.grayLightColor, width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel_outlined),
                                    SizedBox(width: 3),
                                    TXTextWidget(
                                        text:
                                            "${SingleSelectionModel.getActivityNameByType(snapshot.data!.types.first, isForFilter: true)}"),
                                  ],
                                ),
                              ),
                            )
                          : null,
                      icon: Icon(Icons.format_list_bulleted,
                          color: R.color.grayColor),
                      text: R.string.category,
                      onTap: () async {
                        await NavigationUtils.pop(context);
                        showTXModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return _launchCategoryOptions(
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
                  Container(
                    height: 45,
                    child: TXMenuOptionItemWidget(
                      trailing: snapshot.data?.dateRange != null
                          ? InkWell(
                              onTap: () {
                                NavigationUtils.pop(context);
                                bloc.removeFilter(removeDate: true);
                              },
                              child: Container(
                                padding: EdgeInsets.all(3)
                                    .copyWith(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border: Border.all(
                                      color: R.color.grayLightColor, width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel_outlined),
                                    SizedBox(width: 3),
                                    TXTextWidget(
                                        text:
                                            "${CalendarUtils.showInFormat(R.string.dateFormat6, snapshot.data?.dateRange?.start)} - ${CalendarUtils.showInFormat(R.string.dateFormat6, snapshot.data?.dateRange?.end)}"),
                                  ],
                                ),
                              ),
                            )
                          : null,
                      icon: Icon(Icons.date_range_outlined,
                          color: R.color.grayColor),
                      text: R.string.date,
                      onTap: () async {
                        final now = DateTime.now();
                        await NavigationUtils.pop(context);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Card(
                                  child: Container(
                                    color: Colors.white,
                                    height: 350,
                                    width: MediaQuery.of(context).size.width -
                                        (MediaQuery.of(context).size.height /
                                            20),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 300,
                                          child: SfDateRangePicker(
                                            headerStyle:
                                                DateRangePickerHeaderStyle(
                                              backgroundColor:
                                                  R.color.secondaryColor,
                                              textAlign: TextAlign.center,
                                              textStyle: TextStyle(
                                                  color: R.color.whiteColor,
                                                  fontSize: 16),
                                            ),
                                            todayHighlightColor:
                                                R.color.secondaryColor,
                                            startRangeSelectionColor:
                                                R.color.secondaryColor,
                                            endRangeSelectionColor:
                                                R.color.secondaryColor,
                                            rangeSelectionColor:
                                                Colors.indigoAccent,
                                            monthCellStyle:
                                                DateRangePickerMonthCellStyle(
                                              todayTextStyle: TextStyle(
                                                color: R.color.secondaryColor,
                                              ),
                                            ),
                                            yearCellStyle:
                                                DateRangePickerYearCellStyle(
                                              todayTextStyle: TextStyle(
                                                color: R.color.secondaryColor,
                                              ),
                                            ),
                                            view: DateRangePickerView.month,
                                            selectionMode:
                                                DateRangePickerSelectionMode
                                                    .range,
                                            onSelectionChanged:
                                                _selectionChanged,
                                            minDate: bloc.firstActivityDate,
                                            maxDate: now,
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  NavigationUtils.pop(context);
                                                },
                                                child: TXTextWidget(
                                                    color: R.color.darkColor,
                                                    text: R.string.cancel),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  NavigationUtils.pop(context);
                                                  if (dateRange != null) {
                                                    bloc.filterByDateRange(
                                                        dateRange!);
                                                  }
                                                },
                                                child: TXTextWidget(
                                                    color: R.color.darkColor,
                                                    text: R.string.ok),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        // final dateRange = await showDateRangePicker(
                        //     currentDate: now,
                        //     context: context,
                        //     firstDate: bloc.firstActivityDate,
                        //     lastDate: now,
                        //     builder: (context, child) {
                        //       return Theme(
                        //         data: Theme.of(context).copyWith(
                        //           colorScheme: ColorScheme(
                        //               primary: R.color.secondaryColor,
                        //               primaryVariant: R.color.secondaryColor,
                        //               secondary: R.color.secondaryColor,
                        //               secondaryVariant: R.color.secondaryColor,
                        //               surface: R.color.grayDarkestColor,
                        //               background: Colors.white,
                        //               error: Colors.red,
                        //               onPrimary: Colors.white,
                        //               onSecondary: R.color.secondaryHeaderColor,
                        //               onSurface: R.color.grayDarkestColor,
                        //               onBackground: Colors.white,
                        //               onError: Colors.red,
                        //               brightness: Theme.of(context).brightness),
                        //         ),
                        //         child: child,
                        //       );
                        //     });
                        // if (dateRange != null) {
                        //   final dR = DateTimeRange(
                        //       start: dateRange.start,
                        //       end: DateTime(
                        //           dateRange.end.year,
                        //           dateRange.end.month,
                        //           dateRange.end.day,
                        //           23,
                        //           59,
                        //           59));
                        //   bloc.filterByDateRange(dR);
                        // }
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
                ],
              ),
            ),
          );
        });
  }

  Widget _launchCategoryOptions(
      BuildContext context, ActivityFilter currentFilter) {
    final options = SingleSelectionModel.getActivityCategories(
        currentFilter.types.isNotEmpty ? currentFilter.types.first : null);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: TXTextWidget(
              text: R.string.categories,
              color: R.color.grayDarkestColor,
              size: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TXDividerWidget(),
          ..._getCategoriesWidget(options),
        ],
      ),
    );
  }

  List<Widget> _getCategoriesWidget(List<SingleSelectionModel> list) {
    return list
        .map((e) => Column(
              children: [
                Container(
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    text: e.displayName,
                    trailing: e.isSelected
                        ? Container(
                            child: Icon(Icons.check),
                          )
                        : Container(),
                    onTap: () async {
                      NavigationUtils.pop(context);
                      if (!e.isSelected)
                        bloc.filterByType(ACTIVITY_TYPE.values[e.index]);
                    },
                  ),
                ),
                TXDividerWidget(),
              ],
            ))
        .toList();
  }

  void navigateToFiles(BuildContext context,
      {ChannelModel? channelModel, FolderModel? selectedFolder}) {
    if (selectedFolder != null &&
        selectedFolder.tid != widget.joinedTeam.team.id) {
      bloc.showErrorMessageFromString(R.string.folderIsNotInCurrentTeam);
    } else {
      NavigationUtils.push(
          context,
          FilesExplorerPage(
            channels: widget.joinedTeam.channels,
            groups: widget.joinedTeam.groups,
            messages1x1: widget.joinedTeam.messages1x1,
            members: widget.joinedTeam.memberWrapperModel.list,
            selectedChannel: channelModel,
            selectedFolder: selectedFolder,
          ));
    }
  }

  DateTimeRange? dateRange;

  void _selectionChanged(DateRangePickerSelectionChangedArgs args) {
    dateRange = DateTimeRange(
        start: (args.value as PickerDateRange).startDate!,
        end: (args.value as PickerDateRange).endDate != null
            ? DateTime(
                (args.value as PickerDateRange).endDate!.year,
                (args.value as PickerDateRange).endDate!.month,
                (args.value as PickerDateRange).endDate!.day,
                23,
                59,
                59)
            : DateTime(
                (args.value as PickerDateRange).startDate!.year,
                (args.value as PickerDateRange).startDate!.month,
                (args.value as PickerDateRange).startDate!.day,
                23,
                59,
                59));
  }

  Widget _getUserUsageInfo() {
    return Container(
      height: 45,
      child: bloc.userUsage == null
          ? TXTextWidget(
              text: R.string.errorFetchingData,
              color: R.color.grayDarkestColor,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.sentMessages}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: teamIsTrial
                          ? R.string.sentMessagesCount(
                              bloc.userUsage!.messages!.count.toString())
                          : bloc.userUsage!.messages!.count.toString(),
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.usedStorage}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: teamIsTrial
                          ? R.string.usedStorageText(
                              FileManager.convertBytesToGigabytes(
                                      bloc.userUsage!.files!.size)
                                  .toStringAsFixed(4))
                          : FileManager.convertBytesToGigabytes(
                                  bloc.userUsage!.files!.size)
                              .toStringAsFixed(4),
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _getTeamUsageInfo() {
    return Container(
      height: 45,
      child: bloc.teamUsage == null
          ? TXTextWidget(
              text: R.string.errorFetchingData,
              color: R.color.grayDarkestColor,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.sentMessages}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: teamIsTrial
                          ? R.string.sentMessagesCount(
                              bloc.teamUsage!.messages!.count.toString())
                          : bloc.teamUsage!.messages!.count.toString(),
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.usedStorage}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: teamIsTrial
                          ? R.string.usedStorageText(
                              FileManager.convertBytesToGigabytes(
                                      bloc.teamUsage!.files!.size)
                                  .toStringAsFixed(4))
                          : FileManager.convertBytesToGigabytes(
                                  bloc.teamUsage!.files!.size)
                              .toStringAsFixed(4),
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _getMoreInfoWidget(ActivityModel model) {
    SignedInMetaModel? session = model.metaData as SignedInMetaModel?;
    return Container(
      height: session!.isMobile ? 145 : 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: session.isMobile
            ? [
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.date}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: CalendarUtils.showInFormat(
                              R.string.dateFormat5, model.ts) ??
                          '',
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.manufacturer}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.name,
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.device}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.model ?? "",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.operativeSystem}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: "${session.os} ${session.version}",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.appVersion}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.appVersion ?? "",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "IP: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.ipAddress,
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
              ]
            : [
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.date}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: CalendarUtils.showInFormat(
                              R.string.dateFormat5, model.ts) ??
                          '',
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.browser}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: "${session.name} ${session.version}",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.operativeSystem}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.os,
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "IP: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.ipAddress,
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
              ],
      ),
    );
  }
}
