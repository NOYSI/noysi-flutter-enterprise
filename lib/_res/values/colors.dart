
import 'package:code/_di/injector.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:flutter/material.dart';

class AppColor {
  final bool isDarkTheme;

  AppColor({this.isDarkTheme = false});

  final primaryColor = Color(0xFF1C0333);
  final primaryDarkColor = Color(0xFF1C1111);
  final primaryLightColor = Color(0xFF5B476A);
  final secondaryColor = Color(0xFF3333CC);
  final secondaryHeaderColor = Color(0xFF281462);
  final accentColor = Color(0xFF00FFB6);
  final presenceColor = Color(0xFF00FF5A);
  final blackColor = Color(0xFF000000);
  final darkColor = Color(0xFF212121);
  final grayDarkestColor = Color(0xFF262626);
  final grayDarkColor = Color(0xFF363636);
  final grayColor = Color(0xFF757575);
  final graySemiLightColor = Color(0xFF97A0AE);
  final grayLightColor = Color(0xFFBDBDBD);
  final grayLightestColor = Color(0xFFE6E6E6);
  final grayBar = Color(0xFFF3F3F4);
  final whiteColor = Color(0xFFFFFFFF);
  final orangeLight = Color(0xFFFCE8CB);
  final orange = Color(0xFFF6B75C);
  final warning = Color(0xFFF6B13F);
  final blueLink = Color(0xFF49A2CC);

  final tagColor1 = Color(0xFFFF6666);
  final tagColor2 = Color(0xFFFF9466);
  final tagColor3 = Color(0xFFFFD166);
  final tagColor4 = Color(0xFFFFFF00);
  final tagColor5 = Color(0xFF218100);
  final tagColor6 = Color(0xFF7ED321);
  final tagColor7 = Color(0xFF17B6A7);
  final tagColor8 = Color(0xFF00FFCE);
  final tagColor9 = Color(0xFF0000EE);
  final tagColor10 = Color(0xFF2A80B9);
  final tagColor11 = Color(0xFF28A6EF);
  final tagColor12 = Color(0xFF3F71FF);
  final tagColor13 = Color(0xFF6800D3);
  final tagColor14 = Color(0xFFA800FF);
  final tagColor15 = Color(0xFFEB58DF);
  final tagColor16 = Color(0xFFFF709F);

  final calendarButton = Color(0xFFFC149C);
  final unreadThread = Color(0xFFB2EBF2);

  Color get blurBackground =>
      Injector.instance.darkTheme ? Color(0xc8808080) : Color(0xc8F6F7FB);

  final defaultTheme = TeamTheme(
    RemoteConstants.defaultTheme,
    TeamColors(
      sidebarColor: Color(0xff1C0333),
      activeItemBackground: Color(0xff3333CC),
      activeItemText: Color(0xffffffff),
      textColor: Color(0xffcad0e4),
      activePresence: Color(0xff00ff5a),
      inactivePresence: Color(0xffffa30c),
      notificationBadgeBackground: Color(0xff00FFB6),
      notificationBadgeText: Color(0xff1C0333),
    )
  );

  final bluejeansTheme = TeamTheme(
      RemoteConstants.bluejeansTheme,
      TeamColors(
        sidebarColor: Color(0xff474f6a),
        activeItemBackground: Color(0xff313748),
        activeItemText: Color(0xffffffff),
        textColor: Color(0xffcad0e4),
        activePresence: Color(0xff00ff5a),
        inactivePresence: Color(0xffffa30c),
        notificationBadgeBackground: Color(0xff22bf77),
        notificationBadgeText: Color(0xffffffff),
      )
  );

  final blackboardTheme = TeamTheme(
      RemoteConstants.blackboardTheme,
      TeamColors(
        sidebarColor: Color(0xff2b2b2b),
        activeItemBackground: Color(0xff404040),
        activeItemText: Color(0xffffffff),
        textColor: Color(0xffffffff),
        activePresence: Color(0xff00ff5a),
        inactivePresence: Color(0xffffa30c),
        notificationBadgeBackground: Color(0xffde4e5b),
        notificationBadgeText: Color(0xffffffff),
      )
  );

  final lightTheme = TeamTheme(
      RemoteConstants.lightTheme,
      TeamColors(
        sidebarColor: Color(0xfff9f9f9),
        activeItemBackground: Color(0xffffffff),
        activeItemText: Color(0xff2b2b2b),
        textColor: Color(0xff999999),
        activePresence: Colors.green,
        inactivePresence: Color(0xFF757575),
        notificationBadgeBackground: Color(0xffde4e5b),
        notificationBadgeText: Color(0xffffffff),
      )
  );

  final greenbeansTheme = TeamTheme(
      RemoteConstants.greenbeansTheme,
      TeamColors(
        sidebarColor: Color(0xff476a57),
        activeItemBackground: Color(0xff3a5847),
        activeItemText: Color(0xffffffff),
        textColor: Color(0xffffffff),
        activePresence: Color(0xff4ae8bc),
        inactivePresence: Color(0xfff6be3f),
        notificationBadgeBackground: Color(0xff28d660),
        notificationBadgeText: Color(0xffffffff),
      )
  );
}
