import 'dart:async';

import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_info_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_user_presence_widget.dart';
import 'package:code/ui/_tx_widget/tx_user_role_widget.dart';
import 'package:code/ui/user_detail/user_detail_bloc.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/file_manager.dart';
import 'package:code/utils/launcher_manager.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatefulWidget {
  final MemberModel memberModel;

  const UserDetailPage({Key? key, required this.memberModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserDetailState();
}

class _UserDetailState extends StateWithBloC<UserDetailPage, UserDetailBloC>
    with TickerProviderStateMixin {
  late MemberModel member;
  StreamSubscription? ssPresenceChange, ssMemberDisabledEnabled, ssTeamUpdated;
  PageController controller = PageController();
  late Animation<Offset> animationSettingsOffset, animationContactOffset;
  late AnimationController animationSettingsController,
      animationContactController;

  @override
  void initState() {
    super.initState();
    bloc.createChatResult.listen((event) {
      if (event) {
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
      }
    });
    ssTeamUpdated = onTeamUpdatedController.listen((value) {
      setState(() {});
    });
    ssMemberDisabledEnabled = onMemberDisabledEnabled.listen((value) {
      if (value != null && member.tid == value.tid && member.id == value.uid) {
        setState(() {
          member.active = value.enable;
        });
      }
    });
    ssPresenceChange = onUserPresenceChangeController.listen((value) {
      if (value.uid == member.id) {
        setState(() {
          member.presence = value.presence;
        });
      }
    });
    member = widget.memberModel;
    animationSettingsController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animationContactController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animationSettingsOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(1.0, 0.0)).animate(
            CurvedAnimation(
                parent: animationSettingsController,
                curve: Curves.easeInOutBack));
    animationContactOffset =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: animationContactController,
                curve: Curves.easeInOutBack));
    bloc.init(member);
  }

  @override
  void dispose() {
    super.dispose();
    ssMemberDisabledEnabled?.cancel();
    ssPresenceChange?.cancel();
    ssTeamUpdated?.cancel();
    animationContactController.dispose();
    animationSettingsController.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        TXMainAppBarWidget(
          title: member.active
              ? CommonUtils.getMemberNameSingle(member) ?? ""
              : R.string.inactiveMember,
          actions: <Widget>[
            widget.memberModel.id != bloc.currentUserId
                ? Container(
                    margin: EdgeInsets.only(top: 2),
                    child: TXIconButtonWidget(
                      icon: Container(
                        child: Icon(
                          Icons.mark_chat_unread,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (widget.memberModel.id != bloc.currentUserId &&
                            member.userRol != UserRol.Integration)
                          bloc.create1x1Message(widget.memberModel);
                      },
                    ),
                  )
                : Container(),
            !widget.memberModel.isDeletedUser &&
                    widget.memberModel.id != bloc.currentUserId &&
                    Injector.instance.inMemoryData.currentMember?.userRol ==
                        UserRol.Admin &&
                    member.userRol != UserRol.Robot &&
                    member.userRol != UserRol.Integration
                ? TXIconButtonWidget(
                    icon: Container(
                      child: ClipRect(
                        child: Stack(
                          children: [
                            SlideTransition(
                                position: animationContactOffset,
                                child: Icon(Icons.contacts,
                                    key: ValueKey(2), color: Colors.white)),
                            SlideTransition(
                              position: animationSettingsOffset,
                              child: Icon(Icons.settings, color: Colors.white),
                              key: ValueKey(1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (controller.page?.toInt() == 0) {
                        controller.animateToPage(1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease);
                        animationSettingsController.forward();
                        animationContactController.forward();
                      } else {
                        controller.animateToPage(0,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease);
                        animationSettingsController.reverse();
                        animationContactController.reverse();
                      }
                    },
                  )
                : Container()
          ],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TXNetworkImage(
                height: 250,
                width: double.infinity,
                forceLoad: true,
                imageUrl: CommonUtils.getMemberPhoto(member),
                placeholderImage: Image.asset(R.image.logo),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final items = [detailsPage(), settingsPage()];
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: items[index],
                    );
                  },
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

  Widget detailsPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: R.color.grayLightColor,
        ),
        Container(
            height: 70,
            padding: EdgeInsets.only(left: 25, right: 15),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    member.profile?.position?.isNotEmpty == true
                        ? TXTextWidget(
                            text: member.profile?.position ?? "",
                            size: 18,
                            color: R.color.grayDarkColor,
                          )
                        : Container(),
                    Row(
                      children: [
                        member.active == true
                            ? TXUserPresenceWidget(
                                userPresence: member.userPresence,
                                isUserEnabled:
                                    member.active && !member.isDeletedUser,
                              )
                            : Container(),
                        SizedBox(
                          width: member.active == true ? 5 : 0,
                        ),
                        TXTextWidget(
                          text:
                              "@${CommonUtils.getMemberUsername(member) ?? ""}",
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TXUserRoleWidget(
                      memberModel: member,
                    ),
                    SizedBox(
                      height: member.active == true ? 0 : 5,
                    ),
                    member.active == true
                        ? Container()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                text: R.string.inactiveMember,
                                size: 14,
                                color: Colors.redAccent,
                                fontStyle: FontStyle.italic,
                              )
                            ],
                          ),
                  ],
                ),
              ],
            )),
        Container(
          height: 1,
          color: R.color.grayLightColor,
        ),
        (widget.memberModel.id == bloc.currentUserId ||
            Injector.instance.inMemoryData.currentTeam!.showEmails ||
            Injector.instance.inMemoryData.currentMember?.userRol ==
                UserRol.Admin) && !widget.memberModel.isDeletedUser
            ? Container(
                height: 70,
                padding: EdgeInsets.only(left: 25, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TXTextWidget(
                          text: member.profile?.email ?? "",
                          size: 18,
                          color: R.color.grayDarkColor,
                        ),
                        TXTextWidget(
                            text: R.string.email, color: R.color.grayLightColor)
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    TXIconButtonWidget(
                      icon: Icon(
                        Icons.mail_outline,
                        color: R.color.grayDarkColor,
                      ),
                      onPressed: () {
                        LauncherManager.launchApp(
                            'mailto:${member.profile?.email?.trim().toLowerCase() ?? ""}');
                      },
                    )
                  ],
                ))
            : Container(),
        widget.memberModel.id == bloc.currentUserId ||
                Injector.instance.inMemoryData.currentTeam!.showEmails ||
                Injector.instance.inMemoryData.currentMember?.userRol ==
                    UserRol.Admin
            ? Container(
                height: 1,
                color: R.color.grayLightColor,
              )
            : Container(),
        (widget.memberModel.id == bloc.currentUserId ||
                    Injector
                        .instance.inMemoryData.currentTeam!.showPhoneNumbers ||
                    Injector.instance.inMemoryData.currentMember?.userRol ==
                        UserRol.Admin) &&
                member.profile?.phone?.isNotEmpty == true
            ? Container(
                height: 70,
                padding: EdgeInsets.only(left: 25, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TXTextWidget(
                          text: member.profile?.phone ?? "",
                          size: 18,
                          color: R.color.grayDarkColor,
                        ),
                        TXTextWidget(
                            text: R.string.phoneNumber,
                            color: R.color.grayLightColor)
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    TXIconButtonWidget(
                      icon: Icon(
                        Icons.call_outlined,
                        color: R.color.grayDarkColor,
                      ),
                      onPressed: () {
                        LauncherManager.launchApp(
                            'tel:${member.profile?.phone?.replaceAll(" ", "")}');
                      },
                    ),
                    TXIconButtonWidget(
                      icon: Icon(
                        Icons.message_outlined,
                        color: R.color.grayDarkColor,
                      ),
                      onPressed: () {
                        LauncherManager.launchApp(
                            'sms:${member.profile?.phone?.replaceAll(" ", "")}');
                      },
                    )
                  ],
                ))
            : Container(),
        (widget.memberModel.id == bloc.currentUserId ||
                    Injector
                        .instance.inMemoryData.currentTeam!.showPhoneNumbers ||
                    Injector.instance.inMemoryData.currentMember?.userRol ==
                        UserRol.Admin) &&
                member.profile?.phone?.isNotEmpty == true
            ? Container(
                height: 1,
                color: R.color.grayLightColor,
              )
            : Container(),
        member.profile?.country?.isNotEmpty == true
            ? StreamBuilder<String>(
                initialData: member.profile?.country,
                stream: bloc.countryResult,
                builder: (context, snapshot) => Container(
                    height: 70,
                    padding: EdgeInsets.only(left: 25, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TXTextWidget(
                              text: snapshot.data!,
                              size: 18,
                              color: R.color.grayDarkColor,
                            ),
                            TXTextWidget(
                                text: R.string.country,
                                color: R.color.grayLightColor)
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        TXIconButtonWidget(
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: R.color.grayDarkColor,
                          ),
                          onPressed: () {
                            final String url = '${snapshot.data}';
                            LauncherManager.launchApp(
                              'https://www.google.com/maps/search/?api=1&query=${Uri.encodeFull(url)}',
                            );
                          },
                        )
                      ],
                    )),
              )
            : Container(),
        member.profile?.country?.isNotEmpty == true
            ? Container(
                height: 1,
                color: R.color.grayLightColor,
              )
            : Container(),
      ],
    );
  }

  Widget settingsPage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TXTextWidget(
                text: R.string.changeRole,
                color: R.color.blackColor,
                size: 18,
              ),
              Expanded(
                child: Container(),
              ),
              _roleSelector(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 2,
            color: R.color.grayLightestColor,
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<bool>(
            stream: bloc.userStatusResult,
            initialData: false,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TXTextWidget(
                        text: R.string.userStatus,
                        color: R.color.blackColor,
                        size: 18,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Switch.adaptive(
                          activeColor: R.color.secondaryColor,
                          inactiveTrackColor: R.color.grayLightestColor,
                          value: snapshot.data!,
                          onChanged: (value) {
                            bloc.deactivateActivateUser(member);
                          })
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TXInfoWidget(
                      type: InfoType.warning,
                      info: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TXTextWidget(
                              color: R.color.grayDarkestColor,
                              size: 16,
                              textAlign: TextAlign.justify,
                              text: snapshot.data == true
                                  ? R.string.deactivateUserWarning
                                  : R.string.activateUserWarning),
                        ],
                      )),
                ],
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 2,
            color: R.color.grayLightestColor,
          ),
          SizedBox(
            height: 10,
          ),
          _getUserUsageInfo(),
        ],
      ),
    );
  }

  Widget _roleSelector() {
    return StreamBuilder<UserRol>(
      initialData: UserRol.Member,
      stream: bloc.userRoleResult,
      builder: (context, snapshot) {
        return Container(
          child: TextButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    side: BorderSide(color: R.color.grayColor, width: .5)),
              ),
            ),
            icon: Icon(
              Icons.perm_identity_sharp,
              size: 20,
              color: R.color.blackColor,
            ),
            label: Container(
              constraints: BoxConstraints(maxWidth: 230),
              child: TXTextWidget(
                text: snapshot.data == UserRol.Admin
                    ? R.string.administrator
                    : snapshot.data == UserRol.Member
                        ? R.string.member
                        : R.string.guest,
                maxLines: 1,
                color: R.color.blackColor,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            onPressed: () {
              _showRoleSelector();
            },
          ),
        );
      },
    );
  }

  void _showRoleSelector() {
    List<SingleSelectionModel> selectors = [];
    final adminSelector = SingleSelectionModel(
        index: 0,
        id: UserRol.Admin.toString(),
        displayName: R.string.administrator,
        isSelected: member.userRol == UserRol.Admin);
    final memberSelector = SingleSelectionModel(
        index: 1,
        id: UserRol.Member.toString(),
        displayName: R.string.member,
        isSelected: member.userRol == UserRol.Member);
    final guestSelector = SingleSelectionModel(
        index: 2,
        id: UserRol.Member.toString(),
        displayName: R.string.guest,
        isSelected: member.userRol == UserRol.Guest);
    selectors.add(adminSelector);
    selectors.add(memberSelector);
    if (guestSelector.isSelected) selectors.add(guestSelector);
    showTXModalBottomSheetAutoAdjustable(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                ...selectors
                    .map((e) => Container(
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
                                bloc.changeUserRole(
                                    member,
                                    e.id == UserRol.Admin.toString()
                                        ? RemoteConstants.role_admin
                                        : RemoteConstants.role_member);
                            },
                          ),
                        ))
                    .toList()
              ],
            ),
          );
        });
  }

  Widget _getUserUsageInfo() {
    final teamIsTrial =
        Injector.instance.inMemoryData.currentTeam?.trial ?? true;
    return StreamBuilder<UsageModel>(
      initialData: null,
      stream: bloc.userUsageResult,
      builder: (context, snapshot) {
        return snapshot.data == null
            ? Container()
            : TXInfoWidget(
                info: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TXTextWidget(
                          text: "${R.string.sentMessages}: ",
                          color: R.color.grayDarkestColor,
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                        Expanded(
                            child: TXTextWidget(
                          text: teamIsTrial
                              ? R.string.sentMessagesCount(
                                  snapshot.data!.messages?.count.toString() ??
                                      "")
                              : snapshot.data!.messages?.count.toString() ?? "",
                          color: R.color.grayDarkestColor,
                          size: 18,
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TXTextWidget(
                          text: "${R.string.usedStorage}: ",
                          color: R.color.grayDarkestColor,
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                        Expanded(
                          child: TXTextWidget(
                            text: teamIsTrial
                                ? R.string.usedStorageText(
                                    FileManager.convertBytesToGigabytes(
                                            snapshot.data!.files?.size ?? 0)
                                        .toStringAsFixed(4))
                                : FileManager.convertBytesToGigabytes(
                                        snapshot.data!.files?.size ?? 0)
                                    .toStringAsFixed(4),
                            color: R.color.grayDarkestColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}
