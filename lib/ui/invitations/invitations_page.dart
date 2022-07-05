import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_pull_to_refresh_widget.dart';
import 'package:code/ui/_tx_widget/tx_search_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/invitations/invitations_bloc.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../utils/common_utils.dart';

class InvitationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InvitationsState();
}

class _InvitationsState
    extends StateWithBloC<InvitationsPage, InvitationsBloC> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    bloc.initData();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXSearchBarAppWidget(
          title: R.string.invitations,
          onNavBack: () {
            NavigationUtils.pop(context);
          },
          onSearching: (value) {
            bloc.query("");
          },
          onTextChange: (query) {
            bloc.query(query);
          },
          body: Container(
            child: Column(
              children: [
                StreamBuilder<int>(
                    stream: bloc.pageTabResult,
                    initialData: 1,
                    builder: (context, snapshotPageIndex) {
                      bool isPendingTab = snapshotPageIndex.data == 1;
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
                                        pageController.animateToPage(0,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Center(
                                              child: TXTextWidget(
                                                text: R.string.pendingTitle
                                                    .toUpperCase(),
                                                fontWeight: FontWeight.w500,
                                                color: isPendingTab
                                                    ? R.color.darkColor
                                                    : R.color.grayColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 5,
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
                                        pageController.animateToPage(1,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Center(
                                              child: TXTextWidget(
                                                text: R.string.acceptedTitle
                                                    .toUpperCase(),
                                                fontWeight: FontWeight.w500,
                                                color: !isPendingTab
                                                    ? R.color.darkColor
                                                    : R.color.grayColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 5,
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: StreamBuilder<int>(
                      stream: bloc.sortResult,
                      initialData: 1,
                      builder: (context, snapshot) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TXTextWidget(
                              text: R.string.date,
                            ),
                            TXIconButtonWidget(
                              onPressed: () {
                                bloc.sortByDate();
                              },
                              icon: Icon(snapshot.data == 1
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up),
                            )
                          ],
                        );
                      }),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: PageView.builder(
                          itemBuilder: (ctx, index) {
                            return index == 0
                                ? _getPendingWidget()
                                : _getAcceptedWidget();
                          },
                          itemCount: 2,
                          controller: pageController,
                          onPageChanged: (index) {
                            bloc.changePageTab(index + 1);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getPendingWidget() {
    return TXGestureHideKeyBoard(
      child: Container(
        child: StreamBuilder<List<InvitationPendingAcceptedModel>?>(
          stream: bloc.invitationsPendingResult,
          initialData: [],
          builder: (ctx, snapshot) {
            return TXPullToRefreshWidget(
              onLoadMore: (controller) async {
                await bloc.loadInvitations("pending");
                controller.loadComplete();
              },
              onRefresh: (controller) async {
                await bloc.loadInvitations("pending", refresh: true);
                controller.refreshCompleted();
              },
              body: snapshot.data!.isEmpty
                  ? Container()
                  : ListView.builder(
                itemBuilder: (ctx, index) {
                  if (snapshot.data!.isEmpty) return Container();
                  final invitation = snapshot.data![index];
                  return _getPendingItemWidget(invitation);
                },
                itemCount: snapshot.data!.length,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getAcceptedWidget() {
    return TXGestureHideKeyBoard(
      child: Container(
        child: StreamBuilder<List<InvitationPendingAcceptedModel>?>(
          stream: bloc.invitationsAcceptedResult,
          initialData: [],
          builder: (ctx, snapshot) {
            return TXPullToRefreshWidget(
              onLoadMore: (controller) async {
                await bloc.loadInvitations("accepted");
                controller.loadComplete();
              },
              onRefresh: (controller) async {
                await bloc.loadInvitations("accepted", refresh: true);
                controller.refreshCompleted();
              },
              body: snapshot.data!.isEmpty
                  ? Container()
                  : ListView.builder(
                itemBuilder: (ctx, index) {
                  if (snapshot.data!.isEmpty) return Container();
                  final invitation = snapshot.data![index];
                  return _getInvitationWidget(invitation);
                },
                itemCount: snapshot.data!.length,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getInvitationWidget(InvitationPendingAcceptedModel model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TXNetworkImage(
                  imageUrl: CommonUtils.getMemberPhoto(model.memberTo),
                  placeholderImage: Image.asset(R.image.logo),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TXTextWidget(
                        text: model.to ?? '',
                        color: R.color.blackColor,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.date_range,
                                size: 12,
                                color: R.color.grayColor,
                              ),
                              TXTextWidget(
                                size: 12,
                                text: CalendarUtils.showInFormat(
                                        R.string.dateFormat3,
                                        model.accepted == true
                                            ? model.acceptedDate
                                            : model.sendDate) ??
                                    '',
                              )
                            ],
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 12,
                                  color: R.color.grayColor,
                                ),
                                TXTextWidget(
                                  size: 12,
                                  text: R.string.invitedBy(CommonUtils.getMemberUsername(model.memberFrom) ?? ""),
                                  textOverflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: R.color.darkColor),
                  child: TXTextWidget(
                    size: 12,
                    text: model.userRol == UserRol.Admin
                        ? R.string.administrator
                        : model.userRol == UserRol.Member
                            ? R.string.member
                            : R.string.guest,
                    color: R.color.whiteColor,
                  ),
                )
              ],
            ),
          ),
          TXDividerWidget()
        ],
      ),
    );
  }

  Widget _getPendingItemWidget(InvitationPendingAcceptedModel model) {
    return Container(
      margin: EdgeInsets.only(top: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TXTextWidget(
                  text: model.to ?? '',
                  color: R.color.blackColor,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: R.color.darkColor),
                child: TXTextWidget(
                  size: 12,
                  text: model.userRol == UserRol.Admin
                      ? R.string.administrator
                      : model.userRol == UserRol.Member
                          ? R.string.member
                          : R.string.guest,
                  color: R.color.whiteColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.date_range,
                    size: 12,
                    color: R.color.grayColor,
                  ),
                  TXTextWidget(
                    size: 12,
                    text: CalendarUtils.showInFormat(
                            R.string.dateFormat3,
                            model.accepted == true
                                ? model.acceptedDate
                                : model.sendDate) ??
                        '',
                  )
                ],
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 12,
                      color: R.color.grayColor,
                    ),
                    TXTextWidget(
                      size: 12,
                      text: R.string
                          .invitedBy(CommonUtils.getMemberUsername(model.memberFrom) ?? ""),
                      textOverflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                child: TXButtonWidget(
                  title: R.string.revokeInvitation,
                  onPressed: () {
                    _showRevokeWarning(model, context: context);
                  },
                  fontSize: 12,
                  textColor: R.color.whiteColor,
                  mainColor: Colors.redAccent,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 30,
                child: TXButtonWidget(
                  title: R.string.resendInvitation,
                  textColor: R.color.whiteColor,
                  mainColor: R.color.secondaryColor,
                  fontSize: 12,
                  onPressed: () {
                    bloc.resendInvitation(model.id!);
                  },
                ),
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

  void _showRevokeWarning(
    InvitationPendingAcceptedModel model, {
    required BuildContext context,
  }) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.revokeInvitationDelete,
        contentWidget: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: R.color.grayLightestColor),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.warning,
                color: R.color.orange,
                size: 60,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TXTextWidget(
                      text: R.string.revokeInvitationWarning,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        confirmActionColor: Colors.redAccent,
        confirmText: R.string.revoke,
        onOK: () async {
          Navigator.pop(context);
          bloc.revokeInvitation(model.id!);
        },
        onCancel: () {
          Navigator.pop(context, R.string.cancel);
        },
      ),
    );
  }
}
