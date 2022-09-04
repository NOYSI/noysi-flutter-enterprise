
import 'package:code/_di/injector.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:flutter/material.dart';

class AppColor {
  final bool isDarkTheme;

  AppColor({this.isDarkTheme = false});

  final primaryColor = const Color(0xFF1C0333);
  final primaryDarkColor = const Color(0xFF1C1111);
  final primaryLightColor = const Color(0xFF5B476A);
  final secondaryColor = const Color(0xFF3333CC);
  final secondaryHeaderColor = const Color(0xFF281462);
  final accentColor = const Color(0xFF00FFB6);
  final presenceColor = const Color(0xFF00FF5A);
  final blackColor = const Color(0xFF000000);
  final darkColor = const Color(0xFF212121);
  final grayDarkestColor = const Color(0xFF262626);
  final grayDarkColor = const Color(0xFF363636);
  final grayColor = const Color(0xFF757575);
  final graySemiLightColor = const Color(0xFF97A0AE);
  final grayLightColor = const Color(0xFFBDBDBD);
  final grayLightestColor = const Color(0xFFE6E6E6);
  final grayBar = const Color(0xFFF3F3F4);
  final whiteColor = const Color(0xFFFFFFFF);
  final orangeLight = const Color(0xFFFCE8CB);
  final orange = const Color(0xFFF6B75C);
  final warning = const Color(0xFFF6B13F);
  final blueLink = const Color(0xFF49A2CC);

  final tagColor1 = const Color(0xFFFF6666);
  final tagColor2 = const Color(0xFFFF9466);
  final tagColor3 = const Color(0xFFFFD166);
  final tagColor4 = const Color(0xFFFFFF00);
  final tagColor5 = const Color(0xFF218100);
  final tagColor6 = const Color(0xFF7ED321);
  final tagColor7 = const Color(0xFF17B6A7);
  final tagColor8 = const Color(0xFF00FFCE);
  final tagColor9 = const Color(0xFF0000EE);
  final tagColor10 = const Color(0xFF2A80B9);
  final tagColor11 = const Color(0xFF28A6EF);
  final tagColor12 = const Color(0xFF3F71FF);
  final tagColor13 = const Color(0xFF6800D3);
  final tagColor14 = const Color(0xFFA800FF);
  final tagColor15 = const Color(0xFFEB58DF);
  final tagColor16 = const Color(0xFFFF709F);

  final calendarButton = const Color(0xFFFC149C);
  final unreadThread = const Color(0xFFB2EBF2);
  final lifetimeDealButtonYellow = const Color(0xFFF8E71C);

  Color get blurBackground =>
      Injector.instance.darkTheme ? const Color(0xc8808080) : const Color(0xc8F6F7FB);

  final defaultTheme = TeamTheme(
    RemoteConstants.defaultTheme,
    TeamColors(
      sidebarColor: const Color(0xff1C0333),
      activeItemBackground: const Color(0xff3333CC),
      activeItemText: const Color(0xffffffff),
      textColor: const Color(0xffcad0e4),
      activePresence: const Color(0xff00ff5a),
      inactivePresence: const Color(0xffffa30c),
      notificationBadgeBackground: const Color(0xff00FFB6),
      notificationBadgeText: const Color(0xff1C0333),
    )
  );

  final bluejeansTheme = TeamTheme(
      RemoteConstants.bluejeansTheme,
      TeamColors(
        sidebarColor: const Color(0xff474f6a),
        activeItemBackground: const Color(0xff313748),
        activeItemText: const Color(0xffffffff),
        textColor: const Color(0xffcad0e4),
        activePresence: const Color(0xff00ff5a),
        inactivePresence: const Color(0xffffa30c),
        notificationBadgeBackground: const Color(0xff22bf77),
        notificationBadgeText: const Color(0xffffffff),
      )
  );

  final blackboardTheme = TeamTheme(
      RemoteConstants.blackboardTheme,
      TeamColors(
        sidebarColor: const Color(0xff2b2b2b),
        activeItemBackground: const Color(0xff404040),
        activeItemText: const Color(0xffffffff),
        textColor: const Color(0xffffffff),
        activePresence: const Color(0xff00ff5a),
        inactivePresence: const Color(0xffffa30c),
        notificationBadgeBackground: const Color(0xffde4e5b),
        notificationBadgeText: const Color(0xffffffff),
      )
  );

  final lightTheme = TeamTheme(
      RemoteConstants.lightTheme,
      TeamColors(
        sidebarColor: const Color(0xfff9f9f9),
        activeItemBackground: const Color(0xffffffff),
        activeItemText: const Color(0xff2b2b2b),
        textColor: const Color(0xff999999),
        activePresence: Colors.green,
        inactivePresence: const Color(0xFF757575),
        notificationBadgeBackground: const Color(0xffde4e5b),
        notificationBadgeText: const Color(0xffffffff),
      )
  );

  final greenbeansTheme = TeamTheme(
      RemoteConstants.greenbeansTheme,
      TeamColors(
        sidebarColor: const Color(0xff476a57),
        activeItemBackground: const Color(0xff3a5847),
        activeItemText: const Color(0xffffffff),
        textColor: const Color(0xffffffff),
        activePresence: const Color(0xff4ae8bc),
        inactivePresence: const Color(0xfff6be3f),
        notificationBadgeBackground: const Color(0xff28d660),
        notificationBadgeText: const Color(0xffffffff),
      )
  );
}
