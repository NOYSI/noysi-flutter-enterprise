import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/task_milestone/task_milestone_bloc.dart';
import 'package:code/ui/task_milestone/tx_milestone_progress_widget.dart';
import 'package:code/ui/task_milestone_create_edit/task_milestone_create_edit_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:flutter/material.dart';

class TaskMilestonePage extends StatefulWidget {
  final String channelId;

  const TaskMilestonePage({Key? key, required this.channelId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskMilestoneState();
}

class _TaskMilestoneState
    extends StateWithBloC<TaskMilestonePage, TaskMilestoneBloc> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    bloc.loadInitialData(widget.channelId);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXMainAppBarWidget(
          title: R.string.milestones,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: R.color.whiteColor,),
            backgroundColor: R.color.secondaryColor,
            onPressed: () async {
              final res = await NavigationUtils.push(
                  context,
                  TaskMilestoneCreateEditPage(
                    previewName: "",
                    channelId: widget.channelId,
                  ));
              if(res is TaskMileStoneModel){
                bloc.loadOpened();
              }
            },
          ),
          body: Column(
            children: [
              StreamBuilder<int>(
                  stream: bloc.pageTabResult,
                  initialData: 1,
                  builder: (context, snapshotPageIndex) {
                    bool isOpenedTab = snapshotPageIndex.data == 1;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                                      if (pageController.page == 0) return;
                                      bloc.changePageTab(1);
                                      pageController.animateToPage(0,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                            child: StreamBuilder<List<TaskMileStoneModel>>(
                                              stream: bloc.taskMilestonesOpenResult,
                                              initialData: [],
                                              builder: (context, snapshot) {
                                                return TXTextWidget(
                                                  text:
                                                      "${snapshot.data!.length} ${R.string.opened.toUpperCase()}",
                                                  fontWeight: FontWeight.w500,
                                                  color: isOpenedTab
                                                      ? R.color.darkColor
                                                      : R.color.grayColor,
                                                );
                                              }
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 3,
                                          color: snapshotPageIndex.data == 1
                                              ? R.color.secondaryColor
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
                                      if (pageController.page == 1) return;
                                      bloc.changePageTab(2);
                                      pageController.animateToPage(1,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                            child: StreamBuilder<List<TaskMileStoneModel>>(
                                              stream: bloc.taskMilestonesClosedResult,
                                              initialData: [],
                                              builder: (context, snapshot) {
                                                return TXTextWidget(
                                                  text:
                                                      "${snapshot.data!.length} ${R.string.closedMilestone.toUpperCase()}",
                                                  fontWeight: FontWeight.w500,
                                                  color: !isOpenedTab
                                                      ? R.color.darkColor
                                                      : R.color.grayColor,
                                                );
                                              }
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 3,
                                          color: snapshotPageIndex.data == 1
                                              ? null
                                              : R.color.secondaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          TXDividerWidget()
                        ],
                      ),
                    );
                  }),
              Expanded(
                child: Container(
                  child: PageView.builder(
                      itemBuilder: (ctx, pageIndex) {
                        return pageIndex == 0
                            ? Container(
                                child: _getOpenWidget(),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                              )
                            : Container(
                                child: _getClosedWidget(),
                                padding: EdgeInsets.symmetric(horizontal: 10));
                      },
                      itemCount: 2,
                      controller: pageController,
                      onPageChanged: (index) {
                        bloc.changePageTab(index + 1);
                      }),
                ),
              )
            ],
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  Widget _getOpenWidget() {
    return StreamBuilder<List<TaskMileStoneModel>>(
        stream: bloc.taskMilestonesOpenResult,
        initialData: [],
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final milestone = snapshot.data![index];
              return _getMilestoneWidget(milestone);
            },
            itemCount: snapshot.data!.length,
          );
        });
  }

  Widget _getClosedWidget() {
    return StreamBuilder<List<TaskMileStoneModel>>(
        stream: bloc.taskMilestonesClosedResult,
        initialData: [],
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final milestone = snapshot.data![index];
              return _getMilestoneWidget(milestone);
            },
            itemCount: snapshot.data!.length,
          );
        });
  }

  Widget _getMilestoneWidget(TaskMileStoneModel model) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TXTextWidget(
                          text: model.title,
                          color: R.color.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 15,
                              color: R.color.grayColor,
                            ),
                            Expanded(
                              child: TXTextWidget(
                                text:
                                    "${R.string.dueDate}: ${model.due != null ? CalendarUtils.showInFormat(R.string.dateFormat4, model.due)?.toLowerCase() ?? "" : ""}",
                                size: 12,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.flag,
                              size: 15,
                              color: R.color.grayColor,
                            ),
                            Expanded(
                              child: TXTextWidget(
                                text:
                                    "${R.string.lastDueDate}: ${model.updated != null ? CalendarUtils.showInFormat(R.string.dateFormat4, model.updated)?.toLowerCase() ?? "" : ""}",
                                size: 12,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  TXIconButtonWidget(
                    icon: Icon(
                      Icons.more_vert,
                      color: R.color.grayColor,
                    ),
                    onPressed: () {
                      showTXModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return _showMilestoneOptions(context, model);
                          });
                    },
                  )
                ],
              ),
              TXMilestoneProgressWidget(
                model: model,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TXDividerWidget()
        ],
      ),
    );
  }

  Widget _showMilestoneOptions(BuildContext context, TaskMileStoneModel model) {
    bool isOpen = model.state == 'open';
    return Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TXTextWidget(
              text: model.title,
              fontWeight: FontWeight.bold,
              color: R.color.blackColor,
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.edit, color: R.color.grayColor),
              text: R.string.edit,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await NavigationUtils.pop(context);
                final res = await NavigationUtils.push(
                    context,
                    TaskMilestoneCreateEditPage(
                      channelId: widget.channelId,
                      taskMileStoneModel: model,
                    ));
                if(res is TaskMileStoneModel){
                  if(res.state == 'open'){
                    bloc.loadOpened();
                  }else{
                   bloc.loadClosed();
                  }
                }
              },
            ),
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(
                  isOpen
                      ? Icons.check_circle_outline
                      : Icons.radio_button_unchecked,
                  color: R.color.grayColor),
              text: isOpen ? R.string.close : R.string.reopen,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await NavigationUtils.pop(context);
                isOpen
                    ? bloc.closeMilestone(model)
                    : bloc.reopenMilestone(model);
              },
            ),
          ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.delete_forever, color: Colors.redAccent),
              text: R.string.remove,
              textColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await NavigationUtils.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
