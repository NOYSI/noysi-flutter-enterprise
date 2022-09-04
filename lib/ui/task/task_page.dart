import 'dart:core';

import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_search_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/task/task_bloc.dart';
import 'package:code/ui/task/task_page_view_widget.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:code/ui/task_create/task_create_page.dart';
import 'package:code/ui/task_detail/task_detail_page.dart';
import 'package:code/ui/task_filter/task_filter_page.dart';
import 'package:code/ui/task_milestone/task_milestone_page.dart';
import 'package:code/ui/tasks_tag/tasks_tag_page.dart';
import 'package:flutter/material.dart';

import '../../domain/team/team_model.dart';
import '../home/home_ui_model.dart';

class TaskPage extends StatefulWidget {
  final String? channelId;
  final String? appBarTitle;
  final TeamJoinedModel joinedTeam;

  const TaskPage({Key? key, this.channelId, this.appBarTitle, required this.joinedTeam}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskState();
}

class _TaskState extends StateWithBloC<TaskPage, TaskBloC> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    bloc.channelId = widget.channelId ?? "";
    bloc.initDataView();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        _getTasksWidget(),
      ],
    );
  }

  Widget _getTasksWidget() {
    return StreamBuilder<TaskUIModel>(
        stream: bloc.tasksResult,
        initialData: bloc.taskUIModel,
        builder: (context, snapshot) {
          return TXSearchBarAppWidget(
            title: widget.appBarTitle ?? R.string.myTasks,
            onNavBack: () {
              NavigationUtils.pop(context);
            },
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add_circle_outline,
                color: R.color.whiteColor,
              ),
              backgroundColor: R.color.secondaryColor,
              onPressed: () async {
                final res = await NavigationUtils.push(
                    context,
                    TaskCreatePage(
                      channelId: widget.channelId,
                      joinedTeam: widget.joinedTeam,
                    ));
                if (res is TaskModel) {
                  bloc.loadOpened();
                }
              },
            ),
            initSearching: false,
            onTextChange: (String query) {
              bloc.query(query);
            },
            onSearching: (isSearching) {
              if (!isSearching) bloc.query("");
            },
            actions: <Widget>[
              TXIconButtonWidget(
                icon: Icon(Icons.filter_list),
                onPressed: () async {
                  final res = await NavigationUtils.push(
                      context,
                      TaskFilterPage(
                        taskUIModel: bloc.taskUIModel,
                        channelId: bloc.channelId,
                        showAuthorFilter: !bloc.isCreatedByMeTab,
                      ));
                  if (res is TaskUIModel) {
                    bloc.taskUIModel.allTasks.clear();
                    bloc.loadOpened();
                    bloc.loadClosed();
                    bloc.activeFilter();
                  }
                },
              ),
              bloc.channelId.isNotEmpty
                  ? PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        size: 22,
                      ),
                      itemBuilder: (ctx) {
                        return [..._popupActionsForChannelTasks()];
                      },
                      onSelected: (key) async {
                        if (key == MenuTaskAction.milestones) {
                          final res = await NavigationUtils.push(
                              context,
                              TaskMilestonePage(
                                channelId: widget.channelId!,
                              ));
                          if (res ?? false) {
                            bloc.loadOpened();
                            bloc.loadClosed();
                          }
                        } else if (key == MenuTaskAction.tags) {
                          final res = await NavigationUtils.push(
                              context,
                              TasksTagPage(
                                channelId: widget.channelId!,
                              ));
                          if (res ?? false) {
                            bloc.loadOpened();
                            bloc.loadClosed();
                          }
                        }
                      })
                  : Container()
            ],
            body: Container(
              child: Column(
                children: <Widget>[
                  bloc.channelId.isEmpty == true
                      ? _getCreatedAssignedTabWidget()
                      : Container(),
                  StreamBuilder<bool>(
                      stream: bloc.activeFilterResult,
                      initialData: false,
                      builder: (context, snapshot) {
                        return snapshot.data!
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                color: R.color.grayLightestColor,
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: TXTextWidget(
                                      text: R.string.activeFilter,
                                    )),
                                    TXIconButtonWidget(
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () {
                                        bloc.clearFilter();
                                      },
                                    )
                                  ],
                                ),
                              )
                            : Container();
                      }),
                  StreamBuilder<int>(
                      stream: bloc.pageTabResult,
                      initialData: 1,
                      builder: (context, snapshotPageIndex) {
                        return Expanded(
                          child: TaskPageViewWidget(
                            currentPageTab: bloc.currentTab,
                            taskUIModel: bloc.taskUIModel,
                            onItemTap: (task) {
                              navigateToDetails(task);
                            },
                            onPageChange: (tab) {
                              bloc.changePageTab(tab);
                              // pageController.animateToPage(tab - 1,
                              //     duration: Duration(milliseconds: 300),
                              //     curve: Curves.linear);
                            },
                            onLoadMoreClosed: (_controller) async {
                                await bloc.loadClosed(isAddingMore: true);
                                _controller.loadComplete();
                            },
                            onLoadMoreOpen: (_controller) async {
                                await bloc.loadOpened(isAddingMore: true);
                                _controller.loadComplete();
                            },
                            onRefreshOpen: (_controller) async {
                              await bloc.loadOpened();
                              _controller.refreshCompleted();
                            },
                            onRefreshClosed: (_controller) async {
                              await bloc.loadClosed();
                              _controller.refreshCompleted();
                            },
                          ),
                        );
                        // bool isOpenTabActive = snapshotPageIndex.data == 1;
                        // return Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 10),
                        //   height: 50,
                        //   child: Column(
                        //     children: <Widget>[
                        //       Expanded(
                        //         child: Row(
                        //           children: <Widget>[
                        //             Expanded(
                        //               flex: 1,
                        //               child: InkWell(
                        //                 onTap: () {
                        //                   bloc.changePageTab(1);
                        //                   pageController.animateToPage(0,
                        //                       duration:
                        //                           Duration(milliseconds: 300),
                        //                       curve: Curves.linear);
                        //                 },
                        //                 child: Column(
                        //                   children: <Widget>[
                        //                     Expanded(
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                             MainAxisAlignment.center,
                        //                         children: <Widget>[
                        //                           Icon(
                        //                             Icons.warning,
                        //                             color: isOpenTabActive
                        //                                 ? R.color.darkColor
                        //                                 : R.color.grayColor,
                        //                             size: 15,
                        //                           ),
                        //                           SizedBox(
                        //                             width: 5,
                        //                           ),
                        //                           TXTextWidget(
                        //                             text: R.string.open
                        //                                 .toUpperCase(),
                        //                             fontWeight: FontWeight.w500,
                        //                             color: isOpenTabActive
                        //                                 ? R.color.darkColor
                        //                                 : R.color.grayColor,
                        //                           ),
                        //                           TXTextWidget(
                        //                             fontWeight: FontWeight.w500,
                        //                             color: isOpenTabActive
                        //                                 ? R.color.grayColor
                        //                                 : R.color
                        //                                     .grayLightColor,
                        //                             text:
                        //                                 "(${snapshot.data.openTotalFiltered})",
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     Container(
                        //                       height: 3,
                        //                       color: snapshotPageIndex.data == 1
                        //                           ? R.color.secondaryColor
                        //                           : null,
                        //                     )
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             Expanded(
                        //               flex: 1,
                        //               child: InkWell(
                        //                 onTap: () {
                        //                   bloc.changePageTab(2);
                        //                   pageController.animateToPage(1,
                        //                       duration:
                        //                           Duration(milliseconds: 300),
                        //                       curve: Curves.linear);
                        //                 },
                        //                 child: Column(
                        //                   children: <Widget>[
                        //                     Expanded(
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                             MainAxisAlignment.center,
                        //                         children: <Widget>[
                        //                           Icon(
                        //                             Icons.check_circle_outline,
                        //                             color: !isOpenTabActive
                        //                                 ? R.color.darkColor
                        //                                 : R.color.grayColor,
                        //                             size: 15,
                        //                           ),
                        //                           SizedBox(
                        //                             width: 5,
                        //                           ),
                        //                           TXTextWidget(
                        //                             fontWeight: FontWeight.w500,
                        //                             text: R.string.closed
                        //                                 .toUpperCase(),
                        //                             color: !isOpenTabActive
                        //                                 ? R.color.darkColor
                        //                                 : R.color.grayColor,
                        //                           ),
                        //                           TXTextWidget(
                        //                             fontWeight: FontWeight.w500,
                        //                             color: !isOpenTabActive
                        //                                 ? R.color.grayColor
                        //                                 : R.color
                        //                                     .grayLightColor,
                        //                             text:
                        //                                 "(${snapshot.data.closedTotalFiltered})",
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     Container(
                        //                       height: 3,
                        //                       color: snapshotPageIndex.data == 1
                        //                           ? null
                        //                           : R.color.secondaryColor,
                        //                     )
                        //                   ],
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //       TXDividerWidget()
                        //     ],
                        //   ),
                        // );
                      }),
                  // Expanded(
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                  //     child: PageView.builder(
                  //       itemBuilder: (ctx, index) {
                  //         return index == 0
                  //             ? _getOpenWidget()
                  //             : _getClosedWidget();
                  //       },
                  //       itemCount: 2,
                  //       controller: pageController,
                  //       onPageChanged: (index) {
                  //         bloc.changePageTab(index + 1);
                  //       },
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        });
  }

  Widget _getCreatedAssignedTabWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      alignment: Alignment.center,
      child: StreamBuilder<bool>(
          stream: bloc.createdFilterResult,
          initialData: false,
          builder: (context, snapshotCreatedFilter) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TXButtonWidget(
                  onPressed: () {
                    bloc.changeCreatedFilter(true);
                  },
                  title: R.string.created,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4))),
                  textColor: snapshotCreatedFilter.data!
                      ? R.color.secondaryColor
                      : R.color.blackColor,
                  mainColor: snapshotCreatedFilter.data!
                      ? R.color.whiteColor
                      : R.color.grayLightColor,
                  splashColor: R.color.grayLightestColor,
                ),
                TXButtonWidget(
                  onPressed: () {
                    bloc.changeCreatedFilter(false);
                  },
                  title: R.string.assigned,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4))),
                  textColor: !snapshotCreatedFilter.data!
                      ? R.color.secondaryColor
                      : R.color.blackColor,
                  mainColor: !snapshotCreatedFilter.data!
                      ? R.color.whiteColor
                      : R.color.grayLightColor,
                  splashColor: R.color.grayLightestColor,
                )
              ],
            );
          }),
    );
  }

  void navigateToDetails(TaskModel taskModel) async {
    await NavigationUtils.push(
        context,
        TaskDetailPage(
          taskModel: taskModel,
        ));
    bloc.loadOpened();
    bloc.loadClosed();
  }

  List<PopupMenuItem> _popupActionsForChannelTasks() {
    List<PopupMenuItem> list = [];
    final assigned = PopupMenuItem(
      value: MenuTaskAction.tags,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.label_outline, color: R.color.grayColor),
        text: R.string.tags,
      ),
    );
    final created = PopupMenuItem(
      value: MenuTaskAction.milestones,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.outlined_flag, color: R.color.grayColor),
        text: R.string.milestones,
      ),
    );
    list.add(assigned);
    list.add(created);
    return list;
  }

// Widget _getOpenWidget() {
//   final _openList = bloc.taskUIModel.openList;
//   // if (openList.length > 1)
//   //   openList.sort((t1, t2) => t2.created.compareTo(t1.created));
//   return NotificationListener<ScrollNotification>(
//     onNotification: (notification) {
//       if (notification.metrics.pixels >
//           _scrollOpenController.position.maxScrollExtent - 300) {
//         if (!bloc.isLoadingMoreOpen && bloc.hasMoreOpen)
//           bloc.loadOpened(isAddingMore: true);
//       }
//       return true;
//     },
//     child: ListView.builder(
//       physics: BouncingScrollPhysics(),
//       controller: _scrollOpenController,
//       padding: EdgeInsets.only(bottom: 60),
//       itemBuilder: (ctx, index) {
//         final task = _openList[index];
//         return Column(
//           children: [
//             TXTaskItemWidget(
//               taskModel: task,
//               onTap: () {
//                 navigateToDetails(task);
//               },
//             ),
//             TXDividerWidget()
//           ],
//         );
//       },
//       itemCount: _openList.length,
//     ),
//   );
// }
//
// Widget _getClosedWidget() {
//   final _closedList = bloc.taskUIModel.closedList;
//   // if (closedList.length > 1)
//   //   closedList.sort((t1, t2) => t2.created.compareTo(t1.created));
//   return NotificationListener<ScrollNotification>(
//     onNotification: (notification) {
//       if (notification.metrics.pixels >
//           _scrollClosedController.position.maxScrollExtent - 300) {
//         if (!bloc.isLoadingMoreClosed && bloc.hasMoreClosed)
//           bloc.loadClosed(isAddingMore: true);
//       }
//       return true;
//     },
//     child: ListView.builder(
//       physics: BouncingScrollPhysics(),
//       controller: _scrollClosedController,
//       padding: EdgeInsets.only(bottom: 60),
//       itemBuilder: (ctx, index) {
//         final task = _closedList[index];
//         return Column(
//           children: [
//             TXTaskItemWidget(
//               taskModel: task,
//               onTap: () {
//                 navigateToDetails(task);
//               },
//             ),
//             TXDividerWidget()
//           ],
//         );
//       },
//       itemCount: _closedList.length,
//     ),
//   );
// }
}
