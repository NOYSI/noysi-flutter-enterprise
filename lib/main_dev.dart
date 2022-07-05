import 'dart:async';

import 'package:code/_di/injector.dart';
import 'package:code/app.dart';
import 'package:code/ui/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'fcm/fcm_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(FCMController.myBackgroundMessageHandler);
  Injector.initDev();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runZonedGuarded(() {
    runApp(
      NoysiApp(
        initPage: HomePage(),
        fcmController: Injector.instance.getDependency(),
      ),
    );
  }, (error, stackTrace) async {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
