import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_pull_to_refresh_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:code/ui/task/tx_task_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TaskPageViewWidget extends StatefulWidget {
  final ValueChanged<int>? onPageChange;
  final ValueChanged<TaskModel>? onItemTap;
  final ValueChanged<RefreshController>? onLoadMoreClosed;
  final ValueChanged<RefreshController>? onLoadMoreOpen;
  final ValueChanged<RefreshController>? onRefreshClosed;
  final ValueChanged<RefreshController>? onRefreshOpen;
  final TaskUIModel? taskUIModel;
  final int currentPageTab;

  TaskPageViewWidget({
    Key? key,
    this.onPageChange,
    this.onItemTap,
    this.onLoadMoreClosed,
    this.onLoadMoreOpen,
    required this.taskUIModel,
    this.currentPageTab = 0,
    this.onRefreshClosed,
    this.onRefreshOpen,
  }) : super(key: key);

  @override
  _TaskPageViewWidgetState createState() => _TaskPageViewWidgetState();
}

class _TaskPageViewWidgetState extends State<TaskPageViewWidget> {
  PageController pageController = PageController(initialPage: 0);

  ScrollController _scrollOpenController = new ScrollController();

  ScrollController _scrollClosedController = new ScrollController();
  int minPixelsToPullRefresh = -100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                          if (widget.onPageChange != null)
                            widget.onPageChange!(1);
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear);
                        },
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.warning,
                                    color: widget.currentPageTab == 1
                                        ? R.color.darkColor
                                        : R.color.grayColor,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TXTextWidget(
                                    text: R.string.open.toUpperCase(),
                                    fontWeight: FontWeight.w500,
                                    color: widget.currentPageTab == 1
                                        ? R.color.darkColor
                                        : R.color.grayColor,
                                  ),
                                  TXTextWidget(
                                    fontWeight: FontWeight.w500,
                                    color: widget.currentPageTab == 1
                                        ? R.color.grayColor
                                        : R.color.grayLightColor,
                                    text:
                                        "(${widget.taskUIModel?.openTotalFiltered})",
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 3,
                              color: widget.currentPageTab == 1
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
                          if (widget.onPageChange != null)
                            widget.onPageChange!(2);
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear);
                        },
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: widget.currentPageTab != 1
                                        ? R.color.darkColor
                                        : R.color.grayColor,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TXTextWidget(
                                    fontWeight: FontWeight.w500,
                                    text: R.string.closed.toUpperCase(),
                                    color: widget.currentPageTab != 1
                                        ? R.color.darkColor
                                        : R.color.grayColor,
                                  ),
                                  TXTextWidget(
                                    fontWeight: FontWeight.w500,
                                    color: widget.currentPageTab != 1
                                        ? R.color.grayColor
                                        : R.color.grayLightColor,
                                    text:
                                        "(${widget.taskUIModel?.closedTotalFiltered})",
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 3,
                              color: widget.currentPageTab == 1
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
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: PageView.builder(
            itemBuilder: (ctx, index) {
              return index == 0 ? _getOpenWidget() : _getClosedWidget();
            },
            itemCount: 2,
            controller: pageController,
            onPageChanged: (index) {
              if (widget.onPageChange != null) widget.onPageChange!(index + 1);
            },
          ),
        ))
      ],
    );
  }

  Widget _getOpenWidget() {
    final _openList = widget.taskUIModel?.openList ?? [];
    return TXPullToRefreshWidget(
      onRefresh: (_controller) {
        if (widget.onRefreshOpen != null) {
          widget.onRefreshOpen!(_controller);
        }
      },
      onLoadMore: (_controller) {
        if (widget.onLoadMoreOpen != null) {
          widget.onLoadMoreOpen!(_controller);
        }
      },
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: _scrollOpenController,
        padding: EdgeInsets.only(bottom: 60),
        itemBuilder: (ctx, index) {
          final task = _openList[index];
          return Column(
            children: [
              TXTaskItemWidget(
                taskModel: task,
                onTap: () {
                  if (widget.onItemTap != null) widget.onItemTap!(task);
                },
              ),
              TXDividerWidget()
            ],
          );
        },
        itemCount: _openList.length,
      ),
    );
  }

  Widget _getClosedWidget() {
    final _closedList = widget.taskUIModel?.closedList ?? [];
    // if (closedList.length > 1)
    //   closedList.sort((t1, t2) => t2.created.compareTo(t1.created));
    return TXPullToRefreshWidget(
      onRefresh: (_controller) {
        if (widget.onRefreshClosed != null) {
          widget.onRefreshClosed!(_controller);
        }
      },
      onLoadMore: (_controller) {
        if (widget.onLoadMoreClosed != null) {
          widget.onLoadMoreClosed!(_controller);
        }
      },
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: _scrollClosedController,
        padding: EdgeInsets.only(bottom: 60),
        itemBuilder: (ctx, index) {
          final task = _closedList[index];
          return Column(
            children: [
              TXTaskItemWidget(
                taskModel: task,
                onTap: () {
                  if (widget.onItemTap != null) widget.onItemTap!(task);
                },
              ),
              TXDividerWidget()
            ],
          );
        },
        itemCount: _closedList.length,
      ),
    );
  }
}
