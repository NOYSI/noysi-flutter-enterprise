import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  final String firstUse = "firstUse";
  final String termsAccepted = "termsAccepted";
  final String baseUrl = "baseUrl";
  final String accessToken = "accessToken";
  final String refreshToken = "refreshToken";
  final String wss = "wss";
  final String userId = "userId";
  final String currentTeamId = "currentTeamId";
  final String currentTeamName = "currentTeamName";
  final String currentTeamCname = 'currentTeamCname';
  final String currentTeamEnterprise = 'currentTeamEnterprise';
  final String currentChatId = "currentChatId";
  final String language = "language";
  final String cleanLocalDB = "cleanLocalDB";
  final String email = "email";
//  final String password = "password";

  ///Drawer config
  final String favoritesExpanded = "favoritesExpanded";
  final String imsExpanded = "imsExpanded";
  final String channelsExpanded = "channelsExpanded";
  final String groupsExpanded = "groupsExpanded";

  ///Meeting options
  final String displayName = "displayName";
  final String audioMuted = "audioMuted";
  final String videoMuted = "videoMuted";
  final String dontShowAgain = "dontShowAgain";


  Future<void> init() async {
    await setBoolValue(firstUse, true);
    await setBoolValue(cleanLocalDB, true);
    await setBoolValue(termsAccepted, false);

    await setStringValue(displayName, "");
    await setBoolValue(audioMuted, false);
    await setBoolValue(videoMuted, false);
    await setBoolValue(dontShowAgain, false);
    await setBoolValue(currentTeamEnterprise, false);

    await setBoolValue(favoritesExpanded, true);
    await setBoolValue(channelsExpanded, true);
    await setBoolValue(imsExpanded, true);
    await setBoolValue(groupsExpanded, true);

    await setStringValue(baseUrl, "");
    await setStringValue(accessToken, "");
    await setStringValue(refreshToken, "");
//    await setStringValue(password, "");
    await setStringValue(wss, "");
    await setStringValue(userId, "");
    await setStringValue(currentTeamId, "");
    await setStringValue(currentTeamName, "");
    await setStringValue(currentTeamCname, "");
    await setStringValue(currentChatId, "");
//    await setStringValue(language, "en");
  }
  
  Future<void> logout({bool cleanMail = false}) async {
    if(cleanMail) await setStringValue(email, "");
    await setStringValue(userId, "");
    await setStringValue(accessToken, "");
    await setStringValue(refreshToken, "");
    await setStringValue(wss, "");
    await setStringValue(currentChatId, "");
    await setStringValue(currentTeamId, "");
    await setStringValue(currentTeamName, "");
    await setStringValue(currentTeamCname, "");
    await setStringValue(displayName, "");
    await setBoolValue(audioMuted, false);
    await setBoolValue(videoMuted, false);
    await setBoolValue(dontShowAgain, false);
    await setBoolValue(currentTeamEnterprise, false);
    await setBoolValue(favoritesExpanded, true);
    await setBoolValue(channelsExpanded, true);
    await setBoolValue(imsExpanded, true);
    await setBoolValue(groupsExpanded, true);
  }

  Future<bool> getBoolValue(String key, {bool defValue = false}) async {
    var value = (await SharedPreferences.getInstance()).getBool(key);
    if (value == null) {
      value = defValue;
      await setBoolValue(key, value);
    }
    return value;
  }

  Future<bool> setBoolValue(String key, bool newValue) async {
    final sh = await SharedPreferences.getInstance();
    var res = await sh.setBool(key, newValue);
    return res;
  }

  Future<int> getIntValue(String key, {int defValue = 0}) async {
    var value = (await SharedPreferences.getInstance()).getInt(key);
    if (value == null) {
      value = defValue;
      await setIntValue(key, value);
    }
    return value;
  }

  Future<bool> setIntValue(String key, int newValue) async {
    final sh = await SharedPreferences.getInstance();
    var res = await sh.setInt(key, newValue);
    return res;
  }

  Future<String> getStringValue(String key, {String defValue = ""}) async {
    var value = (await SharedPreferences.getInstance()).getString(key);
    if (value == null) {
      value = defValue;
      await setStringValue(key, value);
    }
    return value;
  }

  Future<bool> setStringValue(String key, String newValue) async {
    final sh = await SharedPreferences.getInstance();
    var res = await sh.setString(key, newValue);
    return res;
  }
}
