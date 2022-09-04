import 'dart:async';
import 'dart:io';
import 'package:code/fcm/fcm_message_model.dart';
import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/app_common_model.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/meet/meeting_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/thread/thread_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/rtc/rtc_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_base/richtext_widgets/tx_user_date_message_widget.dart';
import 'package:code/ui/_tx_widget/TXAudioPlayer/tx_audio_player_widget.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_measure_child_size.dart';
import 'package:code/ui/_tx_widget/tx_video_player.dart';
import 'package:code/ui/activity_zone/activity_zone_page.dart';
import 'package:code/ui/calendar/calendar_page.dart';
import 'package:code/ui/channel_rename/channel_rename_page.dart';
import 'package:code/ui/chat_text_widget/tx_chat_text_input_widget.dart';
import 'package:code/ui/_tx_widget/tx_message_body_widget.dart';
import 'package:code/ui/_tx_widget/tx_reactions_all_message_widget.dart';
import 'package:code/ui/_tx_widget/tx_reactions_widget.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/channel/channel_page.dart';
import 'package:code/ui/channel_preferences/channel_preferences_page.dart';
import 'package:code/ui/edit_message/edit_message_page.dart';
import 'package:code/ui/edit_team/edit_team_page.dart';
import 'package:code/ui/files_explorer/files_explorer_page.dart';
import 'package:code/ui/favorites/favorites_page.dart';
import 'package:code/ui/home/home_bloc.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/home/share_external_widget.dart';
import 'package:code/ui/home/tx_folder_notification_widget.dart';
import 'package:code/ui/home/tx_adaptive_card_widget.dart';
import 'package:code/ui/home/tx_home_app_bar_widget.dart';
import 'package:code/ui/home/tx_pinned_message.dart';
import 'package:code/ui/home/tx_task_notification_widget.dart';
import 'package:code/ui/invite/invite_page.dart';
import 'package:code/ui/link/link_page.dart';
import 'package:code/ui/login/login_page.dart';
import 'package:code/ui/mention/mention_page.dart';
import 'package:code/ui/message_comments/message_comments_page.dart';
import 'package:code/ui/private_group/private_group_page.dart';
import 'package:code/ui/profile/profile_page.dart';
import 'package:code/ui/search_global/search_global_page.dart';
import 'package:code/ui/search_user/search_user_page.dart';
import 'package:code/ui/share/share_file_page.dart';
import 'package:code/ui/splash/splash_page.dart';
import 'package:code/ui/task/task_page.dart';
import 'package:code/ui/team/team_page.dart';
import 'package:code/ui/thread/thread_page.dart';
import 'package:code/ui/thread_type_page/thread_type_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'dart:math' as math;
import 'package:code/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../fcm/fcm_controller.dart';
import '../../utils/text_parser_utils.dart';
import '../authenticator/authenticator_page.dart';
import '../channel_create/channel_create_page.dart';
import '../private_group_create/private_group_create_page.dart';

class HomePage extends StatefulWidget {
  final String sharingExternalContent;

  const HomePage({Key? key, this.sharingExternalContent = ""})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends StateWithBloC<HomePage, HomeBloC>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  late AnimationController _animationController;
  GlobalKey teamsPageKey = new GlobalKey();
  GlobalKey<ScaffoldState> homeAppBarKeyScaffoldState = GlobalKey();

  StreamSubscription? _webRtcListenerSubscription;
  StreamSubscription? _sharingContentSubscription;
  StreamSubscription? _appLinksContentSubscription;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed &&
        !bloc.socketInitialized &&
        (await bloc.getCurrentTeamId).isNotEmpty) {
      bloc.loadData(fromInit: true);
    } else if (state == AppLifecycleState.resumed) {
      bloc.sendUserPresence(UserPresence.online);
    } else if (state == AppLifecycleState.detached) {
      bloc.sendUserPresence(UserPresence.offline);
    } else if (state == AppLifecycleState.inactive ||
        (state == AppLifecycleState.paused && currentMeeting != null)) {
      bloc.sendUserPresence(UserPresence.out);
    } else {
      bloc.disposeOnBackground();
    }
  }

  String _validatePathForShareExt(String path) {
    // if (File(path).existsSync()) return path;
    // final split = dartPath.extension(path, 2).split('.');
    // if (split.length > 1 && split.last == split[split.length - 2]) {
    //   final parts = path.split('.');
    //   parts.removeLast();
    //   return parts.join('.');
    // }
    return Uri.decodeFull(path.replaceFirst("file://", ''));
  }

  @override
  void initState() {
    super.initState();
    bloc.initResult.listen((event) {
      if (event == 0) {
        NavigationUtils.pushReplacement(context, SplashPage());
      } else if (event == 1) {
        NavigationUtils.pushReplacement(context, LoginPage());
      }
    });
    // absorbPointerAppController.listen((value) {
    //   isAbsorbingTree = value ?? false;
    //   setState(() {});
    // });
    jitsiListeners = JitsiMeetingListener(
      onConferenceJoined: (String? message) {
        callStatusController.sinkAddSafe(call_status.in_call);
      },
      onClosed: () {
        absorbPointerAppController.sinkAddSafe(false);
        callStatusController.sinkAddSafe(call_status.none);
        if (currentMeeting != null &&
            currentMeeting!.is1x1 &&
            currentMeeting!.tid.isNotEmpty &&
            currentMeeting!.cid.isNotEmpty) {
          bloc.sendRejectCall(currentMeeting!.tid, currentMeeting!.cid);
        }
        currentMeeting = null;
        if (!InMemoryData.isInForeground) {
          bloc.disposeOnBackground();
        }
      },
    );
    _webRtcListenerSubscription = onWebRTCEventController.listen((value) async {
      if (value.action == CALL_ACTION.HANG_DOWN) {
        if ((callStatusController.value) == call_status.calling_me) {
          bloc.onCallingMeCancelled();
        } else {
          final tid = await bloc.getCurrentTeamId;
          final cid = bloc.inMemoryData.currentChannel?.id;
          if (currentMeeting != null &&
              currentMeeting!.tid == tid &&
              currentMeeting!.cid == cid) {
            //JitsiMeet.closeMeeting();
          }
        }
      } else if (value.action == CALL_ACTION.CALL &&
          (callStatusController.value) == call_status.none &&
          InMemoryData.isInForeground &&
          value.uid != bloc.inMemoryData.currentMember?.id) {
        bloc.onCallingMe(value.tid, value.cid, value.uid);
      }
    });
    _appLinksContentSubscription =
        appLinksContentController.listen((AppLinksNavigationModel? model) {
      if (model != null) {
        bloc.processNavigationFromLink(model);
        appLinksContentController.sinkAddSafe(null);
      }
    });
    _sharingContentSubscription = sharingContentController
        .listen((ShareContentModel? shareContentModel) async {
      if (shareContentModel != null) {
        if (shareContentModel.isFile) {
          shareContentModel.content =
              _validatePathForShareExt(shareContentModel.content);
        }
        Uri? uri = Uri.tryParse(shareContentModel.content.trim());
        if (!Platform.isAndroid ||
            (uri == null ||
                (!uri.host.contains("meet.noysi.com") &&
                    !uri.host.contains("dev-meet.noysi.com") &&
                    !uri.host.contains("pre-meet.noysi.com")))) {
          showShareContentView(shareContentModel);
        }
        sharingContentController.sinkAddSafe(null);
        ReceiveSharingIntent.reset();
      }
    });
    bloc.userDisabledController.listen((value) async {
      await NavigationUtils.popUntilWithRouteAndMaterial(
          context, NavigationUtils.HomeRoute);
      NavigationUtils.pushNamed(context, NavigationUtils.TeamsRoute,
              arguments: TeamPageArguments(
                  memberDisabledEnabledModel: value, key: teamsPageKey))
          .then((res) {
        if (res is TeamModel) {
          bloc.changeTeam(res);
        } else if (res is bool && res) {
          NavigationUtils.pushReplacement(context, LoginPage());
        }
      });
    });
    onUserDeleted.listen((value) async {
      if(value.uid == Injector.instance.inMemoryData.currentMember?.id) {
        await bloc.logout(callApi: false, showLoading: false, cleanMail: true);
        await NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
        NavigationUtils.pushReplacement(context, LoginPage());
      } else {
        bloc.doOnUserDeleted(value.tid, value.uid);
      }
    });
    selectNotificationSubject.listen((payload) {
      if (payload.payload.action == fcmMessageActions.MESSAGE) {
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
      }
      bloc.resolveNavigationOnFCMNotiArrive(payload);
    });
    onWSSReconnected.listen((value) {
      if (value) {
        Future.delayed(Duration(milliseconds: 400), () {
          bloc.reloadDataOnWSSReconnected();
        });
      }
    });
    onStatusSet.listen((value) {
      bloc.onStatusSet(value);
    });
    onTeamUpdatedController.listen((value) {
      bloc.onTeamUpdated(value);
    });
    changeChannelAutoController.listen((channel) {
      bloc.changeChannelAuto(channel);
    });
    onMessageReceivedController.listen((message) {
      bloc.onMessageArrived(message);
    });
    onChannelMarked.listen((value) {
      bloc.onChannelMarked(value);
    });
    onChannelRenamed.listen((value) {
      bloc.onChannelRenamed(value);
    });
    onChannelOpened.listen((value) {
      bloc.doOnChannelOpened(value);
    });
    onChannelCreated.listen((value) {
      bloc.doOnChannelCreated(value);
    });
    onMemberProfileUpdatedController.listen((value) {
      bloc.onMemberProfileUpdated(value);
    });
    onChannelNotificationsUpdated.listen((value) {
      bloc.onChannelNotificationUpdated(value);
    });
    onMemberNotificationsUpdated.listen((value) {
      bloc.onMemberNotificationsUpdated(value);
    });
    onMemberRoleUpdated.listen((value) {
      bloc.onMemberRoleUpdated(value);
    });
    onTeamDisabled.listen((value) {
      final isInTeamsPage = teamsPageKey.currentContext != null &&
          ModalRoute.of(teamsPageKey.currentContext!)?.settings.name ==
              NavigationUtils.TeamsRoute;
      bloc.onTeamDisabled(value, isInTeamsPage: isInTeamsPage);
    });
    onChannelLeftDeleted.listen((value) {
      if (value.deleted) {
        bloc.onChannelDeleted(value.tid, value.cid);
      } else if (value.closed) {
        bloc.onChannelClosed(value.tid, value.cid);
      } else {
        bloc.onChannelLeft(value.tid, value.cid, value.uid);
      }
    });
    onTaskCreatedUpdated.listen((value) {
      bloc.resolveOpenTasksCount();
      bloc.checkUnreadCalendar();
    });

    onTaskEventMarked.listen((value) {
      bloc.checkUnreadCalendar();
    });

    onMessageDeletedController.listen((messageDeleted) {
      bloc.onMessageDeleted(messageDeleted);
    });

    onUserPresenceChangeController.listen((value) {
      bloc.onUserPresenceChange(value);
    });

    onFolderDeletedController.listen((value) {
      if (value != null) {
        bloc.onFolderDeleted(value);
      }
    });

    onFolderRenamedController.listen((value) {
      if (value != null) {
        bloc.onFolderRenamed(value);
      }
    });

    onTeamThemeUpdatedController.listen((value) {
      bloc.onTeamThemeUpdated(value);
    });

    onTeamPhotoUpdatedController.listen((value) {
      bloc.onTeamPhotoUpdated(value);
    });

    onMemberDisabledEnabled.listen((value) {
      if (value != null) {
        final isInTeamsPage = teamsPageKey.currentContext != null &&
            ModalRoute.of(teamsPageKey.currentContext!)?.settings.name ==
                NavigationUtils.TeamsRoute;
        bloc.doOnMemberDisabledEnabled(value, isInTeamsPage: isInTeamsPage);
      }
    });

    onMessagePinnedUnpinned.listen((value) {
      bloc.onMessagePinnedUnpinned(value);
    });

    bloc.reverseFloatingButton.listen((value) {
      if (value) _animationController.reverse();
    });
    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 0, // initially visible
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <
              _scrollController.position.minScrollExtent + 50 &&
          !bloc.isNotInLastMessages) {
        _animationController.reverse();
      } else if (_scrollController.position.pixels >=
              _scrollController.position.minScrollExtent + 50 ||
          bloc.isNotInLastMessages) {
        _animationController.forward();
      }
    });
    bloc.refreshScroll.listen((value) {
      if (value) {
        _animationController.forward();
      }
    });
    bloc.messageArrivedForThisChannel.listen((value) {
      if ((value) &&
          _scrollController.hasClients &&
          _scrollController.position.pixels <
              _scrollController.position.minScrollExtent + 50) {
        final isNotInLastMessage = bloc.isNotInLastMessages;
        bloc.restoreLastMessages();
        if (_scrollController.hasClients && !isNotInLastMessage) {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        }
      }
    });
    WidgetsBinding.instance.addObserver(this);
    bloc.init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _animationController.dispose();
    _webRtcListenerSubscription?.cancel();
    _sharingContentSubscription?.cancel();
    _appLinksContentSubscription?.cancel();
    super.dispose();
  }

//  bool isAbsorbingTree = false;
  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          homeAppBarKeyScaffoldState.currentState?.isDrawerOpen == true
              ? homeAppBarKeyScaffoldState.currentState?.openEndDrawer()
              : homeAppBarKeyScaffoldState.currentState?.openDrawer();
          return false;
        },
        child: Stack(
          children: [
            StreamBuilder<bool>(
              initialData: false,
              stream: absorbPointerAppController.stream,
              builder: (context, snapshotAbsorbing) {
                return AbsorbPointer(
                  absorbing: Platform.isIOS ? snapshotAbsorbing.data! : false,
                  child: StreamBuilder(
                    stream: languageCodeResult,
                    initialData: AppSettingsModel(
                        languageCode: CommonUtils.getDefLang(),
                        isDarkMode: false),
                    builder: (context, snapshotLocale) {
                      if (localeChangedController.valueOrNull == true) {
                        bloc.updateHeadersTranslation();
                      }
                      return StreamBuilder<MemberModel?>(
                        stream: bloc.currentMemberResult,
                        initialData:
                            MemberModel(photo: "", profile: MemberProfile()),
                        builder: (ctx, snapshotCurrentMember) {
                          return StreamBuilder<List<DrawerChatModel>>(
                            stream: bloc.drawerChatModelListResult,
                            initialData: [],
                            builder: (ctx, snapshotDrawerChatList) {
                              return TXHomeAppBarWidget(
                                drawerConfig: bloc.drawerConfigResult,
                                onDrawerConfigChanged: (config) {
                                  bloc.changeDrawerConfig(config);
                                },
                                appVersion: bloc.appVersionResult,
                                keyScaffoldState: homeAppBarKeyScaffoldState,
                                unreadTeams: bloc.unreadTeamsResult,
                                unreadCalendar: bloc.unreadCalendarResult,
                                openTasks: bloc.openTasksResult,
                                floatingActionButtonLocation:
                                    FloatingActionButtonLocation.endFloat,
                                floatingActionButton: FadeTransition(
                                  opacity: _animationController,
                                  child: ScaleTransition(
                                    scale: _animationController,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 150),
                                      child: FloatingActionButton(
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          size: 40,
                                          color: R.color.whiteColor,
                                        ),
                                        backgroundColor: R.color.secondaryColor,
                                        onPressed: () {
                                          final value =
                                              bloc.isNotInLastMessages;
                                          final fromDifChannel = bloc
                                              .messageClickedToDifferentChannel;
                                          bloc.restoreLastMessages();
                                          if ((_scrollController.hasClients &&
                                                  !value) ||
                                              (_scrollController.hasClients &&
                                                  !fromDifChannel &&
                                                  bloc.lastMessages != null)) {
                                            _scrollController.jumpTo(
                                                _scrollController
                                                    .position.minScrollExtent);
                                          }
                                          // if (bloc.isNotInLastMessages)
                                          //   bloc.restoreLastMessages();
                                          // else if (_scrollController.hasClients) {
                                          //   _scrollController.jumpTo(
                                          //     _scrollController.position.minScrollExtent
                                          //   );
                                          // }
                                        },
                                        mini: true,
                                      ),
                                    ),
                                  ),
                                ),
                                member: snapshotCurrentMember.data!,
                                team: bloc.teamResult,
                                currentChat: bloc.inMemoryData.currentChannel,
                                onVideoCallTapped: () {
                                  bloc.startJitsiCall();
                                },
                                onSearchTapped: () {
                                  NavigationUtils.push(
                                      context,
                                      SearchGlobalPage(
                                        joinedTeam: bloc.joinedTeam!,
                                        drawerChatList:
                                            snapshotDrawerChatList.data!,
                                      ));
                                },
                                onFavoritesTapped: () {
                                  NavigationUtils.push(
                                      context,
                                      FavoritesPage(
                                          joinedTeam: bloc.joinedTeam!,
                                          drawerChatList: bloc.drawerChatList));
                                },
                                drawerChatList: snapshotDrawerChatList.data!,
                                onAddChatTap: (drawerChat) {
                                  NavigationUtils.pop(context);
                                  if (drawerChat.drawerHeaderChatType ==
                                      DrawerHeaderChatType.Channel) {
                                    NavigationUtils.push(context, ChannelCreatePage());
                                  } else if (drawerChat.drawerHeaderChatType ==
                                      DrawerHeaderChatType.Message1x1) {
                                    NavigationUtils.push(
                                        context,
                                        const SearchUserPage(
                                          userGroupBy: UserGroupBy.team,
                                          activeMembersOnly: false,
                                        ));
                                  } else if (drawerChat.drawerHeaderChatType ==
                                      DrawerHeaderChatType.PrivateGroup) {
                                    NavigationUtils.push(context, PrivateGroupCreatePage());
                                  }
                                },
                                onDrawerChatTap: (drawerChat) async {
                                  // if (_scrollController.hasClients)
                                  //   _scrollController.position
                                  //       .jumpTo(_scrollController.position.minScrollExtent);
                                  // WidgetsBinding?.instance?.focusManager?.primaryFocus
                                  //     ?.unfocus();
                                  NavigationUtils.pop(context);
                                  if (drawerChat.isChild) {
                                    bloc.selectChatRoom(
                                        drawerChat.channelModel!,
                                        mark: true);
                                  } else if (drawerChat.drawerHeaderChatType ==
                                      DrawerHeaderChatType.Thread) {
                                    NavigationUtils.push(
                                            context,
                                            ThreadPage(
                                              teamJoinedModel: bloc.joinedTeam!,
                                              drawerChatList:
                                                  bloc.drawerChatList,
                                            ))
                                        .then((value) =>
                                            bloc.reloadThreadsCount());
                                  } else if (drawerChat.drawerHeaderChatType ==
                                      DrawerHeaderChatType.Channel) {
                                    NavigationUtils.push(
                                        context, ChannelPage());
                                  } else if (drawerChat.drawerHeaderChatType ==
                                      DrawerHeaderChatType.Message1x1) {
                                    NavigationUtils.push(
                                        context,
                                        SearchUserPage(
                                          userGroupBy: UserGroupBy.team,
                                          activeMembersOnly: false,
                                        ));
                                  } else if (drawerChat.drawerHeaderChatType ==
                                      DrawerHeaderChatType.PrivateGroup) {
                                    NavigationUtils.push(
                                        context, PrivateGroupPage());
                                  } else {
//                  Fluttertoast.showToast(msg: drawerChat.title.toString());
                                  }
                                },
                                onMenuDrawerTapped: (menu) async {
                                  WidgetsBinding
                                      .instance.focusManager.primaryFocus
                                      ?.unfocus();
                                  if (menu == DrawerMenuAction.SetState) {
                                    txShowStatusSelector(context,
                                        onValueSelected: (value) {
                                      final currentStatus =
                                          snapshotCurrentMember
                                                  .data?.statusIcon ??
                                              "";
                                      final currentText = snapshotCurrentMember
                                              .data?.statusText ??
                                          "";
                                      if (value.isNotEmpty) {
                                        final selectedStatus = value.keys.first;
                                        final selectedText = value.values.first;
                                        if (currentStatus != selectedStatus ||
                                            currentText != selectedText) {
                                          bloc.setUserStatus(
                                              code: selectedStatus,
                                              text: selectedText);
                                        }
                                      }
                                    },
                                        currentStatus: snapshotCurrentMember
                                                .data?.statusIcon ??
                                            "",
                                        currentText: snapshotCurrentMember
                                                .data?.statusText ??
                                            "");
                                  } else if (menu ==
                                      DrawerMenuAction.Preferences) {
                                    NavigationUtils.push(
                                        context,
                                        ProfilePage(
                                            memberModel:
                                                snapshotCurrentMember.data!));
                                  } else if (menu ==
                                      DrawerMenuAction.Authenticator) {
                                    NavigationUtils.push(
                                        context, AuthenticatorPage());
                                  } else if (menu ==
                                      DrawerMenuAction.Downloads) {
                                  } else if (menu == DrawerMenuAction.Help &&
                                      (await canLaunchUrlString(
                                          Endpoint.helpUrl))) {
                                    launchUrlString(Endpoint.helpUrl);
                                  } else if (menu ==
                                      DrawerMenuAction.Integrations) {
                                  } else if (menu ==
                                      DrawerMenuAction.EditTeam) {
                                    NavigationUtils.push(
                                        context,
                                        EditTeamPage(
                                            teamModel: bloc.joinedTeam?.team));
                                  } else if (menu == DrawerMenuAction.Plans) {
                                  } else if (menu == DrawerMenuAction.Members) {
                                    NavigationUtils.push(
                                        context,
                                        SearchUserPage(
                                          userGroupBy: UserGroupBy.team,
                                          activeMembersOnly: false,
                                          action: RemoteConstants.searchSearch,
                                        ));
                                  } else if (menu == DrawerMenuAction.Logout) {
                                    _showDialogLogout(context: context);
                                  }
                                },
                                onMenuChatActionTapped: (menu) async {
                                  // if (_scrollController.hasClients)
                                  //   _scrollController.position
                                  //       .jumpTo(_scrollController.position.minScrollExtent);
                                  WidgetsBinding
                                      .instance.focusManager.primaryFocus
                                      ?.unfocus();
                                  if (menu == MenuChatAction.SeeFiles) {
                                    navigateToFiles(context,
                                        channelModel:
                                            bloc.inMemoryData.currentChannel!);
                                  } else if (menu ==
                                      MenuChatAction.TaskManager) {
                                    final selectedDrawerItem =
                                        snapshotDrawerChatList.data!
                                            .firstWhereOrNull((element) =>
                                                element.isSelected);
                                    NavigationUtils.push(
                                      context,
                                      TaskPage(
                                        joinedTeam: bloc.joinedTeam!,
                                        channelId: bloc
                                            .inMemoryData.currentChannel!.id,
                                        appBarTitle: selectedDrawerItem == null
                                            ? null
                                            : selectedDrawerItem
                                                        .drawerHeaderChatType ==
                                                    DrawerHeaderChatType
                                                        .Message1x1
                                                ? "@${CommonUtils.getMemberUsername(selectedDrawerItem.memberModel)?.toLowerCase().trim() ?? ""}"
                                                : selectedDrawerItem.title,
                                      ),
                                    );
                                  } else if (menu == MenuChatAction.SeeLinks) {
                                    List<MemberModel> members =
                                        bloc.inMemoryData.getMembers();
                                    NavigationUtils.push(
                                        context,
                                        LinkPage(
                                          members: members,
                                        ));
                                  } else if (menu == MenuChatAction.Mentions) {
                                    List<MemberModel> members =
                                        bloc.inMemoryData.getMembers();
                                    NavigationUtils.push(
                                        context,
                                        MentionsPage(
                                          members: members,
                                        ));
                                  } else if (menu ==
                                      MenuChatAction.ChannelMembers) {
                                    NavigationUtils.push(
                                        context,
                                        SearchUserPage(
                                          userGroupBy: UserGroupBy.channel,
                                          action: "",
                                          channelId: bloc
                                              .inMemoryData.currentChannel!.id,
                                          activeMembersOnly: false,
                                          showKickButton: (bloc
                                                          .inMemoryData
                                                          .currentChannel!
                                                          .uid ==
                                                      snapshotCurrentMember
                                                          .data!.id ||
                                                  snapshotCurrentMember
                                                          .data!.userRol ==
                                                      UserRol.Admin) &&
                                              bloc.inMemoryData.currentChannel
                                                      ?.isPrivateGroup ==
                                                  true,
                                        ));
                                  } else if (menu ==
                                      MenuChatAction.InviteMember) {
                                    bloc
                                        .getChannelMemberIds(bloc
                                            .inMemoryData.currentChannel!.id)
                                        .then((value) async {
                                      final res = await NavigationUtils.push(
                                          context,
                                          SearchUserPage(
                                            userGroupBy: UserGroupBy.team,
                                            action: RemoteConstants
                                                .searchGroupInvite,
                                            pickMember: true,
                                            showInvitationLinkGenerator: bloc
                                                        .inMemoryData
                                                        .currentChannel!
                                                        .uid ==
                                                    snapshotCurrentMember
                                                        .data!.id ||
                                                snapshotCurrentMember
                                                        .data!.userRol ==
                                                    UserRol.Admin,
                                            channelId: bloc.inMemoryData
                                                .currentChannel!.id,
                                            excludeBotMembers: true,
                                            excludeMembers: value,
                                          ));
                                      if (res is MemberModel) {
                                        bloc.addMemberToChannel(res);
                                      }
                                    });
                                  } else if (menu ==
                                      MenuChatAction.RenameChannel) {
                                    NavigationUtils.push(
                                        context,
                                        ChannelRenamePage(
                                          channelModel:
                                              bloc.inMemoryData.currentChannel,
                                        ));
                                    // if (res is ChannelModel) {
                                    //   bloc.searchAndReplace(res);
                                    // }
                                  } else if (menu ==
                                      MenuChatAction.DeleteChannel) {
                                    _showDialogDeleteChannel(
                                      context: context,
                                    );
                                  } else if (menu ==
                                          MenuChatAction.LeaveChannel1x1 ||
                                      menu == MenuChatAction.LeaveChannel) {
                                    bloc.leaveChannel();
                                  } else if (menu ==
                                      MenuChatAction.AddToFavorites) {
                                    bloc.setFavorite();
                                  } else if (menu ==
                                      MenuChatAction.ChannelPreferences) {
                                    NavigationUtils.push(
                                        context,
                                        ChannelPreferencesPage(
                                          channelModel:
                                              bloc.inMemoryData.currentChannel,
                                        ));
                                    // if (res is ChannelModel) {
                                    //   bloc.searchAndReplace(res);
                                    // }
                                  } else
                                    Fluttertoast.showToast(
                                        msg: menu.toString(),
                                        toastLength: Toast.LENGTH_LONG,
                                        textColor: R.color.whiteColor,
                                        backgroundColor: R.color.primaryColor);
                                },
                                onNavigationOptionTap: (option) async {
                                  // if (_scrollController.hasClients)
                                  //   _scrollController.position
                                  //       .jumpTo(_scrollController.position.minScrollExtent);
                                  WidgetsBinding
                                      .instance.focusManager.primaryFocus
                                      ?.unfocus();
                                  if (option ==
                                      DrawerNavigationOption.MyTeams) {
                                    final res = await NavigationUtils.pushNamed(
                                        context, NavigationUtils.TeamsRoute,
                                        arguments: TeamPageArguments(
                                            key: teamsPageKey));
                                    if (res is TeamModel &&
                                        res.id != bloc.joinedTeam?.team.id) {
                                      bloc.changeTeam(res);
                                    } else if (res is bool && res) {
                                      NavigationUtils.pushReplacement(
                                          context, LoginPage());
                                    }
                                  } else if (option ==
                                      DrawerNavigationOption.InvitePeople) {
                                    NavigationUtils.push(
                                        context,
                                        InvitePage(
                                            privateGroups:
                                                bloc.joinedTeam?.groups ?? []));
                                  } else if (option ==
                                      DrawerNavigationOption.Meeting) {
                                    await launchUrlString(
                                        Injector.instance.meetingBaseUrl);
                                  } else if (option ==
                                      DrawerNavigationOption.MyTasks) {
                                    NavigationUtils.push(context, TaskPage(joinedTeam: bloc.joinedTeam!));
                                  } else if (option ==
                                      DrawerNavigationOption.MyFiles) {
                                    navigateToFiles(context);
                                  } else if (option ==
                                      DrawerNavigationOption.ActivityLog) {
                                    NavigationUtils.push(
                                        context,
                                        ActivityZonePage(
                                          joinedTeam: bloc.joinedTeam!,
                                          currentUser:
                                              snapshotCurrentMember.data!,
                                        ));
                                  } else if (option ==
                                      DrawerNavigationOption.Calendar) {
                                    NavigationUtils.push(
                                        context,
                                        CalendarPage(
                                          joinedTeam: bloc.joinedTeam!,
                                        ));
                                  }
                                },
                                body: Stack(
                                  children: <Widget>[
                                    SafeArea(
                                      child: Container(
                                        child: Stack(
                                          children: <Widget>[
                                            TXGestureHideKeyBoard(
                                              child: Container(
                                                height: double.infinity,
                                                child: StreamBuilder<
                                                    ChatRoomUIModel>(
                                                  stream: bloc.chatRoomResult,
                                                  initialData: ChatRoomUIModel(
                                                    messageWrapperModel:
                                                        MessageWrapperModel(
                                                            list: [],
                                                            more: false),
                                                  ),
                                                  builder:
                                                      (ctx, snapshotChatRoom) {
                                                    return _getChatList(
                                                        context,
                                                        snapshotChatRoom.data!
                                                            .messageWrapperModel);
                                                  },
                                                ),
                                              ),
                                            ),
                                            StreamBuilder<MessageModel?>(
                                                initialData: null,
                                                stream:
                                                    bloc.pinnedMessageResult,
                                                builder:
                                                    (context, snapshotPinned) {
                                                      final canPinUnpinMessage =
                                                          bloc.inMemoryData.currentMember?.userRol == UserRol.Admin ||
                                                              bloc.inMemoryData.currentChannel?.uid ==
                                                                  bloc.inMemoryData.currentMember?.id;
                                                  return snapshotPinned.data ==
                                                          null
                                                      ? Container()
                                                      : Positioned(
                                                          left: 0,
                                                          right: 0,
                                                          top: 0,
                                                          child: TXPinnedMessage(
                                                              pinnedMessage:
                                                                  snapshotPinned
                                                                      .data!,
                                                          onTap: () {
                                                            bloc.tapAnswerMessage(
                                                                snapshotPinned.data);
                                                          },
                                                            onLongPress: canPinUnpinMessage ? () {
                                                              showTXModalBottomSheetAutoAdjustable(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    FocusScope.of(context)
                                                                        .unfocus();
                                                                    return Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: 45,
                                                                          child: TXMenuOptionItemWidget(
                                                                            icon: const Icon(Icons.close, color: Colors.red),
                                                                            text: R.string.unpinMessage,
                                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                            onTap: () async {
                                                                              await NavigationUtils.pop(context);
                                                                              bloc.unpinMessage(snapshotPinned.data!);
                                                                            },
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                            } : null,
                                                          ),
                                                        );
                                                }),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Material(
                                                child: TXMeasureChildSize(
                                                  onChange: (size) {
                                                    bloc.setTextInputWidgetSize(
                                                        size);
                                                  },
                                                  child: Container(
                                                    child: StreamBuilder<
                                                            MessageModel?>(
                                                        stream: bloc
                                                            .answerInMessageResult,
                                                        initialData: null,
                                                        builder: (context,
                                                            answerInMessageModelSnapshot) {
                                                          return TXChatTextInputWidget(
                                                            isReadOnlyChannel: bloc
                                                                    .inMemoryData
                                                                    .currentChannel
                                                                    ?.readonly ??
                                                                false,
                                                            onTapAnswerInMessage:
                                                                () {
                                                              bloc.tapAnswerMessage(
                                                                  answerInMessageModelSnapshot
                                                                      .data);
                                                            },
                                                            onCloseAnswerInMessage:
                                                                () {
                                                              bloc.answerInMessageAction(
                                                                  null);
                                                            },
                                                            answerInMessageModel:
                                                                answerInMessageModelSnapshot
                                                                    .data,
                                                            onSendTap:
                                                                (value) async {
                                                              if (answerInMessageModelSnapshot
                                                                      .data !=
                                                                  null) {
                                                                final permanentLink =
                                                                    await bloc.conformMessageLink(
                                                                        answerInMessageModelSnapshot
                                                                            .data);
                                                                bloc.sendMessage(
                                                                    "$permanentLink $value");
                                                              } else
                                                                bloc.sendMessage(
                                                                    value);
                                                            },
                                                            onChange: (value) {
                                                              bloc.sendUserTyping();
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    TXLoadingWidget(
                                      loadingStream: bloc.isLoadingStream,
                                      backgroundColor: R.color.whiteColor,
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
            TXLoadingWidget(loadingStream: bloc.fullScreenLoadingResult)
          ],
        ));
  }

  Widget _getChatList(
      BuildContext context, MessageWrapperModel messageWrapperModel) {
    return messageWrapperModel.list.isEmpty
        ? _getMessageListHeader()
        : _getScrollWidget(context, messageWrapperModel);
  }

  //ScrollNotification _notificationObj;

  // bool shouldJump = false;

  List<MessageModel> nextList = [];
  List<MessageModel> previousList = [];
  List<MessageModel> currentList = [];
  List<MessageModel> completeList = [];

  int? pIdx, cIdx, nIdx;

  Widget _getScrollWidget(
      BuildContext context, MessageWrapperModel messageWrapperModel) {
    // if (messageWrapperModel.bulkLoadMessages == BulkLoadMessages.next &&
    //     shouldJump &&
    //     !bloc.isLoadingMoreNextMessages) {
    //   shouldJump = false;
    //   Future.delayed(Duration(milliseconds: 50), () {
    //     final diffScrollExt =
    //         _scrollController.positions.first.maxScrollExtent -
    //             _notificationObj.metrics.maxScrollExtent;
    //     _scrollController.jumpTo(diffScrollExt);
    //   });
    // }
    const Key centerKey = ValueKey('second-sliver-list');
    previousList.clear();
    nextList.clear();
    currentList.clear();
    completeList.clear();

    pIdx = -1;
    cIdx = -1;
    nIdx = -1;

    messageWrapperModel.list.sort((m1, m2) => (m1.ts!.compareTo(m2.ts!)));
    if (bloc.firstMessageBeforePrevious == null &&
        bloc.lastMessageBeforeNext == null) {
      currentList.addAll(messageWrapperModel.list);
      cIdx = 0;
    } else if (bloc.firstMessageBeforePrevious != null &&
        bloc.lastMessageBeforeNext == null) {
      final idx =
          messageWrapperModel.list.indexOf(bloc.firstMessageBeforePrevious!);
      previousList = messageWrapperModel.list.sublist(0, idx);
      currentList = messageWrapperModel.list
          .sublist(idx, messageWrapperModel.list.length);
      pIdx = 0;
      cIdx = idx;
    } else if (bloc.firstMessageBeforePrevious == null &&
        bloc.lastMessageBeforeNext != null) {
      final idx = messageWrapperModel.list.indexOf(bloc.lastMessageBeforeNext!);
      currentList = messageWrapperModel.list.sublist(0, idx + 1);
      nextList = messageWrapperModel.list
          .sublist(idx + 1, messageWrapperModel.list.length);
      cIdx = 0;
      nIdx = idx + 1;
    } else {
      final idxPrevious =
          messageWrapperModel.list.indexOf(bloc.firstMessageBeforePrevious!);
      final idxNext =
          messageWrapperModel.list.indexOf(bloc.lastMessageBeforeNext!);
      previousList = messageWrapperModel.list.sublist(0, idxPrevious);
      currentList = messageWrapperModel.list.sublist(idxPrevious, idxNext + 1);
      nextList = messageWrapperModel.list
          .sublist(idxNext + 1, messageWrapperModel.list.length);
      pIdx = 0;
      cIdx = idxPrevious;
      nIdx = idxNext + 1;
    }
    completeList = previousList.reversed.toList() +
        currentList.reversed.toList() +
        nextList;
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        //_notificationObj = notification;
        // print("========METRICS=======");
        // print(notification.metrics.viewportDimension);
        // print(notification.metrics.maxScrollExtent);
        // print(notification.metrics.minScrollExtent);
        // print(notification.metrics.pixels);
        if (!bloc.isLoadingMoreNextMessages &&
            !bloc.isLoadingMorePreviousMessages &&
            bloc.hasMorePreviousMessages &&
            _scrollController.position.pixels >
                _scrollController.position.maxScrollExtent -
                    MediaQuery.of(context).size.height / 4) {
          bloc.loadPreviousMessages();
        }
        if (!bloc.isLoadingMoreNextMessages &&
            !bloc.isLoadingMorePreviousMessages &&
            bloc.hasMoreNextMessages &&
            _scrollController.position.pixels <
                _scrollController.position.minScrollExtent + 150) {
          // bloc.currentScrollPosition =
          //     notification.metrics.pixels > 0 ? notification.metrics.pixels : 0;
          //shouldJump = true;

          bloc.loadNextMessages();
        }
        return true;
      },
      child: StreamBuilder<Size>(
        initialData: null,
        stream: bloc.inputWidgetSizeResult,
        builder: (context, snapshotInputSize) => Container(
          padding: EdgeInsets.only(
              bottom: snapshotInputSize.data == null
                  ? 100
                  : snapshotInputSize.data!.height),
          child: CustomScrollView(
            center: centerKey,
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            reverse: true,
            slivers: [
              SliverList(
                  delegate: nextList.isEmpty
                      ? SliverChildListDelegate(<Widget>[
                          Container(),
                        ])
                      : SliverChildListDelegate(_getMessageWidgetList(
                          context, completeList, nextList, nIdx))),
              SliverList(
                  key: centerKey,
                  delegate: currentList.isEmpty
                      ? SliverChildListDelegate(<Widget>[
                          Container(),
                        ])
                      : SliverChildListDelegate(<Widget>[
                          ..._getMessageWidgetList(
                              context, completeList, currentList, cIdx,
                              reversed: true),
                          previousList.isEmpty &&
                                  (!bloc.hasMorePreviousMessages ||
                                      messageWrapperModel.list.length <
                                          RemoteConstants
                                              .message_number_requested_by_next)
                              ? _getMessageListHeader()
                              : Container(),
                        ])),
              SliverList(
                  delegate: previousList.isEmpty
                      ? SliverChildListDelegate(<Widget>[
                          Container(),
                        ])
                      : SliverChildListDelegate(<Widget>[
                          ..._getMessageWidgetList(
                              context, completeList, previousList, pIdx,
                              reversed: true),
                          !bloc.hasMorePreviousMessages ||
                                  messageWrapperModel.list.length <
                                      RemoteConstants
                                          .message_number_requested_by_next
                              ? _getMessageListHeader()
                              : Container(),
                        ])),

              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //         (BuildContext context, int index) {
              //       return _getMessage(context, completeList, previousList.length + currentList.length + index);
              //     },
              //     childCount: nextList.length,
              //   ),
              // ),
              // SliverList(
              //   key: centerKey,
              //   delegate: SliverChildBuilderDelegate(
              //         (BuildContext context, int index) {
              //       return _getMessage(context, completeList, previousList.length + index, reversed: true);
              //     },
              //     childCount: currentList.length,
              //   ),
              // ),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //         (BuildContext context, int index) {
              //       return _getMessage(context, completeList, index, reversed: true);
              //     },
              //     childCount: previousList.length,
              //   ),
              // ),
            ],
            //physics: BouncingScrollPhysics(),
            //reverse: true,
            // child: Column(
            //   children: [
            //     !bloc.hasMorePreviousMessages ||
            //             messageWrapperModel.list.length <= RemoteConstants.message_number_requested_by_next
            //         ? _getMessageListHeader()
            //         : Container(),
            //     ..._getMessageWidgetList(context, messageWrapperModel.list),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  Widget _getMessageListHeader() {
    ChannelModel? channel = bloc.inMemoryData.currentChannel;
    if (channel == null) return Container();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: channel.isM1x1
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                TXNetworkImage(
                  height: 80,
                  width: 80,
                  userBorderRadius: true,
                  imageUrl: CommonUtils.getMemberPhoto(bloc.inMemoryData
                      .getMember(bloc.inMemoryData.currentChannel!.other)),
                  placeholderImage: Image.asset(R.image.logo),
                ),
                SizedBox(
                  height: 10,
                ),
                TXTextWidget(
                  textAlign: TextAlign.center,
                  text: R.string.hereStartsYourMessagesWith(
                      CommonUtils.getMemberUsername(
                              bloc.inMemoryData.getMember(channel.other)) ??
                          ""),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                TXTextWidget(
                  text: channel.titleFixed,
                  color: R.color.blackColor,
                  fontWeight: FontWeight.bold,
                  size: 25,
                ),
                SizedBox(
                  height: 10,
                ),
                TXTextWidget(
                  textAlign: TextAlign.center,
                  text: R.string.thisChannelIsManagedBy(
                      CommonUtils.getMemberUsername(
                              bloc.inMemoryData.getMember(channel.uid!)) ??
                          ""),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
    );
  }

  List<Widget> _getMessageWidgetList(BuildContext context,
      List<MessageModel> totalList, List<MessageModel> iterate, index,
      {reversed = false}) {
    return iterate
        .map((message) =>
            _getMessage(context, totalList, index++, reversed: reversed))
        .toList();
  }

  Widget _getMessage(BuildContext context, List<MessageModel> list, int index,
      {reversed = false}) {
    MessageModel message = list[index];

    Map mapDismiss = {};
    mapDismiss[DismissDirection.horizontal] = 0.1;
    return message.isAdaptiveCard
        ? _getMessageContainer(context, list, index, reversed: reversed)
        : Dismissible(
            key: Key(index.toString()),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                bloc.answerInMessageAction(list[index]);
              } else if (direction == DismissDirection.endToStart) {
                NavigationUtils.push(
                    context,
                    ThreadTypePage(
                      drawerChatList: bloc.drawerChatList,
                      teamJoinedModel: bloc.joinedTeam!,
                      threadId: list[index].id,
                      messageModel: list[index].threadMetaParent != null &&
                              list[index].threadMetaChild == null
                          ? null
                          : list[index],
                      channel: bloc.inMemoryData.currentChannel!,
                    )).then((value) {
                  bloc.reloadThreadsCount();
                });
              }
              return false;
            },
            onDismissed: (direction) {},
            child:
                _getMessageContainer(context, list, index, reversed: reversed),
          );
  }

  Widget _getMessageContainer(
      BuildContext context, List<MessageModel> list, int index,
      {reversed = false}) {
    List<MemberModel> members = bloc.inMemoryData.getMembers();
    MessageModel message = list[index];
    MemberModel? member = bloc.inMemoryData.getMember(message.uid);

    ///Showing thread replies section if contains
    ThreadMetaParent? threadMetaParent = message.threadMetaParent;
    ThreadMetaChild? threadMetaChild = message.threadMetaChild;
    List<Widget> threadSectionList = [];
    if (threadMetaParent != null && threadMetaChild == null) {
      threadMetaParent.participants.forEach((element) {
        threadSectionList.add(TXNetworkImage(
          forceLoad: true,
          height: 25,
          width: 25,
          userBorderRadius: true,
          imageUrl: CommonUtils.getMemberPhoto(
              members.firstWhereOrNull((m) => m.id == element)),
          placeholderImage: Image.asset(R.image.logo),
        ));
      });
      if (threadMetaParent.participants.isNotEmpty) {
        threadSectionList.add(SizedBox(
          width: 5,
        ));
        threadSectionList.add(TXTextWidget(
          text:
              "${threadMetaParent.numReplies} ${R.string.answers.toLowerCase()}",
          color: R.color.secondaryColor,
          size: 14,
        ));
        threadSectionList.add(TXTextWidget(
          text: CalendarUtils.showInFormat(
                      R.string.dateFormat3, threadMetaParent.tsLastReply)
                  ?.toLowerCase() ??
              "",
          size: 14,
        ));
      }
    }

    bool showDateDivider;
    bool showMessageMemberInfo;
    if (reversed) {
      showDateDivider = index == list.length - 1 ||
          list[math.max(index, index == list.length - 1 ? index : index + 1)]
                  .ts
                  ?.day !=
              message.ts?.day;

      showMessageMemberInfo = showDateDivider ||
          list[math.max(index, index == list.length - 1 ? index : index + 1)]
                  .uid !=
              message.uid ||
          threadMetaParent != null ||
          threadMetaChild != null ||
          message.isTaskNotification;
    } else {
      showDateDivider =
          index == 0 || list[math.max(0, index - 1)].ts?.day != message.ts?.day;

      showMessageMemberInfo = showDateDivider ||
          list[math.max(0, index - 1)].uid != message.uid ||
          threadMetaParent != null ||
          threadMetaChild != null ||
          message.isTaskNotification;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          showDateDivider ? _getMessageDateDivider(message) : Container(),
          Stack(
            children: <Widget>[
              Container(
                color: (message.favorite) ? R.color.orangeLight : null,
                padding: EdgeInsets.only(
                    left: 5, bottom: showMessageMemberInfo ? 15 : 0, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: showMessageMemberInfo &&
                                  CommonUtils.getMemberName(member)
                                      .isUpperCase()
                              ? 3.5
                              : showMessageMemberInfo
                                  ? 5.7
                                  : 2.3),
                      width: 40,
                      height: 40,
                      alignment: Alignment.centerRight,
                      child: showMessageMemberInfo
                          ? TXNetworkImage(
                              imageUrl: CommonUtils.getMemberPhoto(member),
                              userBorderRadius: true,
                              boxFitImage: BoxFit.cover,
                              placeholderImage: Image.asset(
                                R.image.logo,
                              ),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: TXTextWidget(
                                      fontWeight: FontWeight.w600,
                                      color: R.color.grayColor,
                                      size: 16,
                                      text: CalendarUtils.showInFormat(
                                                  R.string.dateFormat2,
                                                  message.ts)
                                              ?.toLowerCase() ??
                                          "",
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        showMessageMemberInfo
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 7),
                                                child: TXUserDateMessageWidget(
                                                    onTap: () {
                                                      if(member?.isDeletedUser == false) {
                                                        bloc.onMentionClicked(
                                                            member?.profile
                                                                ?.name ??
                                                                "");
                                                      }
                                                    },
                                                    userText: CommonUtils
                                                            .getMemberName(
                                                                member) ??
                                                        "",
                                                    dateText: CalendarUtils
                                                                .showInFormat(
                                                                    R.string
                                                                        .dateFormat2,
                                                                    message.ts!)
                                                            ?.toLowerCase() ??
                                                        ""),
                                                // margin:
                                                //     EdgeInsets.only(left: 8),
                                              )
                                            : Container(),
                                        if (threadMetaChild != null &&
                                            threadMetaParent != null)
                                          InkWell(
                                            onTap: () {
                                              NavigationUtils.push(
                                                  context,
                                                  ThreadTypePage(
                                                    drawerChatList:
                                                        bloc.drawerChatList,
                                                    teamJoinedModel:
                                                        bloc.joinedTeam!,
                                                    threadId:
                                                        threadMetaChild.pmid ??
                                                            "",
                                                    channel: bloc.inMemoryData
                                                        .currentChannel!,
                                                  )).then((value) {
                                                bloc.reloadThreadsCount();
                                              });
                                            },
                                            child: Container(
                                              //margin: EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Wrap(
                                                    spacing: 3,
                                                    children: <Widget>[
                                                      TXTextWidget(
                                                        text: R.string
                                                            .hasCommentedOnThread,
                                                        size: 16,
                                                      ),
                                                      threadMetaParent
                                                                  .message ==
                                                              RemoteConstants
                                                                  .threadMessageDeleted
                                                          ? Container(
                                                              padding: EdgeInsets
                                                                  .only(top: 1),
                                                              child:
                                                                  TXTextWidget(
                                                                text:
                                                                    "(${R.string.removed})",
                                                                color: R.color
                                                                    .grayColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                size: 14,
                                                              ),
                                                            )
                                                          : TXTextWidget(
                                                              text:
                                                                  threadMetaParent
                                                                      .message,
                                                              size: 16,
                                                              color: R.color
                                                                  .secondaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.message,
                                                        color: R.color
                                                            .secondaryColor,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      TXTextWidget(
                                                        text:
                                                            "${threadMetaParent.numReplies} ${R.string.answers.toLowerCase()}",
                                                        size: 16,
                                                        color: R.color
                                                            .secondaryColor,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        else
                                          Container(),
                                        Container(
                                          child: InkWell(
                                            onLongPress: message.isAdaptiveCard
                                                ? null
                                                : () {
                                                    bloc.currentMessageSelected =
                                                        message;
                                                    showTXModalBottomSheetAutoAdjustable(
                                                        context: context,
                                                        builder: (context) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          return _showMessageOptions(
                                                              context);
                                                        });
                                                  },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                threadMetaParent != null &&
                                                        threadMetaChild == null
                                                    ? Container(
                                                        child: Icon(
                                                          Icons.message,
                                                          size: 15,
                                                          color:
                                                              R.color.grayColor,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            top: 3),
                                                      )
                                                    : Container(),
                                                Expanded(
                                                  child: TXMessageBodyWidget(
                                                    message: message,
                                                    onTapAnswerInMessage: () {
                                                      bloc.tapAnswerMessage(
                                                          message
                                                              .answerMessage);
                                                    },
                                                    onLinkTap: (link) async {
                                                      if (link.startsWith(
                                                          "#file-comment")) {
                                                        NavigationUtils.push(
                                                            context,
                                                            MessageCommentsPage(
                                                              teamJoinedModel:
                                                                  bloc.joinedTeam!,
                                                              drawerChatList: bloc
                                                                  .drawerChatList,
                                                              channel: (bloc.joinedTeam!.messages1x1 +
                                                                          bloc.joinedTeam!
                                                                              .groups +
                                                                          bloc.joinedTeam!
                                                                              .channels)
                                                                      .firstWhereOrNull((element) =>
                                                                          element
                                                                              .id ==
                                                                          message
                                                                              .cid) ??
                                                                  bloc.inMemoryData
                                                                      .currentChannel!,
                                                              parentMessageId:
                                                                  message.mid ??
                                                                      "",
                                                            ));
                                                      } else {
                                                        final username = CommonUtils
                                                            .getUsernameFromLink(
                                                                link);
                                                        bloc.onMentionClicked(
                                                            username);
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        message.isAdaptiveCard && index == 0
                                            ? AdaptiveCardWidget(
                                                messageModel: message,
                                                onBtnTap: (value) {
                                                  bloc.sendMessage(value);
                                                },
                                              )
                                            : Container(),
                                        threadSectionList.isNotEmpty
                                            ? InkWell(
                                                onTap: () {
                                                  NavigationUtils.push(
                                                      context,
                                                      ThreadTypePage(
                                                        drawerChatList:
                                                            bloc.drawerChatList,
                                                        teamJoinedModel:
                                                            bloc.joinedTeam!,
                                                        threadId: message.id,
                                                        channel: bloc
                                                            .inMemoryData
                                                            .currentChannel!,
                                                      )).then((value) {
                                                    bloc.reloadThreadsCount();
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    spacing: 3,
                                                    runSpacing: 3,
                                                    children: <Widget>[
                                                      ...threadSectionList
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        message.isFile
                                            ? Container(
                                                //padding: EdgeInsets.all(8),
                                                child: _getFile(
                                                    context,
                                                    message,
                                                    showMessageMemberInfo,
                                                    member),
                                              )
                                            : Container(),
                                        message.isTaskNotification
                                            ? TXTaskNotificationWidget(
                                                messageModel: message,
                                                onLongPress: () {
                                                  bloc.currentMessageSelected =
                                                      message;
                                                  showTXModalBottomSheetAutoAdjustable(
                                                      context: context,
                                                      builder: (context) {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        return _showMessageOptions(
                                                            context);
                                                      });
                                                },
                                              )
                                            : Container(),
                                        message.isFolderShareMessage ||
                                                message.isFolderUploadMessage ||
                                                message.isFolderLinkMessage
                                            ? TXFolderNotificationWidget(
                                                message: message,
                                                showFolderOwner: message
                                                        .isFolderShareMessage ||
                                                    message
                                                        .isFolderUploadMessage,
                                                folderOwner: message
                                                            .isFolderShareMessage ||
                                                        message
                                                            .isFolderUploadMessage
                                                    ? CommonUtils.getMemberName(
                                                        bloc
                                                            .inMemoryData
                                                            .getMember(message
                                                                    .args
                                                                    ?.uid ??
                                                                ""))
                                                    : null,
                                                onFolderTap:
                                                    (FolderModel folder) async {
                                                  if (folder.deleted) {
                                                    bloc.showErrorMessageFromString(
                                                        R.string.folderDeleted);
                                                  } else {
                                                    final path = (await bloc
                                                                .resolveFolderReference(
                                                                    folder.tid,
                                                                    folder.cid,
                                                                    folder.id))
                                                            ?.path ??
                                                        '';
                                                    folder.path = path;
                                                    if (folder
                                                        .path.isNotEmpty) {
                                                      navigateToFiles(context,
                                                          selectedFolder:
                                                              folder);
                                                    } else {
                                                      bloc.showErrorMessageFromString(R
                                                          .string
                                                          .folderIsNotInAvailableChannel);
                                                    }
                                                  }
                                                },
                                                onLongPress: () {
                                                  bloc.currentMessageSelected =
                                                      message;
                                                  showTXModalBottomSheetAutoAdjustable(
                                                      context: context,
                                                      builder: (context) {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        return _showMessageOptions(
                                                            context);
                                                      });
                                                },
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 3,
                                runSpacing: 3,
                                children: <Widget>[
                                  ..._getReactions(context, message)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (message.favorite)
                  ? Container(
                      padding: EdgeInsets.only(left: 2, top: 2),
                      child: CircleAvatar(
                        backgroundColor: R.color.orange,
                        radius: 6,
                        child: Icon(
                          Icons.star,
                          color: R.color.whiteColor,
                          size: 10,
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _getReactions(BuildContext context, MessageModel message) {
    List<Widget> list = [];
    message.reactions.forEach((element) {
      if (element.userIds.isNotEmpty) {
        final w = InkWell(
          onTap: () {
            bloc.currentMessageSelected = message;
            bloc.addRemoveReaction(element.reactionKey);
            bloc.currentMessageSelected = null;
          },
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: R.color.secondaryColor.lighten(.4),
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                border: Border.all(color: R.color.secondaryColor, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "${R.image.reactionBase}${element.reactionKey}.gif",
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TXTextWidget(
                    text: "${element.userIds.length}",
                    color: R.color.blackColor,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
          ),
        );
        list.add(w);
      }
    });

    if (message.reactions.isNotEmpty == true && list.isNotEmpty) {
      final w = InkWell(
        onTap: () {
          showTXModalBottomSheet(
              context: context,
              builder: (context) {
                return TXReactionsAllMessageWidget(
                  messageModel: message,
                );
              });
        },
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          child: TXTextWidget(
            text: R.string.seeAll,
            color: R.color.secondaryColor,
            size: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      list.add(w);
    }
    return list;
  }

  Widget _showMessageOptions(BuildContext context) {
    final isOwner =
        bloc.currentMessageSelected?.uid == bloc.inMemoryData.currentMember?.id;
    final isFile = bloc.currentMessageSelected?.isFile == true;
    final isFavorite = bloc.currentMessageSelected?.favorite == true;
    final canDeleteMessage = isOwner ||
        (bloc.inMemoryData.currentMember?.userRol == UserRol.Admin &&
            bloc.joinedTeam?.team.adminsCanDelete == true);
    final canPinUnpinMessage =
        bloc.inMemoryData.currentMember?.userRol == UserRol.Admin ||
            bloc.inMemoryData.currentChannel?.uid ==
                bloc.inMemoryData.currentMember?.id;
    final isSending =
        bloc.currentMessageSelected?.messageStatus == MessageStatus.Sending;
    final isSelfUserEvent = bloc.currentMessageSelected?.isChannelsMemberJoined == true ||
        bloc.currentMessageSelected?.isChannelsMemberLeft == true ||
        bloc.currentMessageSelected?.isPinnedMessageNotification == true ||
        bloc.currentMessageSelected?.isUnpinnedMessageNotification == true;
    final isNoysiEvent = bloc.currentMessageSelected?.uid == 'noysi:robot';
    // double maxHeight = 270;
    // if (!isNoysiEvent && canDeleteMessage && isSending)
    //   maxHeight = 135;
    // else if (isNoysiEvent)
    //   maxHeight = 230;
    // else if (bloc.currentMessageSelected?.isThreadDeletedMessage == true)
    //   maxHeight = 270;
    // else if (canDeleteMessage) maxHeight = 360;
    return Container(
      //constraints: BoxConstraints(maxHeight: maxHeight),
      child: Column(
        children: <Widget>[
          isSending
              ? Container()
              : Container(
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.link, color: R.color.grayColor),
                    text: R.string.copyPermanentLink,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      final link = await bloc
                          .conformMessageLink(bloc.currentMessageSelected);
                      await Clipboard.setData(new ClipboardData(text: link));
                      Fluttertoast.showToast(
                          msg: link,
                          toastLength: Toast.LENGTH_LONG,
                          textColor: R.color.whiteColor,
                          backgroundColor: R.color.primaryColor);
                    },
                  ),
                ),
          canPinUnpinMessage && !isSending && !isSelfUserEvent
              ? Container(
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    icon: Icon(Icons.push_pin, color: R.color.grayColor),
                    text: R.string.pinMessage,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      if (bloc.currentMessageSelected != null) {
                        bloc.pinMessage(bloc.currentMessageSelected!);
                      }
                    },
                  ),
                )
              : Container(),
          (isNoysiEvent && !isFile) ||
                  bloc.currentMessageSelected?.isThreadDeletedMessage == true ||
                  isSelfUserEvent
              ? Container()
              : Container(
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    icon: Icon(isFile ? Icons.comment : Icons.content_copy,
                        color: R.color.grayColor),
                    text: isFile
                        ? "${R.string.addComment} ${bloc.currentMessageSelected?.fileModel?.comments ?? ""}"
                        : R.string.copyMessage,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      if (isFile) {
                        await NavigationUtils.push(
                            context,
                            MessageCommentsPage(
                              messageModel: bloc.currentMessageSelected,
                              channel: bloc.inMemoryData.currentChannel!,
                              teamJoinedModel: bloc.joinedTeam!,
                              drawerChatList: bloc.drawerChatList,
                            ));
                      } else {
                        await Clipboard.setData(ClipboardData(
                            text: bloc.currentMessageSelected?.text ?? ""));
                        Fluttertoast.showToast(
                            msg: R.string.copiedToClipboard,
                            toastLength: Toast.LENGTH_LONG,
                            textColor: R.color.whiteColor,
                            backgroundColor: R.color.primaryColor);
                      }
                    },
                  ),
                ),
          isSending && !isNoysiEvent
              ? Container()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.insert_emoticon, color: R.color.grayColor),
                    text: R.string.addReaction,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      showTXModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return _showReactions(context);
                          });
                    },
                  ),
                ),
          isSending
              ? Container()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite ? R.color.orange : R.color.grayColor),
                    text: isFavorite
                        ? R.string.removeFromFavorites
                        : R.string.favorite,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      bloc.setFavoriteMessage(bloc.currentMessageSelected!);
                    },
                  ),
                ),
          isOwner &&
                  !isFile &&
                  !isSending &&
                  !isNoysiEvent &&
                  !isSelfUserEvent &&
                  !(bloc.currentMessageSelected?.isThreadDeletedMessage == true)
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.edit, color: R.color.grayColor),
                    text: R.string.edit,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      final res = await NavigationUtils.push(
                          context,
                          EditMessagePage(
                            model: bloc.currentMessageSelected!,
                          ));
                      if ((res is MessageModel)) {
                        bloc.updateMessageTextAfterEdit(res);
                      }
                    },
                  ),
                )
              : Container(),
          isSending || isSelfUserEvent || (isNoysiEvent && !isFile)
              ? Container()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(
                        isFile ? Icons.cloud_download : Icons.chat_bubble,
                        color: R.color.grayColor),
                    text: isFile ? R.string.download : R.string.createThread,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      if (isFile) {
                        bloc.downloadFile();
                      } else {
                        await NavigationUtils.push(
                            context,
                            ThreadTypePage(
                              drawerChatList: bloc.drawerChatList,
                              teamJoinedModel: bloc.joinedTeam!,
                              threadId: bloc.currentMessageSelected!.id,
                              messageModel: bloc.currentMessageSelected!
                                              .threadMetaParent !=
                                          null &&
                                      bloc.currentMessageSelected!
                                              .threadMetaChild ==
                                          null
                                  ? null
                                  : bloc.currentMessageSelected!,
                              channel: bloc.inMemoryData.currentChannel!,
                            )).then((value) {
                          bloc.reloadThreadsCount();
                        });
                      }
                    },
                  ),
                ),
          !isFile || isSending || isSelfUserEvent
              ? Container()
              : Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.share, color: R.color.grayColor),
                    text: R.string.share,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      final res = await NavigationUtils.push(
                          context,
                          ShareFilePage(
                            fileModel: bloc.currentMessageSelected!.fileModel!,
                            channels: bloc.joinedTeam!.channels,
                            groups: bloc.joinedTeam!.groups,
                            members: bloc.joinedTeam!.memberWrapperModel.list,
                            messages1x1: bloc.joinedTeam!.messages1x1,
                          ));
                      if (res != null) {
                        bloc.changeChannelAuto(
                            ChannelCreatedUI(channelModel: res, members: []));
                      }
                    },
                  ),
                ),
          canDeleteMessage && !isNoysiEvent && !isSelfUserEvent
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.delete_forever, color: Colors.redAccent),
                    text: R.string.remove,
                    textColor: Colors.redAccent,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      _showDialogRemoveMessage(context: context);
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _showReactions(BuildContext context) {
    return TXReactionsWidget(
      onReactionSelected: (reactionKey) async {
        await NavigationUtils.pop(context);
        bloc.addRemoveReaction(reactionKey);
      },
    );
  }

  void _showDialogRemoveMessage({required BuildContext context}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.deleteMessageTitle,
        content: R.string.deleteMessageContent,
        onOK: () async {
          await NavigationUtils.pop(context);
          bloc.deleteMessage();
        },
        onCancel: () {
          NavigationUtils.pop(context);
        },
      ),
    );
  }

  void _showDialogDeleteChannel({required BuildContext context}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.delete,
        content: R.string.deleteChannelWarning,
        onOK: () {
          Navigator.pop(context);
          bloc.deleteChannel();
        },
        onCancel: () {
          Navigator.pop(context, R.string.cancel);
        },
      ),
    );
  }

  Widget _getFile(BuildContext context, MessageModel messageModel,
      bool showMessageMemberInfo, MemberModel? memberModel) {
    final fileRenderW = messageModel.fileModel?.width == null
        ? 250 / 4
        : messageModel.fileModel!.width!.toDouble() * 1 / 8;
    final fileRenderH = messageModel.fileModel?.height == null
        ? 250 / 4
        : messageModel.fileModel!.height!.toDouble() * 1 / 8;

    final isAudio =
        messageModel.fileModel?.mimeType.startsWith("audio") == true;
    final isVideo =
        messageModel.fileModel?.mimeType.startsWith("video") == true;
    final isApp =
        (messageModel.fileModel?.mimeType.startsWith("application") == true) ||
            (messageModel.fileModel?.mimeType.startsWith("text") == true);

    final isAudioVideoApp = isVideo || isAudio || isApp;
    return AbsorbPointer(
      absorbing: messageModel.fileModel?.isUploadingDownloading == true,
      child: InkWell(
        // onTap: () {
        //   if(messageModel.isFolderLinkMessage) {
        //     navigateToFiles(context, selectedFolder: messageModel);
        //   }
        // },
        onLongPress: () {
          bloc.currentMessageSelected = messageModel;
          showTXModalBottomSheetAutoAdjustable(
              context: context,
              builder: (context) {
                FocusScope.of(context).unfocus();
                return _showMessageOptions(context);
              });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showMessageMemberInfo
                ? Container()
                : TXTextWidget(
                    text: CommonUtils.getMemberName(memberModel) ?? "",
                    color: R.color.blackColor,
                    fontWeight: FontWeight.bold,
                    size: 16,
                  ),
            // SizedBox(
            //   height: 8,
            // ),
            TXTextWidget(
              text: messageModel.fileModel?.titleFixed ?? "",
              color: R.color.secondaryColor,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Stack(
                children: [
                  !isAudio && !isVideo
                      ? TXNetworkImage(
                          forceLoad: true,
                          boxFitImage: BoxFit.cover,
                          mimeType: messageModel.fileModel?.mimeType ?? "",
                          width: isAudioVideoApp
                              ? math.min(fileRenderW, 80)
                              : math.max(fileRenderW, 80),
                          userBorderRadius: false,
                          height: math.max(fileRenderH, 80),
                          imageUrl: messageModel.fileModel?.link ?? "",
                          placeholderImage: Image.asset(
                            messageModel.fileModel?.mimeType
                                        .startsWith("image") ==
                                    true
                                ? R.image.imageDefaultIcon
                                : R.image.logo,
                            fit: BoxFit.cover,
                          ),
                          onDownloadImage: (downloading) {
                            setState(() {
                              messageModel.fileModel?.isUploadingDownloading =
                                  downloading;
                            });
                          },
                        )
                      : !isVideo
                          ? TXAudioPlayer(
                              link: messageModel.fileModel?.link ?? "",
                              mimeType: messageModel.fileModel?.mimeType ?? "")
                          : TXVideoPlayer(
                              link: messageModel.fileModel?.link ?? ""),
                  messageModel.fileModel?.isUploadingDownloading == true
                      ? Container(
                          width: fileRenderW,
                          height: fileRenderH,
                          child: Center(
                            child: Container(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    R.color.primaryColor),
                                strokeWidth: 3,
                                backgroundColor: null,
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TXTextWidget(
              text:
                  "${messageModel.fileModel?.sizeFixed ?? ""} ${messageModel.fileModel?.mimeType ?? ""}",
            )
          ],
        ),
      ),
    );
  }

  void navigateToFiles(BuildContext context,
      {ChannelModel? channelModel, FolderModel? selectedFolder}) {
    if (selectedFolder != null &&
        selectedFolder.tid != bloc.joinedTeam?.team.id) {
      bloc.showErrorMessageFromString(R.string.folderIsNotInCurrentTeam);
    } else {
      NavigationUtils.push(
          context,
          FilesExplorerPage(
            channels: bloc.joinedTeam!.channels,
            groups: bloc.joinedTeam!.groups,
            messages1x1: bloc.joinedTeam!.messages1x1,
            members: bloc.joinedTeam!.memberWrapperModel.list,
            selectedChannel: channelModel,
            selectedFolder: selectedFolder,
          ));
    }
  }

  Widget _getMessageDateDivider(MessageModel messageModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TXDividerWidget(),
              ),
              SizedBox(
                width: 5,
              ),
              TXTextWidget(
                text: CalendarUtils.showInFormat(
                        R.string.dateFormat3, messageModel.ts) ??
                    "",
                color: R.color.blackColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: TXDividerWidget(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  void showShareContentView(ShareContentModel shareContentModel) async {
    showTXModalBottomSheet(
        context: context,
        builder: (context) {
          return ShareExternalWidget(
            content: shareContentModel.content,
            isFile: shareContentModel.isFile,
          );
        });
  }

  void _showDialogLogout({required BuildContext context}) {
    txShowWaringDialogMaterial(context,
        title: TXTextWidget(
          text: R.string.logout,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: R.color.darkColor,
          size: 16,
        ), onAction: (action) async {
      if (action) {
        final event = await bloc.logout();
        if (event) NavigationUtils.pushReplacement(context, LoginPage());
      }
    },
        content: Container(
          child: TXTextWidget(
            text: R.string.closeSessionConfirmation,
            color: R.color.grayDarkestColor,
          ),
        ));
  }
}
