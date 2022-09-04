import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/meet/meeting_model.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_checkbox_widget.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_date_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_html_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_media_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/search_user/search_user_page.dart';
import 'package:code/ui/task_comment/task_comment_add_edit_page_widget.dart';
import 'package:code/ui/task_create/model_ui.dart';
import 'package:code/ui/task_milestone_selector/task_milestone_selector_page.dart';
import 'package:code/ui/tasks_tag_selector/task_tag_selector_page.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:code/ui/task/tx_label_widget.dart';
import 'package:code/ui/task_detail/task_detail_bloc.dart';
import 'package:code/ui/task_detail/tx_task_timeline_widget.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/extensions.dart';
import 'package:code/utils/file_manager.dart';
import 'package:code/utils/text_parser_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../domain/team/team_model.dart';
import '../../global_regexp.dart';
import '../home/home_ui_model.dart';
import '../task_create/tx_edit_field_widget.dart';

class TaskDetailPage extends StatefulWidget {
  final TaskModel? taskModel;
  final String taskId;

  const TaskDetailPage({Key? key, this.taskModel, this.taskId = ''})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskDetailState();
}

class _TaskDetailState extends StateWithBloC<TaskDetailPage, TaskDetailBloC> {
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerLocation = TextEditingController();
  final _keyFormEditName = GlobalKey<FormState>();
  final _keyFormEditDescription = GlobalKey<FormState>();
  final _keyFormExternalMails = GlobalKey<FormState>();
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    bloc.initDataView(widget.taskModel, widget.taskId);
    bloc.closeReopenResult.listen((reload) {
      NavigationUtils.pop(context, result: reload);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<TaskDetailUIModel>(
          initialData: null,
          stream: bloc.taskDetailResult,
          builder: (context, snapshot) {
            return TXMainAppBarWidget(
              title: snapshot.data == null
                  ? R.string.task
                  : snapshot.data!.taskModel.isMeetingAppointment ||
                          snapshot.data!.taskModel.isGoogleCalendar ||
                          snapshot.data!.taskModel.isOutlookCalendar ||
                          snapshot.data!.taskModel.isNativeOutlookCalendar ||
                          snapshot.data!.taskModel.isNativeGoogleCalendar ||
                          snapshot.data!.taskModel.isAllPlatforms
                      ? R.string.eventMeeting
                      : (snapshot.data!.taskModel.cid ?? '').isEmpty
                          ? R.string.personalNote
                          : R.string.task,
              leading: TXIconButtonWidget(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  NavigationUtils.pop(context, result: snapshot.data?.taskModel);
                },
              ),
              actions: [
                bloc.taskUpdateProtected || snapshot.data == null
                    ? Container()
                    : Center(
                        child: InkWell(
                        onTap: () {
                          snapshot.data!.taskModel.isMeetingAppointment ||
                                  snapshot.data!.taskModel.isGoogleCalendar ||
                                  snapshot.data!.taskModel.isOutlookCalendar ||
                                  snapshot
                                      .data!.taskModel.isNativeOutlookCalendar ||
                                  snapshot
                                      .data!.taskModel.isNativeGoogleCalendar ||
                                  snapshot.data!.taskModel.isAllPlatforms
                              ? bloc.deleteTask()
                              : snapshot.data!.taskModel.isOpen
                                  ? bloc.closeTask()
                                  : bloc.reopenTask();
                        },
                        child: Row(
                          children: [
                            TXTextWidget(
                              text:
                                  snapshot.data!.taskModel.isMeetingAppointment ||
                                          snapshot.data!.taskModel
                                              .isGoogleCalendar ||
                                          snapshot.data!.taskModel
                                              .isOutlookCalendar ||
                                          snapshot.data!.taskModel
                                              .isNativeOutlookCalendar ||
                                          snapshot.data!.taskModel
                                              .isNativeGoogleCalendar ||
                                          snapshot.data!.taskModel.isAllPlatforms
                                      ? R.string.delete
                                      : snapshot.data!.taskModel.isOpen
                                          ? R.string.close
                                          : R.string.reopen,
                              color: Theme.of(context).appBarTheme.iconTheme?.color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              snapshot.data!.taskModel.isMeetingAppointment ||
                                  snapshot
                                      .data!.taskModel.isGoogleCalendar ||
                                  snapshot
                                      .data!.taskModel.isOutlookCalendar ||
                                  snapshot.data!.taskModel
                                      .isNativeOutlookCalendar ||
                                  snapshot.data!.taskModel
                                      .isNativeGoogleCalendar ||
                                  snapshot.data!.taskModel.isAllPlatforms
                                  ? Icons.delete_forever_outlined
                                  : snapshot.data!.taskModel.isOpen
                                  ? Icons.check_circle_outline
                                  : Icons.warning,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      )),
              ],
              body: snapshot.data == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<bool>(
                              stream: bloc.editNameResult,
                              initialData: false,
                              builder: (context, snapshotEditName) {
                                textEditingControllerName.text =
                                    snapshot.data!.taskModel.title;
                                return snapshotEditName.data!
                                    ? Form(
                                        key: _keyFormEditName,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: TXTextFieldWidget(
                                                  controller:
                                                      textEditingControllerName,
                                                  validator: bloc.required(),
                                                ),
                                                constraints: BoxConstraints(maxHeight: 100),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TXButtonWidget(
                                                    onPressed: () {
                                                      bloc.changeEditModeName(
                                                          false);
                                                    },
                                                    mainColor: R.color
                                                        .grayLightestColor,
                                                    title: R.string.cancel,
                                                    textColor:
                                                        R.color.blackColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  TXButtonWidget(
                                                    onPressed: () {
                                                      if (_keyFormEditName
                                                          .currentState
                                                          !.validate())
                                                        bloc.updateName(
                                                            textEditingControllerName
                                                                .text);
                                                    },
                                                    title: R.string.update,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          TXTextWidget(
                                            text: snapshot.data!.taskModel.title,
                                            color: R.color.blackColor,
                                            maxLines: 10,
                                          ),
                                          bloc.taskUpdateProtected
                                              ? Container(
                                                  height: 10,
                                                )
                                              : TXIconButtonWidget(
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: R.color.grayColor,
                                                  ),
                                                  onPressed: () {
                                                    bloc.changeEditModeName(
                                                        true);
                                                  },
                                                ),
                                          // bloc.isPersonalNote
                                          //     ? Container()
                                          //     : TXIconButtonWidget(
                                          //         icon: Icon(
                                          //           Icons.link,
                                          //           color: R.color.grayColor,
                                          //         ),
                                          //         onPressed: () {},
                                          //       )
                                        ],
                                      );
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      snapshot.data!.taskModel.isOpen
                                          ? Icons.warning
                                          : Icons.check_circle_outline,
                                      size: 15,
                                      color: R.color.whiteColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    TXTextWidget(
                                      text: snapshot.data!.taskModel.isOpen
                                          ? R.string.open
                                          : R.string.closed,
                                      color: R.color.whiteColor,
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: snapshot.data!.taskModel.isOpen
                                        ? Colors.orangeAccent
                                        : R.color.secondaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                              ),
                              Expanded(
                                  child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: snapshot.data!.taskModel.code == null
                                          ? ""
                                          : " #${snapshot.data!.taskModel.code}",
                                      style: TextStyle(
                                          color: R.color.blackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: snapshot
                                            .data!.taskModel.participants.isEmpty
                                        ? ""
                                        : " ${R.string.taskOpened} ${R.string.by}",
                                    style: TextStyle(
                                        color: R.color.blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextSpan(
                                    text: snapshot
                                            .data!.taskModel.participants.isEmpty
                                        ? ""
                                        : " @${snapshot.data!.taskModel.participants.firstWhereOrNull((element) => element.uid == snapshot.data!.taskModel.uid)?.name}",
                                    style: TextStyle(
                                        color: R.color.secondaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ]),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<int>(
                              stream: bloc.pageTabResult,
                              initialData: 1,
                              builder: (context, snapshotPageIndex) {
                                return Container(
                                  height: 50,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  bloc.changePageTab(1);
                                                  pageController.animateToPage(
                                                      0,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.linear);
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: double.infinity,
                                                        child: TXTextWidget(
                                                            text: R
                                                                .string.details
                                                                .toUpperCase(),
                                                            color: snapshotPageIndex
                                                                        .data ==
                                                                    1
                                                                ? R.color
                                                                    .blackColor
                                                                : R.color
                                                                    .grayColor),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 3,
                                                      color: snapshotPageIndex
                                                                  .data ==
                                                              1
                                                          ? R.color
                                                              .secondaryColor
                                                          : null,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  bloc.changePageTab(2);
                                                  pageController.animateToPage(
                                                      1,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.linear);
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: double.infinity,
                                                        child: TXTextWidget(
                                                            text: R
                                                                .string.timeline
                                                                .toUpperCase(),
                                                            color: snapshotPageIndex
                                                                        .data ==
                                                                    1
                                                                ? R.color
                                                                    .blackColor
                                                                : R.color
                                                                    .grayColor),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 3,
                                                      color: snapshotPageIndex
                                                                  .data ==
                                                              2
                                                          ? R.color
                                                              .secondaryColor
                                                          : null,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TXDividerWidget(),
                                    ],
                                  ),
                                );
                              }),
                          Expanded(
                            child: Container(
                              child: PageView.builder(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  return index == 0
                                      ? _getDetails()
                                      : _getTimeline();
                                },
                                itemCount: 2,
                                controller: pageController,
                                onPageChanged: (index) {
                                  bloc.changePageTab(index + 1);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            );
          },
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  Widget _getTimeline() {
    List<Widget> list = [];
    if ((bloc.taskDetailUIModel.taskModel.timeLine.length) >= 2) {
      bloc.taskDetailUIModel.taskModel.timeLine
          .sort((e1, e2) => e1.created!.compareTo(e2.created!));
    }
    bloc.taskDetailUIModel.taskModel.timeLine.forEach((element) {
      final w = TXTaskTimelineWidget(
        taskTimeLineModel: element,
        inMemoryData: bloc.inMemoryData,
        // onCommentTapped: () async {
        //   final res = await NavigationUtils.push(
        //       context,
        //       TaskCommentAddEditPageWidget(
        //         taskModel: bloc.taskDetailUIModel.taskModel,
        //         taskTimeLineModel: element,
        //       ));
        //   if (res is bool) {
        //     bloc.getTask();
        //   }
        // },
        participants: bloc.taskDetailUIModel.taskModel.participants,
      );
      list.add(w);
    });
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 10, bottom: 30),
        children: <Widget>[...list],
      ),
    );
  }

  Widget _getDetails() {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TXDateSelectorWidget(
              showTimePicker: !bloc.taskDetailUIModel.taskModel.isAllDay,
              initialDate: bloc.taskDetailUIModel.taskModel.due,
              dateFormat: bloc.taskDetailUIModel.taskModel.isAllDay
                  ? R.string.dateFormat8
                  : R.string.dateFormat4,
              onDateSelected: (date) {
                if(date != null) {
                  bloc.updateDateRange(DateTimeRange(
                      start: date,
                      end: date.isAfter(bloc.taskDetailUIModel.taskModel.end!)
                          ? date
                          : bloc.taskDetailUIModel.taskModel.end!));
                }
              },
              isBlocked: true,
              // isBlocked: bloc.taskUpdateProtected ||
              //     (bloc.taskDetailUIModel?.taskModel?.isMeetingAppointment ??
              //         false) ||
              //     (bloc.taskDetailUIModel?.taskModel?.isOutlookCalendar ??
              //         false) ||
              //     (bloc.taskDetailUIModel?.taskModel?.isGoogleCalendar ??
              //         false) ||
              //     (bloc.taskDetailUIModel?.taskModel?.isNativeGoogleCalendar ??
              //         false) ||
              //     (bloc.taskDetailUIModel?.taskModel?.isNativeOutlookCalendar ??
              //         false) ||
              //     (bloc.taskDetailUIModel?.taskModel?.isAllPlatforms ?? false),
            ),
            bloc.taskDetailUIModel.taskModel.isMeetingAppointment
                ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TXDateSelectorWidget(
                        showTimePicker:
                            !bloc.taskDetailUIModel.taskModel.isAllDay,
                        isBlocked: true,
                        title: R.string.endDate,
                        dateFormat: bloc.taskDetailUIModel.taskModel.isAllDay
                            ? R.string.dateFormat8
                            : R.string.dateFormat4,
                        onDateSelected: (date) {
                          if(date != null) {
                            bloc.updateDateRange(DateTimeRange(
                                start: bloc.taskDetailUIModel.taskModel.due!,
                                end: date));
                          }
                        },
                        initialDate: bloc.taskDetailUIModel.taskModel.end,
                        firsDate: bloc.taskDetailUIModel.taskModel.due,
                      ),
                      TXCheckBoxWidget(
                        value: bloc.taskDetailUIModel.taskModel.isAllDay,
                        text: R.string.allDay,
                        removeCheckboxExtraPadding: true,
                        onChange: (value) {
                          bloc.changeIsAllDay(value);
                        },
                        leading: true,
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            TXDividerWidget(),
            SizedBox(
              height: 5,
            ),
            StreamBuilder<bool>(
                stream: bloc.editDescriptionResult,
                initialData: false,
                builder: (context, snapshotEditDescription) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TXTextWidget(
                            text: R.string.description,
                            color: R.color.blackColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          bloc.taskUpdateProtected ||
                                  snapshotEditDescription.data!
                              ? Container()
                              : InkWell(
                                  child: Icon(
                                    Icons.edit,
                                    color: R.color.grayColor,
                                    size: 20,
                                  ),
                                  onTap: () async {
                                    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                    final res = await NavigationUtils.push(context, TXEditFieldWidget(text: bloc.taskDetailUIModel.taskModel.description, label: R.string.description,));
                                    if(res != bloc.taskDetailUIModel.taskModel.description) {
                                      bloc.updateDescription(res);
                                    }
                                  },
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () async {
                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                          final res = await NavigationUtils.push(context, TXEditFieldWidget(text: bloc.taskDetailUIModel.taskModel.description, label: R.string.description,));
                          if(res != bloc.taskDetailUIModel.taskModel.description) {
                            bloc.updateDescription(res);
                          }
                  },
                        child: formattedHtmlComponent(TextUtilsParser.emojiParser(bloc.taskDetailUIModel.taskModel
                            .htmlDescription?.html ?? "", removeUploadedFilesExpression: false)),
                      ),
                    ],
                  );
                }),
            bloc.taskDetailUIModel.taskModel.isMeetingAppointment ||
                    bloc.taskDetailUIModel.taskModel.isOutlookCalendar ||
                    bloc.taskDetailUIModel.taskModel.isGoogleCalendar ||
                    bloc.taskDetailUIModel.taskModel.isNativeGoogleCalendar ||
                    bloc.taskDetailUIModel.taskModel.isNativeOutlookCalendar ||
                    bloc.taskDetailUIModel.taskModel.isAllPlatforms
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      TXDividerWidget(),
                      SizedBox(height: 5),
                      StreamBuilder<bool>(
                          stream: bloc.editLocationResult,
                          initialData: false,
                          builder: (context, snapshotEditLocation) {
                            textEditingControllerLocation.text =
                                bloc.taskDetailUIModel.taskModel.location;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TXTextWidget(
                                      text: R.string.location,
                                      color: R.color.blackColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    bloc.taskUpdateProtected ||
                                            snapshotEditLocation.data!
                                        ? Container()
                                        : InkWell(
                                            child: Icon(
                                              Icons.edit,
                                              color: R.color.grayColor,
                                              size: 20,
                                            ),
                                            onTap: () {
                                              bloc.changeEditModeLocation(true);
                                            },
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                snapshotEditLocation.data!
                                    ? Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: TXTextFieldWidget(
                                                controller:
                                                    textEditingControllerLocation,
                                                maxLines: 5,
                                              ),
                                              constraints: BoxConstraints(maxHeight: 100),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TXButtonWidget(
                                                  onPressed: () {
                                                    bloc.changeEditModeLocation(
                                                        false);
                                                  },
                                                  mainColor:
                                                      R.color.grayLightestColor,
                                                  title: R.string.cancel,
                                                  textColor: R.color.blackColor,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                TXButtonWidget(
                                                  onPressed: () {
                                                    bloc.updateLocation(
                                                        textEditingControllerLocation
                                                            .text);
                                                  },
                                                  title: R.string.update,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : formattedHtmlComponent(TextUtilsParser.emojiParser(bloc
                                    .taskDetailUIModel
                                    .taskModel
                                    .htmlLocation
                                    ?.html ?? "", removeUploadedFilesExpression: false)),
                              ],
                            );
                          }),
                      SizedBox(height: 5),
                      bloc.taskDetailUIModel.taskModel.isMeetingAppointment
                          ? Column(
                              children: [
                                TXDividerWidget(),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12)
                                      .copyWith(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                        color: R.color.grayLightColor,
                                        width: 1),
                                  ),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: Icon(Icons.content_copy),
                                        onTap: () async {
                                          await Clipboard.setData(
                                              new ClipboardData(
                                                  text: bloc
                                                          .taskDetailUIModel
                                                          .taskModel
                                                          .meetingUrl ??
                                                      ""));
                                          Fluttertoast.showToast(
                                              msg: bloc.taskDetailUIModel
                                                      .taskModel.meetingUrl ??
                                                  "",
                                              toastLength: Toast.LENGTH_LONG,
                                              textColor: R.color.whiteColor,
                                              backgroundColor:
                                                  R.color.primaryColor);
                                        },
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: InkWell(
                                            child: TXTextWidget(
                                              textOverflow:
                                                  TextOverflow.visible,
                                              text: bloc.taskDetailUIModel
                                                      .taskModel.meetingUrl ??
                                                  "",
                                              color: R.color.secondaryColor,
                                            ),
                                            onTap: () async {
                                              if (bloc
                                                      .taskDetailUIModel
                                                      .taskModel
                                                      .meetingUrl
                                                      ?.isNotEmpty ==
                                                  true) {
                                                final array = (bloc
                                                    .taskDetailUIModel
                                                    .taskModel
                                                    .meetingUrl ?? "")
                                                    .split('/');
                                                final url = array[0] +
                                                    array[1] +
                                                    array[2];
                                                final room = array[3];
                                                final res = await joinMeeting(
                                                    room: room, url: url);
                                                if (res?.isSuccess == true) {
                                                  currentMeeting = MeetingModel(
                                                    room: room,
                                                    url: url,
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TXDividerWidget(),
                              ],
                            )
                          : Container(),
                      bloc.taskDetailUIModel.taskModel.isMeetingAppointment ||
                              bloc.taskDetailUIModel.taskModel
                                  .isOutlookCalendar ||
                              bloc.taskDetailUIModel.taskModel
                                  .isGoogleCalendar ||
                              bloc.taskDetailUIModel.taskModel
                                  .isNativeGoogleCalendar ||
                              bloc.taskDetailUIModel.taskModel
                                  .isNativeOutlookCalendar ||
                              bloc.taskDetailUIModel.taskModel.isAllPlatforms
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                bloc.taskDetailUIModel.taskModel
                                        .isMeetingAppointment
                                    ? Container()
                                    : TXDividerWidget(),
                                Row(
                                  children: [
                                    TXTextWidget(
                                      text: R.string.internalGuests,
                                      color: R.color.blackColor,
                                    ),
                                    bloc.taskUpdateProtected
                                        ? Container(
                                            height: 35,
                                          )
                                        : TXIconButtonWidget(
                                            icon:
                                                Icon(Icons.add_circle_outline, color: R.color.secondaryColor,
                                                  size: 30,),
                                            onPressed: () {
                                              showTXModalBottomSheetAutoAdjustable(context: context, builder: (context) {
                                                return Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 45,
                                                        child: TXMenuOptionItemWidget(
                                                          icon: Icon(Icons.supervised_user_circle),
                                                          text: R.string.selectUserFromTeam,
                                                          onTap: () async {
                                                            await NavigationUtils.pop(context);
                                                            final res = await NavigationUtils.push(
                                                                context,
                                                                SearchUserPage(
                                                                  userGroupBy: UserGroupBy.team,
                                                                  pickMember: true,
                                                                  excludeMembers: bloc.taskDetailUIModel
                                                                      .taskModel.assignees,
                                                                  excludeBotMembers: true,
                                                                  action: RemoteConstants.searchHumans,
                                                                ));
                                                            if (res is MemberModel) {
                                                              bloc.addRemoveAssignee(res.id);
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        child: TXMenuOptionItemWidget(
                                                          icon: Icon(Icons.groups),
                                                          text: R.string.selectUsersFromChannelGroup,
                                                          onTap: () async {
                                                            await NavigationUtils.pop(context);
                                                            showTXModalBottomSheet(context: context, builder: (context) {
                                                              return _showChannels();
                                                            });
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                            },
                                          )
                                  ],
                                ),
                                _getAssignees(),
                                SizedBox(
                                  height: 10,
                                ),
                                TXDividerWidget(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    TXTextWidget(
                                      text: R.string.externalGuests,
                                      color: R.color.blackColor,
                                    ),
                                  ],
                                ),
                                Form(
                                  key: _keyFormExternalMails,
                                  child: StreamBuilder<
                                      List<ExternalEmailsModelUI>>(
                                    stream: bloc.externalEmailsResult,
                                    initialData: bloc.externalEmails,
                                    builder: (context, snapshot) {
                                      return Column(
                                        children: [
                                          ..._getExternalEmailsWidget(
                                              snapshot.data!)
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                bloc.taskUpdateProtected ? Container() : Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        bloc.externalEmails
                                            .add(ExternalEmailsModelUI(
                                          emailController: TextEditingController(),
                                        ));
                                        bloc.refreshDataExternalEmail;
                                      },
                                      child: Row(
                                        children: [
                                          TXTextWidget(
                                            text: R.string.addAnother,
                                            fontWeight: FontWeight.bold,
                                            color: R.color.secondaryColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.add_circle_outline,
                                            color: R.color.secondaryColor,
                                            size: 20,
                                          )
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: TXButtonWidget(
                                        onPressed: () {
                                          if (_keyFormExternalMails.currentState
                                          !.validate()) {
                                            bloc.updateExternalMails();
                                          }
                                        },
                                        title: R.string.updateExternalGuests,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          : Container()
                    ],
                  )
                : Container(),
            bloc.isPersonalNote ||
                    bloc.taskDetailUIModel.taskModel.isMeetingAppointment ||
                    bloc.taskDetailUIModel.taskModel.isGoogleCalendar ||
                    bloc.taskDetailUIModel.taskModel.isOutlookCalendar ||
                    bloc.taskDetailUIModel.taskModel.isNativeOutlookCalendar ||
                    bloc.taskDetailUIModel.taskModel.isNativeGoogleCalendar ||
                    bloc.taskDetailUIModel.taskModel.isAllPlatforms
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TXDividerWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TXTextWidget(
                            text: R.string.tags,
                            color: R.color.blackColor,
                          ),
                          bloc.taskUpdateProtected
                              ? Container(
                                  height: 35,
                                )
                              : TXIconButtonWidget(
                                  icon: Icon(Icons.add_circle_outline, color: R.color.secondaryColor,
                                    size: 30,),
                                  onPressed: () async {
                                    final res = await NavigationUtils.push(
                                        context,
                                        TaskTagSelectorPage(
                                          selectedList: bloc.taskDetailUIModel
                                              .taskModel.labels,
                                          channelId: bloc
                                              .taskDetailUIModel.taskModel.cid ?? "",
                                        ));
                                    if (res is TaskLabelModel) {
                                      bloc.attachDetachLabel(res);
                                    }
                                  },
                                )
                        ],
                      ),
                      _getLabels(),
                      SizedBox(
                        height: 10,
                      ),
                      TXDividerWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TXTextWidget(
                            text: R.string.milestone,
                            color: R.color.blackColor,
                          ),
                          bloc.taskUpdateProtected
                              ? Container(
                                  height: 35,
                                )
                              : TXIconButtonWidget(
                                  icon: Icon(Icons.add_circle_outline, color: R.color.secondaryColor,
                                    size: 30,),
                                  onPressed: () async {
                                    final res = await NavigationUtils.push(
                                        context,
                                        TaskMilestoneSelectorPage(
                                          channelId: bloc
                                              .taskDetailUIModel.taskModel.cid ?? "",
                                          selectedMilestone: bloc
                                              .taskDetailUIModel
                                              .taskModel
                                              .milestone,
                                        ));
                                    if (res is TaskMileStoneModel) {
                                      bloc.attachMilestone(res);
                                    }
                                  },
                                )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          bloc.taskDetailUIModel.taskModel.milestone?.title
                                      .isNotEmpty ==
                                  true
                              ? Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.flag,
                                      size: 15,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TXTextWidget(
                                          text: bloc.taskDetailUIModel.taskModel
                                              .milestone?.title ?? "",
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TXDividerWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TXTextWidget(
                            text: R.string.assignees,
                            color: R.color.blackColor,
                          ),
                          bloc.taskUpdateProtected
                              ? Container(
                                  height: 35,
                                )
                              : TXIconButtonWidget(
                                  icon: Icon(Icons.add_circle_outline, color: R.color.secondaryColor,
                                    size: 30,),
                                  onPressed: () {
                                    showTXModalBottomSheetAutoAdjustable(context: context, builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                           children: [
                                             Container(
                                               height: 45,
                                               child: TXMenuOptionItemWidget(
                                                 icon: Icon(Icons.supervised_user_circle),
                                                 text: R.string.selectUserFromTeam,
                                                 onTap: () async {
                                                   await NavigationUtils.pop(context);
                                                   final res = await NavigationUtils.push(
                                                       context,
                                                       SearchUserPage(
                                                         userGroupBy: UserGroupBy.team,
                                                         pickMember: true,
                                                         excludeMembers: bloc.taskDetailUIModel
                                                             .taskModel.assignees,
                                                         excludeBotMembers: true,
                                                         action: RemoteConstants.searchHumans,
                                                       ));
                                                   if (res is MemberModel) {
                                                     bloc.addRemoveAssignee(res.id);
                                                   }
                                                 },
                                               ),
                                             ),
                                             Container(
                                               height: 45,
                                               child: TXMenuOptionItemWidget(
                                                 icon: Icon(Icons.groups),
                                                 text: R.string.selectUsersFromChannelGroup,
                                                 onTap: () async {
                                                   await NavigationUtils.pop(context);
                                                   showTXModalBottomSheet(context: context, builder: (context) {
                                                     return _showChannels();
                                                   });
                                                 },
                                               ),
                                             )
                                           ],
                                        ),
                                      );
                                    });
                                  },
                                )
                        ],
                      ),
                      _getAssignees(),
                      SizedBox(
                        height: 10,
                      ),
                      TXDividerWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      TXTextWidget(
                        text: R.string.participants,
                        color: R.color.blackColor,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _getParticipants(),
                      SizedBox(
                        height: 10,
                      ),
                      TXDividerWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TXTextWidget(
                            text: R.string.files,
                            color: R.color.blackColor,
                          ),
                          Container(
                                    height: 35,
                                  )
                          // bloc.taskUpdateProtected
                          //     ? Container(
                          //         height: 35,
                          //       )
                          //     : TXIconButtonWidget(
                          //         icon: Icon(Icons.add_circle_outline, color: R.color.secondaryColor,
                          //           size: 30,),
                          //         onPressed: () async {
                          //           showTXModalBottomSheet(
                          //               context: context,
                          //               builder: (context) {
                          //                 return _showSourceSelector(context);
                          //               });
                          //         },
                          //       )
                        ],
                      ),
                      _getFiles(),
                    ],
                  ),
            bloc.taskDetailUIModel.taskModel.isMeetingAppointment ||
                    bloc.taskDetailUIModel.taskModel.isGoogleCalendar ||
                    bloc.taskDetailUIModel.taskModel.isOutlookCalendar ||
                    bloc.taskDetailUIModel.taskModel.isNativeOutlookCalendar ||
                    bloc.taskDetailUIModel.taskModel.isNativeGoogleCalendar ||
                    bloc.taskDetailUIModel.taskModel.isAllPlatforms
                ? Container()
                : Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TXDividerWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TXTextWidget(
                            text: R.string.comments,
                            color: R.color.blackColor,
                          ),
                          bloc.taskUpdateProtected
                              ? Container(
                                  height: 35,
                                )
                              : TXIconButtonWidget(
                                  icon: Icon(Icons.add_circle_outline, color: R.color.secondaryColor,
                                    size: 30,),
                                  onPressed: () async {
                                    final res = await NavigationUtils.push(
                                        context,
                                        TXEditFieldWidget(
                                          label: "${R.string.addComment}...",
                                        ));
                                    if (res is String && res.isNotEmpty) {
                                      bloc.postTaskComment(res);
                                    }
                                  },
                                )
                        ],
                      ),
                      _getComments(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Widget _getLabels() {
    List<Widget> list = [];
    bloc.taskDetailUIModel.taskModel.labels.forEach((element) {
      final w = TXLabelWidget(
        taskLabelModel: element,
        onTap: () {
          if(!bloc.taskUpdateProtected) bloc.attachDetachLabel(element);
        },
      );
      list.add(w);
    });
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: <Widget>[...list],
    );
  }

  Widget _getAssignees() {
    List<Widget> list = [];
    bloc.taskDetailUIModel.taskModel.assignees.forEach((element) {
      if (element.contains('@')) return;
      final participant = bloc.taskDetailUIModel.taskModel.participants
          .firstWhereOrNull((p) => p.uid == element);
      if (participant?.photo != null) {
        final w = Container(
          width: 45,
          height: 45,
          child: InkWell(
            onLongPress: () {
              if(!bloc.taskUpdateProtected) {
                showTXModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return _showAssigneesOptions(participant!);
                    });
              }
            },
            onTap: () {
              Fluttertoast.showToast(msg: participant?.name ?? "");
            },
            child: Stack(
              children: [
                Container(
                    alignment: Alignment.bottomLeft,
                    child:TXNetworkImage(
                      width: 35,
                      height: 35,
                      forceLoad: true,
                      boxFitImage: BoxFit.cover,
                      imageUrl: participant!.photo,
                      placeholderImage: Image.asset(R.image.logo),
                    )
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: TXIconButtonWidget(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      if(!bloc.taskUpdateProtected) bloc.addRemoveAssignee(participant.uid);
                    },
                  ),
                )
              ],
            ),
          )
        );
        list.add(w);
      }
    });
    return list.isNotEmpty
        ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[...list],
          )
        : Container();
  }

  Widget _getParticipants() {
    List<Widget> list = [];
    bloc.taskDetailUIModel.taskModel.participants.forEach((element) {
      final photo = element.photo;
      final w = InkWell(
        onTap: () {
          Fluttertoast.showToast(msg: element.name);
        },
        child: TXNetworkImage(
          width: 35,
          height: 35,
          forceLoad: true,
          boxFitImage: BoxFit.cover,
          imageUrl: photo,
          placeholderImage: Image.asset(R.image.logo),
        ),
      );
      list.add(w);
    });
    return list.isNotEmpty
        ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[...list],
          )
        : Container();
  }

  Widget _getComments() {
    Map<int, TaskTimeLineModel> comments = {};
    for (var i = 0;
        i < bloc.taskDetailUIModel.taskModel.timeLine.length;
        i++) {
      if (bloc.taskDetailUIModel.taskModel.timeLine[i].type
              .startsWith("comment") ==
          true) {
        comments[i] = bloc.taskDetailUIModel.taskModel.timeLine[i];
      }
    }
    List<Widget> commentsWidget = [];

    comments.forEach((key, element) {
      final w = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TXNetworkImage(
            imageUrl: CommonUtils.getMemberPhoto(bloc.inMemoryData.getMember(element.creator!.uid)),
            placeholderImage: Image.asset(R.image.logo),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  children: <Widget>[
                    TXTextWidget(
                      text: "@${element.creator?.name ?? ""} -",
                      color: R.color.blackColor,
                    ),
                    TXTextWidget(
                      text: CalendarUtils.showInFormat(
                          R.string.dateFormat4, element.created) ?? "",
                      color: R.color.blackColor,
                    ),
                  ],
                ),
                formattedHtmlComponent(element.parsedComment)
              ],
            ),
          )
        ],
      );
      commentsWidget.add(Container(
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          child: Material(
            child: InkWell(
                onLongPress: element.creator?.uid ==
                            bloc.inMemoryData.currentMember?.id ||
                        bloc.inMemoryData.currentMember?.userRol == UserRol.Admin
                    ? () {
                        showTXModalBottomSheetAutoAdjustable(
                            context: context,
                            builder: (context) {
                              return _showCommentOptions(key, element);
                            });
                      }
                    : null,
                child: w),
          )));
    });
    return Container(
      child: Column(
        children: [...commentsWidget],
      ),
    );
  }

  Widget _getFiles() {
    List<Widget> list = [];
    bloc.taskDetailUIModel.taskModel.assets.forEach((asset) {
      final imageUrl =
          "${Injector.instance.baseUrl}/files/${bloc.taskDetailUIModel.taskModel.tid}/$asset";
      final w = Column(
        children: [
          Container(
            child: TXNetworkImage(
              width: 80,
              height: 80,
              forceLoad: true,
              boxFitImage: BoxFit.cover,
              userBorderRadius: false,
              imageUrl: imageUrl,
              placeholderImage: Image.asset(R.image.logo),
              onLongPress: () {
                final timeLineModelPos =
                    bloc.taskDetailUIModel.taskModel.timeLine.indexWhere(
                        (element) => element.text.contains(asset) == true);
                final timeLineModel = timeLineModelPos >= 0
                    ? bloc
                        .taskDetailUIModel.taskModel.timeLine[timeLineModelPos]
                    : null;
                if (timeLineModel == null ||
                    timeLineModel.creator?.uid !=
                        bloc.inMemoryData.currentMember?.id || bloc.inMemoryData.currentMember?.userRol != UserRol.Admin)
                  return;
                else
                  showTXModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return _showFileOptions(imageUrl, timeLineModelPos);
                      });
              },
            ),
          ),
        ],
      );
      list.add(w);
    });
    return list.isNotEmpty
        ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[...list],
          )
        : Container();
  }

  Widget _showSourceSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TXTextWidget(
            text: R.string.fromLocalStorage,
            color: R.color.secondaryColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.library_add,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  title: R.string.documents,
                  titleColor: R.color.blackColor,
                  onTap: () {
                    _launchMediaView(allFiles: true);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.photo_library,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.photoGallery,
                  onTap: () {
                    _launchMediaView(imageSource: ImageSource.gallery);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.video_library,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.videoGallery,
                  onTap: () {
                    _launchMediaView(
                        imageSource: ImageSource.gallery, lookForVideo: true);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TXDividerWidget(),
          SizedBox(
            height: 10,
          ),
          TXTextWidget(
            text: R.string.useCamera,
            color: R.color.secondaryColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.photo_camera,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.takePhoto,
                  onTap: () {
                    _launchMediaView(imageSource: ImageSource.camera);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.videocam,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.recordVideo,
                  onTap: () {
                    _launchMediaView(
                        imageSource: ImageSource.camera, lookForVideo: true);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _showSourceSelector(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(8),
  //     height: 80,
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: TXMediaSelectorWidget(
  //             icon: Icon(
  //               Icons.sd_storage,
  //               color: R.color.grayColor,
  //             ),
  //             title: R.string.files,
  //             onTap: () {
  //               _launchMediaView(imageSource: ImageSource.gallery);
  //             },
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: TXMediaSelectorWidget(
  //             icon: Icon(
  //               Icons.photo_camera,
  //               color: R.color.grayColor,
  //             ),
  //             title: R.string.takePhoto,
  //             onTap: () {
  //               _launchMediaView(imageSource: ImageSource.camera);
  //             },
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  void _launchMediaView(
      {ImageSource? imageSource,
      bool lookForVideo = false,
      bool allFiles = false,
      ValueChanged<int>? onFileLoading}) async {
    try {
      NavigationUtils.pop(context);
      final file = await FileManager.getImageFromSource(
          source: imageSource,
          lookForVideo: lookForVideo,
          allFiles: allFiles,
          onFileLoading: onFileLoading);
      if (file != null && file.existsSync()) {
        bloc.attachFile(file);
      }
    } catch (ex) {
      if (ex is PlatformException) {
        if (ex.code == "photo_access_denied" ||
            ex.code == "camera_access_denied") {
          _showDialogPermissions(
              context: context,
              onOkAction: () async {
                openAppSettings();
              });
        }
      }
    }
  }

  void _showDialogPermissions({required BuildContext context, required Function onOkAction}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.permissionDenied,
        content: R.string.enablePermissions,
        onOK: () {
          Navigator.pop(context, R.string.ok);
          onOkAction();
        },
        onCancel: () {
          Navigator.pop(context, R.string.cancel);
        },
      ),
    );
  }

  Widget _showCommentOptions(int taskTimeLineModelPos, TaskTimeLineModel timelineModel) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 8),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.edit, color: R.color.grayDarkColor),
              text: R.string.edit,
              textColor: R.color.grayDarkColor,
              onTap: () async {
                await NavigationUtils.pop(context);
                final res = await NavigationUtils.push(
                    context,
                    TXEditFieldWidget(
                      label: "${R.string.editComment}...",
                      text: timelineModel.text,
                    ));
                if (res is String && res.isNotEmpty && res != timelineModel.text) {
                  bloc.putTaskComment(res, bloc.taskDetailUIModel.taskModel.timeLine.indexWhere((element) => element.created!.millisecondsSinceEpoch == timelineModel.created!.millisecondsSinceEpoch));
                }
              },
            ),
          ),
          SizedBox(
            height: 40,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.delete_forever, color: Colors.redAccent),
              text: R.string.delete,
              textColor: Colors.redAccent,
              onTap: () async {
                await NavigationUtils.pop(context);
                bloc.deleteTaskComment(taskTimeLineModelPos);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _showFileOptions(String fileUrl, int taskTimeLineModelPos) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TXNetworkImage(
            forceLoad: true,
            width: 60,
            height: 60,
            imageUrl: fileUrl,
            shape: BoxShape.rectangle,
            boxFitImage: BoxFit.cover,
            placeholderImage: Image.asset(
              R.image.logo,
            ),
          ),
          Expanded(
            child: Container(
              height: 45,
              child: TXMenuOptionItemWidget(
                icon: Icon(Icons.delete_forever, color: Colors.redAccent),
                text: R.string.deleteFile,
                textColor: Colors.redAccent,
                onTap: () async {
                  await NavigationUtils.pop(context);
                  bloc.deleteTaskComment(taskTimeLineModelPos);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _showAssigneesOptions(TaskParticipantsModel participantsModel) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 50,
      child: Container(
        height: 45,
        child: Row(
          children: [
            TXNetworkImage(
              forceLoad: true,
              width: 40,
              height: 40,
              imageUrl: participantsModel.photo,
              shape: BoxShape.rectangle,
              boxFitImage: BoxFit.cover,
              placeholderImage: Image.asset(
                R.image.logo,
              ),
            ),
            Expanded(
              child: TXMenuOptionItemWidget(
                icon: Icon(Icons.delete_forever, color: Colors.redAccent),
                text: R.string.remove,
                textColor: Colors.redAccent,
                onTap: () async {
                  await NavigationUtils.pop(context);
                  bloc.addRemoveAssignee(participantsModel.uid);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _getExternalEmailsWidget(List<ExternalEmailsModelUI> list) {
    List<Widget> cardsInvitations = [];
    list.forEach((element) {
      final w = Card(
        margin: EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 10),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              TXTextFieldWidget(
                textInputType: TextInputType.emailAddress,
                controller: element.emailController,
                label: R.string.email,
                validator: bloc.emailNotRequired(),
              ),
            ],
          ),
        ),
      );
      cardsInvitations.add(Row(
        children: [
          Expanded(child: w),
          TXIconButtonWidget(
            icon: Icon(
              Icons.remove_circle,
              color: Colors.redAccent,
            ),
            onPressed: () {
              if(!bloc.taskUpdateProtected) {
                bloc.externalEmails.remove(element);
                bloc.updateExternalMails(checkIfEmpty: false);
                //bloc.refreshDataExternalEmail;
              }
            },
          )
        ],
      ));
    });
    return cardsInvitations;
  }

  Widget formattedHtmlComponent(String htmlBody) {
    List<Widget> widgets = [];
    htmlBody.splitMapJoin(GlobalRegexp.uploadedFile, onMatch: (match) {
      return _onMatch(widgets, match);
    }, onNonMatch: (text) {
      return _onNonMatch(widgets, text);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widgets
      ],
    );
  }

  String _onMatch(List<Widget> elements, Match match) {
    if(match.group(3)?.isNotEmpty == true || match.group(9)?.isNotEmpty == true) {
      final img = match.group(3) ?? match.group(7)!.replaceAll(")", "");
      elements.add(
          Container(
            padding: EdgeInsets.only(top: elements.isEmpty ? 0 : 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TXNetworkImage(
                  imageUrl: img,
                  boxFitImage: BoxFit.cover,
                  mimeType: FileManager.lookupMime((match.group(2) ?? match.group(8)) ?? ""),
                  forceLoad: true,
                  placeholderImage: Image.asset(
                    R.image.imageDefaultIcon,
                  ),
                  width: 150,
                  height: 150,
                ),
                TXTextWidget(text: (match.group(2) ?? match.group(8)) ?? "", size: 14,)
              ],
            ),
          )
      );
    }
    return "";
  }

  String _onNonMatch(List<Widget> elements, String text) {
    if(text.isNotEmpty) {
      elements.add(Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: htmlWidget(text),
      ));
    }
    return "";
  }

  Widget htmlWidget(String htmlDescription) {
    return TXHtmlWidget(
      shrinkWrap: true,
      style: {
        "div.mobile-description":
            Style(color: R.color.primaryDarkColor, fontSize: const FontSize(19)),
        "a": Style(
            color: R.color.secondaryColor, textDecoration: TextDecoration.none),
        ".partial-message-bold-text": Style(
          fontWeight: FontWeight.bold,
        ),
        ".partial-message-italics-text": Style(fontStyle: FontStyle.italic),
        ".partial-message-code-text": Style(
          backgroundColor: R.color.grayLightestColor,
          border: Border.all(
            color: R.color.grayLightColor,
            width: .5,
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          margin: EdgeInsets.only(bottom: 5),
          display: Display.BLOCK,
        ),
        ".partial-message-preformatted-text": Style(
          backgroundColor: R.color.grayLightestColor,
          margin: EdgeInsets.only(bottom: 5),
          border: Border.all(
            color: R.color.grayLightColor,
            width: .5,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          display: Display.BLOCK,
        ),
        ".partial-message-strike-text": Style(
          textDecoration: TextDecoration.lineThrough,
        ),
        "p, body": Style(margin: EdgeInsets.zero)
      },
      body: _getMessageText(htmlDescription),
    );
  }

  String _getMessageText(String htmlDescription) {
    String part1 = "<div class =\"mobile-description\">";
    String part2 = _getRichTexts(htmlDescription);
    String part3 = "</div>";

    return "$part1$part2$part3";
  }

  String _getRichTexts(String text) {
    String resultText = text;

    resultText = text.replaceAllMapped(GlobalRegexp.strikeExp, (match) {
      final part1 = "<span class = \"partial-message-strike-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      final part3 = "</span>";
      return "$part1$part2$part3";
    });

    resultText =
        resultText.replaceAllMapped(GlobalRegexp.preformattedExp, (match) {
      final part1 = "<span class = \"partial-message-preformatted-text\">";
      final part2 = match.input.substring(match.start + 3, match.end - 3);
      final part3 = "</span>";
      return "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.codeExp, (match) {
      final part1 = "<span class = \"partial-message-code-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      final part3 = "</span>";
      return "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.boldExp, (match) {
      final part1 = "<span class = \"partial-message-bold-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      final part3 = "</span>";
      return "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.italicsExp, (match) {
      final part1 = "<span class = \"partial-message-italics-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      final part3 = "</span>";
      return "$part1$part2$part3";
    });

    return resultText;
  }

  Widget _showChannels() {
    final drawerChatList = bloc.channelsGroups;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(bottom: 30),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, index) {
        final model = drawerChatList[index];
        return Container(
          child: model.isChild
              ? _getChildWidget(model)
              : _getHeaderWidget(model),
        );
      },
      itemCount: drawerChatList.length,
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
        bloc.addMultiAssigneesFromChannel(model.channelModel!.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(left: 15),
        child: Row(
          children: [
            TXTextWidget(
              text: model.channelModel?.isM1x1 == true
                  ? "@${CommonUtils.getMemberUsername(model.memberModel) ?? ""}"
                  : model.title.toLowerCase().trim(),
              color: R.color.blackColor,
            )
          ],
        ),
      ),
    );
  }
}
