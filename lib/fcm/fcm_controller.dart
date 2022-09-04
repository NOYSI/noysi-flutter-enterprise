import 'dart:async';
import 'dart:collection';
import 'package:collection/collection.dart';
import 'dart:convert';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/fcm/i_fcm_controller.dart';
import 'package:code/ui/home/home_bloc.dart';
import 'package:code/utils/logger.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:code/utils/extensions.dart';
import 'package:rxdart/rxdart.dart';
import '../_res/R.dart';
import '../data/_shared_prefs.dart';
import '../data/in_memory_data.dart';
import 'fcm_message_model.dart';
import 'dart:io';
import 'package:code/utils/text_parser_utils.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

final BehaviorSubject<PayloadModel> selectNotificationSubject =
    BehaviorSubject<PayloadModel>();

BehaviorSubject<FCMMessageModel> localNotificationController =
    BehaviorSubject();

bool fcmResumedFromBackground = false;

class FCMController extends IFCMController {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NetworkHandler _networkHandler;
  final SharedPreferencesManager _prefs;
  final Logger _logger;

  FCMController(this._networkHandler, this._logger, this._prefs);

  @override
  void setUp() {
    _initLocalNotifications();
    _initFirebaseMessaging();
    if(Platform.isAndroid) _initCallListeners();
    localNotificationController.listen((message) {
      _showCommonNotification(message);
    });
  }

  void _initCallListeners() async {
    final last = await FlutterCallkitIncoming.activeCalls();
    if((last as List<dynamic>).isNotEmpty) {
      StreamSubscription? ss;
      ss = joinedTeamLocally.listen((value) {
        if(value) {
          final extra = (last.first["l"] as LinkedHashMap<String, dynamic>);
          selectNotificationSubject.sinkAddSafe(
              PayloadModel(payload: FCMMessageModel.fromString(extra.toMap())));
          ss?.cancel();
        }
      });
    }
    FlutterCallkitIncoming.onEvent.listen((event) async {
      switch (event!.name) {
        case CallEvent.ACTION_CALL_ACCEPT:
          StreamSubscription? ss;
          ss = joinedTeamLocally.listen((value) {
            if(value) {
              final extra = event.body["extra"] as LinkedHashMap<dynamic, dynamic>;
              selectNotificationSubject.sinkAddSafe(
                  PayloadModel(payload: FCMMessageModel.fromString(extra.toMap())));
              ss?.cancel();
            }
          });
          break;
        case CallEvent.ACTION_CALL_TIMEOUT:
          final extra = event.body["extra"] as LinkedHashMap<dynamic, dynamic>;
          FCMMessageModel model = FCMMessageModel.fromString(extra.toMap());
          FCMMessageModel newModel = FCMMessageModel(
            sound: "default",
            title: model.title,
            tid: model.tid,
            action: fcmMessageActions.MESSAGE,
            channelName: model.channelName,
            cid: model.cid,
            from: model.from,
            image: model.image,
            notId: model.notId,
            sender: model.sender,
            teamName: model.teamName,
            teamTitle: model.teamTitle,
            message: R.string.missedCallFrom(model.sender)
          );
          _showCommonNotification(newModel);
          break;
      }
    });
  }

  //Called when DarwinNotificationActionOption.foreground option on iOS and the showsUserInterface on Android are not set
  //so the app will not show his interface but this function could be executed.
  static void notificationTapBackground(NotificationResponse details) {}

  void _initLocalNotifications() async {
    NotificationAppLaunchDetails? notificationAppDetailsOnLaunch =
        await _flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/logo_white');
    var initializationSettingsIOS = DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
          'noysi_call',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain(
              'ANSWER',
              'Answer',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
            DarwinNotificationAction.plain(
              'DECLINE',
              'Decline',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            )
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ],
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      if (!joinedTeamLocally.value) {
        joinedTLocallyForLNM = joinedTeamLocally.listen((value) {
          if (value) {
            fcmResumedFromBackground = true;
            selectNotificationSubject.sinkAddSafe(PayloadModel(
                payload:
                    FCMMessageModel.fromString(json.decode(details.payload!))));
            joinedTLocallyForLNM?.cancel();
          }
        });
      } else {
        fcmResumedFromBackground = true;
        selectNotificationSubject.sinkAddSafe(PayloadModel(
            payload:
                FCMMessageModel.fromString(json.decode(details.payload!))));
      }
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    if ((notificationAppDetailsOnLaunch?.didNotificationLaunchApp ?? false) &&
        notificationAppDetailsOnLaunch?.notificationResponse?.payload != null) {
      calledForOnLaunch = true;
      joinedTLocallyForLNM = joinedTeamLocally.listen((bool value) {
        if (value) {
          selectNotificationSubject.sinkAddSafe(PayloadModel(
              payload: FCMMessageModel.fromString(json.decode(
                  notificationAppDetailsOnLaunch!
                      .notificationResponse!.payload!))));
          joinedTLocallyForLNM?.cancel();
        }
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        calledForOnLaunch = false;
      });
    }
  }

  static bool calledForOnLaunch = false;
  StreamSubscription? joinedTLocallyForFCM;
  StreamSubscription? joinedTLocallyForLNM;
  void _initFirebaseMessaging() async {
    _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
    _firebaseMessaging.getToken().then((token) async {
      _logger.log("FCM Token: $token");
    });
    FirebaseMessaging.onMessage.listen((message) => message.data.containsKey("badge")
        ? _updateBadge(message.data["badge"])
        : _showNotification(message.data));

    ///on app resumed
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) => message.data.containsKey("badge")
        ? _updateBadge(message.data["badge"])
        : onResume(message.data));

    ///on app launch
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      initialMessage.data.containsKey("badge")
          ? _updateBadge(initialMessage.data["badge"])
          : onLaunch(initialMessage.data);
    }
  }

  void onResume(Map<String, dynamic> message) {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!calledForOnLaunch) {
        if (!joinedTeamLocally.value) {
          joinedTLocallyForFCM = joinedTeamLocally.listen((value) {
            if (value) {
              FCMMessageModel model = FCMMessageModel.fromString(message);
              fcmResumedFromBackground = true;
              selectNotificationSubject
                  .sinkAddSafe(PayloadModel(payload: model));
              joinedTLocallyForFCM?.cancel();
            }
          });
        } else {
          FCMMessageModel model = FCMMessageModel.fromString(message);
          fcmResumedFromBackground = true;
          selectNotificationSubject.sinkAddSafe(PayloadModel(payload: model));
        }
      }
    });
  }

  void onLaunch(Map<String, dynamic> message) {
    calledForOnLaunch = true;
    joinedTLocallyForFCM = joinedTeamLocally.listen((bool value) {
      if (value) {
        FCMMessageModel model = FCMMessageModel.fromString(message);
        selectNotificationSubject.sinkAddSafe(PayloadModel(payload: model));
        joinedTLocallyForFCM?.cancel();
      }
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      calledForOnLaunch = false;
    });
  }

  // TOP-LEVEL or STATIC function to handle background messages
  static Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    message.data.containsKey("badge")
        ? _updateBadge(message.data["badge"])
        : _showNotificationInBackground(message.data, message.sentTime);
  }

  static Future<void> _updateBadge(String? numberData) async {
    int number = int.tryParse(numberData ?? "") ?? 0;
    if(await FlutterAppBadger.isAppBadgeSupported()) {
      FlutterAppBadger.updateBadgeCount(number < 0 ? 0 : number);
    }
  }

  static Future<void> _showNotification(Map<String, dynamic> fcmMessage) async {
    FCMMessageModel model = FCMMessageModel.fromString(fcmMessage);

    if (InMemoryData.isInForeground) {
      SharedPreferencesManager prefs = SharedPreferencesManager();
      final currentTeamId = await prefs.getStringValue(prefs.currentTeamId);
      final currentChannelId =
          await prefs.getStringValue(prefs.currentChatId);
      if (model.tid == currentTeamId && model.cid == currentChannelId) return;
    }

    await _showCommonNotification(model);
  }

  static Future<void> _showNotificationInBackground(
      Map<String, dynamic> fcmMessage, DateTime? sentTime) async {
    FCMMessageModel model = FCMMessageModel.fromString(fcmMessage);

    model.action == fcmMessageActions.MESSAGE
        ? await _showCommonNotification(model)
        : Platform.isAndroid
            ? _showCallNotifications(fcmMessage, sentTime ?? DateTime.now())
            : _showCallNotificationIOS(fcmMessage, sentTime ?? DateTime.now());
  }

  static Future _showCommonNotification(FCMMessageModel model) async {
    if (model.action != fcmMessageActions.MESSAGE) return;
    String title =
        "${model.sender}: ${Platform.isIOS ? "${model.teamTitleFixed}::" : ""}${model.cid.startsWith("i") ? "@${model.sender}" : model.channelName}";
    String message1 = TextUtilsParser.emojiParser(model.message);
    String message = TextUtilsParser.getRichTexts(message1,
        useHtmlTags: true, antiPattern: Platform.isIOS);

    var bigTextStyleInformation = BigTextStyleInformation(message,
        htmlFormatBigText: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: model.teamTitleFixed,
        htmlFormatSummaryText: true,
        htmlFormatContent: true,
        htmlFormatTitle: true);
    var platformChannelSpecificsAndroid = AndroidNotificationDetails(
        model.sound.isNotEmpty
            ? "fcm_channel_id"
            : "fcm_channel_id_without_sound",
        model.sound.isNotEmpty ? "Noysi(Default)" : "Noysi Muted",
        playSound: model.sound.isNotEmpty,
        enableVibration: true,
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: bigTextStyleInformation);
    // @formatter:on
    var platformChannelSpecificsIos =
        DarwinNotificationDetails(presentSound: model.sound.isNotEmpty);
    var platformChannelSpecifics = NotificationDetails(
        android: platformChannelSpecificsAndroid,
        iOS: platformChannelSpecificsIos);

    _flutterLocalNotificationsPlugin.show(
        model.notId.abs(), title, message, platformChannelSpecifics,
        payload: json.encode(model.toJson()));
  }

  static FCMMessageModel? currentCall;
  static void _showCallNotifications(
      Map<String, dynamic> fcmMessage, DateTime sentTime) async {
    final model = FCMMessageModel.fromString(fcmMessage);

    final last = await FlutterCallkitIncoming.activeCalls();
    if((last as List<dynamic>).isEmpty) currentCall = null;

    if (model.action == fcmMessageActions.CALL &&
        ((currentCall != null &&
            "${model.tid}_${model.cid}" !=
                "${currentCall!.tid}_${currentCall!.cid}") ||
            (sentTime.difference(DateTime.now()).inMinutes.abs() > 1))) {
      FCMMessageModel newModel = FCMMessageModel(
          sound: "default",
          title: model.title,
          tid: model.tid,
          action: fcmMessageActions.MESSAGE,
          channelName: model.channelName,
          cid: model.cid,
          from: model.from,
          image: model.image,
          notId: model.notId,
          sender: model.sender,
          teamName: model.teamName,
          teamTitle: model.teamTitle,
          message: R.string.missedCallFrom(model.sender)
      );
      _showCommonNotification(newModel);
    } else if (model.action == fcmMessageActions.HANG_DOWN &&
        currentCall != null &&
        "${model.tid}_${model.cid}" ==
            "${currentCall!.tid}_${currentCall!.cid}") {
      FlutterCallkitIncoming.endCall(
          <String, dynamic>{'id': currentCall!.notId.abs().toString()});
    } else if (model.action == fcmMessageActions.CALL && currentCall == null) {
      currentCall = model;

      var params = <String, dynamic>{
        'id': currentCall!.notId.abs().toString(),
        'nameCaller': model.sender,
        'avatar': 'https://noysi.com/a/assets/favicon.ico',
        'handle': model.teamTitleFixed,
        'type': 1,
        'textAccept': R.string.answer,
        'textDecline': R.string.hangDown,
        'textMissedCall': 'Missed call',
        'textCallback': 'Call back',
        'duration': 15000,
        'extra': fcmMessage,
        'android': <String, dynamic>{
          'isCustomNotification': true,
          'isShowLogo': true,
          'isShowCallback': false,
          'isShowMissedCallNotification': false,
          'ringtonePath': 'system_ringtone_default',
          'backgroundColor': '#3333CC',
          'actionColor': '#4CAF50'
        },
      };
      FlutterCallkitIncoming.showCallkitIncoming(params);
    }
  }

  static void _showCallNotificationIOS(
      Map<String, dynamic> fcmMessage, DateTime sentTime,
      {bool showMissedNotification = false}) async {
    final model = FCMMessageModel.fromString(fcmMessage);
    bool showMissedCall = showMissedNotification;

    if (currentCall != null) {
      final actives =
          await _flutterLocalNotificationsPlugin.getActiveNotifications();
      if (actives.firstWhereOrNull((e) => e.id == currentCall!.notId.abs()) ==
          null) currentCall = null;
    }

    if (!showMissedCall &&
        model.action == fcmMessageActions.CALL &&
        ((currentCall != null &&
                "${model.tid}_${model.cid}" !=
                    "${currentCall!.tid}_${currentCall!.cid}") ||
            (sentTime.difference(DateTime.now()).inMinutes.abs() > 1))) {
      showMissedCall = true;
    }

    if (!showMissedCall &&
        model.action == fcmMessageActions.HANG_DOWN &&
        currentCall != null &&
        "${model.tid}_${model.cid}" ==
            "${currentCall!.tid}_${currentCall!.cid}") {
      _flutterLocalNotificationsPlugin.cancel(currentCall!.notId.abs());
    } else if (model.action == fcmMessageActions.CALL &&
        (currentCall == null || showMissedCall)) {
      if (!showMissedCall) {
        currentCall = model;
      }

      final String title =
          Platform.isIOS ? "Noysi: ${model.teamTitle}" : "Noysi";
      final String body = showMissedCall
          ? R.string.missedCallFrom(model.sender)
          : R.string.isCallingYou(model.sender);
      var bigTextStyleInformation = BigTextStyleInformation(body,
          htmlFormatBigText: true,
          contentTitle: title,
          htmlFormatContentTitle: true,
          summaryText: model.teamTitleFixed,
          htmlFormatSummaryText: true,
          htmlFormatContent: true,
          htmlFormatTitle: true);
      var platformChannelSpecificsAndroid = AndroidNotificationDetails(
          showMissedCall
              ? model.sound.isNotEmpty
                  ? "fcm_channel_id"
                  : "fcm_channel_id_without_sound"
              : model.sound.isNotEmpty
                  ? "incoming_calls"
                  : "incoming_calls_muted",
          showMissedCall
              ? model.sound.isNotEmpty
                  ? "Noysi(Default)"
                  : "Noysi Muted"
              : model.sound.isNotEmpty
                  ? "Incoming Call"
                  : "Incoming Call(Muted)",
          playSound: model.sound.isNotEmpty,
          enableVibration: true,
          category: showMissedCall ? null : AndroidNotificationCategory.call,
          visibility: showMissedCall ? null : NotificationVisibility.public,
          importance: Importance.high,
          priority: Priority.high,
          actions: showMissedCall
              ? []
              : [
                  AndroidNotificationAction("ANSWER", R.string.answer,
                      titleColor: Colors.green, showsUserInterface: true),
                  AndroidNotificationAction("DECLINE", R.string.hangDown,
                      titleColor: Colors.red, cancelNotification: true)
                ],
          styleInformation: bigTextStyleInformation);
      // @formatter:on
      var platformChannelSpecificsIos = DarwinNotificationDetails(
          presentSound: model.sound.isNotEmpty,
          sound: showMissedCall ? "default" : "defaultRingtone",
          categoryIdentifier: showMissedCall ? null : "noysi_call");
      var platformChannelSpecifics = NotificationDetails(
          android: platformChannelSpecificsAndroid,
          iOS: platformChannelSpecificsIos);
      _flutterLocalNotificationsPlugin.show(
        model.notId.abs(),
        title,
        body,
        platformChannelSpecifics,
        payload: json.encode(model.toJson()),
      );

      if (!showMissedCall) {
        Future.delayed(const Duration(seconds: 15), () async {
          if (currentCall != null) {
            final actives =
                await _flutterLocalNotificationsPlugin.getActiveNotifications();
            if (actives.firstWhereOrNull(
                    (e) => e.id == currentCall!.notId.abs()) !=
                null) {
              _flutterLocalNotificationsPlugin.cancel(currentCall!.notId.abs());
              _showCallNotificationIOS(currentCall!.toJson(), DateTime.now(),
                  showMissedNotification: true);
            }
          }
        });
      }
    }
  }

  @override
  Future<void> refreshToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      _logger.log("FCM Token: $token");
      AndroidDeviceInfo? androidInfo;
      IosDeviceInfo? iosInfo;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
      } else {
        iosInfo = await deviceInfo.iosInfo;
      }

      final userId = await _prefs.getStringValue(_prefs.userId);
      final vendor = Platform.isIOS ? "ios" : "android";
      final deviceId = Platform.isIOS
          ? iosInfo?.identifierForVendor
          : androidInfo?.androidId;
      final path =
          "/users/$userId/devices/$vendor/$deviceId/$token/firebaseonly";
      await _networkHandler.put(
        path: path,
      );
    } catch (ex) {
      _logger.log('refresh Token Exception');
      _logger.log(ex);
    }
  }

  @override
  Future<void> deactivateToken() async {
    try {
      AndroidDeviceInfo? androidInfo;
      IosDeviceInfo? iosInfo;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
      } else {
        iosInfo = await deviceInfo.iosInfo;
      }
      final deviceId = Platform.isIOS
          ? iosInfo?.identifierForVendor
          : androidInfo?.androidId;
      final userId = await _prefs.getStringValue(_prefs.userId);
      final path = "/users/$userId/devices/$deviceId/firebase";
      await _networkHandler.delete(
        path: path,
      );
    } catch (ex) {
      _logger.log('deactivate Token Exception');
      _logger.log(ex);
    }
  }
}

class PayloadModel {
  FCMMessageModel payload;

  PayloadModel({required this.payload});
}
