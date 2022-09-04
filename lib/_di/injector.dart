import 'package:code/app_bloc.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/2fa_api.dart';
import 'package:code/data/api/account_api.dart';
import 'package:code/data/api/activity_api.dart';
import 'package:code/data/api/channel_api.dart';
import 'package:code/data/api/file_api.dart';
import 'package:code/data/api/message_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/task_api.dart';
import 'package:code/data/api/team_api.dart';
import 'package:code/data/api/thread_api.dart';
import 'package:code/data/api/user_api.dart';
import 'package:code/data/connectivity_manager.dart';
import 'package:code/data/converter/2fa_converter.dart';
import 'package:code/data/converter/account_converter.dart';
import 'package:code/data/converter/activity_converter.dart';
import 'package:code/data/converter/channel_converter.dart';
import 'package:code/data/converter/file_converter.dart';
import 'package:code/data/converter/message_converter.dart';
import 'package:code/data/converter/task_converter.dart';
import 'package:code/data/converter/team_converter.dart';
import 'package:code/data/converter/thread_converter.dart';
import 'package:code/data/converter/usage_converter.dart';
import 'package:code/data/converter/user_converter.dart';
import 'package:code/data/dao/_base/app_database.dart';
import 'package:code/data/dao/channel_dao.dart';
import 'package:code/data/dao/common_dao.dart';
import 'package:code/data/dao/team_dao.dart';
import 'package:code/data/dao/user_dao.dart';
import 'package:code/data/file_cache_manager.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/data/repository/account_repository.dart';
import 'package:code/data/repository/activity_repository.dart';
import 'package:code/data/repository/channel_repository.dart';
import 'package:code/data/repository/file_repository.dart';
import 'package:code/data/repository/message_repository.dart';
import 'package:code/data/repository/task_repository.dart';
import 'package:code/data/repository/team_repository.dart';
import 'package:code/data/repository/thread_repository.dart';
import 'package:code/data/repository/user_repository.dart';
import 'package:code/domain/2fa/i_2fa_api.dart';
import 'package:code/domain/2fa/i_2fa_converter.dart';
import 'package:code/domain/2fa/i_2fa_repository.dart';
import 'package:code/domain/account/i_account_api.dart';
import 'package:code/domain/account/i_account_converter.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/domain/activity/i_activity_api.dart';
import 'package:code/domain/activity/i_activity_converter.dart';
import 'package:code/domain/activity/i_activity_repository.dart';
import 'package:code/domain/channel/i_channel_api.dart';
import 'package:code/domain/channel/i_channel_converter.dart';
import 'package:code/domain/channel/i_channel_dao.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/common_db/i_common_dao.dart';
import 'package:code/domain/file/i_file_api.dart';
import 'package:code/domain/file/i_file_converter.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/message/i_message_api.dart';
import 'package:code/domain/message/i_message_converter.dart';
import 'package:code/domain/message/i_message_repository.dart';
import 'package:code/domain/task/i_task_api.dart';
import 'package:code/domain/task/i_task_converter.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/team/i_team_api.dart';
import 'package:code/domain/team/i_team_converter.dart';
import 'package:code/domain/team/i_team_dao.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/thread/i_thread_api.dart';
import 'package:code/domain/thread/i_thread_converter.dart';
import 'package:code/domain/thread/i_thread_repository.dart';
import 'package:code/domain/usage/i_usage_converter.dart';
import 'package:code/domain/user/i_user_api.dart';
import 'package:code/domain/user/i_user_converter.dart';
import 'package:code/domain/user/i_user_dao.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/fcm/fcm_controller.dart';
import 'package:code/fcm/i_fcm_controller.dart';
import 'package:code/rtc/i_rtc_manager.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/tx_uri_resolver_bloc.dart';
import 'package:code/ui/_tx_widget/tx_video_player.dart';
import 'package:code/ui/authenticator/authenticator_bloc.dart';
import 'package:code/ui/calendar/calendar_bloc.dart';
import 'package:code/ui/activity_zone/activity_zone_bloc.dart';
import 'package:code/ui/activity_zone/sessions/sessions_bloc.dart';
import 'package:code/ui/calendar/overlay_datepicker.dart';
import 'package:code/ui/channel_rename/channel_rename_bloc.dart';
import 'package:code/ui/chat_text_widget/tx_chat_text_input_bloc.dart';
import 'package:code/ui/channel/channel_bloc.dart';
import 'package:code/ui/channel_create/channel_create_bloc.dart';
import 'package:code/ui/channel_preferences/channel_preferences_bloc.dart';
import 'package:code/ui/edit_message/edit_message_bloc.dart';
import 'package:code/ui/files_explorer/files_explorer_bloc.dart';
import 'package:code/ui/favorites/favorites_bloc.dart';
import 'package:code/ui/home/home_bloc.dart';
import 'package:code/ui/home/share_external_bloc.dart';
import 'package:code/ui/invitations/invitations_bloc.dart';
import 'package:code/ui/invite/invite_bloc.dart';
import 'package:code/ui/invite_people/invite_people_bloc.dart';
import 'package:code/ui/link/link_bloc.dart';
import 'package:code/ui/login/login_bloc.dart';
import 'package:code/ui/mention/mention_bloc.dart';
import 'package:code/ui/message_comments/message_comments_bloc.dart';
import 'package:code/ui/private_group/private_group_bloc.dart';
import 'package:code/ui/private_group_create/private_group_create_bloc.dart';
import 'package:code/ui/profile/profile_bloc.dart';
import 'package:code/ui/recover_password/recover_password_bloc.dart';
import 'package:code/ui/register/register_bloc.dart';
import 'package:code/ui/search_global/search_global_bloc.dart';
import 'package:code/ui/search_user/search_user_bloc.dart';
import 'package:code/ui/share/share_file_bloc.dart';
import 'package:code/ui/splash/splash_bloc.dart';
import 'package:code/ui/task_comment/task_comment_add_edit_bloc.dart';
import 'package:code/ui/task_create/tx_edit_field_bloc.dart';
import 'package:code/ui/task_filter/task_fliter_bloc.dart';
import 'package:code/ui/task_milestone/task_milestone_bloc.dart';
import 'package:code/ui/task_milestone_create_edit/task_milestone_create_edit_bloc.dart';
import 'package:code/ui/tasks_tag/tasks_tag_bloc.dart';
import 'package:code/ui/tasks_tag_create_edit/tasks_tag_create_edit_bloc.dart';
import 'package:code/ui/tasks_tag_selector/task_tag_selector_bloc.dart';
import 'package:code/ui/task/task_bloc.dart';
import 'package:code/ui/task_create/task_create_bloc.dart';
import 'package:code/ui/task_detail/task_detail_bloc.dart';
import 'package:code/ui/task_milestone_selector/task_milestone_selector_bloc.dart';
import 'package:code/ui/team/team_bloc.dart';
import 'package:code/ui/team_create/onboarding_welcome_bloc.dart';
import 'package:code/ui/team_create/team_create_bloc.dart';
import 'package:code/ui/thread/thread_bloc.dart';
import 'package:code/ui/thread_type_page/thread_type_bloc.dart';
import 'package:code/ui/user_detail/user_detail_bloc.dart';
import 'package:code/utils/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kiwi/kiwi.dart';

import '../data/repository/2fa_repository.dart';
import '../enums.dart';
import '../ui/edit_team/edit_team_bloc.dart';

///Part dependency injector engine and Part service locator.
///The main purpose of [Injector] is to provide bloCs instances and initialize the app components depending the current scope.
///To reuse a bloc instance in the widget's tree feel free to use the [BlocProvider] mechanism.
class Injector {
  ///Singleton instance
  static late Injector instance;
  bool darkTheme = false;

  KiwiContainer container = KiwiContainer();
  static Environment _environment = Environment.DEV;

  Environment get env => _environment;

  String get baseUrl =>
      env == Environment.DEV ? Endpoint.apiBaseUrlDev : Endpoint.apiBaseUrlProd;

  String get meetingBaseUrl => env == Environment.DEV
      ? baseUrl.contains("pre")
          ? Endpoint.meetBaseUrlPre
          : Endpoint.meetBaseUrlDev
      : Endpoint.meetBaseUrlProd;

  ///Is the app in debug mode?
  bool isInDebugMode() {
    var debugMode = false;
    assert(debugMode = true);
    return debugMode;
  }

  ///returns the current instance of the logger
//  Logger getLogger() => container.resolve();

  ///returns a new bloc instance
  T getNewBloc<T extends BaseBloC>() => container.resolve();

  InMemoryData get inMemoryData => container.resolve();

  FileCacheManager get fileCacheManager => container.resolve();

//
//  SharedPreferencesManager get sharedP => container.resolve();

  T getDependency<T>() => container.resolve();

  static initProd() {
    _environment = Environment.PROD;
    instance = Injector._init();
  }

  static initDev() {
    _environment = Environment.DEV;
    instance = Injector._init();
  }

  Injector._init() {
    _initialize();
  }

  _initialize() {
    _registerCommon();
    _registerMappers();
    _registerApiLayer();
    _registerDaoLayer();
    _registerRepositoryLayer();
    _registerBloCs();
  }

  _registerMappers() {
    container.registerSingleton<IAccountConverter>(
        (c) => AccountConverter(container.resolve()));

    container.registerSingleton<IUserConverter>((c) => UserConverter());

    container.registerSingleton<IUsageConverter>((c) => UsageConverter());

    container.registerSingleton<ITeamConverter>((c) => TeamConverter(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));

    container.registerSingleton<IChannelConverter>(
        (c) => ChannelConverter(container.resolve()));

    container.registerSingleton<IMessageConverter>((c) => MessageConverter(
        container.resolve(), container.resolve(), container.resolve()));

    container.registerSingleton<ITaskConverter>((c) => TaskConverter());

    container.registerSingleton<IThreadConverter>(
        (c) => ThreadConverter(container.resolve()));

    container.registerSingleton<IFileConverter>((c) => FileConverter());

    container.registerSingleton<IActivityConverter>((c) => ActivityConverter());

    container.registerSingleton<I2faConverter>((c) => TwoFaConverter());
  }

  _registerApiLayer() {
    container.registerSingleton<IAccountApi>(
        (c) => AccountApi(container.resolve(), container.resolve()));
    container.registerSingleton<IUserApi>((c) => UserApi(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerSingleton<ITeamApi>((c) =>
        TeamApi(container.resolve(), container.resolve(), container.resolve(), container.resolve()));
    container.registerSingleton<IChannelApi>((c) => ChannelApi(
        container.resolve(), container.resolve(), container.resolve()));
    container.registerSingleton<ITaskApi>((c) =>
        TaskApi(container.resolve(), container.resolve(), container.resolve()));
    container.registerSingleton<IMessageApi>((c) => MessageApi(
        container.resolve(), container.resolve(), container.resolve()));
    container.registerSingleton<IThreadApi>((c) => ThreadApi(
        container.resolve(), container.resolve(), container.resolve()));
    container.registerSingleton<IFileApi>((c) =>
        FileApi(container.resolve(), container.resolve(), container.resolve()));
    container.registerSingleton<IActivityApi>(
        (c) => ActivityApi(container.resolve(), container.resolve()));
    container.registerSingleton<I2faApi>((c) => TwoFaApi(c.resolve(), c.resolve()));
  }

  _registerDaoLayer() {
    container.registerSingleton((c) => AppDatabase.instance);
    container.registerSingleton<ICommonDao>((c) => CommonDao(c.resolve()));

    container
        .registerSingleton<ITeamDao>((c) => TeamDao(c.resolve(), c.resolve()));
    container.registerSingleton<IChannelDao>(
        (c) => ChannelDao(c.resolve(), c.resolve()));
    container
        .registerSingleton<IUserDao>((c) => UserDao(c.resolve(), c.resolve()));
  }

  _registerRepositoryLayer() {
    container.registerSingleton<IAccountRepository>((c) => AccountRepository(
        container.resolve(), container.resolve(), container.resolve()));
    container.registerSingleton<IUserRepository>(
        (c) => UserRepository(container.resolve(), container.resolve()));
    container.registerSingleton<ITeamRepository>((c) => TeamRepository(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerSingleton<IChannelRepository>((c) => ChannelRepository(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerSingleton<ITaskRepository>(
        (c) => TaskRepository(container.resolve(), container.resolve()));
    container.registerSingleton<IMessageRepository>(
        (c) => MessageRepository(container.resolve(), container.resolve()));
    container.registerSingleton<IThreadRepository>(
        (c) => ThreadRepository(container.resolve()));
    container.registerSingleton<IFileRepository>(
        (c) => FileRepository(container.resolve()));
    container.registerSingleton<IActivityRepository>(
        (c) => ActivityRepository(container.resolve(), container.resolve()));
    container.registerSingleton<I2faRepository>((c) => TwoFaRepository(c.resolve()));
  }

  _registerBloCs() {
    container.registerFactory((container) => AppBloC(
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory(
        (container) => SplashBloC(container.resolve(), container.resolve()));
    container
        .registerFactory((container) => TXUriResolverBloC(container.resolve()));
    container.registerFactory((container) => HomeBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory(
        (container) => RegisterBloC(container.resolve(), container.resolve()));
    container.registerFactory((container) => LoginBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory((container) =>
        RecoverPasswordBloC(container.resolve(), container.resolve()));
    container.registerFactory((container) => TeamBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory((container) => TeamCreateBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory((container) => OnboardingWelcomeBloC(
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory((container) =>
        InvitationsBloC(container.resolve(), container.resolve()));
    container.registerFactory(
        (container) => InviteBloC(container.resolve(), container.resolve()));
    container.registerFactory((container) => InvitePeopleBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory((container) => TaskBloC(
        container.resolve(), container.resolve(), container.resolve()));

    container.registerFactory((container) => TaskFilterBloC());

    container.registerFactory((container) =>
        FilesExplorerBloC(container.resolve(), container.resolve(), container.resolve(), container.resolve()));
    container.registerFactory(
        (container) => ShareFileBloC(container.resolve(), container.resolve()));

    container.registerFactory((container) => TaskDetailBloC(
        container.resolve(), container.resolve(), container.resolve(), container.resolve(), container.resolve()));

    container.registerFactory((container) =>
        TaskCommentAddEditBloC(container.resolve(), container.resolve()));
    container.registerFactory((container) =>
        TaskCreateBloC(container.resolve(), container.resolve(), container.resolve()));
    container.registerFactory((container) =>
        TaskTagSelectorBloC(container.resolve(), container.resolve()));

    container.registerFactory((container) =>
        TaskMilestoneSelectorBloC(container.resolve(), container.resolve()));
    container.registerFactory((container) => SearchUserBloC(
        container.resolve(), container.resolve(), container.resolve(), container.resolve()));
    container.registerFactory((container) => ProfileBloC(container.resolve(),
        container.resolve(), container.resolve()));

    container.registerFactory((container) => LinkBloC(container.resolve()));

    container
        .registerFactory((container) => EditMessageBloC(container.resolve()));

    container.registerFactory((container) => MessageCommentsBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));

    container.registerFactory((container) => MentionBloC(container.resolve(),
        container.resolve(), container.resolve(), container.resolve()));

    container.registerFactory((container) => UserDetailBloC(
        container.resolve(), container.resolve(), container.resolve()));

    container.registerFactory(
        (container) => ChannelBloC(container.resolve(), container.resolve()));

    container.registerFactory((container) =>
        ChannelCreateBloC(container.resolve(), container.resolve()));

    container.registerFactory((container) =>
        PrivateGroupBloC(container.resolve(), container.resolve()));

    container.registerFactory((container) =>
        PrivateGroupCreateBloC(container.resolve(), container.resolve()));

    container.registerFactory(
        (container) => ChannelPreferencesBloC(container.resolve()));
    container
        .registerFactory((container) => ChannelRenameBloC(container.resolve()));
    container.registerFactory((container) => ThreadBloC(
        container.resolve(), container.resolve(), container.resolve()));
    container.registerFactory((container) => ThreadTypeBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));

    container.registerFactory((container) => TXChatTextInputBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory((container) =>
        TaskTagCreateEditBloc(container.resolve(), container.resolve()));
    container.registerFactory((container) =>
        TaskMilestoneCreateEditBloC(container.resolve(), container.resolve()));

    container.registerFactory(
        (container) => TaskTagBloc(container.resolve(), container.resolve()));
    container.registerFactory((container) =>
        TaskMilestoneBloc(container.resolve(), container.resolve()));
    container.registerFactory((container) => SearchGlobalBloC(
          container.resolve(),
          container.resolve(),
          container.resolve(),
          container.resolve(),
          container.resolve(),
          container.resolve(),
        ));
    container.registerFactory((container) => ShareExternalBloC(
          container.resolve(),
          container.resolve(),
          container.resolve(),
          container.resolve()
        ));

    container.registerFactory((container) => CalendarBloc(
          container.resolve(),
          container.resolve(),
          container.resolve(),
        ));
    container.registerFactory((container) => ActivityZoneBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory((container) => SessionsBloC(container.resolve()));
    container.registerFactory((container) => OverlayDatePickerBloC());
    container.registerFactory((container) => FavoritesBloC(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));
    container.registerFactory((container) => TXVideoPlayerBloC());
    container.registerFactory((container) => AuthenticatorBloC(container.resolve()));
    container.registerFactory((container) => EditTeamBloC(container.resolve(), container.resolve(), container.resolve()));
    container.registerFactory((container) => TXEditFieldBloC(container.resolve()));
  }

  _registerCommon() {
    container.registerSingleton<Logger>((c) => LoggerImpl());
    container.registerSingleton<IFCMController>(
      (c) => FCMController(
        c.resolve(),
        c.resolve(),
        c.resolve()
      ),
    );
    container.registerSingleton((c) => FlutterLocalNotificationsPlugin());

    container.registerSingleton<InMemoryData>((c) => InMemoryData(
        container.resolve()));

    container.registerSingleton<FileCacheManager>(
        (c) => FileCacheManager(container.resolve()));

    container.registerSingleton<IRTCManager>((c) => RTCManager(
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve(),
        container.resolve()));

    container.registerSingleton((c) => ConnectivityManager());

    container.registerSingleton((c) => SharedPreferencesManager());

    container.registerSingleton(
      (c) => NetworkHandler(container.resolve(), container.resolve(), container.resolve()),
    );
//    container.registerSingleton<IFCMFeature, FCMFeature>(
//      (c) => FCMFeature(
//        c.resolve(),
//        c.resolve(),
//      ),
//    );
  }
}
