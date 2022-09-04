import 'package:code/data/api/remote/remote_constants.dart';

class AppSettingsModel {
  int? languageCodeId;
  String languageCode;
  bool isDarkMode;

  AppSettingsModel({this.isDarkMode = false, this.languageCode = RemoteConstants.defLang, this.languageCodeId});
}

class ShareContentModel {
  String content;
  bool isFile;

  ShareContentModel({this.content = "", this.isFile = false});
}
