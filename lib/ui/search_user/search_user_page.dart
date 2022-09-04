import 'dart:async';

import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_pull_to_refresh_widget.dart';
import 'package:code/ui/_tx_widget/tx_search_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_user_presence_widget.dart';
import 'package:code/ui/_tx_widget/tx_user_role_widget.dart';
import 'package:code/ui/search_user/search_user_bloc.dart';
import 'package:code/ui/user_detail/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/common_utils.dart';

class SearchUserPage extends StatefulWidget {
  final UserGroupBy? userGroupBy;
  final String? channelId;
  final String action;
  final bool pickMember;
  final List<String> excludeMembers;
  final bool excludeBotMembers;
  final bool activeMembersOnly;
  final bool showInvitationLinkGenerator;
  final bool showKickButton;

  const SearchUserPage({
    Key? key,
    this.userGroupBy,
    this.channelId,
    this.action = RemoteConstants.searchIms,
    this.pickMember = false,
    this.showInvitationLinkGenerator = false,
    this.showKickButton = false,
    this.excludeMembers = const [],
    this.excludeBotMembers = false,
    this.activeMembersOnly = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchUserPageState();
}

class _SearchUserPageState
    extends StateWithBloC<SearchUserPage, SearchUserBloC> {
  StreamSubscription? memberRoleUpdatedStreamSubs,
      memberDisabledEnabledStreamSubs,
      userPresenceChangedStreamSubs,
      channelLeftStreamSubs;

  @override
  void initState() {
    super.initState();
    memberRoleUpdatedStreamSubs = onMemberRoleUpdated.listen((value) {
      bloc.onMemberRoleUpdated(value);
    });
    userPresenceChangedStreamSubs =
        onUserPresenceChangeController.listen((value) {
      bloc.onUserPresenceChangeController(value);
    });
    memberDisabledEnabledStreamSubs = onMemberDisabledEnabled.listen((value) {
      bloc.onMemberDisabledEnabled(value);
    });
    if (widget.channelId?.isNotEmpty == true) {
      channelLeftStreamSubs = onChannelLeftDeleted.listen((value) {
        if ((value.deleted ||
                value.closed ||
                value.uid ==
                    Injector.instance.inMemoryData.currentMember?.id) &&
            value.cid == widget.channelId &&
            value.tid == bloc.currentTeamId &&
            mounted) {
          NavigationUtils.popUntilWithRouteAndMaterial(
              context, NavigationUtils.HomeRoute);
        } else {
          bloc.onMemberLeftChannel(value, widget.channelId!);
        }
      });
    }
    bloc.initDataView(
        widget.action,
        widget.userGroupBy!,
        widget.channelId,
        widget.excludeMembers,
        widget.excludeBotMembers,
        widget.activeMembersOnly);
  }

  @override
  void dispose() {
    memberRoleUpdatedStreamSubs?.cancel();
    memberDisabledEnabledStreamSubs?.cancel();
    userPresenceChangedStreamSubs?.cancel();
    channelLeftStreamSubs?.cancel();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return TXSearchBarAppWidget(
      title: R.string.users,
      onNavBack: () {
        NavigationUtils.pop(context);
      },
      onTextChange: (value) {
        bloc.searchByQuery(value);
      },
      floatingActionButton: widget.showInvitationLinkGenerator
          ? StreamBuilder<bool>(
              initialData: false,
              stream: bloc.generatingLinkController.stream,
              builder: (context, snapshot) {
                return AbsorbPointer(
                  absorbing: snapshot.data!,
                  child: FloatingActionButton(
                      child: snapshot.data!
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  R.color.primaryColor),
                              strokeWidth: 3,
                              backgroundColor: null,
                            )
                          : Icon(
                              Icons.link,
                              size: 30,
                              color: R.color.whiteColor,
                            ),
                      backgroundColor: R.color.secondaryColor,
                      onPressed: () {
                        bloc.generatePrivateGroupInvitationLink().then((value) {
                          if (value.isNotEmpty) {
                            _showPrivateGroupLinkGeneratorModal(context, value);
                          }
                        });
                      }),
                );
              },
            )
          : null,
      body: Container(
        child: StreamBuilder<MemberWrapperModel>(
          stream: bloc.membersResult,
          initialData: bloc.memberWrapperModel,
          builder: (ctx, snapshot) {
            if (snapshot.data!.list.isEmpty) return Container();
            return TXPullToRefreshWidget(
              onRefresh: (_controller) async {
                await bloc.loadMembers(replace: true);
                _controller.refreshCompleted();
              },
              onLoadMore: (_controller) async {
                await bloc.loadMembers();
                _controller.loadComplete();
              },
              body: ListView.builder(
                padding: EdgeInsets.only(bottom: 30),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  final member = snapshot.data!.list[index];
                  return _getUserWidget(member);
                },
                itemCount: snapshot.data!.list.length,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getUserWidget(MemberModel memberModel) {
    bool memberIsInactiveDeleted = !memberModel.active || memberModel.isDeletedUser;
    bool showKick = widget.channelId?.isNotEmpty == true &&
        memberModel.id != Injector.instance.inMemoryData.currentMember?.id &&
        widget.showKickButton;
    return Container(
      child: InkWell(
        onTap: () {
          if (widget.pickMember)
            NavigationUtils.pop(context, result: memberModel);
          else
            NavigationUtils.push(
                context,
                UserDetailPage(
                  memberModel: memberModel,
                ));
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 85,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TXNetworkImage(
                    imageUrl: CommonUtils.getMemberPhoto(memberModel),
                    forceLoad: true,
                    placeholderImage: Image.asset(R.image.logo),
                    height: 67,
                    width: 67,
                    boxFitImage: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        memberIsInactiveDeleted ? Container() : TXTextWidget(
                          text: CommonUtils.getMemberNameSingle(memberModel) ?? '',
                          color: R.color.blackColor,
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: memberIsInactiveDeleted ? 0 : 5,
                        ),
                        memberIsInactiveDeleted && memberModel.profile?.position?.isEmpty == true
                            ? Container() : TXTextWidget(
                                text: memberModel.profile?.position ?? '',
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            memberIsInactiveDeleted
                                ? Container() : TXUserPresenceWidget(
                                    userPresence: memberModel.userPresence,
                                  ),
                            SizedBox(
                              width: memberIsInactiveDeleted ? 0 : 3,
                            ),
                            Expanded(
                              child: TXTextWidget(
                                text: "@${CommonUtils.getMemberUsername(memberModel)}",
                                size: 17,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        memberIsInactiveDeleted
                            ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.info_outline,
                              color: Colors.redAccent,
                              size: 11,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            TXTextWidget(
                              text: memberModel.isDeletedUser ? R.string.memberDeleted : R.string.inactiveMember,
                              size: 14,
                              color: Colors.redAccent,
                              fontStyle: FontStyle.italic,
                            )
                          ],
                        ) : Container()
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TXUserRoleWidget(
                        memberModel: memberModel,
                      ),
                      SizedBox(
                        height: showKick ? 5 : 0,
                      ),
                      showKick
                          ? InkWell(
                              onTap: () {
                                bloc.kickOutUser(memberModel.id);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  TXTextWidget(
                                    text: R.string.kick,
                                    size: 16,
                                    color: Colors.red,
                                  )
                                ],
                              ))
                          : Container()
                    ],
                  )
                ],
              ),
            ),
            TXDividerWidget()
          ],
        ),
      ),
    );
  }

  void _showPrivateGroupLinkGeneratorModal(BuildContext context, String link) {
    showTXModalBottomSheetAutoAdjustable(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TXTextWidget(
                    text: R.string.invitePrivateGroupLink,
                    color: R.color.blackColor),
                Divider(),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12).copyWith(left: 5, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: R.color.grayLightColor, width: 1),
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(Icons.content_copy),
                        onTap: () async {
                          await Clipboard.setData(
                              new ClipboardData(text: link));
                          Fluttertoast.showToast(
                              msg: link,
                              toastLength: Toast.LENGTH_LONG,
                              textColor: R.color.whiteColor,
                              backgroundColor: R.color.primaryColor);
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: InkWell(
                            child: TXTextWidget(
                              textOverflow: TextOverflow.visible,
                              text: link,
                              color: Colors.black,
                            ),
                            onTap: () async {
                              if (await canLaunchUrlString(link)) launchUrlString(link);
                            },
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
