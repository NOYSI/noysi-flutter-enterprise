import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/app.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/domain/meet/meeting_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:code/domain/app_common_model.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

Map<String, ChewieController> initializedVideos = {};

BehaviorSubject<AppSettingsModel> languageCodeController = BehaviorSubject();

Stream<AppSettingsModel> get languageCodeResult =>
    languageCodeController.stream;

BehaviorSubject<bool> localeChangedController = BehaviorSubject();

BehaviorSubject<ShareContentModel?> sharingContentController = BehaviorSubject();

BehaviorSubject<AppLinksNavigationModel?> appLinksContentController = BehaviorSubject();

BehaviorSubject<bool> messageDismissed = BehaviorSubject();

BehaviorSubject<bool> absorbPointerAppController = BehaviorSubject();

BehaviorSubject<TeamTheme> teamThemeController =
    BehaviorSubject.seeded(R.color.defaultTheme);

enum call_status { calling_me, in_call, none }
BehaviorSubject<call_status> callStatusController = BehaviorSubject.seeded(call_status.none);
JitsiMeetingListener? jitsiListeners;
MeetingModel? currentMeeting;
Future<JitsiMeetingResponse?> joinMeeting(
    {String? url,
    String? userEmail,
    required String room,
    String? userAvatarUrl,
    String? subject,
    bool showOptionsDialog = false}) async {
  final micPermission = await Permission.microphone.request().isGranted;
  final cameraPermission = await Permission.camera.request().isGranted;
  if (!micPermission || !cameraPermission) {
    txShowWarningDialogBlur(NoysiApp.navigatorKey.currentContext!,
        blurY: 10,
        blurX: 10,
        title: TXTextWidget(
          text: R.string.enablePermissions,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: R.color.darkColor,
          size: 16,
        ), onAction: (action) {
      if (action) openAppSettings();
    },
        content: Container(
          child: TXTextWidget(
            text: R.string.micAndCameraRequiredAlert,
            color: R.color.grayDarkestColor,
          ),
        ));
    return JitsiMeetingResponse(isSuccess: false, message: "PermissionError");
  }
  SharedPreferencesManager _prefs = SharedPreferencesManager();
  final _prefDisplayName = await _prefs.getStringValue(_prefs.displayName);
  String displayName = (_prefDisplayName.isEmpty)
      ? CommonUtils.getMemberUsername(Injector.instance.inMemoryData.currentMember) ?? ""
      : _prefDisplayName;
  bool audioMuted = await _prefs.getBoolValue(_prefs.audioMuted);
  bool videoMuted = await _prefs.getBoolValue(_prefs.videoMuted);
  bool dontShowDialog = await _prefs.getBoolValue(_prefs.dontShowAgain);
  if (showOptionsDialog || !dontShowDialog) {
    final result = (await txShowMeetingOptionsDialog(
        NoysiApp.navigatorKey.currentContext!, onAudioChange: (value) {
      audioMuted = !value;
    }, onVideoChange: (value) {
      videoMuted = !value;
    }, onDisplayNameChange: (value) {
      displayName = value;
    }, onDontShowAgainChange: (value) {
      dontShowDialog = value;
    },
        initialAudioStatus: !audioMuted,
        initialVideoStatus: !videoMuted,
        initialDisplayName: displayName,
        initialDontShowAgain: dontShowDialog)) as bool?;
    if (result ?? false) {
      _prefs.setStringValue(_prefs.displayName, displayName);
      _prefs.setBoolValue(_prefs.dontShowAgain, dontShowDialog);
      _prefs.setBoolValue(_prefs.videoMuted, videoMuted);
      _prefs.setBoolValue(_prefs.audioMuted, audioMuted);
    } else {
      callStatusController.sinkAddSafe(call_status.none);
      return JitsiMeetingResponse(isSuccess: false, message: "CANCELLED");
    }
  }
  return await _joinMeeting(
      room: room,
      url: url,
      audioMuted: audioMuted,
      displayName: displayName,
      subject: subject,
      userAvatarUrl: userAvatarUrl,
      userEmail: userEmail,
      videoMuted: videoMuted);
}

Future<JitsiMeetingResponse?> _joinMeeting(
    {String? url,
    String? userEmail,
    String? displayName,
    required String room,
    bool audioMuted = false,
    bool videoMuted = false,
    String? userAvatarUrl,
    String? subject}) async {
  try {
    Map<FeatureFlag, dynamic> featureFlags = {
      FeatureFlag.isWelcomePageEnabled: false,
      FeatureFlag.isCallIntegrationEnabled: false,
      FeatureFlag.isPipEnabled: false,
      FeatureFlag.isToolboxAlwaysVisible: false,
      FeatureFlag.isTileViewEnabled: true,
      FeatureFlag.isInviteEnabled: true,
      FeatureFlag.isAddPeopleEnabled: true,
      FeatureFlag.isCalendarEnabled: false,
      FeatureFlag.isCloseCaptionsEnabled: false,
      FeatureFlag.isRecordingEnabled: true,
      FeatureFlag.isLiveStreamingEnabled: Platform.isAndroid,
      FeatureFlag.isIosRecordingEnabled: Platform.isIOS,
      FeatureFlag.isIosScreensharingEnabled: true,
      //FeatureFlag.isFilmstripEnabled: false,
      FeatureFlag.isReactionsEnabled: Platform.isAndroid
    };
    // FeatureFlag featureFlag = FeatureFlag();
    // featureFlag.welcomePageEnabled = false;
    // featureFlag.resolution = FeatureFlagVideoResolution
    //     .HD_RESOLUTION; // Limit video resolution to 720p
    // featureFlag.callIntegrationEnabled =
    //     false; // Disable ConnectionService usage on Android and CallKit on iOS to avoid issues.
    // featureFlag.pipEnabled = false; // Disable PIP because of bug.
    // featureFlag.videoShareButtonEnabled = true;
    // featureFlag.toolboxAlwaysVisible = false;
    // featureFlag.tileViewEnabled = true;
    // featureFlag.inviteEnabled = true;
    // featureFlag.addPeopleEnabled = true;
    // featureFlag.calendarEnabled = false;
    // featureFlag.closeCaptionsEnabled = false;
    // featureFlag.recordingEnabled = true;
    // if (Platform.isAndroid) {
    //   featureFlag.liveStreamingEnabled = true;
    //   featureFlag.iOSRecordingEnabled = false; // Not supported for Android
    // } else if (Platform.isIOS) {
    //   featureFlag.liveStreamingEnabled = false; //crash on ios
    //   featureFlag.iOSRecordingEnabled = true;
    // }

    var options = JitsiMeetingOptions(roomNameOrUrl: room,
      serverUrl: url.isNullOrEmpty() ? Injector.instance.meetingBaseUrl : url,
      subject: subject,
      userDisplayName: displayName.isNullOrEmpty()
          ? CommonUtils.getMemberUsername(Injector.instance.inMemoryData.currentMember) ?? ""
          : displayName,
      userEmail: userEmail.isNullOrEmpty()
          ? Injector.instance.inMemoryData.currentMember?.profile?.email ?? ""
          : userEmail,
      userAvatarUrl: userAvatarUrl,
      isAudioMuted: audioMuted,
      isVideoMuted: videoMuted,
      isAudioOnly: false,
      featureFlags: featureFlags);

    absorbPointerAppController.sinkAddSafe(true);
    await Future.delayed(Duration(milliseconds: 500));
    return await JitsiMeetWrapper.joinMeeting(options: options, listener: jitsiListeners);
  } catch (error) {
    debugPrint("error: $error");
    absorbPointerAppController.sinkAddSafe(false);
    callStatusController.sinkAddSafe(call_status.none);
    return null;
  }
}
