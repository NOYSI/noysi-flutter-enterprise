import '../../../_res/values/config.dart';

class Endpoint {
  static const String apiBaseUrlDev = noysiBaseUrlDev;
  static const String apiBaseUrlProd = noysiBaseUrlProd;

  static const String noysiBaseUrlProd = "https://noysi.com";
  static const String noysiBaseUrlDev = "https://dev.noysi.com";
  static const String noysiBaseUrlPre = "https://pre.noysi.com";

  static const String meetBaseUrlProd = "https://meet.noysi.com";
  static const String meetBaseUrlDev = "https://dev-meet.noysi.com";
  static const String meetBaseUrlPre = "https://pre-meet.noysi.com";

  static String noysiZendesk = "https://noysi.zendesk.com/hc/${AppConfig.localeCode}";

  static String cnameHelp = "";

  static String get helpUrl => cnameHelp.isNotEmpty ? cnameHelp : noysiZendesk;

  static const String apiVersion = "/v1";

  ///Authorization & Authentication
  static const String login = "/identity/sign-in";
  static const String googleSignIn = "/identity/google/connect";
  static const String appleSignIn = "/identity/apple/connect";
  static const String recoverPassword = "/identity/forgot-password";
  static const String logout = "/identity/logout";
  static const String logoutSessions = "/identity/logout/sessions";
  static const String register = "/identity/sign-up";
  static const String mailCheck = "/identity/sign-up-check";
  static const String authorize = "/authorize";

  ///Teams
  static const String teams = "/teams";

  ///Accounts
  static const String accounts = "/accounts";

  ///Members
  static const String members = "/members";

  ///Users
  static const String users = '/users';

  ///Tasks
  static const String tasks = "/tasks";
  static const String action_reopen = "/actions/reopen";
  static const String action_close = "/actions/close";

  ///Channels
  static const String channels = "/channels";
  static const String channels_rename = "/rename";
  static const String channels_mentions = "/mentions";

  ///Messages
  static const String messages = "/messages";
  static const String unread_count = "/unread/count";

  ///Comments
  static const String comments = "/comments";

  ///Threads
  static const String threads = "/threads";

  ///Reaction
  static const String reactions = "/reactions";

  ///Activity Zone
  static const String activities = "/activity";
  static const String sessions = "/identity/sessions";

  ///Files
  static const String files = "/files";

  ///Favorites
  static const String favorites = "/favorites";

  ///2fa
  static const String two_fa = "/2fa/totps";

  ///public
  static const String public = "/public";

  ///noysi enterprise
  static const String enterprise = "/enterprise";

  static const String pinned = "/pinned";
}
