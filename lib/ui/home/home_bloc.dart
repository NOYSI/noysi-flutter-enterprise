import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/_res/values/config.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/data/repository/team_repository.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/domain/app_common_model.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/common_db/i_common_dao.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/meet/meeting_model.dart';
import 'package:code/domain/message/i_message_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/thread/i_thread_repository.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/fcm/fcm_controller.dart';
import 'package:code/fcm/fcm_message_model.dart';
import 'package:code/global_regexp.dart';
import 'package:code/rtc/i_rtc_manager.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/rtc/rtc_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/home/tx_drawer_chat_item_widget.dart';
import 'package:code/ui/home/tx_home_app_bar_widget.dart';
import 'package:code/ui/task/task_page.dart';
import 'package:code/ui/task_detail/task_detail_page.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uuid/uuid.dart';

import '../../app.dart';
import '../../data/file_cache_manager.dart';
import '../../enums.dart';
import '../../utils/common_utils.dart';

BehaviorSubject<bool> joinedTeamLocally = BehaviorSubject.seeded(false);

class HomeBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final ITeamRepository _iTeamRepository;
  final IThreadRepository _iThreadRepository;
  final IUserRepository _iUserRepository;
  final SharedPreferencesManager _prefs;
  final IRTCManager _irtcManager;
  final IMessageRepository _iMessageRepository;
  final IChannelRepository _iChannelRepository;
  final InMemoryData inMemoryData;
  final IFileRepository _iFileRepository;
  final ITaskRepository _iTaskRepository;
  final ICommonDao _iCommonDao;
  final IAccountRepository _iAccountRepository;

  HomeBloC(
      this._iTeamRepository,
      this._iThreadRepository,
      this._prefs,
      this._iUserRepository,
      this._irtcManager,
      this._iMessageRepository,
      this._iChannelRepository,
      this.inMemoryData,
      this._iFileRepository,
      this._iTaskRepository,
      this._iAccountRepository,
      this._iCommonDao);

  @override
  void dispose() {
    _currentMemberController.close();
    _unreadTeamsController.close();
    _unreadCalendarController.close();
    _openTasksController.close();
    _chatRoomController.close();
    _drawerChatModelListController.close();
    _answerInMessageController.close();
    _initController.close();
    reverseFloatingButton.close();
    refreshScroll.close();
    messageArrivedForThisChannel.close();
    _inputWidgetSizeController.close();
    _teamController.close();
    userDisabledController.close();
    _fullScreenLoadingController.close();
    _appVersionController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<bool> _fullScreenLoadingController = BehaviorSubject();

  Stream<bool> get fullScreenLoadingResult =>
      _fullScreenLoadingController.stream;

  BehaviorSubject<RTCMemberDisabledEnabledModel> userDisabledController =
      new BehaviorSubject();

  BehaviorSubject<Size> _inputWidgetSizeController = new BehaviorSubject();

  Stream<Size> get inputWidgetSizeResult => _inputWidgetSizeController.stream;

  BehaviorSubject<int> _initController = new BehaviorSubject();

  Stream<int> get initResult => _initController.stream;

  BehaviorSubject<MemberModel> _currentMemberController = new BehaviorSubject();

  Stream<MemberModel> get currentMemberResult =>
      _currentMemberController.stream;

  BehaviorSubject<ChatRoomUIModel> _chatRoomController = new BehaviorSubject();

  Stream<ChatRoomUIModel> get chatRoomResult => _chatRoomController.stream;

  BehaviorSubject<List<DrawerChatModel>> _drawerChatModelListController =
      new BehaviorSubject.seeded([]);

  Stream<List<DrawerChatModel>> get drawerChatModelListResult =>
      _drawerChatModelListController.stream;

  final BehaviorSubject<MessageModel?> _answerInMessageController =
      BehaviorSubject();

  Stream<MessageModel?> get answerInMessageResult =>
      _answerInMessageController.stream;

  final BehaviorSubject<MessageModel?> _pinnedMessageController = BehaviorSubject();

  Stream<MessageModel?> get pinnedMessageResult => _pinnedMessageController.stream;

  BehaviorSubject<int> _unreadTeamsController = new BehaviorSubject.seeded(0);

  Stream<int> get unreadTeamsResult => _unreadTeamsController.stream;

  BehaviorSubject<int> _unreadCalendarController = new BehaviorSubject();

  Stream<int> get unreadCalendarResult => _unreadCalendarController.stream;

  BehaviorSubject<TeamModel> _teamController = new BehaviorSubject();

  Stream<TeamModel> get teamResult => _teamController.stream;

  BehaviorSubject<bool> reverseFloatingButton = new BehaviorSubject();

  BehaviorSubject<int> _openTasksController = new BehaviorSubject();

  Stream<int> get openTasksResult => _openTasksController.stream;

  BehaviorSubject<String> _appVersionController = BehaviorSubject();

  Stream<String> get appVersionResult => _appVersionController.stream;

  BehaviorSubject<DrawerConfig> _drawerConfigController = BehaviorSubject();

  Stream<DrawerConfig> get drawerConfigResult => _drawerConfigController.stream;

  MessageModel? currentMessageSelected;
  TeamJoinedModel? joinedTeam;
  bool isLoadingMorePreviousMessages = false;
  bool hasMorePreviousMessages = true;
  bool isLoadingMoreNextMessages = false;
  bool hasMoreNextMessages = true;
  bool socketInitialized = false;

  List<DrawerChatModel> get drawerChatList =>
      _drawerChatModelListController.value;

  void disposeOnBackground() {
    joinedTeamLocally.sinkAddSafe(false);
    socketInitialized = false;
    _irtcManager.disposeRTC();
  }

  void init() async {
    if (Injector.instance.env == Environment.DEV) {
      String currentUrl = await _prefs.getStringValue(_prefs.baseUrl);
      if (currentUrl != Endpoint.apiBaseUrlDev) {
        await _prefs.init();
        await _prefs.setStringValue(_prefs.baseUrl, Endpoint.apiBaseUrlDev);
      }
    } else {
      String currentUrl = await _prefs.getStringValue(_prefs.baseUrl);
      if (currentUrl != Endpoint.apiBaseUrlProd) {
        await _prefs.init();
        await _prefs.setStringValue(_prefs.baseUrl, Endpoint.apiBaseUrlProd);
      }
    }

    bool cleanDB =
        await _prefs.getBoolValue(_prefs.cleanLocalDB, defValue: true);
    if (cleanDB) {
      await _prefs.setBoolValue(_prefs.cleanLocalDB, false);
      await _iCommonDao.cleanDB();
    }

    bool firstUser = await _prefs.getBoolValue(_prefs.firstUse);
    if (firstUser) {
      _initController.sinkAddSafe(0);
    } else {
      String currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
      String accessToken = await _prefs.getStringValue(_prefs.accessToken);
      String currentTeamName =
          await _prefs.getStringValue(_prefs.currentTeamName);

      if (accessToken.isEmpty ||
          currentTeamId.isEmpty ||
          currentTeamName.isEmpty) {
        _initController.sinkAddSafe(1);
      } else {
        loadData(fromInit: true);
      }
      await _prefs.setBoolValue(_prefs.firstUse, false);
    }
  }

  StreamSubscription? ss;
  void loadData({bool fromInit = false}) async {
    isLoading = true;
    _loadAppVersion();
    await _loadDrawerConfig();

    ///Joining team
    await joinTeam();
    joinedTeamLocally.sinkAddSafe(true);

    ///Initializing RT
    if (!socketInitialized) {
      socketInitialized = true;
      _irtcManager.initRTC();
      sendUserPresence(UserPresence.online);
    }

    selectChatRoom(inMemoryData.currentChannel!,
            forceReload: true, fromInit: fromInit)
        .then((value2) async {
      await ss?.cancel();
      ss = joinedTeamLoaded.listen((value) {
        if (value != null && waitingForJoinedTeam) {
          onJoinedTeamLoadedFromApi(value);
          joinedTeamLoaded.sinkAddSafe(null);
        }
        ss?.cancel();
      });
    });
    checkUnreadTeams();
    checkUnreadTeamsAppBadge();
    checkUnreadCalendar();
    resolveOpenTasksCount();
  }

  void reloadDataOnWSSReconnected({bool loadChannelMessages = true}) async {
    onWSSReconnected.sinkAddSafe(false);
    // if(!fcmResumedFromBackground) {
    //   var currentTeamName = await _prefs.getStringValue(_prefs.currentTeamName);
    //   var currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    //   final teamRes = await _iTeamRepository.joinTeam(currentTeamName, currentTeamId, forceApi: true);
    //   if(loadChannelMessages) {
    //     hasMoreNextMessages = true;
    //     loadNextMessages().then((value) async {
    //       if(teamRes is ResultSuccess<TeamJoinedModel> && teamRes.value.team.id == (await getCurrentTeamId)) {
    //         waitingForJoinedTeam = true;
    //         onJoinedTeamLoadedFromApi(teamRes.value);
    //       }
    //       _iChannelRepository.putChannelMemberMark(inMemoryData.currentChannel!);
    //     });
    //   } else if(teamRes is ResultSuccess<TeamJoinedModel> && teamRes.value.team.id == (await getCurrentTeamId)) {
    //     waitingForJoinedTeam = true;
    //     onJoinedTeamLoadedFromApi(teamRes.value);
    //   }
    //   checkUnreadTeams();
    //   checkUnreadCalendar();
    //   resolveOpenTasksCount();
    // }
  }

  void answerInMessageAction(MessageModel? messageModel) {
    //currentMessageSelected = messageModel;
    messageDismissed.sink.add(true);
    _answerInMessageController.sinkAddSafe(messageModel);
  }

  int badgeCount = 0;
  bool isUpdatingBadge = false;
  void checkUnreadTeamsAppBadge() async {
    if(!isUpdatingBadge && await FlutterAppBadger.isAppBadgeSupported()) {
      isUpdatingBadge = true;
      final teamsRes = await _iTeamRepository.getTeams();
      badgeCount = 0;
      if (teamsRes is ResultSuccess<List<TeamModel>>) {
        List<Future> futures = [];
        for (var t in teamsRes.value) {
          futures.add(_iTeamRepository.teamMessagesUnreadCount(t.id));
        }
        final result = await Future.wait(futures);
        for (var res in result) {
          if (res is ResultSuccess<int>) {
            badgeCount += res.value;
          }
        }
      }
      FlutterAppBadger.updateBadgeCount(badgeCount);
      isUpdatingBadge = false;
    }
  }

  void checkUnreadTeams() async {
    String currentTeamId = await getCurrentTeamId;
    final teamsRes = await _iTeamRepository.getTeams();
    int unread = 0;
    if (teamsRes is ResultSuccess<List<TeamModel>>) {
      if (currentTeamId.isEmpty) currentTeamId = teamsRes.value[0].id;
      List<Future> futures = [];
      teamsRes.value.forEach((t) {
        if (t.id != currentTeamId)
          futures.add(_iTeamRepository.teamMessagesUnreadCount(t.id));
      });
      final result = await Future.wait(futures);
      result.forEach((res) {
        if (res is ResultSuccess<int>) {
          unread += res.value;
        }
      });
    }
    _unreadTeamsController.sinkAddSafe(unread);
  }

  void resolveNavigationOnFCMNotiArrive(PayloadModel payloadModel) async {
    //final payloadSplit = payloadModel.payload.split("---");
    // final teamName = payloadSplit[0];
    // final tid = payloadSplit[1];
    // final cid = payloadSplit[2];
    if (payloadModel.payload.action != fcmMessageActions.MESSAGE) {
      FlutterCallkitIncoming.endAllCalls();
      onCallingMeBackground(payloadModel.payload);
      return;
    }
    final teamName = payloadModel.payload.teamName;
    final tid = payloadModel.payload.tid;
    final cid = payloadModel.payload.cid;

    final currentTeam = await getCurrentTeamId;
    ChannelModel? channel;
    MemberModel? other;

    if (tid == currentTeam) {
      channel = ((joinedTeam?.groups ?? []) +
              (joinedTeam?.messages1x1 ?? []) +
              (joinedTeam?.channels ?? []))
          .firstWhereOrNull((element) => element.id == cid);
      if (channel != null && (channel.isM1x1 == true)) {
        other = joinedTeam?.memberWrapperModel.list
            .firstWhereOrNull((element) => element.id == channel?.other);
      }
    }

    if (channel == null || ((channel.isM1x1 == true) && other == null)) {
      final resChannel = await _iChannelRepository.getChannel(tid, cid);
      if (resChannel is ResultSuccess<ChannelModel>) {
        channel = resChannel.value;
        if (resChannel.value.isM1x1) {
          final resMember =
              await _iUserRepository.getTeamMember(tid, resChannel.value.other);
          if (resMember is ResultSuccess<MemberModel>) {
            other = resMember.value;
          }
        }
      }
    }

    if (channel == null || ((channel.isM1x1 == true) && other == null)) {
      showErrorMessageFromString(R.string.errorFetchingData);
    } else {
      await _prefs.setStringValue(_prefs.currentChatId, cid);
      if (tid == currentTeam) {
        changeChannelAuto(ChannelCreatedUI(
            members: channel.isM1x1 ? [other!] : [], channelModel: channel));
      } else {
        await _prefs.setStringValue(_prefs.currentTeamName, teamName);
        await _prefs.setStringValue(_prefs.currentTeamId, tid);
        // _chatRoomController.sinkAddSafe(ChatRoomUIModel(
        //   messageWrapperModel: MessageWrapperModel(more: false, list: []),
        // ));
        Result res;
        avoidOnChannelOpen = true;
        if (channel.isM1x1) {
          res = await _iChannelRepository.create1x1Channel(other!, tid: tid);
        } else {
          res = await _iChannelRepository.putChannelMember(
              tid, channel.id, (await _prefs.getStringValue(_prefs.userId)));
        }
        if (res is ResultSuccess<ChannelModel>) {
          loadData();
        } else {
          avoidOnChannelOpen = false;
          showErrorMessageFromString(R.string.errorFetchingData);
        }
      }
    }
  }

  Future<String> get getCurrentTeamId async =>
      await _prefs.getStringValue(_prefs.currentTeamId);

  void changeTeam(TeamModel team) async {
    await _prefs.setStringValue(_prefs.currentTeamId, team.id);
    await _prefs.setStringValue(_prefs.currentTeamName, team.name);
    await _prefs.setStringValue(_prefs.currentChatId, "");
    _chatRoomController.sinkAddSafe(ChatRoomUIModel(
      messageWrapperModel: MessageWrapperModel(more: false, list: []),
    ));
    loadData();
  }

  void updateHeadersTranslation() {
    List<DrawerChatModel> list = _drawerChatModelListController.value;
    list.forEach((element) {
      if (!element.isChild) {
        switch (element.drawerHeaderChatType) {
          case DrawerHeaderChatType.Channel:
            element.title = R.string.openChannels.toLowerCase();
            break;
          case DrawerHeaderChatType.Message1x1:
            element.title = R.string.message1x1.toLowerCase();
            break;
          case DrawerHeaderChatType.PrivateGroup:
            element.title = R.string.privateGroups.toLowerCase();
            break;
          case DrawerHeaderChatType.Favorite:
            element.title = R.string.favorites.toLowerCase();
            break;
          default:
            element.title = R.string.allThreads.toLowerCase();
            break;
        }
      }
    });
    _drawerChatModelListController.sinkAddSafe(list);
  }

  Future<void> onJoinedTeamLoadedFromApi(TeamJoinedModel jTeam) async {
    if (waitingForJoinedTeam && jTeam.team.id == lastJoinedTeam) {
      waitingForJoinedTeam = false;
      joinedTeam = jTeam;
      inMemoryData.currentTeam = jTeam.team;
      _teamController.sinkAddSafe(jTeam.team);
      teamThemeController.sinkAddSafe(jTeam.team.theme);

      if (jTeam.team.cname?.enabled == true &&
          jTeam.team.cname?.domain?.isNotEmpty == true) {
        await _prefs.setStringValue(
            _prefs.currentTeamCname, jTeam.team.cname!.domain!);
        if(jTeam.team.enterprise?.enabled == true && inMemoryData.currentWhiteBrandConfig == null) {
          final wbConfig = await _getWhiteBrandConfig(jTeam.team.cname!.domain!);
          await _prefs.setBoolValue(
              _prefs.currentTeamEnterprise, wbConfig?.enabled == true);
          if(wbConfig?.enabled == true) {
            inMemoryData.currentWhiteBrandConfig = wbConfig;
            Endpoint.cnameHelp = wbConfig?.helpUrl ?? "";
          } else {
            inMemoryData.currentWhiteBrandConfig = null;
            Endpoint.cnameHelp = "";
          }
        } else if (jTeam.team.enterprise?.enabled == false && inMemoryData.currentWhiteBrandConfig != null) {
          await _prefs.setBoolValue(_prefs.currentTeamEnterprise, false);
          Endpoint.cnameHelp = "";
          inMemoryData.currentWhiteBrandConfig = null;
        }
      } else {
        await _prefs.setStringValue(_prefs.currentTeamCname, "");
        await _prefs.setBoolValue(_prefs.currentTeamEnterprise, false);
        Endpoint.cnameHelp = "";
        inMemoryData.currentWhiteBrandConfig = null;
      }

      ///Setting in-memory and prefs current member
      String email = await _prefs.getStringValue(_prefs.email);
      final currentMember = jTeam.memberWrapperModel.list
          .firstWhere((element) => element.profile?.email == email);
      inMemoryData.currentMember = currentMember;
      _currentMemberController.sinkAddSafe(currentMember);

      _changeLang(currentMember.profile?.language);

      List<DrawerChatModel> drawerChatModelList = [];
      List<ChannelModel> allCurrentTeamChannels = [];
      allCurrentTeamChannels.addAll(jTeam.channels);
      allCurrentTeamChannels.addAll(jTeam.groups);
      allCurrentTeamChannels.addAll(jTeam.messages1x1);

      final tIdx = (_drawerChatModelListController.value).indexWhere(
          (element) =>
              element.drawerHeaderChatType == DrawerHeaderChatType.Thread);
      if (tIdx >= 0) {
        drawerChatModelList.add(_drawerChatModelListController.value[tIdx]);
      } else {
        await resolveThreadsCount(drawerChatModelList);
      }

      final favorites = allCurrentTeamChannels
          .where((element) => element.isFavorite == true)
          .toList();

      if (favorites.isNotEmpty) {
        drawerChatModelList.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Favorite,
          isChild: false,
          title: R.string.favorites.toLowerCase(),
          childrenCount: favorites.length,
        ));
      }

      ///Adding channels header
      drawerChatModelList.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.Channel,
        isChild: false,
        title: R.string.openChannels.toLowerCase(),
        childrenCount: joinedTeam?.channels.length ?? 0,
      ));

      ///Adding channels
      joinedTeam?.channels.forEach((element) {
        drawerChatModelList.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Channel,
          isChild: true,
          channelModel: element,
          title: element.titleFixed,
          isSelected: inMemoryData.currentChannel?.id == element.id,
          unreadMessagesCount: element.unreadCount ?? 0,
        ));
      });

      ///Adding messages 1x1 header
      drawerChatModelList.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
        isChild: false,
        title: R.string.message1x1.toLowerCase(),
        childrenCount: joinedTeam?.memberWrapperModel.total ??
            (joinedTeam?.messages1x1.length ?? 0),
      ));

      ///Adding messages 1x1
      joinedTeam?.messages1x1.forEach((element) {
        final drawerElement = DrawerChatModel(
            drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
            isChild: true,
            isSelected: inMemoryData.currentChannel?.id == element.id,
            channelModel: element,
            title: element.titleFixed,
            unreadMessagesCount: element.unreadCount ?? 0,
            memberModel: joinedTeam?.memberWrapperModel.list
                .firstWhereOrNull((member) => element.other == member.id));
        if (drawerElement.memberModel != null)
          drawerChatModelList.add(drawerElement);
      });

      ///Adding private groups header
      drawerChatModelList.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
        isChild: false,
        title: R.string.privateGroups.toLowerCase(),
        childrenCount: joinedTeam?.groups.length ?? 0,
      ));

      ///Adding private groups
      joinedTeam?.groups.forEach((element) {
        drawerChatModelList.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
          isChild: true,
          isSelected: inMemoryData.currentChannel?.id == element.id,
          channelModel: element,
          title: element.titleFixed,
          unreadMessagesCount: element.unreadCount ?? 0,
        ));
      });

      _drawerChatModelListController.sinkAddSafe(drawerChatModelList);
      print("Team Loaded from API OK");
    }
  }

  bool waitingForJoinedTeam = false;
  String lastJoinedTeam = '';

  void _changeLang(String? code) {
    if (code?.isNotEmpty == true) {
      if (AppConfig.localeCode != code) {
        final res = languageCodeController.valueOrNull;
        if (res != null) {
          res.languageCode = code!;
        }
        _prefs.setStringValue(_prefs.language, code!);
        languageCodeController.sinkAddSafe(res ??
            AppSettingsModel(
              isDarkMode: false,
              languageCode: code,
            ));
        localeChangedController.sinkAddSafe(true);
      }
    }
  }

  Future<WhiteBrandConfig?> _getWhiteBrandConfig(String domain) async {
    final res = await _iTeamRepository.getWhiteBrandConfig(domain);
    if (res is ResultSuccess<WhiteBrandConfig>) {
      return res.value;
    }
    return null;
  }

  Future<void> joinTeam() async {
    List<DrawerChatModel> drawerChatModelLis = [];
    var currentTeamName = await _prefs.getStringValue(_prefs.currentTeamName);
    var currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _iTeamRepository.joinTeam(currentTeamName, teamId: currentTeamId);
    if (res is ResultSuccess<TeamJoinedModel>) {
      waitingForJoinedTeam = true;

      ///In-memory save joined team
      joinedTeam = res.value;

      ///Setting in in-memory and controller current team
      inMemoryData.currentTeam = res.value.team;
      _teamController.sinkAddSafe(res.value.team);

      ///Setting theme
      teamThemeController.sinkAddSafe(res.value.team.theme);

      ///Check cname properties
      if (res.value.team.cname?.enabled == true &&
          res.value.team.cname?.domain?.isNotEmpty == true) {
        await _prefs.setStringValue(
            _prefs.currentTeamCname, res.value.team.cname!.domain!);
        if(res.value.team.enterprise?.enabled == true) {
          final wbConfig = await _getWhiteBrandConfig(res.value.team.cname!.domain!);
          await _prefs.setBoolValue(
              _prefs.currentTeamEnterprise, wbConfig?.enabled == true);
          if(wbConfig?.enabled == true) {
            inMemoryData.currentWhiteBrandConfig = wbConfig;
            Endpoint.cnameHelp = wbConfig?.helpUrl ?? "";
          } else {
            inMemoryData.currentWhiteBrandConfig = null;
            Endpoint.cnameHelp = "";
          }
        } else {
          inMemoryData.currentWhiteBrandConfig = null;
          Endpoint.cnameHelp = "";
          await _prefs.setBoolValue(
              _prefs.currentTeamEnterprise, false);
        }
      } else {
        await _prefs.setStringValue(_prefs.currentTeamCname, "");
        await _prefs.setBoolValue(_prefs.currentTeamEnterprise, false);
        Endpoint.cnameHelp = "";
        inMemoryData.currentWhiteBrandConfig = null;
      }

      ///Setting in-memory and prefs current member
      String email = await _prefs.getStringValue(_prefs.email);
      final currentMember = res.value.memberWrapperModel.list
          .firstWhere((element) => element.profile?.email == email);
      inMemoryData.currentMember = currentMember;
      await _prefs.setStringValue(_prefs.userId, currentMember.id);

      _changeLang(currentMember.profile?.language);

      ///Setting in-memory and prefs current channel
      String currentChatId = await _prefs.getStringValue(_prefs.currentChatId);
      List<ChannelModel> allCurrentTeamChannels = [];
      allCurrentTeamChannels.addAll(res.value.channels);
      allCurrentTeamChannels.addAll(res.value.groups);
      allCurrentTeamChannels.addAll(res.value.messages1x1);

      ChannelModel? currentChat = allCurrentTeamChannels
          .firstWhereOrNull((element) => element.id == currentChatId);
      if (currentChat == null) {
        final generalChannel = res.value.channels
            .firstWhereOrNull((element) => element.general == true);
        if (generalChannel != null) {
          currentChat = generalChannel;
        } else if (res.value.groups.isNotEmpty) {
          currentChat = res.value.groups[0];
        } else if (res.value.channels.isNotEmpty) {
          currentChat = res.value.channels[0];
        } else if (res.value.messages1x1.isNotEmpty) {
          currentChat = res.value.messages1x1[0];
        }
      }
      inMemoryData.currentChannel = currentChat;
      await _prefs.setStringValue(_prefs.currentChatId, currentChat?.id ?? "");

      ///init current user data
      _currentMemberController.sinkAddSafe(inMemoryData.currentMember!);

      ///Getting thread section info in async mode
      resolveThreadsCount(drawerChatModelLis);

      final favorites = allCurrentTeamChannels
          .where((element) => element.isFavorite == true)
          .toList();

      if (favorites.isNotEmpty) {
        drawerChatModelLis.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Favorite,
          isChild: false,
          title: R.string.favorites.toLowerCase(),
          childrenCount: favorites.length,
        ));
      }

      ///Adding channels header
      drawerChatModelLis.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.Channel,
        isChild: false,
        title: R.string.openChannels.toLowerCase(),
        childrenCount: joinedTeam?.channels.length ?? 0,
      ));

      ///Adding channels
      joinedTeam?.channels.forEach((element) {
        drawerChatModelLis.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Channel,
          isChild: true,
          channelModel: element,
          title: element.titleFixed,
          isSelected: inMemoryData.currentChannel?.id == element.id,
          unreadMessagesCount: element.unreadCount ?? 0,
        ));
      });

      ///Adding messages 1x1 header
      drawerChatModelLis.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
        isChild: false,
        title: R.string.message1x1.toLowerCase(),
        childrenCount: joinedTeam?.memberWrapperModel.total ??
            (joinedTeam?.messages1x1.length ?? 0),
      ));

      ///Adding messages 1x1
      joinedTeam?.messages1x1.forEach((element) {
        final drawerElement = DrawerChatModel(
            drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
            isChild: true,
            isSelected: inMemoryData.currentChannel?.id == element.id,
            channelModel: element,
            title: element.titleFixed,
            unreadMessagesCount: element.unreadCount ?? 0,
            memberModel: joinedTeam?.memberWrapperModel.list
                .firstWhereOrNull((member) => element.other == member.id));
        if (drawerElement.memberModel != null)
          drawerChatModelLis.add(drawerElement);
      });

      ///Adding private groups header
      drawerChatModelLis.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
        isChild: false,
        title: R.string.privateGroups.toLowerCase(),
        childrenCount: joinedTeam?.groups.length ?? 0,
      ));

      ///Adding private groups
      joinedTeam?.groups.forEach((element) {
        drawerChatModelLis.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
          isChild: true,
          isSelected: inMemoryData.currentChannel?.id == element.id,
          channelModel: element,
          title: element.titleFixed,
          unreadMessagesCount: element.unreadCount ?? 0,
        ));
      });

      _drawerChatModelListController.sinkAddSafe(drawerChatModelLis);
      lastJoinedTeam = currentTeamId;
    } else {
      showErrorMessage(res);
    }
  }

  ///Getting my open tasks
  void resolveOpenTasksCount() async {
    final res =
        await _iTaskRepository.getTasksCount(inMemoryData.currentTeam!.id);
    if (res is ResultSuccess<int>) {
      _openTasksController.sinkAddSafe(res.value);
    }
  }

  ///Getting unread events
  void checkUnreadCalendar() async {
    String currentTeamId = await getCurrentTeamId;
    final res = await _iTaskRepository.getAppointmentsCount(currentTeamId);
    if (res is ResultSuccess<int>) {
      _unreadCalendarController.sinkAddSafe(res.value);
    }
  }

  ///Getting Unread thread count
  Future<void> resolveThreadsCount(List<DrawerChatModel> drawerChatModelLis,
      {bool toReload = false}) async {
    int threadUnreadCount = 0;
    final threadUnreadRes = await _iThreadRepository
        .getThreadsUnreadCount(inMemoryData.currentTeam!.id);
    if (threadUnreadRes is ResultSuccess<int>)
      threadUnreadCount = threadUnreadRes.value;

    ///Adding Thread header
    final thread = DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Thread,
      isChild: false,
      title: R.string.allThreads.toLowerCase(),
      unreadMessagesCount: threadUnreadCount,
    );
    if (drawerChatModelLis.isEmpty)
      drawerChatModelLis.add(thread);
    else if (drawerChatModelLis.isNotEmpty && toReload)
      drawerChatModelLis.first = thread;
    else
      drawerChatModelLis.insert(0, thread);
    _drawerChatModelListController.sinkAddSafe(drawerChatModelLis);
  }

  void reloadThreadsCount() {
    final drawerChannelList = _drawerChatModelListController.value;
    resolveThreadsCount(drawerChannelList, toReload: true);
  }

  void updateMessageTextAfterEdit(MessageModel model) {
    final chatRoom = _chatRoomController.valueOrNull;
    if (chatRoom != null) {
      final mIndex = chatRoom.messageWrapperModel.list
          .indexWhere((element) => element.id == model.id);
      chatRoom.messageWrapperModel.list[mIndex].text = model.text;
      chatRoom.messageWrapperModel.list[mIndex].html = model.html;
      _chatRoomController.sinkAddSafe(chatRoom);
    }
  }

  ///Add-Remove Favorite channel
  void setFavorite() async {
    final currentChannelList = _drawerChatModelListController.value;
    final currentIndex =
        currentChannelList.indexWhere((element) => element.isSelected);
    currentChannelList[currentIndex].channelModel?.isFavorite =
        !(currentChannelList[currentIndex].channelModel?.isFavorite == true);
    if (currentChannelList[currentIndex].channelModel?.isOpenChannel == true) {
      joinedTeam?.channels
          .firstWhere((element) =>
              element.id == currentChannelList[currentIndex].channelModel?.id)
          .isFavorite = currentChannelList[currentIndex]
              .channelModel
              ?.isFavorite ==
          true;
    } else if (currentChannelList[currentIndex].channelModel?.isPrivateGroup ==
        true) {
      joinedTeam?.groups
          .firstWhere((element) =>
              element.id == currentChannelList[currentIndex].channelModel?.id)
          .isFavorite = currentChannelList[currentIndex]
              .channelModel
              ?.isFavorite ==
          true;
    } else {
      joinedTeam?.messages1x1
          .firstWhere((element) =>
              element.id == currentChannelList[currentIndex].channelModel?.id)
          .isFavorite = currentChannelList[currentIndex]
              .channelModel
              ?.isFavorite ==
          true;
    }
    final favHeaderExists = currentChannelList.firstWhereOrNull((element) =>
            !element.isChild &&
            element.drawerHeaderChatType == DrawerHeaderChatType.Favorite) !=
        null;
    final favCount = currentChannelList
        .where((element) => element.channelModel?.isFavorite == true)
        .length;
    if (favCount > 0 && !favHeaderExists) {
      currentChannelList.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.Favorite,
        isChild: false,
        title: R.string.favorites.toLowerCase(),
        childrenCount: favCount,
      ));
    } else if (favCount == 0 && favHeaderExists) {
      currentChannelList.removeWhere((element) =>
          !element.isChild &&
          element.drawerHeaderChatType == DrawerHeaderChatType.Favorite);
    } else if (favCount > 0 && favHeaderExists) {
      currentChannelList
          .firstWhereOrNull((element) =>
              !element.isChild &&
              element.drawerHeaderChatType == DrawerHeaderChatType.Favorite)
          ?.childrenCount = favCount;
    }
    _iChannelRepository.setFavorite(
        currentChannelList[currentIndex].channelModel?.isFavorite == true);
    _drawerChatModelListController.sinkAddSafe(currentChannelList);
  }

  ///Add-Remove Favorite message
  void setFavoriteMessage(MessageModel messageModel) async {
    messageModel.favorite = !messageModel.favorite;
    final chatRoom = _chatRoomController.valueOrNull;
    if (chatRoom != null) {
      //    final indexM = chatRoom.messageWrapperModel.list.indexWhere((element) => element.id == messageModel.id);
//    chatRoom.messageWrapperModel.list[indexM] = messageModel;
      _chatRoomController.sinkAddSafe(chatRoom);
      _iMessageRepository.setFavorite(messageModel.id);
    }
  }

  ///Conform permanent link
  Future<String> conformMessageLink(MessageModel? messageModel) async {
    final teamId = messageModel?.tid ?? "";
    final messageId = messageModel?.id ?? "";
    final cname = await _prefs.getStringValue(_prefs.currentTeamCname);
    final baseUrl =
        cname.isNotEmpty ? "https://$cname" : Injector.instance.baseUrl;
    return "$baseUrl/a/#/messages/$teamId/${messageModel?.cid ?? ''}/$messageId";
  }

  ///Close chat
//   void closeChannel() async {
//     final currentChannelList = _drawerChatModelListController.value;
//     if (currentChannelList.where((element) => element.isChild).toList().length >
//         1) {
//       final userId = await _prefs.getStringValue(_prefs.userId);
//       final index = currentChannelList.indexWhere((element) =>
//           element?.channelModel?.id == inMemoryData.currentChannel.id);
//       currentChannelList[index].channelModel.joined = false;
//       await _iChannelRepository.putChannelMemberClose(
//           inMemoryData.currentTeam.id,
//           currentChannelList[index].channelModel.id,
//           userId);
// //      currentChannelList.removeAt(index);
//       final indexChild =
//           currentChannelList.indexWhere((element) => element.isChild);
//       currentChannelList[indexChild].isSelected = true;
//       _drawerChatModelListController.sinkAddSafe(currentChannelList);
//       selectChatRoom(currentChannelList[indexChild].channelModel, mark: true);
//     }
//   }

  ///On channel closed -> 1x1
  void onChannelClosed(String teamId, String channelId) async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (currentTeamId == teamId) {
      final currentChannelList = _drawerChatModelListController.value;
      final currentChannelId =
          await _prefs.getStringValue(_prefs.currentChatId);
      currentChannelList
          .removeWhere((element) => element.channelModel?.id == channelId);
      _drawerChatModelListController.sinkAddSafe(currentChannelList);
      final ims = joinedTeam?.messages1x1
          .firstWhereOrNull((element) => element.id == channelId);
      if (ims != null) {
        joinedTeam?.messages1x1
            .removeWhere((element) => element.id == channelId);
        // joinedTeam?.memberWrapperModel.list
        //     .removeWhere((element) => element.id == ims.other);
      }
      if (currentChannelId == channelId) {
        final indexChild =
            currentChannelList.indexWhere((element) => element.isChild);
        currentChannelList[indexChild].isSelected = true;
        selectChatRoom(currentChannelList[indexChild].channelModel!,
            mark: true);
      }
    } else {
      checkUnreadTeams();
    }
    checkUnreadTeamsAppBadge();
  }

  ///On Channel left event
  void onChannelLeft(String teamId, String channelId, String userId) async {
    final currentMemberId = await _prefs.getStringValue(_prefs.userId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (currentMemberId == userId && currentTeamId == teamId) {
      final currentChannelList = _drawerChatModelListController.value;
      final currentChannelId =
          await _prefs.getStringValue(_prefs.currentChatId);
      final toDelete = currentChannelList
          .firstWhereOrNull((element) => element.channelModel?.id == channelId);
      if (toDelete != null) {
        if (toDelete.channelModel?.isPrivateGroup == true) {
          currentChannelList
              .firstWhereOrNull((element) =>
                  !element.isChild &&
                  element.drawerHeaderChatType ==
                      DrawerHeaderChatType.PrivateGroup)
              ?.childrenCount--;
        }
        currentChannelList.remove(toDelete);
        _drawerChatModelListController.sinkAddSafe(currentChannelList);
      }

      // final ims = joinedTeam?.messages1x1
      //     .firstWhere((element) => element.id == channelId, orElse: () => null);
      final pg = joinedTeam?.groups
          .firstWhereOrNull((element) => element.id == channelId);
      final oc = joinedTeam?.channels
          .firstWhereOrNull((element) => element.id == channelId);

      // if (ims != null) {
      //   joinedTeam?.messages1x1
      //       .removeWhere((element) => element.id == channelId);
      //   joinedTeam?.memberWrapperModel.list
      //       .removeWhere((element) => element.id == ims.other);
      // }
      if (pg != null) {
        joinedTeam?.groups
            .firstWhere((element) => element.id == toDelete?.channelModel?.id)
            .joined = false;
      } else if (oc != null) {
        joinedTeam?.channels
            .removeWhere((element) => element.id == toDelete?.channelModel?.id);
      }

      if (currentChannelId == channelId) {
        final indexChild =
            currentChannelList.indexWhere((element) => element.isChild);
        currentChannelList[indexChild].isSelected = true;
        selectChatRoom(currentChannelList[indexChild].channelModel!,
            mark: true);
      }
    } else if (currentTeamId != teamId) {
      checkUnreadTeams();
    }
    checkUnreadTeamsAppBadge();
  }

  ///Leave channel
  void leaveChannel() async {
    final currentChannelList = _drawerChatModelListController.value;
    final memberId = await _prefs.getStringValue(_prefs.userId);
    final teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final channelId = await _prefs.getStringValue(_prefs.currentChatId);
    final toDelete = currentChannelList
        .firstWhereOrNull((element) => element.channelModel?.id == channelId);
    if (toDelete?.channelModel?.isM1x1 == true) {
      _iChannelRepository.putChannelMemberClose(teamId, channelId, memberId);
      _iChannelRepository.putChannelMemberMark(toDelete!.channelModel!);
    } else {
      _iChannelRepository.deleteChannelMember(teamId, channelId, memberId);
    }
  }

  ///On channel deleted event
  void onChannelDeleted(String teamId, String channelId) async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (currentTeamId == teamId) {
      final currentChannelId =
          await _prefs.getStringValue(_prefs.currentChatId);
      final currentChannelList = _drawerChatModelListController.value;
      final toDelete = currentChannelList
          .firstWhereOrNull((element) => element.channelModel?.id == channelId);
      if (toDelete != null) {
        if (toDelete.channelModel?.isOpenChannel == true) {
          currentChannelList
              .firstWhereOrNull((element) =>
                  !element.isChild &&
                  element.drawerHeaderChatType == DrawerHeaderChatType.Channel)
              ?.childrenCount--;
        } else if (toDelete.channelModel?.isPrivateGroup == true) {
          currentChannelList
              .firstWhereOrNull((element) =>
                  !element.isChild &&
                  element.drawerHeaderChatType ==
                      DrawerHeaderChatType.PrivateGroup)
              ?.childrenCount--;
        }
        currentChannelList.remove(toDelete);
        _drawerChatModelListController.sinkAddSafe(currentChannelList);
      }
      // final ims = joinedTeam?.messages1x1
      //     .firstWhere((element) => element.id == channelId, orElse: () => null);
      final pg = joinedTeam?.groups
          .firstWhereOrNull((element) => element.id == channelId);
      final oc = joinedTeam?.channels
          .firstWhereOrNull((element) => element.id == channelId);

      // if (ims != null) {
      //   joinedTeam?.messages1x1
      //       .removeWhere((element) => element.id == channelId);
      //   joinedTeam?.memberWrapperModel.list
      //       .removeWhere((element) => element.id == ims.other);
      // }
      if (pg != null) {
        joinedTeam?.groups.removeWhere((element) => element.id == channelId);
      } else if (oc != null) {
        joinedTeam?.channels.removeWhere((element) => element.id == channelId);
      }

      if (channelId == currentChannelId) {
        final indexChild =
            currentChannelList.indexWhere((element) => element.isChild);
        currentChannelList[indexChild].isSelected = true;
        selectChatRoom(currentChannelList[indexChild].channelModel!,
            mark: true);
      }
    } else {
      checkUnreadTeams();
    }
    checkUnreadTeamsAppBadge();
  }

  ///Delete channel
  void deleteChannel() async {
    final teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final channelId = await _prefs.getStringValue(_prefs.currentChatId);
    _iChannelRepository.deleteChannel(teamId, channelId);
  }

  ///Automatically redirect to channel
  Future<void> changeChannelAuto(ChannelCreatedUI channelCreatedUI) async {
    final currentChannelList = _drawerChatModelListController.value;
    // final channel = currentChannelList?.firstWhere(
    //     (element) =>
    //         element?.channelModel?.id == channelCreatedUI.channelModel.id,
    //     orElse: () {
    //   return null;
    // });
    final index = currentChannelList.indexWhere((element) =>
        element.channelModel?.id == channelCreatedUI.channelModel.id);
    final memberId = await _prefs.getStringValue(_prefs.userId);
    channelCreatedUI.channelModel.joined = true;
    channelCreatedUI.channelModel.open = true;
    if (index >= 0) {
      currentChannelList[index].channelModel = channelCreatedUI.channelModel;
      _iChannelRepository.putChannelMember(channelCreatedUI.channelModel.tid!,
          channelCreatedUI.channelModel.id, memberId);
      await selectChatRoom(channelCreatedUI.channelModel,
          forceReload: true,
          mark: true,
          lastReadMessage: channelCreatedUI.lastReadMessage,
          fromSearchPage: channelCreatedUI.fromSearchMessage);
    } else {
      final drawerChatModel = DrawerChatModel(
        drawerHeaderChatType: channelCreatedUI.channelModel.isM1x1
            ? DrawerHeaderChatType.Message1x1
            : channelCreatedUI.channelModel.isPrivateGroup
                ? DrawerHeaderChatType.PrivateGroup
                : DrawerHeaderChatType.Channel,
        isChild: true,
        isSelected: true,
        channelModel: channelCreatedUI.channelModel,
        title: channelCreatedUI.channelModel.titleFixed,
        unreadMessagesCount: channelCreatedUI.channelModel.unreadCount ?? 0,
      );
      if (drawerChatModel.drawerHeaderChatType ==
          DrawerHeaderChatType.Message1x1) {
        drawerChatModel.memberModel = channelCreatedUI.members[0];
        drawerChatModel.channelModel?.uid = channelCreatedUI.members[0].id;

        int mIdx = joinedTeam?.memberWrapperModel.list.indexWhere(
                (element) => element.id == channelCreatedUI.members[0].id) ??
            -1;
        if (mIdx >= 0) {
          joinedTeam?.memberWrapperModel.list[mIdx] =
              channelCreatedUI.members[0];
        } else {
          joinedTeam?.memberWrapperModel.list.add(channelCreatedUI.members[0]);
        }
        int cIdx = joinedTeam?.messages1x1.indexWhere(
                (element) => element.id == drawerChatModel.channelModel?.id) ??
            -1;
        if (cIdx < 0) {
          joinedTeam?.messages1x1.add(drawerChatModel.channelModel!);
        }
        inMemoryData.addReplaceMember(channelCreatedUI.members[0]);
        inMemoryData.addReplaceChannel(channelCreatedUI.channelModel);
      } else if (drawerChatModel.drawerHeaderChatType ==
          DrawerHeaderChatType.PrivateGroup) {
        int cIdx = joinedTeam?.groups.indexWhere(
                (element) => element.id == drawerChatModel.channelModel?.id) ??
            -1;
        if (cIdx < 0) {
          joinedTeam?.groups.add(drawerChatModel.channelModel!);
        }
        currentChannelList
            .firstWhereOrNull((element) =>
                !element.isChild &&
                element.drawerHeaderChatType ==
                    DrawerHeaderChatType.PrivateGroup)
            ?.childrenCount++;
      } else {
        int cIdx = joinedTeam?.channels.indexWhere(
                (element) => element.id == drawerChatModel.channelModel?.id) ??
            -1;
        if (cIdx < 0) {
          joinedTeam?.channels.add(drawerChatModel.channelModel!);
        }
        if (channelCreatedUI.newCreated) {
          currentChannelList
              .firstWhereOrNull((element) =>
                  !element.isChild &&
                  element.drawerHeaderChatType == DrawerHeaderChatType.Channel)
              ?.childrenCount++;
        }
      }

      int indexOfHeaderGroup = currentChannelList.indexWhere((element) =>
          element.drawerHeaderChatType == drawerChatModel.drawerHeaderChatType);

      if (indexOfHeaderGroup >= currentChannelList.length - 1) {
        currentChannelList.add(drawerChatModel);
      } else {
        currentChannelList.insert(indexOfHeaderGroup + 1, drawerChatModel);
      }

      if (drawerChatModel.drawerHeaderChatType ==
          DrawerHeaderChatType.Message1x1) {
        _iChannelRepository.create1x1Channel(channelCreatedUI.members[0]);
      } else {
        _iChannelRepository.putChannelMember(channelCreatedUI.channelModel.tid!,
            channelCreatedUI.channelModel.id, memberId);
      }

      ///Cleaning current messages in Room
      final newChatRoomUIModel = ChatRoomUIModel(
        messageWrapperModel: MessageWrapperModel(more: false, list: []),
      );
      _chatRoomController.sinkAddSafe(newChatRoomUIModel);
      _drawerChatModelListController.sinkAddSafe(currentChannelList);

      await Future.delayed(Duration(milliseconds: 100));
      await selectChatRoom(channelCreatedUI.channelModel,
          forceReload: true,
          mark: true,
          lastReadMessage: channelCreatedUI.lastReadMessage,
          fromSearchPage: channelCreatedUI.fromSearchMessage);
    }
  }

  ///Search and replace channel
  void searchAndReplace(ChannelModel channelModel) {
    final list = _drawerChatModelListController.value;
    final channelIndex = list
        .indexWhere((element) => element.channelModel?.id == channelModel.id);
    if (channelIndex >= 0) {
      list[channelIndex].channelModel = channelModel;
      list[channelIndex].title = channelModel.titleFixed;
    }
    inMemoryData.addReplaceChannel(channelModel);
    int joinedTeamIndex = -1;
    if (channelModel.isM1x1) {
      joinedTeamIndex = joinedTeam?.messages1x1
              .indexWhere((element) => element.id == channelModel.id) ??
          -1;
      if (joinedTeamIndex > -1)
        joinedTeam?.messages1x1[joinedTeamIndex] = channelModel;
    } else if (channelModel.isOpenChannel) {
      joinedTeamIndex = joinedTeam?.channels
              .indexWhere((element) => element.id == channelModel.id) ??
          -1;
      if (joinedTeamIndex > -1)
        joinedTeam?.channels[joinedTeamIndex] = channelModel;
    } else {
      joinedTeamIndex = joinedTeam?.groups
              .indexWhere((element) => element.id == channelModel.id) ??
          -1;
      if (joinedTeamIndex > -1)
        joinedTeam?.groups[joinedTeamIndex] = channelModel;
    }
    _drawerChatModelListController.sinkAddSafe(list);
  }

  void onChannelNotificationUpdated(RTCChannelNotificationUpdated model) async {
    if (model.tid == joinedTeam?.team.id &&
        model.uid == (await _prefs.getStringValue(_prefs.userId))) {
      final list = _drawerChatModelListController.value;
      final channelIndex =
          list.indexWhere((element) => element.channelModel?.id == model.cid);
      if (channelIndex >= 0) {
        list[channelIndex].channelModel?.notifications = model.notifications;
      }
      final chMemory = inMemoryData
          .getChannels()
          .firstWhereOrNull((element) => element.id == model.cid);
      if (chMemory != null) {
        chMemory.notifications = model.notifications;
        inMemoryData.addReplaceChannel(chMemory);
      }
      int joinedTeamIndex = -1;

      joinedTeamIndex = joinedTeam?.messages1x1
              .indexWhere((element) => element.id == model.cid) ??
          -1;
      if (joinedTeamIndex > -1)
        joinedTeam?.messages1x1[joinedTeamIndex].notifications =
            model.notifications;

      if (joinedTeamIndex < 0) {
        joinedTeamIndex = joinedTeam?.channels
                .indexWhere((element) => element.id == model.cid) ??
            -1;
        if (joinedTeamIndex > -1)
          joinedTeam?.channels[joinedTeamIndex].notifications =
              model.notifications;
      }

      if (joinedTeamIndex < 0) {
        joinedTeamIndex = joinedTeam?.groups
                .indexWhere((element) => element.id == model.cid) ??
            -1;
        if (joinedTeamIndex > -1)
          joinedTeam?.groups[joinedTeamIndex].notifications =
              model.notifications;
      }

      _drawerChatModelListController.sinkAddSafe(list);
    }
  }

  void onMemberNotificationsUpdated(RTCMemberNotificationsUpdated model) async {
    final currentMember = _currentMemberController.valueOrNull;
    if (currentMember != null) {
      final uid = await _prefs.getStringValue(_prefs.userId);
      currentMember.notifications = model.notifications;
      _currentMemberController.sinkAddSafe(currentMember);
      joinedTeam?.memberWrapperModel.list
          .firstWhereOrNull((element) => element.id == uid)
          ?.notifications = model.notifications;
      inMemoryData.currentMember?.notifications = model.notifications;
      inMemoryData.addReplaceMember(inMemoryData.currentMember!);
    }
  }

  void sendMessage(String text) async {
    Iterable<RegExpMatch> matches =
        GlobalRegexp.folderLink.allMatches(text).toList();
    if (matches.isEmpty) {
      await _irtcManager.sendMessage(text,
          answerMessage: _answerInMessageController.valueOrNull);
    } else {
      List<Map<String, String>> folders = [];
      matches.forEach((element) {
        final fullUrl = element.group(0)!;
        final team = Uri.decodeFull(element.group(5)!);
        if (team == joinedTeam?.team.name) {
          final channel = Uri.decodeFull(element.group(6)!);
          String path = Uri.decodeFull(element.group(7)!);
          if (!path.endsWith('/')) path = "$path/";
          final folderName = path.split('/')[path.split('/').length - 2];
          String? cid;
          for (int i = 0;
              i < _drawerChatModelListController.value.length && cid == null;
              i++) {
            final d = _drawerChatModelListController.value[i];
            if (d.isChild) {
              if (d.title == channel)
                cid = d.channelModel?.id;
              else if (d.subtitle == channel) cid = d.channelModel?.id;
            }
          }
          if (cid != null && cid.isNotEmpty) {
            bool found = false;
            for (int i = 0; i < folders.length && !found; i++) {
              if (folders[i]['path'] == path) found = true;
            }
            if (!found) {
              folders.add({
                'cid': cid,
                'path': path,
              });
            }
            text = text.replaceFirst(fullUrl, "*$folderName*");
          } else {
            text = text.replaceFirst(fullUrl, "*(${R.string.folderNotFound})*");
          }
        } else {
          text = text.replaceFirst(fullUrl, "*(${R.string.folderNotFound})*");
        }
      });
      await _irtcManager.sendFolderLinkMessage(text, folders,
          answerMessage: _answerInMessageController.valueOrNull);
    }
    currentMessageSelected = null;
    _answerInMessageController.sinkAddSafe(null);
  }

  void addRemoveReaction(String reactionKey) {
    if (currentMessageSelected != null) {
      _iMessageRepository.addRemoveReaction(currentMessageSelected!.tid,
          currentMessageSelected!.cid, currentMessageSelected!.id, reactionKey);
    }
  }

  BehaviorSubject<bool> messageArrivedForThisChannel = BehaviorSubject();

  void onMessageArrived(MessageModel message) async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final currentChannelId = await _prefs.getStringValue(_prefs.currentChatId);
    final currentUserId = await _prefs.getStringValue(_prefs.userId);
    if (message.tid == currentTeamId && message.cid == currentChannelId) {
      final streamData = !isNotInLastMessages
          ? _chatRoomController.valueOrNull
          : lastMessages!;

      ///Resolving answered message
      if (message.links.isNotEmpty == true &&
          message.links.first.contains("#/messages") == true) {
        MessageModel? answeredMessage = streamData?.messageWrapperModel.list
            .firstWhereOrNull(
                (element) => element.id == message.getAnswerMessageId);
        if (answeredMessage == null) {
          final anMesRes = await _iMessageRepository.getMessage(
              inMemoryData.currentTeam!.id,
              inMemoryData.currentChannel!.id,
              message.getAnswerMessageId);
          if (anMesRes is ResultSuccess<MessageModel>) {
            answeredMessage = anMesRes.value;
          }
        }
        message.answerMessage = answeredMessage;
      }

      ///Setting message status
      if (message.messageStatus == MessageStatus.Updated) {
        final index = streamData?.messageWrapperModel.list
                .indexWhere((element) => element.id == message.id) ??
            -1;
        if (index >= 0) {
          streamData?.messageWrapperModel.list[index] = message;
        }
        streamData?.messageWrapperModel.list.forEach((element) {
          if (element.threadMetaParent != null &&
              element.threadMetaChild != null &&
              element.threadMetaChild?.pmid == message.id) {
            element.threadMetaParent?.message = message.text;
          }
        });
        final currentPinnedMessage = getCurrentPinnedMessage();
        if(currentPinnedMessage != null && currentPinnedMessage.id == message.id && currentPinnedMessage.tid == message.tid && currentPinnedMessage.cid == message.cid) {
          _pinnedMessageController.sinkAddSafe(message);
        }
      } else if (message.messageStatus == MessageStatus.Sent) {
        if (message.threadMetaChild != null) {
          final index = streamData?.messageWrapperModel.list.indexWhere(
                  (element) => element.id == message.threadMetaChild?.pmid) ??
              -1;
          final resMessage = await _iMessageRepository.getMessage(
              inMemoryData.currentTeam!.id,
              inMemoryData.currentChannel!.id,
              message.threadMetaChild!.pmid ?? "");
          if (resMessage is ResultSuccess<MessageModel>) {
            resMessage.value.messageStatus = MessageStatus.Sent;
            if (index >= 0) {
              streamData?.messageWrapperModel.list[index] = resMessage.value;
            }
            if (message.threadMetaChild!.showOnChannel) {
              message.threadMetaParent = resMessage.value.threadMetaParent;
              message.threadMetaParent!.message = resMessage.value.text;
              streamData?.messageWrapperModel.list.add(message);
            }
          }
        } else {
          final String ack = message.ack ?? "";
          var pos = -1;
          var m =
              streamData?.messageWrapperModel.list.firstWhereOrNull((element) {
            pos += 1;
            return ack == element.id;
          });
          if (m != null && pos >= 0) {
            streamData?.messageWrapperModel.list[pos] = message;
          } else {
            streamData?.messageWrapperModel.list.add(message);
          }
        }
      } else if (message.messageStatus == MessageStatus.Sending) {
        var mIndex = streamData?.messageWrapperModel.list
                .indexWhere((element) => element.id == message.id) ??
            -1;
        if (mIndex >= 0) {
          streamData?.messageWrapperModel.list[mIndex] = message;
        } else {
          streamData?.messageWrapperModel.list.add(message);
        }
      }

      if (!isNotInLastMessages && streamData != null) {
        _chatRoomController.sinkAddSafe(streamData);
        if (lastMessageBeforeNext != null)
          messageArrivedForThisChannel.sinkAddSafe(true);
      }
    } else if (message.tid == currentTeamId && currentUserId != message.uid) {
      if (message.threadMetaChild != null) {
      } else {
        if (message.messageStatus == MessageStatus.Sent) {
          List<DrawerChatModel> drawerChatModelList =
              _drawerChatModelListController.value;
          bool found = false;
          for (int i = 0; i < drawerChatModelList.length && !found; i++) {
            DrawerChatModel element = drawerChatModelList[i];
            if (element.isChild && element.channelModel?.id == message.cid) {
              found = true;
              element.unreadMessagesCount++;
              drawerChatController.sinkAddSafe(element);
            }
          }
        }

        ///play notification
        bool isMentioned = false;
        for (int i = 0; i < message.mentions.length && !isMentioned; i++) {
          if (message.mentions[i] == currentUserId) {
            isMentioned = true;
          }
        }
        if (InMemoryData.isInForeground &&
            message.announcements.isEmpty &&
            !isMentioned) {
          if(await FlutterAppBadger.isAppBadgeSupported() && !isUpdatingBadge) FlutterAppBadger.updateBadgeCount(++badgeCount);
          ChannelModel? channelNamePrivate = joinedTeam?.groups
              .firstWhereOrNull((element) => message.cid == element.id);
          ChannelModel? channelNamePublic = joinedTeam?.channels
              .firstWhereOrNull((element) => message.cid == element.id);
          ChannelModel? imName = joinedTeam?.messages1x1
              .firstWhereOrNull((element) => message.cid == element.id);

          if (channelNamePublic == null &&
              channelNamePrivate == null &&
              imName == null) {
            final res =
                await _iChannelRepository.getChannel(message.tid, message.cid);
            if (res is ResultSuccess<ChannelModel>) {
              if (res.value.isOpenChannel)
                channelNamePublic = res.value;
              else if (res.value.isPrivateGroup)
                channelNamePrivate = res.value;
              else
                imName = res.value;
            }
          }
          if (channelNamePublic != null ||
              channelNamePrivate != null ||
              imName != null) {
            String channelName = '';
            String channelId = '';
            bool shouldSound = true;
            final currentMember = _currentMemberController.valueOrNull;
            if (channelNamePrivate != null) {
              if (channelNamePrivate.notifications?.alwaysPush == true ||
                  !(currentMember?.notifications?.push == true)) return;
              channelName = channelNamePrivate.titleFixed;
              channelId = channelNamePrivate.id;
              shouldSound = channelNamePrivate.notifications?.sounds == true &&
                  currentMember?.notifications?.sounds ==
                      profileNotificationSound.all.toString().split('.').last;
            } else if (channelNamePublic != null) {
              if (channelNamePublic.notifications?.alwaysPush == true ||
                  !(currentMember?.notifications?.push == true)) return;
              channelName = channelNamePublic.titleFixed;
              channelId = channelNamePublic.id;
              shouldSound = channelNamePublic.notifications?.sounds == true &&
                  currentMember?.notifications?.sounds ==
                      profileNotificationSound.all.toString().split('.').last;
            } else {
              if (imName?.notifications?.alwaysPush == true ||
                  !(currentMember?.notifications?.push == true) ||
                  currentMember?.userPresence != UserPresence.online) return;
              channelId = imName?.id ?? "";
              shouldSound = imName?.notifications?.sounds == true &&
                  currentMember?.notifications?.sounds ==
                      profileNotificationSound.all.toString().split('.').last;
            }
            String uidGuide = message.isTaskNotification
                ? (message.args?.uid ?? "")
                : message.uid;
            String sender = uidGuide == RemoteConstants.noysiRobot && inMemoryData.currentWhiteBrandConfig != null
              ? joinedTeam?.team.titleFixed ?? RemoteConstants.noysiUsername
              : uidGuide == RemoteConstants.noysiRobot
                ? RemoteConstants.noysiUsername
                : (joinedTeam?.memberWrapperModel.list
                        .firstWhereOrNull((element) => element.id == uidGuide)
                        ?.profile
                        ?.name ??
                    "");
            if (sender.isEmpty == true) {
              final res =
                  await _iUserRepository.getTeamMember(message.tid, uidGuide);
              if (res is ResultSuccess<MemberModel>) {
                sender = CommonUtils.getMemberUsername(res.value) ?? "";
              }
            }
            FCMMessageModel notifModel = FCMMessageModel(
              teamName: (await _prefs.getStringValue(_prefs.currentTeamName))
                  .trim()
                  .toLowerCase(),
              channelName: channelName.toLowerCase().trim(),
              cid: channelId,
              image: R.image.logo,
              message: _getMessageText(message),
              tid: currentTeamId,
              sender: sender,
              title: sender,
              notId: math.Random().nextInt(999999),
            );
            if (shouldSound) {
              AudioPlayer player = AudioPlayer(
                  mode: Platform.isAndroid
                      ? PlayerMode.MEDIA_PLAYER
                      : PlayerMode.LOW_LATENCY);
              AudioCache cache =
                  AudioCache(fixedPlayer: player, respectSilence: true);
              cache.play(
                  channelNamePublic != null
                      ? R.sound.openChannelsNotification
                      : R.sound.privateGroupsNotification,
                  isNotification: true);
            }
            localNotificationController.sinkAddSafe(notifModel);
          }
        }
      }
    } else if (message.tid != currentTeamId && currentUserId != message.uid) {
      if (message.threadMetaChild != null) {
      } else {
        final teamRes = await _iTeamRepository.getTeam(message.tid);
        if (teamRes is ResultSuccess<TeamModel>) {
          final selectedTeam = teamRes.value;
          if (message.messageStatus == MessageStatus.Sent) {
            int unreadTeams = _unreadTeamsController.value;
            _unreadTeamsController.sinkAddSafe(++unreadTeams);
          }

          ///play notification
          bool isMentioned = false;
          for (int i = 0; i < message.mentions.length && !isMentioned; i++) {
            if (message.mentions[i] == currentUserId) {
              isMentioned = true;
            }
          }
          if (InMemoryData.isInForeground &&
              message.announcements.isEmpty &&
              !isMentioned) {
            if(await FlutterAppBadger.isAppBadgeSupported() && !isUpdatingBadge) FlutterAppBadger.updateBadgeCount(++badgeCount);
            final resChannel =
                await _iChannelRepository.getChannel(message.tid, message.cid);
            if (resChannel is ResultSuccess<ChannelModel>) {
              ChannelModel? channel, privateGroup, im;
              if (resChannel.value.isOpenChannel)
                channel = resChannel.value;
              else if (resChannel.value.isPrivateGroup)
                privateGroup = resChannel.value;
              else
                im = resChannel.value;
              if (channel != null || privateGroup != null || im != null) {
                String channelName = '';
                String channelId = '';
                final currentMember = _currentMemberController.valueOrNull;
                if (channel != null) {
                  if (channel.notifications?.alwaysPush == true ||
                      !(currentMember?.notifications?.push == true)) return;
                  channelName = channel.titleFixed;
                  channelId = channel.id;
                } else if (privateGroup != null) {
                  if (privateGroup.notifications?.alwaysPush == true ||
                      !(currentMember?.notifications?.push == true)) return;
                  channelName = privateGroup.titleFixed;
                  channelId = privateGroup.id;
                } else {
                  if (im?.notifications?.alwaysPush == true ||
                      !(currentMember?.notifications?.push == true) ||
                      currentMember?.userPresence != UserPresence.online)
                    return;
                  channelId = im?.id ?? "";
                }

                String uidGuide = message.isTaskNotification
                    ? (message.args?.uid ?? "")
                    : message.uid;
                String sender = uidGuide == RemoteConstants.noysiRobot && inMemoryData.currentWhiteBrandConfig != null
                    ? joinedTeam?.team.titleFixed ?? RemoteConstants.noysiUsername
                    : uidGuide == RemoteConstants.noysiRobot
                    ? RemoteConstants.noysiUsername
                    : "";

                if (sender.isEmpty == true) {
                  final res = await _iUserRepository.getTeamMember(
                      selectedTeam.id, uidGuide);
                  if (res is ResultSuccess<MemberModel>) {
                    sender = CommonUtils.getMemberUsername(res.value) ?? '';
                  }
                }
                FCMMessageModel notifModel = FCMMessageModel(
                  teamName: selectedTeam.name,
                  channelName: channelName.toLowerCase().trim(),
                  cid: channelId,
                  image: R.image.logo,
                  message: _getMessageText(message),
                  tid: selectedTeam.id,
                  sender: sender,
                  title: sender,
                  notId: math.Random().nextInt(999999),
                );
                localNotificationController.sinkAddSafe(notifModel);
              }
            }
          }
        }
      }
    }
  }

  String _getMessageText(MessageModel messageModel) {
    String part2 = messageModel.text;

    if (messageModel.isNoysiWelcomeMessageFirstName) {
      part2 = messageModel.getNoysiWelcomeMessageFirstName;
    } else if (messageModel.isNoysiWelcomeMessageLastName) {
      part2 = messageModel.getNoysiWelcomeMessageLastName;
    } else if (messageModel.isNoysiWelcomeMessageDescription) {
      part2 = messageModel.getNoysiWelcomeMessageDescription;
    } else if (messageModel.isNoysiWelcomeMessageInvite) {
      part2 = messageModel.getNoysiWelcomeMessageInvite;
    } else if (messageModel.isNoysiWelcomeMessageDownloads) {
      part2 = messageModel.getNoysiWelcomeMessageDownloads;
    } else if (messageModel.isNoysiWelcomeMessageTimeOut) {
      part2 = messageModel.getNoysiWelcomeMessageTimeoutContent;
    } else if (messageModel.isFolderShareMessage ||
        messageModel.isFolderUploadMessage ||
        messageModel.isFolderLinkMessage) {
      part2 = messageModel.getFolderEventText();
    } else if (messageModel.hasAnswerMessage) {
      part2 = messageModel.links.isNotEmpty == true &&
              messageModel.text.contains(messageModel.links[0])
          ? messageModel.text.replaceAll(messageModel.links[0], "").trim()
          : messageModel.text;
    } else if (messageModel.isIntegrationMessage) {
      part2 = messageModel.getIntegrationMessageContent;
    } else if (messageModel.isChannelsMemberJoined) {
      part2 = messageModel.getChannelsMemberJoinedContent(
          Injector.instance.inMemoryData.getMember(messageModel.uid));
    } else if (messageModel.isChannelsMemberLeft) {
      part2 = messageModel.getChannelsMemberLeftContent(
          Injector.instance.inMemoryData.getMember(messageModel.uid));
    } else if (messageModel.isPinnedMessageNotification) {
      part2 = messageModel.getChannelMessagePinned(Injector.instance.inMemoryData.getMember(messageModel.uid));
    } else if (messageModel.isUnpinnedMessageNotification) {
      part2 = messageModel.getChannelMessageUnpinned(Injector.instance.inMemoryData.getMember(messageModel.uid));
    } else if (messageModel.isFileComment) {
      part2 =
          "${R.string.newFileComment}${messageModel.args?.title ?? ""} ${messageModel.text}";
    } else if (messageModel.isTaskNotification) {
      part2 = "${messageModel.taskEvent} ${messageModel.args?.title ?? ""}";
    }
    return part2.replaceAll(GlobalRegexp.html, '');
  }

  void onMessageDeleted(MessageDeletedModel messageDeletedModel) async {
    final streamData = _chatRoomController.valueOrNull;
    if (streamData != null && messageDeletedModel.tid == inMemoryData.currentTeam?.id && messageDeletedModel.cid == inMemoryData.currentChannel?.id) {
      streamData.messageWrapperModel.list
          .removeWhere((element) => element.id == messageDeletedModel.id);

      if (messageDeletedModel.pmid != null) {
        streamData.messageWrapperModel.list.removeWhere((element) =>
            element.threadMetaChild?.pmid == messageDeletedModel.pmid);

        onNotifyThreadController.sinkAddSafe(messageDeletedModel);
      }
      _chatRoomController.sinkAddSafe(streamData);
    }
  }

  void onUserPresenceChange(RTCPresenceChangeModel rtcPresenceChangeModel) {
    final currentChannelList = _drawerChatModelListController.value;
    final member = inMemoryData.getMember(rtcPresenceChangeModel.uid ?? "");
    if (member != null) {
      member.presence = rtcPresenceChangeModel.presence;
      inMemoryData.addReplaceMember(member);
    }

    final jIndex = joinedTeam?.memberWrapperModel.list.indexWhere(
            (element) => element.id == rtcPresenceChangeModel.uid) ??
        -1;
    if (jIndex >= 0) {
      joinedTeam?.memberWrapperModel.list[jIndex].presence =
          rtcPresenceChangeModel.presence;
    }

    final mIndex = currentChannelList.indexWhere(
        (element) => element.channelModel?.other == rtcPresenceChangeModel.uid);
    if (mIndex >= 0) {
      currentChannelList[mIndex].memberModel?.presence =
          rtcPresenceChangeModel.presence;
      _drawerChatModelListController.sinkAddSafe(currentChannelList);
    }
  }

  void onUserTyping(RTCUserTypingModel rtcUserTypingModel) {
    if (rtcUserTypingModel.tid == inMemoryData.currentTeam!.id &&
        rtcUserTypingModel.cid == inMemoryData.currentChannel!.id) {}
  }

  void sendUserPresence(UserPresence presence) {
    _irtcManager.sendWssPresence(presence);
  }

  void sendUserTyping() {
    _irtcManager.sendWssTyping();
  }

  void setTextInputWidgetSize(Size size) {
    _inputWidgetSizeController.sinkAddSafe(size);
  }

  void tapAnswerMessage(MessageModel? message) {
    selectChatRoom(inMemoryData.currentChannel!,
        forceReload: true, lastReadMessage: message, fromSearchPage: true);
  }

  void onChannelRenamed(RTCChannelRenamed model) async {
    await _iChannelRepository.updateNameLocally(
        model.cid, model.title, model.name);
    final channels = (joinedTeam?.channels ?? []) + (joinedTeam?.groups ?? []);
    final idx = channels.indexWhere((element) => model.cid == element.id);
    if (idx > -1) {
      channels[idx].title = model.title;
      channels[idx].name = model.name;
    }
    final chats = _drawerChatModelListController.value;
    final chatIndex =
        chats.indexWhere((element) => element.channelModel?.id == model.cid);
    if (chatIndex >= 0) {
      chats[chatIndex].channelModel?.title = model.title;
      chats[chatIndex].channelModel?.name = model.name;
      chats[chatIndex].title = chats[chatIndex].channelModel?.titleFixed ?? "";
    }
    if (inMemoryData.currentChannel?.id == model.cid) {
      inMemoryData.currentChannel?.title = model.title;
      inMemoryData.currentChannel?.name = model.name;
    }
    _drawerChatModelListController.sinkAddSafe(chats);
  }

  void onChannelMarked(RTCChannelMarked model) async {
    await _iChannelRepository.resetChannelMark(model.cid, model.marked);
    final currentTeamId = await getCurrentTeamId;
    if ((currentTeamId) == model.tid) {
      Future.delayed(Duration(seconds: 5)).then((value) async {
        if (currentTeamId == (await getCurrentTeamId)) {
          final channelList = _drawerChatModelListController.value;
          final currentIndexRoom = channelList
              .indexWhere((element) => element.channelModel?.id == model.cid);
          if (currentIndexRoom >= 0) {
            if(await FlutterAppBadger.isAppBadgeSupported() && !isUpdatingBadge) {
              badgeCount = badgeCount - channelList[currentIndexRoom].unreadMessagesCount >= 0
                  ? badgeCount - channelList[currentIndexRoom].unreadMessagesCount
                  : 0;
              FlutterAppBadger.updateBadgeCount(badgeCount);
            }
            channelList[currentIndexRoom].channelModel?.unreadCount = 0;
            channelList[currentIndexRoom].channelModel?.unreadMessages = [];
            channelList[currentIndexRoom].unreadMessagesCount = 0;
            _drawerChatModelListController.sinkAddSafe(channelList);
          }
        }
      });
    } else {
      checkUnreadTeams();
      checkUnreadTeamsAppBadge();
    }
  }

  MessageModel? firstMessageBeforePrevious;
  MessageModel? lastMessageBeforeNext;

  String lastChatRoomSelectedProcedureId = '';
  Future<void> selectChatRoom(ChannelModel newChat,
      {forceReload = false,
      bool mark = true,
      MessageModel? lastReadMessage,
      bool fromSearchPage = false,
      bool fromInit = false}) async {
    if (newChat.id == inMemoryData.currentChannel?.id && !forceReload) return;
    cancelPreviousNext();
    final uuid = const Uuid().v1();
    lastChatRoomSelectedProcedureId = uuid;
    ChatRoomUIModel? oldMessages;
    if (!(isNotInLastMessages && lastMessages != null)) {
      oldMessages = _chatRoomController.valueOrNull;
    }
    if (isNotInLastMessages) isNotInLastMessages = false;
    if (messageClickedToDifferentChannel)
      messageClickedToDifferentChannel = false;
    reverseFloatingButton.sinkAddSafe(true);
    if (firstMessageBeforePrevious != null) firstMessageBeforePrevious = null;
    if (lastMessageBeforeNext != null) lastMessageBeforeNext = null;

    currentMessageSelected = null;

    if (inMemoryData.currentChannel?.id != newChat.id)
      _answerInMessageController.sinkAddSafe(null);

    final currentChannelList = _drawerChatModelListController.value;

    ///Setting in-memory and prefs current channel
    final oldCurrentChannel = inMemoryData.currentChannel;
    inMemoryData.currentChannel = newChat;
    await _prefs.setStringValue(_prefs.currentChatId, newChat.id);

    isLoading = true;
    // hasMorePreviousMessages = true;

    ///Setting chat selected
    currentChannelList.forEach((element) {
      if (element.channelModel != null)
        element.isSelected = element.channelModel?.id == newChat.id;
    });
    _drawerChatModelListController.sinkAddSafe(currentChannelList);

    ///Cleaning current messages in Room
    final newChatRoomUIModel = ChatRoomUIModel(
      messageWrapperModel: MessageWrapperModel(more: false, list: []),
    );
    _chatRoomController.sinkAddSafe(newChatRoomUIModel);

    ///Marking room chat as read when user enters channel
    if (mark) {
      _iChannelRepository.putChannelMemberMark(inMemoryData.currentChannel!);
      if (fromInit)
        onChannelMarked(RTCChannelMarked(
            cid: inMemoryData.currentChannel!.id,
            tid: inMemoryData.currentTeam!.id,
            uid: inMemoryData.currentMember!.id,
            marked: DateTime.now()));
    }

    hasMoreNextMessages = lastReadMessage != null ? true : false;
    hasMorePreviousMessages = true;

    ///Getting pinned message
    _getPinnedMessage(newChat.id).then((value) async {
      if(value.isNotEmpty && value.first.cid == (await _prefs.getStringValue(_prefs.currentChatId))) {
        _pinnedMessageController.sinkAddSafe(value.first);
      } else {
        _pinnedMessageController.sinkAddSafe(null);
      }
    });

    ///Getting channel's messages
    final resMessages = lastReadMessage == null
        ? await _iMessageRepository.getMessages(
            inMemoryData.currentTeam!.id,
            newChat.id,
            newChat.mark?.millisecondsSinceEpoch ??
                DateTime.now().millisecondsSinceEpoch)
        : await _iMessageRepository.getMessagePrevious(
            inMemoryData.currentTeam!.id, newChat.id, lastReadMessage.id);

    if (resMessages is ResultSuccess<MessageWrapperModel>) {
      loadedFolders = Map();
      MessageWrapperModel messageWrapperModel =
          await _resolveThreadsReferences(resMessages.value);
      newChatRoomUIModel.messageWrapperModel = messageWrapperModel;
      if (lastReadMessage != null) {
        newChatRoomUIModel.messageWrapperModel.list =
            newChatRoomUIModel.messageWrapperModel.list;
        newChatRoomUIModel.messageWrapperModel.list.add(lastReadMessage);
      }
    }

    newChatRoomUIModel.messageWrapperModel.bulkLoadMessages =
        lastReadMessage != null
            ? BulkLoadMessages.previous
            : BulkLoadMessages.last;

    bool needToRefreshScroll = false;
    bool force = false;
    newChatRoomUIModel.messageWrapperModel.list
        .sort((m1, m2) => (m1.ts!.compareTo(m2.ts!)));
    final newRoomChatLastId =
        newChatRoomUIModel.messageWrapperModel.list.isNotEmpty
            ? newChatRoomUIModel.messageWrapperModel.list.last.id
            : null;

    if (lastChatRoomSelectedProcedureId == uuid) {
      if (fromSearchPage && newRoomChatLastId != null) {
        if (inMemoryData.currentChannel?.id == oldCurrentChannel?.id) {
          if (oldMessages != null) {
            oldMessages.messageWrapperModel.list
                .sort((m1, m2) => (m1.ts!.compareTo(m2.ts!)));
            if (oldMessages.messageWrapperModel.list.last.id ==
                newRoomChatLastId) {
              isNotInLastMessages = false;
            } else {
              force = true;
            }
          } else {
            messageClickedToDifferentChannel = true;
          }
        } else {
          messageClickedToDifferentChannel = true;
          // final res = await _iMessageRepository.getMessageNext(
          //     inMemoryData.currentTeam.id,
          //     inMemoryData.currentChannel.id,
          //     newChatRoomUIModel.messageWrapperModel.list.last.id);
          // if (res is ResultSuccess<MessageWrapperModel>) {
          //   isNotInLastMessages = res.value.list.isNotEmpty;
          //   needToRefreshScroll = isNotInLastMessages;
          // }
        }
      }

      _chatRoomController.sinkAddSafe(newChatRoomUIModel);

      if (messageClickedToDifferentChannel || force) {
        await loadNextMessages(alwaysMarkLast: true);
        if (force) {
          lastMessages = oldMessages;
          needToRefreshScroll = true;
        } else {
          if (hasMoreNextMessages)
            needToRefreshScroll = true;
          else {
            _chatRoomController.valueOrNull?.messageWrapperModel.list
                .sort((m1, m2) => (m1.ts!.compareTo(m2.ts!)));
            if (_chatRoomController
                    .valueOrNull?.messageWrapperModel.list.last.id ==
                newRoomChatLastId) {
              needToRefreshScroll = false;
            } else {
              needToRefreshScroll = true;
            }
          }
        }
        isNotInLastMessages = hasMoreNextMessages;
      }
      if (needToRefreshScroll) refreshScroll.sinkAddSafe(true);
      isLoading = false;
    }
    if (fcmResumedFromBackground) {
      fcmResumedFromBackground = false;
      if (!fromInit && onWSSReconnected.value) {
        reloadDataOnWSSReconnected(loadChannelMessages: false);
      } else if (fromInit && onWSSReconnected.value) {
        onWSSReconnected.sinkAddSafe(false);
      }
    }
  }

  ChatRoomUIModel? lastMessages;
  bool isNotInLastMessages = false;
  bool messageClickedToDifferentChannel = false;
  BehaviorSubject<bool> refreshScroll = BehaviorSubject();

  String loadingPreviousMessageLastProcedureId = '';
  Future<void> loadPreviousMessages() async {
    hasMoreNextMessages = true;
    final streamData = _chatRoomController.valueOrNull;
    if (isLoadingMorePreviousMessages ||
        !hasMorePreviousMessages ||
        streamData == null) return;
    isLoadingMorePreviousMessages = true;
    final uuid = Uuid().v1();
    loadingPreviousMessageLastProcedureId = uuid;

    final firstMessage = streamData.messageWrapperModel.list.isNotEmpty
        ? streamData.messageWrapperModel.list[0]
        : null;

    if (firstMessage != null) {
      final res = await _iMessageRepository.getMessagePrevious(
          inMemoryData.currentTeam!.id,
          inMemoryData.currentChannel!.id,
          firstMessage.id, onCancelToken: (token) {
        cancelToken = token;
      });
      if (res is ResultSuccess<MessageWrapperModel>) {
        hasMorePreviousMessages = res.value.list.length ==
            RemoteConstants.message_number_requested_by_next;
        streamData.messageWrapperModel.more = hasMorePreviousMessages;

        if (firstMessageBeforePrevious == null && hasMorePreviousMessages)
          firstMessageBeforePrevious = firstMessage;

        MessageWrapperModel messageWrapperModel =
            streamData.messageWrapperModel;

        Map<String, MessageModel> map = {};
        messageWrapperModel.list.forEach((element) {
          map[element.id] = element;
        });
        res.value.list.forEach((element) {
          map[element.id] = element;
        });

        messageWrapperModel.list = map.values.toList();

        streamData.messageWrapperModel =
            await _resolveThreadsReferences(messageWrapperModel);

        streamData.messageWrapperModel.bulkLoadMessages =
            BulkLoadMessages.previous;
        if (loadingPreviousMessageLastProcedureId == uuid)
          _chatRoomController.sinkAddSafe(streamData);
      }
    }
    isLoadingMorePreviousMessages = false;
  }

  String loadingNextMessageLastProcedureId = '';
  Future<void> loadNextMessages({bool alwaysMarkLast = false}) async {
    hasMorePreviousMessages = true;
    final streamData = _chatRoomController.valueOrNull;
    if (isLoadingMoreNextMessages || !hasMoreNextMessages || streamData == null)
      return;
    isLoadingMoreNextMessages = true;
    final uuid = Uuid().v1();
    loadingNextMessageLastProcedureId = uuid;

    final lastMessage = streamData.messageWrapperModel.list.isNotEmpty
        ? streamData.messageWrapperModel.list.last
        : null;

    if (lastMessage != null) {
      final res = await _iMessageRepository.getMessageNext(
          inMemoryData.currentTeam!.id,
          inMemoryData.currentChannel!.id,
          lastMessage.id, onCancelToken: (token) {
        cancelToken = token;
      });
      if (res is ResultSuccess<MessageWrapperModel>) {
        MessageWrapperModel messageWrapperModel =
            streamData.messageWrapperModel;

        hasMoreNextMessages = res.value.list.length ==
            RemoteConstants.message_number_requested_by_next;
        streamData.messageWrapperModel.more = hasMoreNextMessages;

        if ((lastMessageBeforeNext == null && hasMoreNextMessages) ||
            (lastMessageBeforeNext == null && alwaysMarkLast))
          lastMessageBeforeNext = lastMessage;

        Map<String, MessageModel> map = {};
        messageWrapperModel.list.forEach((element) {
          map[element.id] = element;
        });
        res.value.list.forEach((element) {
          map[element.id] = element;
        });
        messageWrapperModel.list.addAll(res.value.list);
        streamData.messageWrapperModel =
            await _resolveThreadsReferences(messageWrapperModel);
        streamData.messageWrapperModel.bulkLoadMessages = BulkLoadMessages.next;
        streamData.messageWrapperModel.list
            .sort((m1, m2) => (m1.ts!.compareTo(m2.ts!)));
        if (isNotInLastMessages) {
          if (lastMessages?.messageWrapperModel.list.last.id ==
                  streamData.messageWrapperModel.list.last.id ||
              !hasMoreNextMessages) {
            isNotInLastMessages = false;
          }
        }
        if (uuid == loadingNextMessageLastProcedureId)
          _chatRoomController.sinkAddSafe(streamData);
      }
    }
    isLoadingMoreNextMessages = false;
  }

  CancelToken? cancelToken;

  void cancelPreviousNext() async {
    cancelToken?.cancel();
  }

  void restoreLastMessages() {
    if (!isNotInLastMessages) {
      final chatRoom = _chatRoomController.valueOrNull;
      if (firstMessageBeforePrevious != null) firstMessageBeforePrevious = null;
      if (lastMessageBeforeNext != null) lastMessageBeforeNext = null;
      if (chatRoom != null) _chatRoomController.sinkAddSafe(chatRoom);
    } else if (messageClickedToDifferentChannel) {
      selectChatRoom(inMemoryData.currentChannel!,
          mark: true, forceReload: true);
    } else {
      if (lastMessages != null) {
        if (firstMessageBeforePrevious != null)
          firstMessageBeforePrevious = null;
        if (lastMessageBeforeNext != null) lastMessageBeforeNext = null;
        _chatRoomController.sinkAddSafe(lastMessages!);
      }
    }
    isNotInLastMessages = false;
    reverseFloatingButton.sinkAddSafe(true);
    messageClickedToDifferentChannel = false;
  }

  void onFolderDeleted(FolderModel folder) {
    ChatRoomUIModel? chatRoom = _chatRoomController.valueOrNull;
    if (chatRoom != null) {
      folder.deleted = true;
      chatRoom.messageWrapperModel.list.forEach((message) {
        if (message.isFolderLinkMessage) {
          message.folders.forEach((element) {
            if (element.id == folder.id) element.deleted = true;
          });
        } else if (message.isFolderUploadMessage ||
            message.isFolderShareMessage) {
          if (message.args?.id == folder.id) message.args?.folderDeleted = true;
        }
      });
      loadedFolders[folder.id] = folder;
      _chatRoomController.sinkAddSafe(chatRoom);
    }
  }

  void onFolderRenamed(FolderModel folder) {
    ChatRoomUIModel? chatRoom = _chatRoomController.valueOrNull;
    if (chatRoom != null) {
      chatRoom.messageWrapperModel.list.forEach((message) {
        if (message.isFolderLinkMessage) {
          message.folders.forEach((element) {
            if (element.id == folder.id) {
              element.renamed = folder.renamed;
              element.path = folder.path;
            }
          });
        } else if (message.isFolderUploadMessage ||
            message.isFolderShareMessage) {
          if (message.args?.id == folder.id) {
            message.args?.folderRenamed = folder.renamed;
            message.args?.path = folder.path;
          }
        }
      });
      loadedFolders[folder.id] = folder;
      _chatRoomController.sinkAddSafe(chatRoom);
    }
  }

  Future<FolderModel?> resolveFolderReference(
      String tid, String cid, String id) async {
    isLoading = true;
    final res = await _iFileRepository.getFolderReference(tid, cid, id);
    isLoading = false;
    if (res is ResultSuccess<FolderModel>) {
      return res.value;
    }
    return null;
  }

  ///Resolving threads, answer messages and folders reference
  Map<String, FolderModel> loadedFolders = Map();
  Future<MessageWrapperModel> _resolveThreadsReferences(
      MessageWrapperModel messageWrapperModel) async {
    await Future.forEach<MessageModel>(messageWrapperModel.list,
        (element) async {
      ///Resolving thread and/or answered message reference
      if (element.threadMetaChild != null || element.hasAnswerMessage) {
        MessageModel? pMessage;

        if (element.threadMetaChild != null) {
          pMessage = messageWrapperModel.list
              .firstWhereOrNull((pM) => pM.id == element.threadMetaChild?.pmid);
        } else if (element.hasAnswerMessage) {
          final answerMessageId = element.getAnswerMessageId;
          pMessage = messageWrapperModel.list
              .firstWhereOrNull((pM) => pM.id == answerMessageId);
        }

        if (pMessage == null) {
          final resM = await _iMessageRepository.getMessage(
              inMemoryData.currentTeam!.id,
              inMemoryData.currentChannel!.id,
              element.hasAnswerMessage
                  ? element.getAnswerMessageId
                  : (element.threadMetaChild?.pmid ?? ""));
          if (resM is ResultSuccess<MessageModel>) {
            pMessage = resM.value;
          }
        }

        if (element.threadMetaChild != null) {
          element.threadMetaParent = pMessage?.threadMetaParent;
          element.threadMetaParent?.message = pMessage?.text ?? "";
        } else if (element.hasAnswerMessage) {
          element.answerMessage = pMessage;
        }
      }

      ///Resolving folder link, folder uploaded and folder shared reference
      if (element.isFolderUploadMessage || element.isFolderShareMessage) {
        final folder = loadedFolders[element.args?.id ?? ""];
        if (folder == null) {
          final resF = await _iFileRepository.getFolderReference(
              element.args?.tid ?? "",
              element.args?.cid ?? "",
              element.args?.id ?? "");
          if (resF is ResultSuccess<FolderModel>) {
            element.args?.path = resF.value.path;
            element.args?.folderRenamed = resF.value.renamed;
          } else if (resF is ResultError &&
              (resF as ResultError).code == RemoteConstants.code_not_found) {
            element.args?.folderDeleted = true;
          }
          loadedFolders[element.args?.id ?? ""] = FolderModel(
            id: element.args?.id ?? "",
            cid: element.args?.cid ?? "",
            tid: element.args?.tid ?? "",
            renamed: element.args?.folderRenamed,
            path: element.args?.path ?? "",
            deleted: element.args?.folderDeleted == true,
          );
        } else {
          element.args?.path = folder.path;
          element.args?.folderRenamed = folder.renamed;
          element.args?.folderDeleted = folder.deleted;
        }
      } else if (element.isFolderLinkMessage) {
        await Future.forEach<FolderModel>(element.folders, (folder) async {
          final f = loadedFolders[folder.id];
          if (f == null) {
            final resM = await _iFileRepository.getFolderReference(
                folder.tid, folder.cid, folder.id);
            if (resM is ResultSuccess<FolderModel>) {
              folder.path = resM.value.path;
              folder.renamed = resM.value.renamed;
            } else if (resM is ResultError &&
                (resM as ResultError).code == RemoteConstants.code_not_found) {
              folder.deleted = true;
            }
            loadedFolders[folder.id] = FolderModel(
              id: folder.id,
              cid: folder.cid,
              tid: folder.tid,
              renamed: folder.renamed,
              path: folder.path,
              deleted: folder.deleted,
            );
          } else {
            folder.path = f.path;
            folder.renamed = f.renamed;
            folder.deleted = f.deleted;
          }
        });
      }
    });
    return messageWrapperModel;
  }

  void deleteMessage() async {
    final streamData = _chatRoomController.valueOrNull;
    if (currentMessageSelected != null && streamData != null) {
      if (currentMessageSelected?.messageStatus == MessageStatus.Sending) {
        streamData.messageWrapperModel.list
            .removeWhere((element) => element.id == currentMessageSelected?.id);
        _chatRoomController.sinkAddSafe(streamData);
      } else {
        final currentPinnedMessage = getCurrentPinnedMessage();
        if(currentPinnedMessage != null && currentPinnedMessage.id == currentMessageSelected!.id && currentPinnedMessage.tid == currentMessageSelected!.tid && currentPinnedMessage.cid == currentMessageSelected!.cid) {
          await unpinMessage(currentMessageSelected!);
        }
        _iMessageRepository.deleteMessage(
            inMemoryData.currentTeam?.id ?? "",
            inMemoryData.currentChannel?.id ?? "",
            currentMessageSelected!.id);
      }
    }
    currentMessageSelected = null;
  }

  void downloadFile() async {
    final chatRoom = _chatRoomController.valueOrNull;
    if (chatRoom != null) {
      final mIndex = chatRoom.messageWrapperModel.list
          .indexWhere((element) => element.id == currentMessageSelected?.id);
      currentMessageSelected?.fileModel?.isUploadingDownloading = true;
      chatRoom.messageWrapperModel.list[mIndex] = currentMessageSelected!;
      _chatRoomController.sinkAddSafe(chatRoom);

      final res = await _iFileRepository
          .downloadFile(currentMessageSelected!.fileModel!);
      if (res is ResultSuccess<File>) {
        await OpenFile.open(res.value.path);
      }
      final mIndex1 = chatRoom.messageWrapperModel.list
          .indexWhere((element) => element.id == currentMessageSelected?.id);
      currentMessageSelected?.fileModel?.isUploadingDownloading = false;
      chatRoom.messageWrapperModel.list[mIndex1] = currentMessageSelected!;
      _chatRoomController.sinkAddSafe(chatRoom);
    }
  }

  void addMemberToChannel(MemberModel memberModel) async {
    final res = await _iChannelRepository.putChannelMember(
        inMemoryData.currentTeam?.id ?? "",
        inMemoryData.currentChannel?.id ?? "",
        memberModel.id);
    if (res is ResultSuccess<ChannelModel>) {
    } else
      showErrorMessage(res);
  }

  void onMentionClicked(String username) async {
    if (username.isNotEmpty &&
        username != 'channel' &&
        username != 'all' &&
        username != inMemoryData.currentMember?.profile?.name) {
      final membersInMemory = inMemoryData.getMembers(
          excludeMe: true, teamId: inMemoryData.currentTeam?.id);
      final memberIsInMemory = membersInMemory
          .firstWhereOrNull((element) => element.profile?.name == username);
      if (memberIsInMemory == null) {
        final membersQuery = await _iUserRepository.getTeamMembers(
            inMemoryData.currentTeam!.id,
            max: 1,
            offset: 0,
            action: "search",
            active: true,
            query: username);
        if (membersQuery is ResultSuccess<MemberWrapperModel> &&
            membersQuery.value.list.isNotEmpty &&
            membersQuery.value.list[0].profile?.name == username) {
          final member = membersQuery.value.list[0];
          final res = await _iChannelRepository.create1x1Channel(member);
          if (res is ResultSuccess<ChannelModel>) {
            reverseFloatingButton.sinkAddSafe(true);
            changeChannelAutoController.sinkAddSafe(
                ChannelCreatedUI(members: [member], channelModel: res.value));
          } else {
            //showErrorMessage(res);
          }
        }
      } else {
        final res =
            await _iChannelRepository.create1x1Channel(memberIsInMemory);
        if (res is ResultSuccess<ChannelModel>) {
          reverseFloatingButton.sinkAddSafe(true);
          changeChannelAutoController.sinkAddSafe(ChannelCreatedUI(
              members: [memberIsInMemory], channelModel: res.value));
        } else {
          //showErrorMessage(res);
        }
      }
    }
  }

  void onTeamDisabled(String tid, {bool isInTeamsPage = false}) async {
    if (joinedTeam != null) {
      if (!isInTeamsPage && tid == joinedTeam!.team.id) {
        final currentUserId = await _prefs.getStringValue(_prefs.userId);
        _chatRoomController.sinkAddSafe(ChatRoomUIModel(
          messageWrapperModel: MessageWrapperModel(more: false, list: []),
        ));
        userDisabledController.sinkAddSafe(RTCMemberDisabledEnabledModel(
            uid: currentUserId, tid: joinedTeam!.team.id, enable: false));
      } else if (joinedTeam!.team.id != tid && !isInTeamsPage) {
        await _iTeamRepository.getTeams();
        checkUnreadTeams();
      }
      checkUnreadTeamsAppBadge();
    }
  }

  void doOnMemberDisabledEnabled(RTCMemberDisabledEnabledModel model,
      {bool isInTeamsPage = false}) async {
    final currentUserId = await _prefs.getStringValue(_prefs.userId);
    if (currentUserId == model.uid &&
        joinedTeam?.team.id == model.tid &&
        !model.enable &&
        !isInTeamsPage) {
      _chatRoomController.sinkAddSafe(ChatRoomUIModel(
        messageWrapperModel: MessageWrapperModel(more: false, list: []),
      ));
      userDisabledController.sinkAddSafe(model);
    } else if (currentUserId != model.uid && joinedTeam?.team.id == model.tid) {
      final currentChannelList = _drawerChatModelListController.value;
      final member = inMemoryData.getMember(model.uid);
      if (member != null) {
        member.active = model.enable;
        member.profile?.name = "*";
        member.profile?.lastName = "*";
        member.profile?.email = "*";
        member.profile?.description = "*";
        member.profile?.position = "*";
        member.profile?.skype = "*";
        member.profile?.phone = "*";
        member.profile?.firstName = "*";
        member.photo = "*";
        inMemoryData.addReplaceMember(member);
      }

      final jIndex = joinedTeam?.memberWrapperModel.list
              .indexWhere((element) => element.id == model.uid) ??
          -1;
      if (jIndex >= 0 && member != null) {
        joinedTeam?.memberWrapperModel.list[jIndex] = member;
      } else if (jIndex >= 0) {
        joinedTeam?.memberWrapperModel.list[jIndex].active = model.enable;
      }

      final mIndex = currentChannelList
          .indexWhere((element) => element.channelModel?.other == model.uid);
      if (mIndex >= 0) {
        if(member != null) {
          currentChannelList[mIndex].memberModel = member;
        } else {
          currentChannelList[mIndex].memberModel?.active = model.enable;
        }
        _drawerChatModelListController.sinkAddSafe(currentChannelList);
      }
    }
    // else if (currentUserId == model.uid &&
    //     joinedTeam?.team.id != model.tid &&
    //     !isInTeamsPage) {
    //   await _iTeamRepository.getTeams();
    //   checkUnreadTeams();
    // }
    // checkUnreadTeamsAppBadge();
  }

  void doOnUserDeleted(String tid, String uid) async {
    final res = await _iUserRepository.getTeamMember(tid, uid);
    if(res is ResultSuccess<MemberModel>) {
      inMemoryData.addReplaceMember(res.value);
      if(tid == await getCurrentTeamId) {
        final idx = joinedTeam?.memberWrapperModel.list.indexWhere((element) => element.id == uid);
        if((idx ?? -1) > -1) {
          joinedTeam?.memberWrapperModel.list[idx!] = res.value;
        }
        final currentChannelList = _drawerChatModelListController.value;
        final mIndex = currentChannelList
            .indexWhere((element) => element.channelModel?.other == res.value.id);
        if (mIndex > -1) {
          currentChannelList[mIndex].memberModel = res.value;
          _drawerChatModelListController.sinkAddSafe(currentChannelList);
        }
      }
    }
  }

  Future<bool> isLoggedIn() async {
    return (await _prefs.getStringValue(_prefs.accessToken)).isNotEmpty;
  }

  void onMemberRoleUpdated(RTCMemberRoleUpdated model) async {
    final currentUserId = await _prefs.getStringValue(_prefs.userId);
    final currentChannelList = _drawerChatModelListController.value;
    final member = inMemoryData.getMember(model.uid);
    if (member != null) {
      member.role = model.role;
      inMemoryData.addReplaceMember(member);
    }
    if (joinedTeam?.team.id == model.tid) {
      if (model.uid == currentUserId) {
        inMemoryData.currentMember?.role = model.role;
        _currentMemberController.sinkAddSafe(inMemoryData.currentMember!);
      }
      final index = joinedTeam?.memberWrapperModel.list
              .indexWhere((element) => element.id == model.uid) ??
          -1;
      if (index >= 0) {
        joinedTeam?.memberWrapperModel.list[index].role = model.role;
      }
      final mIndex = currentChannelList
          .indexWhere((element) => element.channelModel?.other == model.uid);
      if (mIndex >= 0) {
        currentChannelList[mIndex].memberModel?.role = model.role;
        _drawerChatModelListController.sinkAddSafe(currentChannelList);
      }
    }
  }

  void onMemberProfileUpdated(RTCMemberUpdated model) async {
    final currentUserId = await _prefs.getStringValue(_prefs.userId);
    final currentChannelList = _drawerChatModelListController.value;
    final member = inMemoryData.getMember(model.uid);
    if (member != null) {
      member.profile = model.profile;
      inMemoryData.addReplaceMember(member);
    }
    if (joinedTeam?.team.id == model.tid) {
      if (model.uid == currentUserId) {
        inMemoryData.currentMember?.profile = model.profile;
        _currentMemberController.sinkAddSafe(inMemoryData.currentMember!);
      }
      final index = joinedTeam?.memberWrapperModel.list
              .indexWhere((element) => element.id == model.uid) ??
          -1;
      if (index >= 0) {
        joinedTeam?.memberWrapperModel.list[index].profile = model.profile;
      }
      final mIndex = currentChannelList
          .indexWhere((element) => element.channelModel?.other == model.uid);
      if (mIndex >= 0) {
        currentChannelList[mIndex].memberModel?.profile = model.profile;
        _drawerChatModelListController.sinkAddSafe(currentChannelList);
      }
    }
  }

  Future<void> startJitsiCall() async {
    final currentTeamId = await getCurrentTeamId;
    final currentChannel = inMemoryData.currentChannel!;
    final room = currentTeamId + "_" + currentChannel.id;
    MemberModel? member;
    if (currentChannel.isM1x1 == true) {
      member = inMemoryData.getMember(currentChannel.other);
      if (member == null) {
        final res = await _iUserRepository.getTeamMember(
            currentTeamId, currentChannel.other);
        if (res is ResultSuccess<MemberModel>) member = res.value;
      }
    }
    final res = await joinMeeting(
        room: room,
        subject: currentChannel.isM1x1
            ? CommonUtils.getMemberUsername(member)
            : currentChannel.titleFixed);
    if (res?.isSuccess == true) {
      currentMeeting = MeetingModel(
          cid: currentChannel.id,
          tid: currentTeamId,
          is1x1: currentChannel.isM1x1,
          room: room,
          url: Injector.instance.meetingBaseUrl);
      if (currentChannel.isM1x1) {
        _irtcManager.sendCallEventStart();
      }
    } else if (!(res?.isSuccess == true) &&
        (res?.message ?? "") != "CANCELLED" &&
        (res?.message ?? "") != "PermissionError")
      showErrorMessageFromString(R.string.callCouldNotBeInitialized);
  }

  Future<void> sendRejectCall(String tid, String cid) async {
    _irtcManager.sendCallEventReject(tid, cid);
  }

  void onCallingMeCancelled() {
    if (!(callingSnackBarController?.isDisposed ?? true)) {
      callingSnackBarController?.dismiss();
    }
    callNotificationPlayer.stop();
    callStatusController.sinkAddSafe(call_status.none);
  }

  void onCallingMeBackground(FCMMessageModel fcmMessage) async {
    if (callStatusController.value == call_status.none) {
      final room = fcmMessage.tid + "_" + fcmMessage.cid;
      final res =
          await joinMeeting(room: room, subject: "@${fcmMessage.sender}");
      if (res?.isSuccess == true) {
        currentMeeting = MeetingModel(
            url: Injector.instance.meetingBaseUrl,
            room: room,
            tid: fcmMessage.tid,
            cid: fcmMessage.cid,
            is1x1: true);
      }
    }
  }

  FlashController? callingSnackBarController;
  AudioPlayer callNotificationPlayer = AudioPlayer(
      mode:
          Platform.isAndroid ? PlayerMode.MEDIA_PLAYER : PlayerMode.LOW_LATENCY,
      playerId: "call");
  AudioCache? callNotificationAudioCache;
  void onCallingMe(String tid, String cid, String uid) async {
    MemberModel? member = inMemoryData.getMember(uid);
    if (member == null) {
      final res = await _iUserRepository.getTeamMember(tid, uid);
      if (res is ResultSuccess<MemberModel>) member = res.value;
    }
    callStatusController.sinkAddSafe(call_status.calling_me);
    callNotificationAudioCache =
        AudioCache(fixedPlayer: callNotificationPlayer, respectSilence: true);
    callNotificationAudioCache!.loop(R.sound.callingMe, isNotification: true);
    txShowCallingNotification(
        NoysiApp.navigatorKey.currentContext!,
        member != null ? CommonUtils.getMemberPhoto(member) : R.image.logo,
        CommonUtils.getMemberUsername(member) ?? "", (accepted) async {
      if (!(callingSnackBarController?.isDisposed ?? true)) {
        callingSnackBarController?.dismiss();
      }
      callNotificationPlayer.stop();
      if (accepted) {
        final room = tid + "_" + cid;
        final res =
            await joinMeeting(room: room, subject: "@${CommonUtils.getMemberUsername(member)}");
        if (res?.isSuccess == true) {
          currentMeeting = MeetingModel(
              url: Injector.instance.meetingBaseUrl,
              room: room,
              tid: tid,
              cid: cid,
              is1x1: true);
        }
      } else {
        callStatusController.sinkAddSafe(call_status.none);
        sendRejectCall(tid, cid);
      }
    }, controllerCallBack: (controller) {
      callingSnackBarController = controller;
    });
  }

  void doOnChannelCreated(RTCChannelCreated model) async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (currentTeamId == model.tid) {
      final currentDrawerChatList = _drawerChatModelListController.value;
      DrawerChatModel? chat = currentDrawerChatList
          .firstWhereOrNull((element) => element.channelModel?.id == model.cid);
      if (chat == null) {
        model.channel?.joined = true;
        model.channel?.open = true;
        if (model.channel?.isM1x1 == true) {
          final resMember = await _iUserRepository
              .getChannelMembers(model.tid, model.cid, max: 2);
          if (resMember is ResultSuccess<MemberWrapperModel>) {
            final member = resMember.value.list.firstWhereOrNull(
                (element) => element.id == model.channel!.other);
            chat = DrawerChatModel(
                drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
                isChild: true,
                isSelected: false,
                channelModel: model.channel,
                title: model.channel!.titleFixed,
                unreadMessagesCount: model.channel!.unreadCount ?? 0,
                memberModel: member);
            final memberExists = joinedTeam?.memberWrapperModel.list
                .firstWhereOrNull((element) => element.id == member?.id);
            final channel1x1Exists = joinedTeam?.messages1x1
                .firstWhereOrNull((element) => element.id == model.cid);
            if (memberExists == null && member != null)
              joinedTeam?.memberWrapperModel.list.add(member);
            if (channel1x1Exists == null)
              joinedTeam?.messages1x1.add(model.channel!);
          }
        } else {
          chat = DrawerChatModel(
            drawerHeaderChatType: model.channel?.isPrivateGroup == true
                ? DrawerHeaderChatType.PrivateGroup
                : DrawerHeaderChatType.Channel,
            isChild: true,
            isSelected: false,
            channelModel: model.channel,
            title: model.channel?.titleFixed ?? "",
            unreadMessagesCount: model.channel?.unreadCount ?? 0,
          );
          final channelExists = model.channel?.isPrivateGroup == true
              ? joinedTeam?.groups
                  .firstWhereOrNull((element) => element.id == model.cid)
              : joinedTeam?.channels
                  .firstWhereOrNull((element) => element.id == model.cid);
          if (channelExists == null)
            model.channel?.isPrivateGroup == true
                ? joinedTeam?.groups.add(model.channel!)
                : joinedTeam?.channels.add(model.channel!);
        }
        currentDrawerChatList.add(chat!);
        currentDrawerChatList
            .firstWhereOrNull((element) =>
                !element.isChild &&
                element.drawerHeaderChatType ==
                    (model.channel?.isPrivateGroup == true
                        ? DrawerHeaderChatType.PrivateGroup
                        : DrawerHeaderChatType.Channel))
            ?.childrenCount++;
        _drawerChatModelListController.sinkAddSafe(currentDrawerChatList);
      }
    } else {
      checkUnreadTeams();
    }
    checkUnreadTeamsAppBadge();
  }

  bool avoidOnChannelOpen = false;
  void doOnChannelOpened(RTCChannelOpened model) async {
    if (avoidOnChannelOpen) {
      avoidOnChannelOpen = false;
      return;
    }
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (currentTeamId == model.tid) {
      final currentDrawerChatList = _drawerChatModelListController.value;
      DrawerChatModel? chat = currentDrawerChatList
          .firstWhereOrNull((element) => element.channelModel?.id == model.cid);
      if (chat == null) {
        final resChannel =
            await _iChannelRepository.getChannel(model.tid, model.cid);
        if (resChannel is ResultSuccess<ChannelModel>) {
          resChannel.value.joined = true;
          resChannel.value.open = true;
          if (resChannel.value.isM1x1) {
            final resMember = await _iUserRepository
                .getChannelMembers(model.tid, model.cid, max: 2);
            if (resMember is ResultSuccess<MemberWrapperModel>) {
              final member = resMember.value.list.firstWhereOrNull(
                  (element) => element.id == resChannel.value.other);
              if(member?.id == RemoteConstants.noysiRobot) member!.presence = UserPresence.online.name;
              chat = DrawerChatModel(
                  drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
                  isChild: true,
                  isSelected: false,
                  channelModel: resChannel.value,
                  title: resChannel.value.titleFixed,
                  unreadMessagesCount: resChannel.value.unreadCount ?? 0,
                  memberModel: member);
              final memberExists = joinedTeam?.memberWrapperModel.list
                  .firstWhereOrNull((element) => element.id == member?.id);
              final channel1x1Exists = joinedTeam?.messages1x1
                  .firstWhereOrNull((element) => element.id == model.cid);
              if (memberExists == null && member != null)
                joinedTeam?.memberWrapperModel.list.add(member);
              if (channel1x1Exists == null)
                joinedTeam?.messages1x1.add(resChannel.value);
            }
          } else {
            chat = DrawerChatModel(
              drawerHeaderChatType: resChannel.value.isPrivateGroup
                  ? DrawerHeaderChatType.PrivateGroup
                  : DrawerHeaderChatType.Channel,
              isChild: true,
              isSelected: false,
              channelModel: resChannel.value,
              title: resChannel.value.titleFixed,
              unreadMessagesCount: resChannel.value.unreadCount ?? 0,
            );
            final channelExists = resChannel.value.isPrivateGroup
                ? joinedTeam?.groups
                    .firstWhereOrNull((element) => element.id == model.cid)
                : joinedTeam?.channels
                    .firstWhereOrNull((element) => element.id == model.cid);
            if (channelExists == null)
              resChannel.value.isPrivateGroup
                  ? joinedTeam?.groups.add(resChannel.value)
                  : joinedTeam?.channels.add(resChannel.value);
          }
          currentDrawerChatList.add(chat!);
          _drawerChatModelListController.sinkAddSafe(currentDrawerChatList);
        }
      }
    } else {
      checkUnreadTeams();
    }
    checkUnreadTeamsAppBadge();
  }

  void setUserStatus({String code = '', String text = ''}) async {
    if (code.isEmpty && text.isEmpty)
      _iUserRepository.deleteUserStatus();
    else
      _iUserRepository.updateUserStatus(code.replaceAll("-200d-", "-").toUpperCase(), text);
  }

  void onStatusSet(RTCStatusSet model) async {
    final currentUserId = await _prefs.getStringValue(_prefs.userId);
    final currentChannelList = _drawerChatModelListController.value;
    final member = inMemoryData.getMember(model.uid);
    if (member != null) {
      member.statusIcon = model.statusIcon;
      member.statusText = model.statusText;
      inMemoryData.addReplaceMember(member);
    }
    if (joinedTeam?.team.id == model.tid) {
      if (model.uid == currentUserId) {
        inMemoryData.currentMember?.statusIcon = model.statusIcon;
        inMemoryData.currentMember?.statusText = model.statusText;
        _currentMemberController.sinkAddSafe(inMemoryData.currentMember!);
      }
      final index = joinedTeam?.memberWrapperModel.list
              .indexWhere((element) => element.id == model.uid) ??
          -1;
      if (index >= 0) {
        joinedTeam?.memberWrapperModel.list[index].statusIcon =
            model.statusIcon;
        joinedTeam?.memberWrapperModel.list[index].statusText =
            model.statusText;
      }
      final mIndex = currentChannelList
          .indexWhere((element) => element.channelModel?.other == model.uid);
      if (mIndex >= 0) {
        currentChannelList[mIndex].memberModel?.statusIcon = model.statusIcon;
        currentChannelList[mIndex].memberModel?.statusText = model.statusText;
        _drawerChatModelListController.sinkAddSafe(currentChannelList);
      }
    }
  }

  Future<bool> logout({bool callApi = true, bool showLoading = true, bool cleanMail = false}) async {
    try {
      if(showLoading) _fullScreenLoadingController.sinkAddSafe(true);
      if(callApi) {
        await _iAccountRepository.logout();
      }
      await _prefs.logout(cleanMail: cleanMail);
      await _iCommonDao.cleanDB();
      if(showLoading) _fullScreenLoadingController.sinkAddSafe(false);
      return true;
    } catch (ex) {
      if(showLoading) _fullScreenLoadingController.sinkAddSafe(false);
      return true;
    }
  }

  Future<List<String>> getChannelMemberIds(String cid) async {
    _fullScreenLoadingController.sinkAddSafe(true);
    final res = await _iUserRepository.getChannelMembers(
        joinedTeam?.team.id ?? "", cid);
    List<String> list = [];
    if (res is ResultSuccess<MemberWrapperModel>) {
      list.addAll(res.value.list.map((e) => e.id).toList());
    }
    _fullScreenLoadingController.sinkAddSafe(false);
    return list;
  }

  // void onTeamUpdated(RTCTeamUpdated value) async {
  //   if(joinedTeam != null) {
  //     final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
  //     _iTeamRepository.getTeam(value.tid);
  //     if (value.tid == currentTeamId) {
  //       if (value.title?.isNotEmpty == true) {
  //         joinedTeam!.team.title = value.title ?? "";
  //       }
  //       if (value.name?.isNotEmpty == true) {
  //         joinedTeam!.team.name = value.name ?? "";
  //         await _prefs.setStringValue(_prefs.currentTeamName, value.name ?? "");
  //       }
  //       joinedTeam!.team.updateUsernameBlocked = value.updateUsernameBlocked;
  //       joinedTeam!.team.taskUpdateProtected = value.taskUpdateProtected;
  //       joinedTeam!.team.onlyAdminInvitesAllowed = value.onlyAdminInvitesAllowed;
  //       joinedTeam!.team.channelMentionProtected = value.channelMentionProtected;
  //       joinedTeam!.team.allMentionProtected = value.allMentionProtected;
  //       joinedTeam!.team.adminsCanDelete = value.adminsCanDelete;
  //       inMemoryData.addReplaceTeam(joinedTeam!.team);
  //       inMemoryData.currentTeam = joinedTeam!.team;
  //       _teamController.sinkAddSafe(joinedTeam!.team);
  //     }
  //   }
  // }

  void onTeamUpdated(RTCTeamUpdated value) async {
    if (joinedTeam != null) {
      final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
      if (value.tid == currentTeamId) {
        if (value.title?.isNotEmpty == true) {
          joinedTeam!.team.title = value.title ?? "";
        }
        if (value.name?.isNotEmpty == true) {
          joinedTeam!.team.name = value.name ?? "";
          await _prefs.setStringValue(_prefs.currentTeamName, value.name ?? "");
        }
        if (value.alwaysPush != joinedTeam!.team.alwaysPush) {
          var currentTeamName =
              await _prefs.getStringValue(_prefs.currentTeamName);
          final res = await _iTeamRepository
              .joinTeam(currentTeamName, teamId: currentTeamId, forceApi: true);
          if (res is ResultSuccess<TeamJoinedModel>) {
            waitingForJoinedTeam = true;
            onJoinedTeamLoadedFromApi(res.value);
            joinedTeamLoaded.sinkAddSafe(null);
          }
        } else {
          _iTeamRepository.getTeam(value.tid);
          joinedTeam!.team.updateUsernameBlocked = value.updateUsernameBlocked;
          joinedTeam!.team.taskUpdateProtected = value.taskUpdateProtected;
          joinedTeam!.team.onlyAdminInvitesAllowed =
              value.onlyAdminInvitesAllowed;
          joinedTeam!.team.channelMentionProtected =
              value.channelMentionProtected;
          joinedTeam!.team.allMentionProtected = value.allMentionProtected;
          joinedTeam!.team.adminsCanDelete = value.adminsCanDelete;
          joinedTeam!.team.showEmails = value.showEmails;
          joinedTeam!.team.showPhoneNumbers = value.showPhoneNumbers;
          inMemoryData.addReplaceTeam(joinedTeam!.team);
          inMemoryData.currentTeam = joinedTeam!.team;
          _teamController.sinkAddSafe(joinedTeam!.team);
        }
      } else if (value.tid != currentTeamId) {
        final res = await _iTeamRepository.getTeam(value.tid);
        if (res is ResultSuccess<TeamModel>) {
          _iTeamRepository.joinTeam(res.value.name, teamId: value.tid, forceApi: true);
        }
      } else {
        _iTeamRepository.getTeam(value.tid);
      }
    }
  }

  void onTeamThemeUpdated(RTCTeamThemeUpdated value) async {
    if (joinedTeam != null) {
      final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
      _iTeamRepository.getTeam(value.tid);
      if (value.tid == currentTeamId) {
        joinedTeam!.team.theme = value.theme;
        inMemoryData.addReplaceTeam(joinedTeam!.team);
        inMemoryData.currentTeam = joinedTeam!.team;
        _teamController.sinkAddSafe(joinedTeam!.team);
        teamThemeController.sinkAddSafe(joinedTeam!.team.theme);
      }
    }
  }

  void onTeamPhotoUpdated(RTCTeamPhotoUpdated model) async {
    if (joinedTeam != null) {
      final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
      _iTeamRepository.getTeam(model.tid);
      if (model.tid == currentTeamId) {
        if (joinedTeam?.team.photo?.isNotEmpty == true)
          await FileCacheManager.instance
              .removeFile(joinedTeam?.team.photo ?? "");
        joinedTeam!.team.photo = model.photo;
        inMemoryData.addReplaceTeam(joinedTeam!.team);
        inMemoryData.currentTeam = joinedTeam!.team;
        _teamController.sinkAddSafe(joinedTeam!.team);
      }
    }
  }

  Future<void> _loadAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersionController.sinkAddSafe(packageInfo.version);
  }

  Future<void> _loadDrawerConfig() async {
    final favoritesExpanded = await _prefs.getBoolValue(_prefs.favoritesExpanded, defValue: true);
    final channelsExpanded = await _prefs.getBoolValue(_prefs.channelsExpanded, defValue: true);
    final imsExpanded = await _prefs.getBoolValue(_prefs.imsExpanded, defValue: true);
    final groupsExpanded = await _prefs.getBoolValue(_prefs.groupsExpanded, defValue: true);
    _drawerConfigController.sinkAddSafe(DrawerConfig(favoritesExpanded: favoritesExpanded, channelExpanded: channelsExpanded, imsExpanded: imsExpanded, groupsExpanded: groupsExpanded));
  }

  void changeDrawerConfig(DrawerConfig config) {
    _prefs.setBoolValue(_prefs.favoritesExpanded, config.favoritesExpanded);
    _prefs.setBoolValue(_prefs.channelsExpanded, config.channelExpanded);
    _prefs.setBoolValue(_prefs.imsExpanded, config.imsExpanded);
    _prefs.setBoolValue(_prefs.groupsExpanded, config.groupsExpanded);
    _drawerConfigController.sinkAddSafe(config);
  }

  Future<List<MessageModel>> _getPinnedMessage(String cid) async {
    final tid = await getCurrentTeamId;
    final res = await _iMessageRepository.getPinnedMessages(tid, cid);
    if(res is ResultSuccess<List<MessageModel>>) {
      return res.value;
    }
    return [];
  }

  Future<void> pinMessage(MessageModel message) async {
    _fullScreenLoadingController.sinkAddSafe(true);
    await _iMessageRepository.pinMessage(message.tid, message.cid, message.id);
    _fullScreenLoadingController.sinkAddSafe(false);
  }

  Future<void> unpinMessage(MessageModel message) async {
    _fullScreenLoadingController.sinkAddSafe(true);
    await _iMessageRepository.unpinMessage(message.tid, message.cid, message.id);
    _fullScreenLoadingController.sinkAddSafe(false);
  }

  MessageModel? getCurrentPinnedMessage() => _pinnedMessageController.valueOrNull;

  void onMessagePinnedUnpinned(RTCMessagePinnedUnpinned model) {
    final currentChannelId = inMemoryData.currentChannel?.id;
    final currentTeamId = inMemoryData.currentTeam?.id;
    if(model.pinnedMessage.tid == currentTeamId && model.pinnedMessage.cid == currentChannelId) {
      _pinnedMessageController.sinkAddSafe(model.unpinned ? null : model.pinnedMessage);
    }
  }

  void _navigateToTask(String teamName, String taskId) async {
    final currentTeamName = await _prefs.getStringValue(_prefs.currentTeamName);
    if(teamName == currentTeamName) {
      NavigationUtils.push(NoysiApp.navigatorKey.currentContext!, TaskDetailPage(taskId: taskId));
    } else {
      _fullScreenLoadingController.sinkAddSafe(true);
      final res = await _iTeamRepository.joinTeam(teamName);
      _fullScreenLoadingController.sinkAddSafe(false);
      if(res is ResultSuccess<TeamJoinedModel>) {
        changeTeam(res.value.team);
        StreamSubscription? ss;
        ss = joinedTeamLocally.listen((value) {
          if(value) {
            NavigationUtils.push(NoysiApp.navigatorKey.currentContext!, TaskDetailPage(taskId: taskId));
            ss?.cancel();
          }
        });
      } else {
        showErrorMessageFromString(R.string.taskNotFound);
      }
    }
  }

  void _navigateToMessage(String tid, String cid, String mid) async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if(currentTeamId == tid) {
      final resChannel = await _iChannelRepository.getChannel(tid, cid);
      final resMessage = await _iMessageRepository.getMessage(tid, cid, mid);
      if(resChannel is ResultSuccess<ChannelModel> && resMessage is ResultSuccess<MessageModel>) {
        selectChatRoom(resChannel.value, forceReload: true, lastReadMessage: resMessage.value, fromSearchPage: true);
      } else {
        showErrorMessageFromString(R.string.messageNotFound);
      }
    } else {
      _fullScreenLoadingController.sinkAddSafe(true);
      final res = await _iTeamRepository.joinTeam(tid, teamId: tid);
      _fullScreenLoadingController.sinkAddSafe(false);
      if(res is ResultSuccess<TeamJoinedModel>) {
        changeTeam(res.value.team);
        StreamSubscription? ss;
        ss = joinedTeamLocally.listen((value) async {
          if(value) {
            final resChannel = await _iChannelRepository.getChannel(tid, cid);
            final resMessage = await _iMessageRepository.getMessage(tid, cid, mid);
            if(resChannel is ResultSuccess<ChannelModel> && resMessage is ResultSuccess<MessageModel>) {
              selectChatRoom(resChannel.value, forceReload: true, lastReadMessage: resMessage.value, fromSearchPage: true);
            } else {
              showErrorMessageFromString(R.string.messageNotFound);
            }
            ss?.cancel();
          }
        });
      } else {
        showErrorMessageFromString(R.string.messageNotFound);
      }
    }
  }

  void processNavigationFromLink(AppLinksNavigationModel model) async {
    if(model.link.toLowerCase().trim().startsWith("http") || model.link.toLowerCase().trim().startsWith("com.noysi")) {
      Uri? uri = Uri.tryParse(model.link.trim());
      if(uri != null) {
        if (uri.scheme != "https") {
          uri = uri.replace(scheme: "https");
        }
        if (uri
            .toString().toLowerCase()
            .startsWith(Endpoint.meetBaseUrlProd) ||
            uri
                .toString().toLowerCase()
                .startsWith(Endpoint.meetBaseUrlPre) ||
            uri
                .toString().toLowerCase()
                .startsWith(Endpoint.meetBaseUrlDev)) {
          final room = uri.pathSegments.first.replaceAll("/", "");
          final url = "https://${uri.host}";
          StreamSubscription? ss;
          ss = joinedTeamLocally.listen((value) async {
            if (value) {
              final res = await joinMeeting(url: url, room: room);
              if (res?.isSuccess == true) {
                currentMeeting = MeetingModel(
                  room: room,
                  url: url,
                );
              }
              ss?.cancel();
            }
          });
        } else if (uri.path.toLowerCase().startsWith("/webrtc")) {
          StreamSubscription? ss;
          ss = joinedTeamLocally.listen((value) async {
            if(value) {
              final teamId = uri!.fragment.split("/")[2];
              final channelId = uri.fragment.split("/").last;
              final channelRes = await _iChannelRepository.getChannel(teamId, channelId);
              final url = Endpoint.noysiBaseUrlProd.contains(uri.host)
                  ? Endpoint.meetBaseUrlProd
                  : Endpoint.noysiBaseUrlPre.contains(uri.host)
                  ? Endpoint.meetBaseUrlPre
                  : Endpoint.meetBaseUrlDev;
              String room = "${teamId}_$channelId";
              String subject = "";
              bool is1x1 = false;
              if(channelRes is ResultSuccess<ChannelModel>) {
                if(channelRes.value.isM1x1) {
                  is1x1 = true;
                  final dynamic userRes = inMemoryData.getMember(channelRes.value.other)?.profile ?? await _iUserRepository.getTeamMemberProfile(teamId, channelRes.value.other);
                  if(userRes != null && userRes is MemberProfile) {
                    subject = userRes.name;
                  } else if (userRes != null && userRes is ResultSuccess<MemberProfile>) {
                    subject = userRes.value.name;
                  }
                } else {
                  subject = channelRes.value.titleFixed;
                }
              }
              final res = await joinMeeting(url: url, room: room, subject: subject);
              if (res?.isSuccess == true) {
                currentMeeting = MeetingModel(
                  room: room,
                  url: url,
                  is1x1: is1x1,
                  tid: teamId,
                  cid: channelId
                );
              }
              ss?.cancel();
            }
          });
        } else if (uri.path.toLowerCase().startsWith("/a") && uri.fragment.toLowerCase().contains("/tasks")) {
          final taskId = uri.fragment.split("/").last;
          final teamName = uri.fragment.split("/")[2];
          StreamSubscription? ss;
          ss = joinedTeamLocally.listen((value) async {
            if(value) {
              await NavigationUtils.popUntilWithRouteAndMaterial(NoysiApp.navigatorKey.currentContext!, NavigationUtils.HomeRoute);
              _navigateToTask(teamName, taskId);
              ss?.cancel();
            }
          });
        } else if (uri.path.toLowerCase().startsWith("/a") && uri.fragment.toLowerCase().contains("/messages")) {
          final fragments = uri.fragment.split("/");
          final mid = fragments.last;
          final cid = fragments[fragments.length - 2];
          final tid = fragments[fragments.length - 3];
          StreamSubscription? ss;
          ss = joinedTeamLocally.listen((value) async {
            if(value) {
              await NavigationUtils.popUntilWithRouteAndMaterial(NoysiApp.navigatorKey.currentContext!, NavigationUtils.HomeRoute);
              _navigateToMessage(tid, cid, mid);
              ss?.cancel();
            }
          });
        } else if (await canLaunchUrl(uri)) {
          if (kDebugMode) {
            print(uri.toString());
          }
          launchUrl(uri);
        }
      }
    } else if(model.onLinkTap != null) {
      model.onLinkTap!(model.link);
    } else if (await canLaunchUrlString(model.link)) {
      if (kDebugMode) {
        print(model.link);
      }
      launchUrlString(model.link);
    }
  }

}
