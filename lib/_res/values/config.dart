import 'dart:io';

import 'package:code/_res/values/text/custom_localizations_delegate.dart';

enum AppPlatform { ANDROID, IOS }
enum AppLocale { EN, ES, DE, FR, PT, AR, JA, SC, TC, EU, GL, CA }

class AppConfig {
  static bool get isInDebugMode {
    var debugMode = false;
    assert(debugMode = true);
    return debugMode;
  }

  static AppLocale get locale => CustomLocalizationsDelegate.currentLang;

  static String get localeCode => locale == AppLocale.DE
      ? 'de'
      : locale == AppLocale.ES
          ? 'es'
          : locale == AppLocale.FR
              ? 'fr'
              // : locale == AppLocale.RU
              //     ? 'ru'
                  : locale == AppLocale.PT
                      ? 'pt'
                      : locale == AppLocale.AR
                          ? 'ar'
                          : locale == AppLocale.JA
                              ? 'ja'
                              : locale == AppLocale.TC
                                  ? 'tc'
                                  : locale == AppLocale.SC
                                      ? 'sc'
                                      : locale == AppLocale.EU
                                          ? 'eu'
                                          : locale == AppLocale.GL
                                              ? 'gl'
                                              : locale == AppLocale.CA
                                                  ? 'ca'
                                                  // : locale == AppLocale.IT
                                                  //   ? 'it'
                                                  //   : locale == AppLocale.VI
                                                  //     ? 'vi'
                                                      : 'en';

  ///Access to info about current platform
  static AppPlatform get platform =>
      Platform.isIOS ? AppPlatform.IOS : AppPlatform.ANDROID;
}
