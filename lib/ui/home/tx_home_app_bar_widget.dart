import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_animated_expansion_tile.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_user_presence_widget.dart';
import 'package:code/ui/home/tx_drawer_chat_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/home/tx_home_menu_icon_widget.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/text_parser_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/extensions.dart';
import '../../enums.dart';

class TXHomeAppBarWidget extends StatefulWidget {
  final MemberModel member;
  final Function() onSearchTapped;
  final Function() onFavoritesTapped;
  final Function() onVideoCallTapped;
  final Stream<TeamModel> team;
  final ValueChanged<MenuChatAction> onMenuChatActionTapped;
  final List<DrawerChatModel> drawerChatList;
  final ValueChanged<DrawerChatModel> onDrawerChatTap;
  final ValueChanged<DrawerChatModel> onAddChatTap;
  final ValueChanged<DrawerNavigationOption> onNavigationOptionTap;
  final ValueChanged<DrawerMenuAction>? onMenuDrawerTapped;
  final Widget body;
  final ChannelModel? currentChat;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Stream<int> unreadTeams;
  final Stream<int> openTasks;
  final Stream<int> unreadCalendar;
  final Stream<String> appVersion;
  final GlobalKey<ScaffoldState> keyScaffoldState;
  final Stream<DrawerConfig> drawerConfig;
  final ValueChanged<DrawerConfig> onDrawerConfigChanged;

  const TXHomeAppBarWidget({
    Key? key,
    required this.body,
    required this.team,
    required this.onSearchTapped,
    required this.onVideoCallTapped,
    required this.onFavoritesTapped,
    required this.onDrawerConfigChanged,
    required this.member,
    required this.drawerConfig,
    this.onMenuDrawerTapped,
    required this.onNavigationOptionTap,
    required this.onMenuChatActionTapped,
    required this.drawerChatList,
    required this.appVersion,
    required this.onDrawerChatTap,
    required this.onAddChatTap,
    this.currentChat,
    required this.floatingActionButton,
    required this.floatingActionButtonLocation,
    required this.unreadTeams,
    required this.openTasks,
    required this.unreadCalendar,
    required this.keyScaffoldState,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TXHomeAppBarState();
}

class _TXHomeAppBarState extends State<TXHomeAppBarWidget> {
  String userTyping = "";
  final inMemoryData = Injector.instance.inMemoryData;
  DateTime? userTypingMark;

  @override
  void initState() {
    super.initState();
    onUserTypingChannelController.listen((value) {
      if (inMemoryData.currentTeam?.id == value.tid &&
          widget.currentChat?.id == value.cid) {
        final member = inMemoryData
            .getMembers()
            .firstWhereOrNull((element) => element.id == value.uid);
        if (member != null &&
            member.userPresence == UserPresence.online &&
            member.id != widget.member.id) {
          userTypingMark = DateTime.now();
          setState(() {
            userTyping = CommonUtils.getMemberUsername(member) ?? "";
            Future.delayed(Duration(seconds: 3), () {
              final dif = DateTime.now().difference(userTypingMark!);
              if (dif.inSeconds > 2)
                setState(() {
                  userTyping = "";
                });
            });
          });
        }
      }
    });
  }

  // _handleDrawer() {
  //   _keyScaffoldState.currentState.isDrawerOpen
  //       ? _keyScaffoldState.currentState.openDrawer()
  //       : _keyScaffoldState.currentState.openEndDrawer();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.keyScaffoldState,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: _getTitle(),
        leadingWidth: 30,
        actions: <Widget>[
          TXGestureHideKeyBoard(
            child: TXIconButtonWidget(
              onPressed: widget.onVideoCallTapped,
              icon: Icon(
                Icons.video_call,
                size: 30,
              ),
            ),
          ),
          TXGestureHideKeyBoard(
            child: TXIconButtonWidget(
              onPressed: widget.onFavoritesTapped,
              icon: Icon(
                Icons.star_border,
              ),
            ),
          ),
          TXGestureHideKeyBoard(
            child: TXIconButtonWidget(
              onPressed: widget.onSearchTapped,
              icon: Icon(
                Icons.search,
              ),
            ),
          ),
          TXGestureHideKeyBoard(
            child: PopupMenuButton(
                offset: Offset(0, kToolbarHeight),
                icon: Icon(
                  Icons.more_vert,
                ),
                itemBuilder: (ctx) {
                  return [..._popupActionsChatMenu()];
                },
                onSelected: (key) {
                  if (key != null)
                    widget.onMenuChatActionTapped(key as MenuChatAction);
                }),
          )
        ],
      ),
      drawer: _getDrawer(),
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }

  List<PopupMenuEntry> _popupActionsDrawerMenu() {
    List<PopupMenuEntry> list = [];
    double itemHeight = 35.0;
    final isTeamAdmin = widget.member.userRol == UserRol.Admin;
    final setState = PopupMenuItem(
        height: itemHeight,
        value: DrawerMenuAction.SetState,
        child: TXMenuOptionItemWidget(
            textColor: R.color.grayColor,
            icon: Icon(Icons.speaker_notes_outlined, color: R.color.grayColor),
            text: R.string.setAStatus));
    final preferences = PopupMenuItem(
        height: itemHeight,
        value: DrawerMenuAction.Preferences,
        child: TXMenuOptionItemWidget(
            textColor: R.color.grayColor,
            icon: Icon(Icons.settings_outlined, color: R.color.grayColor),
            text: R.string.preferences));
    final authenticator = PopupMenuItem(
        height: itemHeight,
        value: DrawerMenuAction.Authenticator,
        child: TXMenuOptionItemWidget(
            textColor: R.color.grayColor,
            icon: Icon(Icons.security, color: R.color.grayColor),
            text: R.string.noysiAuthenticator));
    // final downloads = PopupMenuItem(
    //     height: itemHeight,
    //     value: DrawerMenuAction.Downloads,
    //     child: TXMenuOptionItemWidget(
    //         textColor: R.color.grayColor,
    //         icon: Icon(Icons.cloud_download_outlined, color: R.color.grayColor),
    //         text: R.string.downloads));
    final help = PopupMenuItem(
        height: itemHeight,
        value: DrawerMenuAction.Help,
        child: TXMenuOptionItemWidget(
            textColor: R.color.grayColor,
            icon: Icon(Icons.help_outline_outlined, color: R.color.grayColor),
            text: R.string.help));
    // final integrations = PopupMenuItem(
    //     height: itemHeight,
    //     value: DrawerMenuAction.Integrations,
    //     child: TXMenuOptionItemWidget(
    //         textColor: R.color.grayColor,
    //         icon: Icon(Icons.add_circle_outline_outlined,
    //             color: R.color.grayColor),
    //         text: R.string.integrations));
    final editTeam = PopupMenuItem(
        height: itemHeight,
        value: DrawerMenuAction.EditTeam,
        child: TXMenuOptionItemWidget(
            textColor: R.color.grayColor,
            icon: Icon(Icons.edit_road_sharp, color: R.color.grayColor),
            text: R.string.editTeam));
    // final plans = PopupMenuItem(
    //     height: itemHeight,
    //     value: DrawerMenuAction.Preferences,
    //     child: TXMenuOptionItemWidget(
    //         textColor: R.color.grayColor,
    //         icon: Icon(Icons.money, color: R.color.grayColor),
    //         text: R.string.plans));
    final members = PopupMenuItem(
        height: itemHeight,
        value: DrawerMenuAction.Members,
        child: TXMenuOptionItemWidget(
            textColor: R.color.grayColor,
            icon: Icon(Icons.group_outlined, color: R.color.grayColor),
            text: R.string.members));
    final signOut = PopupMenuItem(
        height: itemHeight,
        value: DrawerMenuAction.Logout,
        child: TXMenuOptionItemWidget(
            textColor: Colors.red,
            icon: Icon(Icons.exit_to_app, color: Colors.red),
            text: R.string.signOut));

    list.add(PopupMenuItem(
        height: 20,
        child: TXTextWidget(
            text: R.string.general.toUpperCase(),
            fontWeight: FontWeight.bold,
            color: R.color.grayColor)));
    list.add(setState);
    list.add(preferences);
    list.add(authenticator);
    // list.add(downloads);
    list.add(help);
    list.add(PopupMenuDivider(
      height: 10,
    ));
    list.add(PopupMenuItem(
        height: 20,
        child: TXTextWidget(
            text: R.string.configuration.toUpperCase(),
            fontWeight: FontWeight.bold,
            color: R.color.grayColor)));
    // list.add(integrations);
    if (isTeamAdmin) {
      list.add(editTeam);
      //   list.add(plans);
    }
    list.add(members);
    list.add(PopupMenuDivider(
      height: 10,
    ));
    list.add(PopupMenuItem(
        height: 20,
        child: TXTextWidget(
            text: R.string.teams.toUpperCase(),
            fontWeight: FontWeight.bold,
            color: R.color.grayColor)));
    list.add(signOut);
    list.add(PopupMenuDivider(
      height: 10,
    ));
    list.add(PopupMenuItem(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 10,
        child: StreamBuilder<String>(
          stream: widget.appVersion,
          initialData: "",
          builder: (context, text) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(R.image.logoNoysiDarkBlue, width: 50),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TXTextWidget(
                      text: "v${text.data!}", color: R.color.primaryColor),
                ),
              ],
            );
          },
        )));
    return list;
  }

  List<PopupMenuItem> _popupActionsChatMenu() {
    final channel =
        widget.drawerChatList.firstWhereOrNull((element) => element.isSelected);
    final isFavorite = channel?.channelModel?.isFavorite ?? false;

    final isChannelOwner = channel?.channelModel?.uid == widget.member.id;
    final isTeamAdmin = widget.member.userRol == UserRol.Admin;
    final isGuest = widget.member.userRol == UserRol.Guest;
    final isOwner = isChannelOwner || isTeamAdmin;

    final isGeneral = channel?.channelModel?.general ?? false;

    List<PopupMenuItem> list = [];
    if (channel == null) return list;
    final seeFiles = PopupMenuItem(
      value: MenuChatAction.SeeFiles,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.folder_open, color: R.color.grayColor),
        text: R.string.seeFiles,
      ),
    );
    final addToFavorites = PopupMenuItem(
      value: MenuChatAction.AddToFavorites,
      child: TXMenuOptionItemWidget(
        icon: Icon(isFavorite ? Icons.star : Icons.star_border,
            color: (channel.channelModel?.isFavorite ?? false)
                ? Colors.orangeAccent
                : R.color.grayColor),
        text: isFavorite
            ? R.string.removeFromFavorites
            : R.string.addChannelToFavorites,
      ),
    );
    final seeLinks = PopupMenuItem(
      value: MenuChatAction.SeeLinks,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.link, color: R.color.grayColor),
        text: R.string.seeLinks,
      ),
    );
    final taskManager = PopupMenuItem(
      value: MenuChatAction.TaskManager,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.developer_board, color: R.color.grayColor),
        text: R.string.taskManager,
      ),
    );
    // final videoCall = PopupMenuItem(
    //   value: MenuChatAction.VideoCall,
    //   child: TXMenuOptionItemWidget(
    //     icon: Icon(Icons.video_call, color: R.color.grayColor),
    //     text: R.string.videoCall,
    //   ),
    // );
    final mentions = PopupMenuItem(
      value: MenuChatAction.Mentions,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.alternate_email, color: R.color.grayColor),
        text: R.string.mentions,
      ),
    );
    final invite = PopupMenuItem(
        value: MenuChatAction.InviteMember,
        child: TXMenuOptionItemWidget(
          icon: Icon(Icons.add_circle_outline, color: R.color.grayColor),
          text: R.string.inviteToGroup,
        ));
    final chatMembers = PopupMenuItem(
      value: MenuChatAction.ChannelMembers,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.group, color: R.color.grayColor),
        text: R.string.channelMembers,
      ),
    );
    // final chatInfo = PopupMenuItem(
    //   value: MenuChatAction.ChannelInfo,
    //   child: TXMenuOptionItemWidget(
    //     icon: Icon(Icons.info_outline, color: R.color.grayColor),
    //     text: R.string.channelInfo,
    //   ),
    // );
    final chatPreferences = PopupMenuItem(
      value: MenuChatAction.ChannelPreferences,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.settings_input_component_outlined,
            color: R.color.grayColor),
        text: R.string.channelPreferences,
      ),
    );
    final leaveChat = PopupMenuItem(
      value: MenuChatAction.LeaveChannel,
      child: TXMenuOptionItemWidget(
        icon: Icon(
          Icons.exit_to_app,
          color: Colors.redAccent,
        ),
        text: R.string.leaveChannel,
        textColor: Colors.redAccent,
      ),
    );
    final closeChatVisibility = PopupMenuItem(
      value: MenuChatAction.LeaveChannel1x1,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.visibility_off, color: R.color.grayColor),
        text: R.string.closeChatVisibility,
      ),
    );
    final renameChannel = PopupMenuItem(
      value: MenuChatAction.RenameChannel,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.edit, color: R.color.grayColor),
        text: R.string.rename,
      ),
    );
    final deleteChannel = PopupMenuItem(
      value: MenuChatAction.DeleteChannel,
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.delete_forever, color: R.color.grayColor),
        text: R.string.remove,
      ),
    );

    list.add(seeFiles);
    list.add(addToFavorites);
    list.add(seeLinks);
    list.add(taskManager);
    // list.add(videoCall);
    if (channel.channelModel?.isOpenChannel == true ||
        channel.channelModel?.isPrivateGroup == true) {
      list.add(mentions);
      list.add(chatMembers);

      if (channel.channelModel?.isPrivateGroup == true && !isGuest)
        list.add(invite);
    }
//    list.add(chatInfo);
    list.add(chatPreferences);

    if (isOwner && !isGeneral && !(channel.channelModel?.isM1x1 == true)) {
      list.add(renameChannel);
      list.add(deleteChannel);
    }

    if (channel.channelModel?.isM1x1 == true && !isFavorite) {
      list.add(closeChatVisibility);
    } else if (!isGeneral &&
        (channel.channelModel?.isOpenChannel == true ||
            (channel.channelModel?.isPrivateGroup == true && !isChannelOwner)))
      list.add(leaveChat);
    return list;
  }

  Widget _getDrawer() {
    return Drawer(
      child: StreamBuilder<TeamTheme>(
        initialData: R.color.defaultTheme,
        stream: teamThemeController.stream,
        builder: (context, snapshotTheme) {
          return Container(
            color: snapshotTheme.data!.colors.primaryHeaderColor,
            child: SafeArea(
              right: false,
              bottom: false,
              left: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.zero,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    shadowColor: R.color.grayDarkColor,
                    color: snapshotTheme.data!.colors.primaryHeaderColor,
                    child: TXGestureHideKeyBoard(
                        child: PopupMenuButton(
                      onSelected: (value) {
                        if (widget.onMenuDrawerTapped != null &&
                            value != null) {
                          widget.onMenuDrawerTapped!(value as DrawerMenuAction);
                        }
                      },
                      offset: Offset(0, kToolbarHeight),
                      itemBuilder: (ctx) {
                        return [..._popupActionsDrawerMenu()];
                      },
                      child: StreamBuilder<TeamModel>(
                        stream: widget.team,
                        initialData: null,
                        builder: (context, snapshotTeam) {
                          return Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 4, bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TXNetworkImage(
                                  width: 45,
                                  height: 45,
                                  forceLoad: true,
                                  imageUrl: snapshotTeam.data?.photo ?? "",
                                  placeholderImage: Image.asset(
                                    R.image.logo,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TXTextWidget(
                                        text:
                                            snapshotTeam.data?.titleFixed ?? "",
                                        color: snapshotTheme
                                            .data!.colors.textColor,
                                        size: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          TXUserPresenceWidget(
                                            userPresence: UserPresence.online,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Flexible(
                                              child: TXTextWidget(
                                            text:
                                                "@${CommonUtils.getMemberUsername(widget.member)}",
                                            color: snapshotTheme
                                                .data!.colors.subtextColor,
                                            textOverflow: TextOverflow.ellipsis,
                                          )),
                                          !(widget.member.statusIcon.isEmpty ==
                                                  true)
                                              ? InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(45),
                                                  onTap: !(widget
                                                              .member
                                                              .statusText
                                                              .isEmpty ==
                                                          true)
                                                      ? () {
                                                          Fluttertoast.showToast(
                                                              msg: TextUtilsParser
                                                                  .emojiParser(widget
                                                                      .member
                                                                      .statusText));
                                                        }
                                                      : null,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2),
                                                    child: TXTextWidget(
                                                      text: widget
                                                              .member
                                                              .statusIcon
                                                              .isEmpty
                                                          ? ""
                                                          : TextUtilsParser
                                                              .emojiParserFromHex(
                                                                  widget.member
                                                                      .statusIcon
                                                                      .split(
                                                                          '-')),
                                                      // fontFamily: "EmojiOne",
                                                      size: 20,
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                TXIconButtonWidget(
                                  icon: Icon(
                                    Icons.settings_outlined,
                                    color: snapshotTheme.data!.colors.textColor,
                                  ),
                                  // onPressed: () async {
                                  //   NavigationUtils.push(
                                  //       context,
                                  //       ProfilePage(
                                  //         memberModel: widget.member,
                                  //       ));
                                  // },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )),
                  ),
                  Expanded(
                    child: Container(
                      color: snapshotTheme.data!.colors.sidebarColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              color: snapshotTheme
                                  .data!.colors.secondaryHeaderColor,
                              width: 70,
                              child: _getHomeDrawerActionButtons(
                                  snapshotTheme.data!.colors),
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder<DrawerConfig>(
                              stream: widget.drawerConfig,
                              initialData: null,
                              builder: (context, snapshotDrawerConfig) => _getDrawerChatListWidget(
                                  snapshotTheme.data!.colors, snapshotDrawerConfig.data),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getDrawerChatListWidget(TeamColors colors, DrawerConfig? drawerConfig) {
    if (widget.drawerChatList.isEmpty || drawerConfig == null) return Container();
    List<Widget> list = [];
    DrawerChatWrapper orderedList = _getSortedList(widget.drawerChatList);
    if (orderedList.threads != null) {
      list.add(TXGestureHideKeyBoard(
          child: TXDrawerChatItemWidget(
        drawerChatModel: orderedList.threads!,
        onTap: () {
          widget.onDrawerChatTap(orderedList.threads!);
        },
      )));
    }
    if(orderedList.favorites != null) {
      list.add(TXGestureHideKeyBoard(
        child: TXAnimatedExpansionTile(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8)
              .copyWith(top: 20),
          initiallyExpanded: drawerConfig.favoritesExpanded,
          onExpansionChanged: (value) {
            drawerConfig.favoritesExpanded = value;
            widget.onDrawerConfigChanged(drawerConfig);
          },
          chevronPadding: const EdgeInsets.only(right: 3, left: 5),
          chevronColor: colors.textColor,
          expandedBottomContainerBorder: false,
          bottomParentContainerBorder: false,
          topParentContainerBorder: false,
          title: TXDrawerChatItemWidget(
            drawerChatModel: orderedList.favorites!.keys.first,
          ),
          children: [
            ...orderedList.favorites!.values.first.map((e) => TXGestureHideKeyBoard(
              child: TXDrawerChatItemWidget(
                  drawerChatModel: e,
                  onTap: () {
                    widget.onDrawerChatTap(e);
                  }),
            )),
          ],
        ),
      ));
    }
    list.add(TXGestureHideKeyBoard(
      child: TXAnimatedExpansionTile(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8)
            .copyWith(top: 20),
        initiallyExpanded: drawerConfig.channelExpanded,
        onExpansionChanged: (value) {
          drawerConfig.channelExpanded = value;
          widget.onDrawerConfigChanged(drawerConfig);
        },
        chevronPadding: const EdgeInsets.only(right: 3, left: 5),
        chevronColor: colors.textColor,
        expandedBottomContainerBorder: false,
        bottomParentContainerBorder: false,
        topParentContainerBorder: false,
        title: TXDrawerChatItemWidget(
          drawerChatModel: orderedList.channels.keys.first,
          onTap: () {
            widget.onDrawerChatTap(orderedList.channels.keys.first);
          },
        ),
        children: [
          ...orderedList.channels.values.first.map((e) => TXGestureHideKeyBoard(
                child: TXDrawerChatItemWidget(
                    drawerChatModel: e,
                    onTap: () {
                      widget.onDrawerChatTap(e);
                    }),
              )),
          _getAddNewChannelWidget(
              orderedList.channels.keys.first, colors.textColor)
        ],
      ),
    ));
    list.add(TXGestureHideKeyBoard(
      child: TXAnimatedExpansionTile(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8)
            .copyWith(top: 20),
        initiallyExpanded: drawerConfig.imsExpanded,
        onExpansionChanged: (value) {
          drawerConfig.imsExpanded = value;
          widget.onDrawerConfigChanged(drawerConfig);
        },
        chevronPadding: const EdgeInsets.only(right: 3, left: 5),
        chevronColor: colors.textColor,
        expandedBottomContainerBorder: false,
        bottomParentContainerBorder: false,
        topParentContainerBorder: false,
        title: TXDrawerChatItemWidget(
          drawerChatModel: orderedList.ims.keys.first,
          onTap: () {
            widget.onDrawerChatTap(orderedList.ims.keys.first);
          },
        ),
        children: [
          ...orderedList.ims.values.first.map((e) => TXGestureHideKeyBoard(
            child: TXDrawerChatItemWidget(
                drawerChatModel: e,
                onTap: () {
                  widget.onDrawerChatTap(e);
                }),
          )),
          _getAddNewChannelWidget(
              orderedList.ims.keys.first, colors.textColor)
        ],
      ),
    ));
    list.add(TXGestureHideKeyBoard(
      child: TXAnimatedExpansionTile(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8)
            .copyWith(top: 20),
        initiallyExpanded: drawerConfig.groupsExpanded,
        onExpansionChanged: (value) {
          drawerConfig.groupsExpanded = value;
          widget.onDrawerConfigChanged(drawerConfig);
        },
        chevronPadding: const EdgeInsets.only(right: 3, left: 5),
        chevronColor: colors.textColor,
        expandedBottomContainerBorder: false,
        bottomParentContainerBorder: false,
        topParentContainerBorder: false,
        title: TXDrawerChatItemWidget(
          drawerChatModel: orderedList.groups.keys.first,
          onTap: () {
            widget.onDrawerChatTap(orderedList.groups.keys.first);
          },
        ),
        children: [
          ...orderedList.groups.values.first.map((e) => TXGestureHideKeyBoard(
            child: TXDrawerChatItemWidget(
                drawerChatModel: e,
                onTap: () {
                  widget.onDrawerChatTap(e);
                }),
          )),
          _getAddNewChannelWidget(
              orderedList.groups.keys.first, colors.textColor)
        ],
      ),
    ));
    // orderedList.forEach((element) {
    //   final w = TXDrawerChatItemWidget(
    //     drawerChatModel: element,
    //     onTap: () {
    //       widget.onDrawerChatTap(element);
    //     },
    //   );
    //   list.add(TXGestureHideKeyBoard(child: w));
    // });
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 30),
      itemBuilder: (context, index) {
        return list[index];
      },
      itemCount: list.length,
    );
  }

  Widget _getAddNewChannelWidget(DrawerChatModel model, Color? color) {
    return TXGestureHideKeyBoard(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        onTap: () {
          widget.onAddChatTap(model);
        },
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 5),
          child: Row(
            children: [
              Icon(
                model.drawerHeaderChatType == DrawerHeaderChatType.Channel ||
                        model.drawerHeaderChatType ==
                            DrawerHeaderChatType.PrivateGroup
                    ? Icons.add
                    : Icons.search,
                size: 20,
                color: color,
              ),
              const SizedBox(width: 5),
              Expanded(
                  child: TXTextWidget(
                text: model.drawerHeaderChatType == DrawerHeaderChatType.Channel
                    ? R.string.addChannel
                    : model.drawerHeaderChatType ==
                            DrawerHeaderChatType.PrivateGroup
                        ? R.string.addPrivateGroup
                        : R.string.searchUsers,
                color: color,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHomeDrawerActionButtons(TeamColors themeColor) {
    bool hideInviteOption = inMemoryData.currentTeam?.expired == true ||
        (inMemoryData.currentTeam?.onlyAdminInvitesAllowed == true &&
            inMemoryData.currentMember?.userRol != UserRol.Admin);
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  TXHomeMenuIconWidget(
                    text: R.string.activityZone,
                    icon: Image.asset(
                      R.image.activityZoneDrawer,
                      height: 22,
                      width: 22,
                      color: themeColor.textColor,
                    ),
                    // icon: Icon(
                    //   Icons.receipt_long,
                    //   color: R.color.grayLightestColor,
                    // ),
                    isSelected: false,
                    iconMargin: EdgeInsets.only(left: 2),
                    onTap: () {
                      NavigationUtils.pop(context);
                      widget.onNavigationOptionTap(
                          DrawerNavigationOption.ActivityLog);
                    },
                  ),
                  TXHomeMenuIconWidget(
                    text: R.string.chat,
                    icon: Icon(
                      Icons.chat,
                      color: themeColor.activeItemText,
                    ),
                    isSelected: true,
                  ),
                  TXHomeMenuIconWidget(
                    text: R.string.myFiles,
                    icon: Icon(
                      Icons.folder_open,
                      color: themeColor.textColor,
                    ),
                    isSelected: false,
                    onTap: () {
                      NavigationUtils.pop(context);
                      widget.onNavigationOptionTap(
                          DrawerNavigationOption.MyFiles);
                    },
                  ),
                  TXHomeMenuIconWidget(
                    unread: widget.openTasks,
                    text: R.string.myTasks,
                    icon: Icon(
                      Icons.developer_board,
                      color: themeColor.textColor,
                    ),
                    isSelected: false,
                    onTap: () {
                      NavigationUtils.pop(context);
                      widget.onNavigationOptionTap(
                          DrawerNavigationOption.MyTasks);
                    },
                  ),
                  // TXHomeMenuIconWidget(
                  //   text: R.string.meeting,
                  //   icon: Image.asset(
                  //     R.image.meetingDrawer,
                  //     height: 22,
                  //     width: 22,
                  //     color: R.color.grayLightestColor,
                  //   ),
                  //   isSelected: false,
                  //   iconMargin: EdgeInsets.only(right: 2),
                  //   onTap: () {
                  //     NavigationUtils.pop(context);
                  //     widget.onNavigationOptionTap(DrawerNavigationOption.Meeting);
                  //   },
                  // ),
                  TXHomeMenuIconWidget(
                    text: R.string.calendar,
                    unread: widget.unreadCalendar,
                    icon: Icon(
                      Icons.calendar_today,
                      color: themeColor.textColor,
                    ),
                    isSelected: false,
                    onTap: () {
                      NavigationUtils.pop(context);
                      widget.onNavigationOptionTap(
                          DrawerNavigationOption.Calendar);
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  hideInviteOption
                      ? Container()
                      : TXHomeMenuIconWidget(
                          text: R.string.inviteMorPeople,
                          icon: Icon(
                            Icons.group_add,
                            color: themeColor.textColor,
                          ),
                          isSelected: false,
                          onTap: () {
                            NavigationUtils.pop(context);
                            widget.onNavigationOptionTap(
                                DrawerNavigationOption.InvitePeople);
                          },
                        ),
                  TXHomeMenuIconWidget(
                    text: R.string.myTeams,
                    icon: Icon(
                      Icons.language,
                      color: themeColor.textColor,
                    ),
                    isSelected: false,
                    unread: widget.unreadTeams,
                    onTap: () {
                      NavigationUtils.pop(context);
                      widget.onNavigationOptionTap(
                          DrawerNavigationOption.MyTeams);
                    },
                  ),
                ],
              ),
            )),
      );
    });
  }

  _getTitle() {
    final channel =
        widget.drawerChatList.firstWhereOrNull((element) => element.isSelected);
    final ism1x1 = channel?.channelModel?.isM1x1 == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ism1x1
                ? Container(
                    margin: EdgeInsets.only(right: 5),
                    child: TXUserPresenceWidget(
                      userPresence: channel?.memberModel?.userPresence ??
                          UserPresence.out,
                      isUserEnabled: (channel?.memberModel?.active ?? false) && channel?.memberModel?.isDeletedUser == false,
                    ),
                  )
                : Container(),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: StreamBuilder<TeamModel>(
                  initialData: null,
                  stream: widget.team,
                  builder: (context, snapshotTeam) {
                    return StreamBuilder<TeamTheme>(
                      stream: teamThemeController.stream,
                      builder: (context, snapshotTheme) {
                        return TXTextWidget(
                          text: ism1x1
                              ? "@${CommonUtils.getMemberUsername(channel?.memberModel)}"
                              : channel?.channelModel?.titleFixed
                                      .trim()
                                      .toLowerCase() ??
                                  (snapshotTeam.data?.titleFixed
                                          .toCapitalize() ??
                                      ""),
                          color:
                              teamThemeController.valueOrNull?.colors.textColor,
                          size: 20,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
        userTyping.isNotEmpty
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  TXTextWidget(
                    size: 10,
                    text: "$userTyping ${R.string.isTyping}",
                  )
                ],
              )
            : Container()
      ],
    );
  }

  DrawerChatWrapper _getSortedList(List<DrawerChatModel> list) {
    //List<DrawerChatModel> orderedList = [];

    ///Thread section
    // final threads = list
    //     .where((element) =>
    //         element.drawerHeaderChatType == DrawerHeaderChatType.Thread &&
    //         element.isChild)
    //     .toList();
    //
    // final threadsHeader = list.firstWhere(
    //         (element) =>
    //     element.drawerHeaderChatType == DrawerHeaderChatType.Thread &&
    //         !element.isChild, orElse: () {
    //   return null;
    // });
    //
    // if(threads.length > 1){
    //   threads.sort((c1, c2) {
    //     if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
    //       return -1;
    //     else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
    //       return c1.title.toLowerCase().compareTo(c2.title.toLowerCase());
    //     else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
    //       return 1;
    //     else
    //       return c1.title.toLowerCase().compareTo(c2.title.toLowerCase());
    //   });
    // }
    //
    // if(threadsHeader != null) orderedList.add(threadsHeader);
    //
    // orderedList.addAll(threads);

    final favHeader = list.firstWhereOrNull((element) =>
        element.drawerHeaderChatType == DrawerHeaderChatType.Favorite);

    ///Favorites section
    final favorites = list
        .where((element) =>
            element.channelModel?.isFavorite == true &&
            (element.channelModel?.isM1x1 == true ||
                element.channelModel?.isOpenChannel == true ||
                element.channelModel?.isPrivateGroup == true))
        .toList();

    ///removing duplicate favorites
    final idsFav = favorites.map((e) => e.channelModel!.id).toSet();
    favorites.retainWhere((x) => idsFav.remove(x.channelModel!.id));

    final favoritesM1x1 = favorites
        .where((element) =>
            element.channelModel?.isFavorite == true &&
            element.channelModel?.isM1x1 == true)
        .toList();

    final favoritesOpenChannels = favorites
        .where((element) =>
            element.channelModel?.isFavorite == true &&
            element.channelModel?.isOpenChannel == true)
        .toList();

    final favoritesPrivateGroups = favorites
        .where((element) =>
            element.channelModel?.isFavorite == true &&
            element.channelModel?.isPrivateGroup == true)
        .toList();

    if (favorites.isNotEmpty) {
      // orderedList.add(DrawerChatModel(
      //   drawerHeaderChatType: DrawerHeaderChatType.Favorite,
      //   isChild: false,
      //   title: R.string.favorites.toLowerCase(),
      //   childrenCount: favorites.length,
      // ));

      List<DrawerChatModel> favoritesOnline = favoritesM1x1
          .where((element) =>
              element.memberModel?.userPresence == UserPresence.online &&
              element.memberModel?.active == true)
          .toList();
      List<DrawerChatModel> favoritesIdle = favoritesM1x1
          .where((element) =>
              element.memberModel?.userPresence == UserPresence.out &&
              element.memberModel?.active == true)
          .toList();
      List<DrawerChatModel> favoritesOffline = favoritesM1x1
          .where((element) =>
              element.memberModel?.userPresence == UserPresence.offline &&
              element.memberModel?.active == true)
          .toList();
      List<DrawerChatModel> favoritesDisabled = favoritesM1x1
          .where((element) => !(element.memberModel?.active == true))
          .toList();

      if (favoritesOnline.length > 1) {
        favoritesOnline.sort((c1, c2) {
          if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
            return -1;
          else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
            return c1.memberModel!.profile!.name
                .toLowerCase()
                .trim()
                .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
          else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
            return 1;
          else
            return c1.memberModel!.profile!.name
                .toLowerCase()
                .trim()
                .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
        });
      }

      if (favoritesIdle.length > 1) {
        favoritesIdle.sort((c1, c2) {
          if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
            return -1;
          else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
            return c1.memberModel!.profile!.name
                .toLowerCase()
                .trim()
                .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
          else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
            return 1;
          else
            return c1.memberModel!.profile!.name
                .toLowerCase()
                .trim()
                .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
        });
      }

      if (favoritesOffline.length > 1) {
        favoritesOffline.sort((c1, c2) {
          if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
            return -1;
          else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
            return c1.memberModel!.profile!.name
                .toLowerCase()
                .trim()
                .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
          else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
            return 1;
          else
            return c1.memberModel!.profile!.name
                .toLowerCase()
                .trim()
                .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
        });
      }

      if (favoritesDisabled.length > 1) {
        favoritesDisabled.sort((c1, c2) {
          if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
            return -1;
          else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
            return c1.memberModel!.profile!.name
                .toLowerCase()
                .trim()
                .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
          else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
            return 1;
          else
            return c1.memberModel!.profile!.name
                .toLowerCase()
                .trim()
                .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
        });
      }

      if (favoritesOpenChannels.length > 1) {
        favoritesOpenChannels.sort((c1, c2) {
          if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
            return -1;
          else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
            return c1.title
                .toLowerCase()
                .trim()
                .compareTo(c2.title.toLowerCase().trim());
          else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
            return 1;
          else
            return c1.title
                .toLowerCase()
                .trim()
                .compareTo(c2.title.toLowerCase().trim());
        });
      }

      if (favoritesPrivateGroups.length > 1) {
        favoritesPrivateGroups.sort((c1, c2) {
          if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
            return -1;
          else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
            return c1.title
                .toLowerCase()
                .trim()
                .compareTo(c2.title.toLowerCase().trim());
          else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
            return 1;
          else
            return c1.title
                .toLowerCase()
                .trim()
                .compareTo(c2.title.toLowerCase().trim());
        });
      }
      favorites.clear();
      favorites.addAll(favoritesOnline);
      favorites.addAll(favoritesIdle);
      favorites.addAll(favoritesOffline);
      favorites.addAll(favoritesDisabled);

      favorites.addAll(favoritesOpenChannels);
      favorites.addAll(favoritesPrivateGroups);
    }

    ///Channels section
    final channels = list
        .where((element) =>
            element.drawerHeaderChatType == DrawerHeaderChatType.Channel &&
            (element.channelModel?.isFavorite ?? false) == false &&
            element.isChild)
        .toList();

    ///removing duplicate channels
    final idsChannels = channels.map((e) => e.channelModel!.id).toSet();
    channels.retainWhere((x) => idsChannels.remove(x.channelModel!.id));

    final channelsHeader = list.firstWhere((element) =>
        element.drawerHeaderChatType == DrawerHeaderChatType.Channel &&
        !element.isChild);

    if (channels.length > 1) {
      channels.sort((c1, c2) {
        if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
          return -1;
        else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
          return c1.title
              .toLowerCase()
              .trim()
              .compareTo(c2.title.toLowerCase().trim());
        else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
          return 1;
        else
          return c1.title
              .toLowerCase()
              .trim()
              .compareTo(c2.title.toLowerCase().trim());
      });
    }

    ///Messages 1x1 section
    final directChat = list
        .where((element) =>
            element.drawerHeaderChatType == DrawerHeaderChatType.Message1x1 &&
            (element.channelModel?.isFavorite ?? false) == false &&
            element.isChild)
        .toList();

    ///removing duplicate ims
    final idsIms = directChat.map((e) => e.channelModel!.id).toSet();
    directChat.retainWhere((x) => idsIms.remove(x.channelModel!.id));

    final directChatHeader = list.firstWhere((element) =>
        element.drawerHeaderChatType == DrawerHeaderChatType.Message1x1 &&
        !element.isChild);
    final directChatOnline = directChat
        .where((element) =>
            element.memberModel?.userPresence == UserPresence.online &&
            element.memberModel?.active == true)
        .toList();
    final directChatOffline = directChat
        .where((element) =>
            element.memberModel?.userPresence == UserPresence.offline &&
            element.memberModel?.active == true)
        .toList();
    final directChatIdle = directChat
        .where((element) =>
            element.memberModel?.userPresence == UserPresence.out &&
            element.memberModel?.active == true)
        .toList();
    final directChatDisabled = directChat
        .where((element) => (element.memberModel?.active ?? false) == false)
        .toList();

    if (directChatOnline.length > 1) {
      directChatOnline.sort((c1, c2) {
        if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
          return -1;
        else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
          return c1.memberModel!.profile!.name
              .toLowerCase()
              .trim()
              .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
        else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
          return 1;
        else
          return c1.memberModel!.profile!.name
              .toLowerCase()
              .trim()
              .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
      });
    }

    if (directChatIdle.length > 1) {
      directChatIdle.sort((c1, c2) {
        if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
          return -1;
        else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
          return c1.memberModel!.profile!.name
              .toLowerCase()
              .trim()
              .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
        else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
          return 1;
        else
          return c1.memberModel!.profile!.name
              .toLowerCase()
              .trim()
              .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
      });
    }

    if (directChatOffline.length > 1) {
      directChatOffline.sort((c1, c2) {
        if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
          return -1;
        else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
          return c1.memberModel!.profile!.name
              .toLowerCase()
              .trim()
              .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
        else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
          return 1;
        else
          return c1.memberModel!.profile!.name
              .toLowerCase()
              .trim()
              .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
      });
    }

    if (directChatDisabled.length > 1) {
      directChatDisabled.sort((c1, c2) {
        if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
          return -1;
        else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
          return c1.memberModel!.profile!.name
              .toLowerCase()
              .trim()
              .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
        else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
          return 1;
        else
          return c1.memberModel!.profile!.name
              .toLowerCase()
              .trim()
              .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim());
      });
    }
    directChat.clear();
    directChat.addAll(directChatOnline);
    directChat.addAll(directChatIdle);
    directChat.addAll(directChatOffline);
    directChat.addAll(directChatDisabled);

    ///Private groups section
    final privateGroup = list
        .where((element) =>
            element.drawerHeaderChatType == DrawerHeaderChatType.PrivateGroup &&
            (element.channelModel?.isFavorite ?? false) == false &&
            element.isChild)
        .toList();

    ///removing duplicate PG
    final idsPg = privateGroup.map((e) => e.channelModel!.id).toSet();
    privateGroup.retainWhere((x) => idsPg.remove(x.channelModel!.id));

    final privateGroupHeader = list.firstWhere((element) =>
        element.drawerHeaderChatType == DrawerHeaderChatType.PrivateGroup &&
        !element.isChild);

    if (privateGroup.length > 1) {
      privateGroup.sort((c1, c2) {
        if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount == 0)
          return -1;
        else if (c1.unreadMessagesCount > 0 && c2.unreadMessagesCount > 0)
          return c1.title
              .toLowerCase()
              .trim()
              .compareTo(c2.title.toLowerCase().trim());
        else if (c1.unreadMessagesCount == 0 && c2.unreadMessagesCount > 0)
          return 1;
        else
          return c1.title
              .toLowerCase()
              .trim()
              .compareTo(c2.title.toLowerCase().trim());
      });
    }

    return DrawerChatWrapper(
        channels: {channelsHeader: channels},
        ims: {directChatHeader: directChat},
        groups: {privateGroupHeader: privateGroup},
        threads: list.firstWhereOrNull((element) =>
            element.drawerHeaderChatType == DrawerHeaderChatType.Thread),
        favorites: favHeader != null && favorites.isNotEmpty
            ? {favHeader: favorites}
            : null);
  }
}

class DrawerChatWrapper {
  Map<DrawerChatModel, List<DrawerChatModel>>? favorites;
  Map<DrawerChatModel, List<DrawerChatModel>> channels;
  Map<DrawerChatModel, List<DrawerChatModel>> ims;
  Map<DrawerChatModel, List<DrawerChatModel>> groups;
  DrawerChatModel? threads;

  DrawerChatWrapper(
      {required this.channels,
      required this.ims,
      required this.groups,
      required this.threads,
      this.favorites});
}

class DrawerConfig {
  bool favoritesExpanded, imsExpanded, groupsExpanded, channelExpanded;

  DrawerConfig({this.favoritesExpanded = true, this.imsExpanded = true, this.groupsExpanded = true, this.channelExpanded = true});
}
