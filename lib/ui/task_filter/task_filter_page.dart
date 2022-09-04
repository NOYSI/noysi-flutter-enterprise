import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/search_user/search_user_page.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:code/ui/task/tx_label_widget.dart';
import 'package:code/ui/task_filter/task_fliter_bloc.dart';
import 'package:code/ui/task_milestone_selector/task_milestone_selector_page.dart';
import 'package:code/ui/tasks_tag_selector/task_tag_selector_page.dart';
import 'package:flutter/material.dart';

import '../../utils/common_utils.dart';

class TaskFilterPage extends StatefulWidget {
  final TaskUIModel taskUIModel;
  final String channelId;
  final bool showAuthorFilter;

  const TaskFilterPage(
      {Key? key, required this.taskUIModel, this.channelId = "", this.showAuthorFilter = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskFilterState();
}

class _TaskFilterState extends StateWithBloC<TaskFilterPage, TaskFilterBloC> {
  _navBack() {
    NavigationUtils.pop(context, result: bloc.taskUIModel);
  }

  @override
  void initState() {
    super.initState();
    bloc.initViewData(
        widget.taskUIModel, widget.channelId, widget.showAuthorFilter);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navBack();
        return false;
      },
      child: TXMainAppBarWidget(
        title: R.string.filterBy,
        onLeadingTap: () {
          _navBack();
        },
        body: SingleChildScrollView(
          child: StreamBuilder<TaskUIModel?>(
              stream: bloc.initResult,
              initialData: bloc.taskUIModel,
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          showTXModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return _showSortOptions(
                                  context,
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TXTextWidget(
                                    text: "${R.string.sort}:",
                                    color: R.color.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  TXTextWidget(
                                    text: snapshot.data?.taskSort ==
                                        TaskSort.newest
                                        ? R.string.newestFirst
                                        : snapshot.data?.taskSort ==
                                        TaskSort.oldest
                                        ? R.string.oldestFirst
                                        : snapshot.data?.taskSort ==
                                        TaskSort.dueDateEarly
                                        ? R.string.earlyDeliverDate
                                        : R.string.farDeliverDate,
                                    color: R.color.blackColor,
                                  ),
                                ],
                              ),
                            ),
                            TXIconButtonWidget(
                              icon: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                      widget.channelId.isNotEmpty == true ?
                      Column(
                        children: [
                          TXDividerWidget(),
                          InkWell(
                            onTap: () async {
                              final res = await NavigationUtils.push(
                                  context,
                                  TaskTagSelectorPage(
                                    selectedList: snapshot.data?.labels ?? [],
                                    channelId: bloc.channelId,
                                  ));
                              if (res is TaskLabelModel) bloc.updateLabels(res);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TXTextWidget(
                                    text: R.string.tags,
                                    color: R.color.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TXIconButtonWidget(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: R.color.grayColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          _getLabels(),
                          TXDividerWidget(),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              final res = await NavigationUtils.push(
                                  context,
                                  TaskMilestoneSelectorPage(
                                    selectedMilestone: snapshot.data?.milestone,
                                    channelId: bloc.channelId,
                                  ));
                              if (res is TaskMileStoneModel) {
                                bloc.updateMilestone(res);
                              }
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TXTextWidget(
                                        text: "${R.string.milestone}:",
                                        color: R.color.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.flag,
                                            size: 15,
                                            color: R.color.grayColor,
                                          ),
                                          snapshot.data?.milestone != null
                                              ? Expanded(
                                            child: Wrap(
                                              crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                              children: [
                                                TXTextWidget(
                                                  text: snapshot
                                                      .data?.milestone?.title ?? "",
                                                ),
                                                TXIconButtonWidget(
                                                  icon: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onPressed: () {
                                                    bloc.updateMilestone(
                                                        null);
                                                  },
                                                )
                                              ],
                                            ),
                                          )
                                              : Container()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                TXIconButtonWidget(
                                  icon: Icon(Icons.arrow_forward_ios),
                                )
                              ],
                            ),
                          ),
                          TXDividerWidget(),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              final res = await NavigationUtils.push(
                                  context,
                                  SearchUserPage(
                                    action: RemoteConstants.searchHumans,
                                    userGroupBy: UserGroupBy.team,
                                    pickMember: true,
                                    excludeMembers: snapshot.data?.assignee != null
                                        ? [snapshot.data!.assignee!.id]
                                        : [],
                                    excludeBotMembers: true,
                                  ));
                              if (res is MemberModel) {
                                bloc.updateAssignee(res);
                              }
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TXTextWidget(
                                        text: "${R.string.assigned}:",
                                        color: R.color.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      snapshot.data?.assignee != null
                                          ? Wrap(
                                        crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                        children: [
                                          TXNetworkImage(
                                            imageUrl: CommonUtils.getMemberPhoto(snapshot.data!.assignee),
                                            width: 35,
                                            height: 35,
                                            forceLoad: true,
                                            placeholderImage: Image.asset(
                                              R.image.logo,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          TXTextWidget(
                                            text: snapshot.data?.assignee?.isDeletedUser == true ? R.string.memberDeleted : snapshot.data?.assignee?.active == false ? R.string.inactiveMember : CommonUtils.getMemberNameSingle(snapshot.data?.assignee) ??
                                                "",
                                            color: snapshot.data?.assignee?.active == false || snapshot.data?.assignee?.isDeletedUser == true ? Colors.redAccent : null,
                                            fontStyle: snapshot.data?.assignee?.active == false || snapshot.data?.assignee?.isDeletedUser == true ? FontStyle.italic : null,
                                          ),
                                          TXIconButtonWidget(
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              bloc.updateAssignee(null);
                                            },
                                          )
                                        ],
                                      )
                                          : Container()
                                    ],
                                  ),
                                ),
                                TXIconButtonWidget(
                                  icon: Icon(Icons.arrow_forward_ios),
                                )
                              ],
                            ),
                          ),
                        ],
                      ) : Container(),
                      TXDividerWidget(),
                      widget.showAuthorFilter
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final res = await NavigationUtils.push(
                                        context,
                                        SearchUserPage(
                                          userGroupBy: UserGroupBy.team,
                                          pickMember: true,
                                          excludeMembers:
                                              snapshot.data?.author != null
                                                  ? [snapshot.data!.author!.id]
                                                  : [],
                                          excludeBotMembers: true,
                                          action: RemoteConstants.searchHumans,
                                        ));
                                    if (res is MemberModel) {
                                      bloc.updateAuthor(res);
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TXTextWidget(
                                              text: "${R.string.author}:",
                                              color: R.color.blackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            snapshot.data?.author != null
                                                ? Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      TXNetworkImage(
                                                        imageUrl: CommonUtils.getMemberPhoto(snapshot
                                                            .data!.author!),
                                                        width: 35,
                                                        height: 35,
                                                        forceLoad: true,
                                                        placeholderImage:
                                                            Image.asset(
                                                          R.image.logo,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      TXTextWidget(
                                                        text: snapshot.data?.author?.isDeletedUser == true ? R.string.memberDeleted : snapshot
                                                            .data
                                                            ?.author?.active == false ? R.string.inactiveMember : CommonUtils.getMemberNameSingle(snapshot
                                                            .data
                                                            ?.author) ??
                                                            "",
                                                        color: snapshot
                                                            .data
                                                            ?.author?.active == false || snapshot.data?.author?.isDeletedUser == true ? Colors.redAccent : null,
                                                        fontStyle: snapshot
                                                            .data
                                                            ?.author?.active == false || snapshot.data?.author?.isDeletedUser == true ? FontStyle.italic : null,
                                                      ),
                                                      TXIconButtonWidget(
                                                        icon: Icon(
                                                          Icons.remove_circle,
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        onPressed: () {
                                                          bloc.updateAuthor(
                                                              null);
                                                        },
                                                      )
                                                    ],
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                      TXIconButtonWidget(
                                        icon: Icon(Icons.arrow_forward_ios),
                                      )
                                    ],
                                  ),
                                ),
                                TXDividerWidget(),
                              ],
                            )
                          : Container()
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _getLabels() {
    List<Widget> list = [];
    bloc.taskUIModel.labels.forEach((element) {
      final w = TXLabelWidget(
        taskLabelModel: element,
        onTap: () {
          bloc.updateLabels(element);
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

  Widget _showSortOptions(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.schedule,
                  color: bloc.taskUIModel.taskSort == TaskSort.newest
                      ? R.color.blackColor
                      : R.color.grayColor),
              text: R.string.newestFirst,
              textColor: bloc.taskUIModel.taskSort == TaskSort.newest
                  ? R.color.blackColor
                  : R.color.grayColor,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await NavigationUtils.pop(context);
                bloc.updateSort(TaskSort.newest);
              },
            ),
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.schedule,
                  color: bloc.taskUIModel.taskSort == TaskSort.oldest
                      ? R.color.blackColor
                      : R.color.grayColor),
              text: R.string.oldestFirst,
              textColor: bloc.taskUIModel.taskSort == TaskSort.oldest
                  ? R.color.blackColor
                  : R.color.grayColor,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await NavigationUtils.pop(context);
                bloc.updateSort(TaskSort.oldest);
              },
            ),
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.schedule,
                  color: bloc.taskUIModel.taskSort == TaskSort.dueDateEarly
                      ? R.color.blackColor
                      : R.color.grayColor),
              text: R.string.earlyDeliverDate,
              textColor: bloc.taskUIModel.taskSort == TaskSort.dueDateEarly
                  ? R.color.blackColor
                  : R.color.grayColor,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await NavigationUtils.pop(context);
                bloc.updateSort(TaskSort.dueDateEarly);
              },
            ),
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.schedule,
                  color: bloc.taskUIModel.taskSort == TaskSort.dueDateFar
                      ? R.color.blackColor
                      : R.color.grayColor),
              text: R.string.farDeliverDate,
              textColor: bloc.taskUIModel.taskSort == TaskSort.dueDateFar
                  ? R.color.blackColor
                  : R.color.grayColor,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await NavigationUtils.pop(context);
                bloc.updateSort(TaskSort.dueDateFar);
              },
            ),
          ),
        ],
      ),
    );
  }
}
