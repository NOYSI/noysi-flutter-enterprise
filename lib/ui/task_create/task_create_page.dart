import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_checkbox_widget.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_date_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_media_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/search_user/search_user_page.dart';
import 'package:code/ui/task_create/model_ui.dart';
import 'package:code/ui/task_create/tx_edit_field_widget.dart';
import 'package:code/ui/tasks_tag_selector/task_tag_selector_page.dart';
import 'package:code/ui/task/tx_label_widget.dart';
import 'package:code/ui/task_create/task_create_bloc.dart';
import 'package:code/ui/task_milestone_selector/task_milestone_selector_page.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/extensions.dart';
import 'package:code/utils/file_manager.dart';
import 'package:code/utils/text_parser_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:collection/collection.dart';

import '../../global_regexp.dart';
import '../_tx_widget/tx_html_widget.dart';

class TaskCreatePage extends StatefulWidget {
  final String? channelId;
  final bool isMeetingAppointment;
  final TeamJoinedModel joinedTeam;
  final bool fromCalendar;

  const TaskCreatePage({
    Key? key,
    this.channelId,
    required this.joinedTeam,
    this.isMeetingAppointment = false,
    this.fromCalendar = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskCreateState();
}

class _TaskCreateState extends StateWithBloC<TaskCreatePage, TaskCreateBloC> {
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController roomNameController = TextEditingController(text: '');
  TextEditingController locationController = TextEditingController(text: '');
  TextEditingController channelTitle = TextEditingController(text: '');
  final _keyFormCreateTask = new GlobalKey<FormState>();
  bool isPersonalNote = false;

  FocusNode _meetUrl = FocusNode();

  @override
  void initState() {
    super.initState();
    isPersonalNote = widget.channelId == null ||
        widget.channelId?.isEmpty == true && !widget.isMeetingAppointment;
    bloc.initViewData(widget.channelId, widget.joinedTeam,
        isMeeting: widget.isMeetingAppointment,
        createdForCalendar: widget.fromCalendar);
    if (widget.isMeetingAppointment) {
      bloc.createRoom();
      final general = widget.joinedTeam.channels
          .firstWhere((element) => element.general == true);
      channelTitle.text = general.titleFixed;
      bloc.selectedChannelId = general.id;
    }
    bloc.taskCreateResult.listen((newTask) {
      NavigationUtils.pop(context, result: newTask);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXMainAppBarWidget(
          title: widget.isMeetingAppointment
              ? R.string.newMeetingEvent
              : isPersonalNote
                  ? R.string.newPersonalNote
                  : R.string.newTask,
          body: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 30),
              child: StreamBuilder<TaskCreateUIModel>(
                  stream: bloc.initResult,
                  initialData: null,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    final model = snapshot.data;
                    return Form(
                      key: _keyFormCreateTask,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                              width: double.infinity,
                              child: TXTextWidget(
                                text: R.string.name,
                                color: Colors.black,
                                textAlign: TextAlign.start,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: TXTextFieldWidget(
                              controller: nameController,
                              validator: bloc.required(),
                              maxLines: 10,
                            ),
                            constraints: BoxConstraints(
                              maxHeight: 100,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              TXTextWidget(
                                text: R.string.description,
                                color: Colors.black,
                                textAlign: TextAlign.start,
                              ),
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(
                                    Icons.edit,
                                    color: R.color.grayColor,
                                    size: 20,
                                  ),
                                ),
                                onTap: () async {
                                  WidgetsBinding
                                      .instance.focusManager.primaryFocus
                                      ?.unfocus();
                                  final res = await NavigationUtils.push(
                                      context,
                                      TXEditFieldWidget(
                                        text: commentController.text,
                                        label: R.string.description,
                                      ));
                                  commentController.text = res;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () async {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                              final res = await NavigationUtils.push(
                                  context,
                                  TXEditFieldWidget(
                                    text: commentController.text,
                                    label: R.string.description,
                                  ));
                              commentController.text = res;
                              setState(() {});
                            },
                            child: formattedHtmlComponent(
                                TextUtilsParser.emojiParser(
                                    commentController.text,
                                    removeUploadedFilesExpression: false)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TXDateSelectorWidget(
                            isBlocked: true,
                            showTimePicker: !bloc.taskCreateUIModel.isAllDay,
                            dateFormat: bloc.taskCreateUIModel.isAllDay
                                ? R.string.dateFormat8
                                : R.string.dateFormat4,
                            onDateSelected: (date) {
                              if (date != null) {
                                bloc.updateDateRange(DateTimeRange(
                                    start: date,
                                    end: date.isAfter(snapshot.data!.end!)
                                        ? date
                                        : snapshot.data!.end!));
                              }
                            },
                            initialDate: bloc.taskCreateUIModel.due,
                          ),
                          SizedBox(
                              height: widget.isMeetingAppointment
                                  ? 10
                                  : isPersonalNote
                                      ? 20
                                      : 0),
                          widget.isMeetingAppointment
                              ? Column(
                                  children: [
                                    TXDateSelectorWidget(
                                      isBlocked: true,
                                      showTimePicker:
                                          !bloc.taskCreateUIModel.isAllDay,
                                      title: R.string.endDate,
                                      dateFormat:
                                          bloc.taskCreateUIModel.isAllDay
                                              ? R.string.dateFormat8
                                              : R.string.dateFormat4,
                                      onDateSelected: (date) {
                                        bloc.updateDateRange(DateTimeRange(
                                            start: snapshot.data!.due!,
                                            end: date!));
                                      },
                                      initialDate: snapshot.data?.end,
                                      firsDate: snapshot.data?.due,
                                    ),
                                    TXCheckBoxWidget(
                                      value: bloc.taskCreateUIModel.isAllDay,
                                      text: R.string.allDay,
                                      removeCheckboxExtraPadding: true,
                                      onChange: (value) {
                                        bloc.changeIsAllDay(value);
                                      },
                                      leading: true,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ],
                                )
                              : Container(),
                          widget.isMeetingAppointment
                              ? StreamBuilder<bool>(
                                  initialData: false,
                                  stream: bloc.eventRelatedToGroupSwitchStatus,
                                  builder: (context,
                                      snapshotSwitchEventRelatedToGroup) {
                                    return StreamBuilder<bool>(
                                        initialData: true,
                                        stream: bloc.customUrlSwitchStatus,
                                        builder:
                                            (context, snapshotSwitchCustomUrl) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TXDividerWidget(),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                child: TXTextFieldWidget(
                                                  label: R.string.location,
                                                  controller:
                                                      locationController,
                                                  maxLines: 5,
                                                ),
                                                constraints: BoxConstraints(
                                                    maxHeight: 100),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TXDividerWidget(),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              // Row(
                                              //   children: [
                                              //     Expanded(
                                              //       child: TXTextWidget(
                                              //         text: R.string.eventRelatedToChannel,
                                              //         color: Colors.black,
                                              //         textAlign: TextAlign.start,
                                              //       ),
                                              //     ),
                                              //     Switch(
                                              //         value: snapshotSwitchEventRelatedToGroup.data!,
                                              //         onChanged: (value) {
                                              //           bloc.switchChangeEventRelatedToGroup(value);
                                              //           if (value) {
                                              //             _meetUrl.unfocus();
                                              //             bloc.createRoom(roomName: "${bloc.currentTeamId}_${bloc.selectedChannelId}");
                                              //           } else {
                                              //             if (snapshotSwitchCustomUrl.data!) {
                                              //               bloc.createRoom();
                                              //             } else {
                                              //               bloc.createRoom(
                                              //                   roomName: roomNameController
                                              //                       .text);
                                              //             }
                                              //           }
                                              //         }),
                                              //   ],
                                              // ),
                                              snapshotSwitchEventRelatedToGroup
                                                      .data!
                                                  ? Container()
                                                  : SizedBox(
                                                      height: 5,
                                                    ),
                                              snapshotSwitchEventRelatedToGroup
                                                      .data!
                                                  ? Container()
                                                  : Row(
                                                      children: [
                                                        Expanded(
                                                          child: TXTextWidget(
                                                            text: R.string
                                                                .autogenerateRoomNameQuestion,
                                                            color: Colors.black,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        Switch(
                                                            value:
                                                                snapshotSwitchCustomUrl
                                                                    .data!,
                                                            onChanged: (value) {
                                                              bloc.switchChangeCustomUrl(
                                                                  value);
                                                              if (value) {
                                                                bloc.createRoom();
                                                                _meetUrl
                                                                    .unfocus();
                                                              } else {
                                                                bloc.assignRoomName(
                                                                    roomNameController
                                                                        .text);
                                                                _meetUrl
                                                                    .requestFocus();
                                                              }
                                                            }),
                                                      ],
                                                    ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              StreamBuilder<String>(
                                                stream: bloc.roomTextResult,
                                                initialData: "",
                                                builder:
                                                    (context, snapshotRoom) {
                                                  return Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(12)
                                                        .copyWith(
                                                            left: 5, right: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                      border: Border.all(
                                                          color: R.color
                                                              .grayLightColor,
                                                          width: 1),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          child: Icon(Icons
                                                              .content_copy),
                                                          onTap: () async {
                                                            await Clipboard.setData(
                                                                new ClipboardData(
                                                                    text:
                                                                        "${Injector.instance.meetingBaseUrl}/${Uri.encodeFull(snapshotRoom.data!.trim())}"));
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "${Injector.instance.meetingBaseUrl}/${Uri.encodeFull(snapshotRoom.data!.trim())}",
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                textColor: R
                                                                    .color
                                                                    .whiteColor,
                                                                backgroundColor: R
                                                                    .color
                                                                    .primaryColor);
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: TXTextWidget(
                                                              textOverflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              text:
                                                                  "${Injector.instance.meetingBaseUrl}/${snapshotRoom.data ?? ""}",
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              snapshotSwitchEventRelatedToGroup
                                                      .data!
                                                  ? InkWell(
                                                      onTap: () {
                                                        showTXModalBottomSheet(
                                                            context: context,
                                                            builder: (context) {
                                                              return _showChannels();
                                                            });
                                                      },
                                                      child: TXTextFieldWidget(
                                                        label: R.string.channel,
                                                        controller:
                                                            channelTitle,
                                                        enabled: false,
                                                      ),
                                                    )
                                                  : snapshotSwitchCustomUrl
                                                          .data!
                                                      ? Container()
                                                      : Container(
                                                          child:
                                                              TXTextFieldWidget(
                                                            focusNode: _meetUrl,
                                                            label: R.string
                                                                .roomName,
                                                            controller:
                                                                roomNameController,
                                                            validator: bloc
                                                                .alphanumericRoomName(),
                                                            onChanged: (text) {
                                                              bloc.assignRoomName(
                                                                  text);
                                                            },
                                                          ),
                                                        ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TXDividerWidget(),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  TXTextWidget(
                                                    text:
                                                        "Asignar usuarios de canales o grupos",
                                                    color: R.color.blackColor,
                                                  ),
                                                  TXIconButtonWidget(
                                                    icon: Icon(
                                                      Icons.add_circle_outline,
                                                      color: R
                                                          .color.secondaryColor,
                                                      size: 30,
                                                    ),
                                                    onPressed: () async {
                                                      showTXModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return _showChannels(
                                                                all: false);
                                                          });
                                                    },
                                                  )
                                                ],
                                              ),
                                              _getSelectedChannel(),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  TXTextWidget(
                                                    text:
                                                        R.string.internalGuests,
                                                    color: R.color.blackColor,
                                                  ),
                                                  TXIconButtonWidget(
                                                    icon: Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color: R.color
                                                            .secondaryColor,
                                                        size: 30),
                                                    onPressed: () async {
                                                      final res =
                                                          await NavigationUtils
                                                              .push(
                                                                  context,
                                                                  SearchUserPage(
                                                                    pickMember:
                                                                        true,
                                                                    action: RemoteConstants
                                                                        .searchHumans,
                                                                    userGroupBy:
                                                                        UserGroupBy
                                                                            .team,
                                                                    excludeMembers: bloc
                                                                        .taskCreateUIModel
                                                                        .assignees,
                                                                    excludeBotMembers:
                                                                        true,
                                                                  ));
                                                      if (res is MemberModel) {
                                                        if (bloc
                                                            .taskCreateUIModel
                                                            .assignees
                                                            .contains(res.id)) {
                                                          bloc.taskCreateUIModel
                                                              .assignees
                                                              .removeWhere(
                                                                  (element) =>
                                                                      element ==
                                                                      res.id);
                                                        } else {
                                                          bloc.taskCreateUIModel
                                                              .assignees
                                                              .add(res.id);
                                                        }
                                                        bloc.refreshData;
                                                      }
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  TXTextWidget(
                                                    text:
                                                        R.string.externalGuests,
                                                    color: R.color.blackColor,
                                                  ),
                                                ],
                                              ),
                                              StreamBuilder<
                                                  List<ExternalEmailsModelUI>>(
                                                stream:
                                                    bloc.externalEmailsResult,
                                                initialData:
                                                    bloc.externalEmails,
                                                builder: (context, snapshot) {
                                                  return Column(
                                                    children: [
                                                      ..._getExternalEmailsWidget(
                                                          snapshot.data!)
                                                    ],
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  bloc.externalEmails.add(
                                                      ExternalEmailsModelUI(
                                                    emailController:
                                                        TextEditingController(),
                                                  ));
                                                  bloc.refreshDataExternalEmail;
                                                },
                                                child: Row(
                                                  children: [
                                                    TXTextWidget(
                                                      text: R.string.addAnother,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: R
                                                          .color.secondaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Icons.add_circle_outline,
                                                      color: R
                                                          .color.secondaryColor,
                                                      size: 20,
                                                    )
                                                  ],
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              )
                                            ],
                                          );
                                        });
                                  },
                                )
                              : Container(),
                          widget.channelId?.trim().isNotEmpty == true &&
                                  !widget.isMeetingAppointment
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TXDividerWidget(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TXTextWidget(
                                          text: R.string.tags,
                                          color: R.color.blackColor,
                                        ),
                                        TXIconButtonWidget(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: R.color.secondaryColor,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            final res =
                                                await NavigationUtils.push(
                                                    context,
                                                    TaskTagSelectorPage(
                                                      selectedList: bloc
                                                          .taskCreateUIModel
                                                          .labels,
                                                      channelId:
                                                          widget.channelId!,
                                                    ));
                                            if (res is TaskLabelModel) {
                                              if (bloc.taskCreateUIModel.labels
                                                  .map((e) => e.id)
                                                  .toList()
                                                  .contains(res.id))
                                                bloc.taskCreateUIModel.labels
                                                    .removeWhere((element) =>
                                                        element.id == res.id);
                                              else
                                                bloc.taskCreateUIModel.labels
                                                    .add(res);
                                              bloc.refreshData;
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TXTextWidget(
                                          text: R.string.milestone,
                                          color: R.color.blackColor,
                                        ),
                                        TXIconButtonWidget(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: R.color.secondaryColor,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            final res =
                                                await NavigationUtils.push(
                                                    context,
                                                    TaskMilestoneSelectorPage(
                                                      channelId:
                                                          widget.channelId!,
                                                      selectedMilestone:
                                                          model?.milestone,
                                                    ));
                                            if (res is TaskMileStoneModel) {
                                              bloc.taskCreateUIModel.milestone =
                                                  res;
                                              bloc.refreshData;
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        model!.milestone!.title.isNotEmpty
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
                                                        text: model
                                                            .milestone!.title,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TXTextWidget(
                                          text:
                                              "Asignar usuarios de canales o grupos",
                                          color: R.color.blackColor,
                                        ),
                                        TXIconButtonWidget(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: R.color.secondaryColor,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            showTXModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return _showChannels(
                                                      all: false);
                                                });
                                          },
                                        )
                                      ],
                                    ),
                                    _getSelectedChannel(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TXTextWidget(
                                          text: R.string.assignees,
                                          color: R.color.blackColor,
                                        ),
                                        TXIconButtonWidget(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: R.color.secondaryColor,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            final res =
                                                await NavigationUtils.push(
                                                    context,
                                                    SearchUserPage(
                                                      pickMember: true,
                                                      action: RemoteConstants
                                                          .searchHumans,
                                                      userGroupBy:
                                                          UserGroupBy.team,
                                                      excludeMembers: bloc
                                                          .taskCreateUIModel
                                                          .assignees,
                                                      excludeBotMembers: true,
                                                    ));
                                            if (res is MemberModel) {
                                              if (bloc
                                                  .taskCreateUIModel.assignees
                                                  .contains(res.id)) {
                                                bloc.taskCreateUIModel.assignees
                                                    .removeWhere((element) =>
                                                        element == res.id);
                                              } else {
                                                bloc.taskCreateUIModel.assignees
                                                    .add(res.id);
                                              }
                                              bloc.refreshData;
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                    _getAssignees(),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.center,
                                    //   children: [
                                    //     TXTextWidget(
                                    //       text: R.string.files,
                                    //       color: R.color.blackColor,
                                    //     ),
                                    //     TXIconButtonWidget(
                                    //       icon: Icon(
                                    //         Icons.add_circle_outline,
                                    //         color: R.color.secondaryColor,
                                    //         size: 30,
                                    //       ),
                                    //       onPressed: () async {
                                    //         showTXModalBottomSheet(
                                    //             context: context,
                                    //             builder: (context) {
                                    //               return _showSourceSelector(
                                    //                   context);
                                    //             });
                                    //       },
                                    //     )
                                    //   ],
                                    // ),
                                    // _getFiles(),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // TXDividerWidget(),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                )
                              : Container(),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: TXButtonWidget(
                              onPressed: () {
                                if (_keyFormCreateTask.currentState!
                                    .validate()) {
                                  bloc.createTask(nameController.text,
                                      commentController.text,
                                      isMeetingAppointment:
                                          widget.isMeetingAppointment,
                                      location: locationController.text);
                                }
                              },
                              title: widget.isMeetingAppointment
                                  ? R.string.createMeetingEvent
                                  : isPersonalNote
                                      ? R.string.createNewPersonalNote
                                      : R.string.createTask,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  Widget _getSelectedChannel() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 3,
      runSpacing: 3,
      children: <Widget>[
        ...bloc.selectedChannels
            .map((e) => IntrinsicWidth(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: R.color.secondaryColor.lighten(.4),
                      borderRadius: const BorderRadius.all(Radius.circular(45)),
                      border:
                          Border.all(color: R.color.secondaryColor, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                            e.drawerHeaderChatType ==
                                    DrawerHeaderChatType.Channel
                                ? Icons.numbers
                                : Icons.lock,
                            size: 20),
                        const SizedBox(
                          width: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: TXTextWidget(
                            text: e.title,
                            color: R.color.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ))
            .toList()
      ],
    );
  }

  Widget _getLabels() {
    List<Widget> list = [];
    bloc.taskCreateUIModel.labels.forEach((element) {
      final w = TXLabelWidget(
        taskLabelModel: element,
        onTap: () {
          bloc.taskCreateUIModel.labels
              .removeWhere((label) => label.id == element.id);
          bloc.refreshData;
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
    final members = Injector.instance.inMemoryData.getMembers();
    List<Widget> list = [];
    bloc.taskCreateUIModel.assignees.forEach((element) {
      final photo = CommonUtils.getMemberPhoto(
          members.firstWhereOrNull((p) => p.id == element));
      final w = Container(
        width: 45,
        height: 45,
        child: InkWell(
          onLongPress: () {
            showTXModalBottomSheet(
                context: context,
                builder: (context) {
                  return _showAssigneesOptions(element, photo);
                });
          },
          onTap: () {
            Fluttertoast.showToast(
                msg: CommonUtils.getMemberUsername(
                        members.firstWhereOrNull((p) => p.id == element)) ??
                    "");
          },
          child: Stack(
            children: [
              Container(
                  alignment: Alignment.bottomLeft,
                  child: TXNetworkImage(
                    width: 35,
                    height: 35,
                    forceLoad: true,
                    boxFitImage: BoxFit.cover,
                    imageUrl: photo,
                    placeholderImage: Image.asset(R.image.logo),
                  )),
              Positioned(
                bottom: 10,
                left: 10,
                child: TXIconButtonWidget(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    bloc.taskCreateUIModel.assignees
                        .removeWhere((userId) => userId == element);
                    bloc.refreshData;
                  },
                ),
              )
            ],
          ),
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

  Widget _getFiles() {
    List<Widget> list = [];
    bloc.taskCreateUIModel.filePaths.forEach((filePath) {
      final w = Column(
        children: [
          Container(
              child: InkWell(
            onLongPress: () {
              showTXModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _showFileOptions(filePath);
                  });
            },
            child: Container(
              width: 80,
              height: 80,
              child: FileManager.getFileWidgetByMimeType(filePath,
                  height: 80, width: 80),
            ),
          )),
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

  Widget formattedHtmlComponent(String htmlBody) {
    List<Widget> widgets = [];
    htmlBody.splitMapJoin(GlobalRegexp.uploadedFile, onMatch: (match) {
      return _onMatch(widgets, match);
    }, onNonMatch: (text) {
      return _onNonMatch(widgets, text);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...widgets],
    );
  }

  String _onMatch(List<Widget> elements, Match match) {
    if (match.group(3)?.isNotEmpty == true ||
        match.group(9)?.isNotEmpty == true) {
      final img = match.group(3) ?? match.group(7)!.replaceAll(")", "");
      elements.add(Container(
        padding: EdgeInsets.only(top: elements.isEmpty ? 0 : 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TXNetworkImage(
              imageUrl: img,
              boxFitImage: BoxFit.cover,
              mimeType: FileManager.lookupMime(
                  (match.group(2) ?? match.group(8)) ?? ""),
              forceLoad: true,
              placeholderImage: Image.asset(
                R.image.imageDefaultIcon,
              ),
              width: 150,
              height: 150,
            ),
            TXTextWidget(
              text: (match.group(2) ?? match.group(8)) ?? "",
              size: 14,
            )
          ],
        ),
      ));
    }
    return "";
  }

  String _onNonMatch(List<Widget> elements, String text) {
    if (text.isNotEmpty) {
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
        "div.mobile-description": Style(
            color: R.color.primaryDarkColor, fontSize: const FontSize(19)),
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

  void _launchMediaView({
    ImageSource? imageSource,
    bool lookForVideo = false,
    bool allFiles = false,
    ValueChanged<int>? onFileLoading,
  }) async {
    try {
      NavigationUtils.pop(context);
      final file = await FileManager.getImageFromSource(
          source: imageSource,
          lookForVideo: lookForVideo,
          allFiles: allFiles,
          onFileLoading: onFileLoading);
      if (file != null && file.existsSync()) {
        bloc.addFile(file.path);
      }
    } catch (ex) {
      if (ex is PlatformException) {
        if (ex.code == "photo_access_denied" ||
            ex.code == "camera_access_denied") {
          _showDialogPermissions(context, onOkAction: () async {
            openAppSettings();
          });
        }
      }
    }
  }

  void _showDialogPermissions(BuildContext context, {Function? onOkAction}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.permissionDenied,
        content: R.string.enablePermissions,
        onOK: () {
          Navigator.pop(context, R.string.ok);
          onOkAction!();
        },
        onCancel: () {
          Navigator.pop(context, R.string.cancel);
        },
      ),
    );
  }

  Widget _showFileOptions(String filePath) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            child: FileManager.getFileWidgetByMimeType(filePath,
                height: 60, width: 60),
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
                  bloc.removeFile(filePath);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _showAssigneesOptions(String participantsModelId, String photo) {
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
              imageUrl: photo,
              shape: BoxShape.rectangle,
              boxFitImage: BoxFit.cover,
              placeholderImage: Image.asset(
                R.image.logo,
              ),
            ),
            Expanded(
              child: TXMenuOptionItemWidget(
                icon: Icon(Icons.delete_forever,
                    color: !widget.fromCalendar ||
                            (widget.fromCalendar &&
                                bloc.currentUserId != participantsModelId)
                        ? Colors.redAccent
                        : R.color.grayColor),
                text: R.string.remove,
                textColor: !widget.fromCalendar ||
                        (widget.fromCalendar &&
                            bloc.currentUserId != participantsModelId)
                    ? Colors.redAccent
                    : R.color.grayColor,
                onTap: () async {
                  await NavigationUtils.pop(context);
                  if (!widget.fromCalendar ||
                      (widget.fromCalendar &&
                          bloc.currentUserId != participantsModelId)) {
                    bloc.taskCreateUIModel.assignees
                        .removeWhere((userId) => userId == participantsModelId);
                    bloc.refreshData;
                  }
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
                textInputType: TextInputType.text,
                controller: element.emailController,
                label: R.string.email,
                validator: bloc.formValidatorEmailCommaSeparatedNotRequired(),
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
              bloc.externalEmails.remove(element);
              bloc.refreshDataExternalEmail;
            },
          )
        ],
      ));
    });
    return cardsInvitations;
  }

  Widget _showChannels({bool all = true}) {
    final drawerChatList = all ? bloc.allChannels : bloc.channelsGroups;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(bottom: 30),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, index) {
        final model = drawerChatList[index];
        return Container(
          child: model.isChild
              ? _getChildWidget(model, all: all)
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

  Widget _getChildWidget(DrawerChatModel model, {bool all = true}) {
    int idx = -1;
    if (!all) {
      idx = bloc.selectedChannels.indexWhere(
          (element) => element.channelModel!.id == model.channelModel!.id);
    }
    return InkWell(
      onTap: () async {
        await NavigationUtils.pop(context);
        if (all) {
          bloc.selectedChannelId = model.channelModel!.id;
          bloc.createRoom(
              roomName: "${bloc.currentTeamId}_${model.channelModel!.id}");
          channelTitle.text = model.channelModel?.isM1x1 == true
              ? "@${CommonUtils.getMemberUsername(model.memberModel) ?? ""}"
              : model.title.toLowerCase().trim();
        } else {
          if (idx > -1) {
            bloc.selectedChannels.removeAt(idx);
          } else {
            bloc.selectedChannels.add(model);
          }
          bloc.refreshData;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Expanded(
              child: TXTextWidget(
                text: model.channelModel?.isM1x1 == true
                    ? "@${CommonUtils.getMemberUsername(model.memberModel) ?? ""}"
                    : model.title.toLowerCase().trim(),
                color: R.color.blackColor,
              ),
            ),
            idx > -1
                ? Icon(Icons.check, color: R.color.primaryColor)
                : Container()
          ],
        ),
      ),
    );
  }
}
