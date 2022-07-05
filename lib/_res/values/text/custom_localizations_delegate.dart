import 'package:code/_res/values/config.dart';
import 'package:code/_res/values/text/strings_ar.dart';
import 'package:code/_res/values/text/strings_base.dart';
import 'package:code/_res/values/text/strings_ca.dart';
import 'package:code/_res/values/text/strings_de.dart';
import 'package:code/_res/values/text/strings_en.dart';
import 'package:code/_res/values/text/strings_es.dart';
import 'package:code/_res/values/text/strings_eu.dart';
import 'package:code/_res/values/text/strings_fr.dart';
import 'package:code/_res/values/text/strings_gl.dart';
import 'package:code/_res/values/text/strings_ja.dart';
import 'package:code/_res/values/text/strings_pt.dart';
import 'package:code/_res/values/text/strings_sc.dart';
import 'package:code/_res/values/text/strings_tc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CustomLocalizationsDelegate extends LocalizationsDelegate<StringsBase> {
  static StringsBase stringsBase = StringsEn();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("es", ""),
      Locale("de", ""),
      Locale("fr", ""),
      // Locale("ru", ""),
      Locale("pt", ""),
      Locale("ar", ""),
      Locale("ja", ""),
      Locale("eu", ""),
      Locale("gl", ""),
      Locale("ca", ""),
      // Locale("it", ""),
      // Locale("vi", ""),
      Locale.fromSubtags(languageCode: "zh", scriptCode: "Hans"),
      Locale.fromSubtags(languageCode: "zh", scriptCode: "Hant"),
    ];
  }

  @override
  Future<StringsBase> load(Locale locale) {
    switch (locale.languageCode) {
     case "de":
       stringsBase = StringsDe();
       currentLang = AppLocale.DE;
       break;
      case "es":
        stringsBase = StringsEs();
        currentLang = AppLocale.ES;
        break;
     case "fr":
       stringsBase = StringsFr();
       currentLang = AppLocale.FR;
       break;
      // case "ru":
      //   stringsBase = StringsRu();
      //   currentLang = AppLocale.RU;
      //   break;
      case "en":
        stringsBase = StringsEn();
        currentLang = AppLocale.EN;
        break;
      case "ar":
        stringsBase = StringsAr();
        currentLang = AppLocale.AR;
        break;
      case "pt":
        stringsBase = StringsPt();
        currentLang = AppLocale.PT;
        break;
      case "ja":
        stringsBase = StringsJa();
        currentLang = AppLocale.JA;
        break;
      case "eu":
        stringsBase = StringsEu();
        currentLang = AppLocale.EU;
        break;
      case "gl":
        stringsBase = StringsGl();
        currentLang = AppLocale.GL;
        break;
      case "ca":
        stringsBase = StringsCa();
        currentLang = AppLocale.CA;
        break;
      // case "it":
      //   stringsBase = StringsIt();
      //   currentLang = AppLocale.IT;
      //   break;
      // case "vi":
      //   stringsBase = StringsVi();
      //   currentLang = AppLocale.VI;
      //   break;
      case "zh":
        if(locale.scriptCode == "Hans"){
          stringsBase = StringsSc();
          currentLang = AppLocale.SC;
        }else{
          stringsBase = StringsTc();
          currentLang = AppLocale.TC;
        }
        break;
      default:
        stringsBase = StringsEn();
        currentLang = AppLocale.EN;
        break;
    }
    return SynchronousFuture<StringsBase>(stringsBase);
  }

  static late AppLocale currentLang;

  LocaleResolutionCallback resolution({Locale? fallback}) {
    return (Locale? locale, Iterable<Locale> supported) {
      return resolve(locale, fallback, supported);
    };
  }

  Locale resolve(Locale? locale, Locale? fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale.fromSubtags(languageCode: locale.languageCode,
        scriptCode: locale.scriptCode);
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  bool isSupported(Locale locale) {
    return supportedLocales
        .map((l) => l.languageCode)
        .toList()
        .contains(locale.languageCode);
  }

  @override
  bool shouldReload(LocalizationsDelegate<StringsBase> old) => false;
}
