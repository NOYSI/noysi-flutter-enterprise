import 'package:code/_res/R.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_blur_dialog.dart';
import 'package:code/ui/_tx_widget/tx_checkbox_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/_tx_widget/tx_video_player.dart';
import 'package:code/utils/text_parser_utils.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';

Future txShowVideoDialog(
  BuildContext context, {
  required TXVideoPlayerMedia content,
  VoidCallback? onClose,
}) {
  return showBlurDialog(
      context: context,
      blurX: 2.0,
      blurY: 2.0,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: R.color.whiteColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                  child: const Icon(Icons.close),
                ),
                onTap: () {
                  NavigationUtils.pop(context);
                },
              ),
            ],
          ),
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          content: content,
        );
      });
}

Future txShowWarningDialogBlur(
  BuildContext context, {
  required Widget title,
  required Widget content,
  double blurX = 2.0,
  double blurY = 2.0,
  bool yesNo = true,
  ValueChanged<bool>? onAction,
}) {
  return showBlurDialog(
      blurX: blurX,
      blurY: blurY,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: R.color.whiteColor,
          title: title,
          content: content,
          // content: TXTextWidget(
          //   text: content,
          //   textAlign: TextAlign.start,
          //   color: R.color.grayDarkestColor,
          //   textOverflow: TextOverflow.visible,
          // ),
          actions: <Widget>[
            TextButton(
              child: TXTextWidget(
                text: yesNo ? R.string.yes : R.string.ok,
                fontWeight: FontWeight.bold,
                color: R.color.darkColor,
              ),
              onPressed: () {
                NavigationUtils.pop(context);
                if (onAction != null) onAction(true);
              },
            ),
            yesNo
                ? TextButton(
                    child: TXTextWidget(
                      text: R.string.no,
                      fontWeight: FontWeight.bold,
                      color: R.color.darkColor,
                    ),
                    onPressed: () {
                      NavigationUtils.pop(context);
                      if (onAction != null) onAction(false);
                    },
                  )
                : Container(),
          ],
        );
      });
}

txShowWaringDialogMaterial(
  BuildContext context, {
  required Widget title,
  required Widget content,
  bool barrierDismissible = true,
  bool yesNo = true,
  ValueChanged<bool>? onAction,
  String? yesText,
  String? noText,
  bool alwaysPopDialog = true,
}) {
  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
            backgroundColor: R.color.whiteColor,
            title: title,
            content: content,
            // content: TXTextWidget(
            //   text: content,
            //   textAlign: TextAlign.start,
            //   color: R.color.grayDarkestColor,
            //   textOverflow: TextOverflow.visible,
            // ),
            actions: <Widget>[
              TextButton(
                child: TXTextWidget(
                  text: yesNo ? (yesText ?? R.string.yes) : R.string.ok,
                  fontWeight: FontWeight.bold,
                  color: R.color.darkColor,
                ),
                onPressed: () {
                  if (alwaysPopDialog) Navigator.of(context).pop();
                  if (onAction != null) onAction(true);
                },
              ),
              yesNo
                  ? TextButton(
                      child: TXTextWidget(
                        text: noText ?? R.string.no,
                        fontWeight: FontWeight.bold,
                        color: R.color.darkColor,
                      ),
                      onPressed: () {
                        if (alwaysPopDialog) Navigator.of(context).pop();
                        if (onAction != null) onAction(false);
                      },
                    )
                  : Container(),
            ],
          ));
}

 txShowStatusSelector(BuildContext context,
    {String currentStatus = '',
    String currentText = '',
    required ValueChanged<Map<String, String>> onValueSelected}) {
  String selectedCode =
          TextUtilsParser.emojiParserFromHex(currentStatus.split('-')),
      selectedText = currentText;
  TextEditingController ctrl = TextEditingController(text: currentText);
  final keyFormName = GlobalKey<FormState>();
  BehaviorSubject<String> selectedCodeController =
      BehaviorSubject.seeded(selectedCode);
  Map<String, String> suggestions = {
    "231A": R.string.busy,
    "1F3E2": R.string.inAMeeting,
    "1F683": R.string.traveling,
    "1F4A5": R.string.onFire,
    "1F630": R.string.sick
  };
  List<Widget> suggestionWidgets = [];
  suggestions.forEach((key, value) {
    suggestionWidgets.add(InkWell(
      onTap: () {
        selectedText = value;
        selectedCode = TextUtilsParser.emojiParserFromHex(key.split('-'));
        selectedCodeController.sink.add(selectedCode);
        ctrl.text = selectedText;
        keyFormName.currentState?.validate();
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10, left: 5),
            child: TXTextWidget(
                text: TextUtilsParser.emojiParserFromHex(key.split('-')),
                //fontFamily: "EmojiOne",
                size: 24),
          ),
          TXTextWidget(text: value, color: R.color.blackColor)
        ],
      ),
    ));
    if (key != suggestions.keys.toList()[suggestions.length - 1]) {
      suggestionWidgets.add(const SizedBox(height: 10));
    }
  });

  return txShowWaringDialogMaterial(context,
      barrierDismissible: false,
      alwaysPopDialog: false,
      yesText: R.string.accept,
      noText: R.string.cancel,
      title: TXTextWidget(
        text: R.string.setAStatus,
        color: R.color.blackColor,
        size: 24,
      ), onAction: (ok) {
    if (!ok) {
      selectedCodeController.close();
      Navigator.of(context).pop();
    } else if (ok && keyFormName.currentState?.validate() == true) {
      final unicodeString = selectedCode.isEmpty
          ? ""
          : selectedCode.runes.map((e) => e.toRadixString(16)).join('-');
      onValueSelected({unicodeString: selectedText});
      selectedCodeController.close();
      Navigator.of(context).pop();
    }
  },
      content: SizedBox(
        height: 285,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                StreamBuilder<String>(
                  stream: selectedCodeController.stream,
                  initialData: "",
                  builder: (context, snapshotCode) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(45),
                      onTap: () {
                        txShowEmojiSelector(context, onEmojiSelected: (emoji) {
                          selectedCode = emoji.emoji;
                          selectedCodeController.sink.add(selectedCode);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 10, left: 5, top: 10),
                        child: snapshotCode.data?.isEmpty == true
                            ? Icon(Icons.emoji_emotions_outlined,
                            color: R.color.grayColor)
                            : TXTextWidget(
                            text: selectedCode,
                            //fontFamily: "EmojiOne",
                            size: 24),
                      ),
                    );
                  },
                ),
                Expanded(
                    child: Form(
                        key: keyFormName,
                        child: TXTextFieldWidget(
                          contentPadding: const EdgeInsets.only(left: 5, top: 7),
                          borderRadiusMagnitude: 10,
                          validator: (value) {
                            return (value?.toString().trim().isEmpty == true && selectedCode.isNotEmpty)
                                ? R.string.fieldRequired
                                : ((value?.toString().trim().length ?? 0) > 25)
                                ? R.string.fieldMax25
                                : null;
                          },
                          hintText: R.string.whatsYourStatus,
                          hintColor: R.color.grayColor,
                          maxLines: 1,
                          controller: ctrl,
                          onChanged: (text) {
                            selectedText = text;
                            keyFormName.currentState?.validate();
                          },
                          onSuffixIconTap: () {
                            selectedCode = "";
                            selectedText = "";
                            ctrl.text = selectedText;
                            selectedCodeController.sink.add(selectedCode);
                          },
                          suffixIcon: Icons.close,
                          suffixIconColor: R.color.grayColor,
                        )))
              ]),
              const SizedBox(height: 15),
              TXTextWidget(
                  text: R.string.suggestions.toUpperCase(),
                  color: R.color.grayColor),
              const SizedBox(height: 10),
              ...suggestionWidgets,
            ],
          ),
        ),
      ),
  );
}

Future<dynamic> txShowMeetingOptionsDialog(BuildContext context,
    {ValueChanged<bool>? onVideoChange,
    ValueChanged<bool>? onAudioChange,
    ValueChanged<bool>? onDontShowAgainChange,
    ValueChanged<String>? onDisplayNameChange,
    initialDisplayName = "",
    initialDontShowAgain = false,
    initialVideoStatus = true,
    initialAudioStatus = true}) {
  BehaviorSubject<bool> videoController = BehaviorSubject();
  BehaviorSubject<bool> audioController = BehaviorSubject();
  BehaviorSubject<bool> checkBoxDontShowAgainController = BehaviorSubject();
  TextEditingController textController =
      TextEditingController(text: initialDisplayName);
  final keyFormName = GlobalKey<FormState>();

  return showBlurDialog(
      blurX: 10,
      blurY: 10,
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            titlePadding: const EdgeInsets.only(left: 15, top: 20),
            contentPadding:
                const EdgeInsets.only(top: 25, left: 15, right: 10, bottom: 0),
            title: TXTextWidget(
              text: R.string.meetingOptions,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              color: R.color.darkColor,
              size: 16,
            ),
            content: SizedBox(
              height: 245,
              child: Form(
                key: keyFormName,
                onWillPop: () async {
                  audioController.close();
                  videoController.close();
                  checkBoxDontShowAgainController.close();
                  Navigator.of(context).pop(false);
                  return false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TXTextWidget(
                            text: R.string.videoEnabled,
                            color: R.color.grayDarkestColor,
                          ),
                        ),
                        StreamBuilder<bool>(
                            stream: videoController.stream,
                            initialData: initialVideoStatus,
                            builder: (context, snapshot) => Switch(
                                value: snapshot.data ?? false,
                                onChanged: (value) {
                                  videoController.sink.add(value);
                                  if (onVideoChange != null) {
                                    onVideoChange(value);
                                  }
                                })),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TXTextWidget(
                            text: R.string.audioEnabled,
                            color: R.color.grayDarkestColor,
                          ),
                        ),
                        StreamBuilder<bool>(
                            stream: audioController.stream,
                            initialData: initialAudioStatus,
                            builder: (context, snapshot) => Switch(
                                value: snapshot.data ?? false,
                                onChanged: (value) {
                                  audioController.sink.add(value);
                                  if (onAudioChange != null) {
                                    onAudioChange(value);
                                  }
                                })),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TXTextFieldWidget(
                      controller: textController,
                      label: R.string.name,
                      validator: (value) {
                        return (value?.toString().trim().isEmpty == true)
                            ? R.string.fieldRequired
                            : null;
                      },
                      onChanged: (text) {
                        if (onDisplayNameChange != null) {
                          onDisplayNameChange(text);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    StreamBuilder<bool>(
                      initialData: initialDontShowAgain,
                      stream: checkBoxDontShowAgainController.stream,
                      builder: (context, snapshot) {
                        return TXCheckBoxWidget(
                          leading: true,
                          value: snapshot.data ?? false,
                          onChange: (value) {
                            checkBoxDontShowAgainController.sink.add(value);
                            if (onDontShowAgainChange != null) {
                              onDontShowAgainChange(value);
                            }
                          },
                          text: R.string.dontShowThisMessage,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  audioController.close();
                  videoController.close();
                  checkBoxDontShowAgainController.close();
                  Navigator.of(context).pop(false);
                },
                child: TXTextWidget(
                  text: R.string.cancel,
                  fontWeight: FontWeight.bold,
                  color: R.color.darkColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (keyFormName.currentState?.validate() == true) {
                    audioController.close();
                    videoController.close();
                    checkBoxDontShowAgainController.close();
                    Navigator.of(context).pop(true);
                  }
                },
                child: TXTextWidget(
                  text: R.string.ok,
                  fontWeight: FontWeight.bold,
                  color: R.color.darkColor,
                ),
              ),
            ],
          ));
}

txShowInternetEstablished(
  BuildContext context, {
  ValueChanged<FlashController>? controllerCallBack,
}) =>
    showFlash(
      context: context,
      duration: const Duration(seconds: 4),
      builder: (context, controller) {
        if (controllerCallBack != null) controllerCallBack(controller);
        return Flash.bar(
          controller: controller,
          backgroundGradient: LinearGradient(
            colors: [R.color.secondaryColor, Colors.green],
          ),
          position: FlashPosition.top,
          horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          forwardAnimationCurve: Curves.easeOutBack,
          reverseAnimationCurve: Curves.easeInOutBack,
          child: FlashBar(
            title: TXTextWidget(
              text: R.string.connectionStatus,
              color: R.color.whiteColor,
            ),
            content: TXTextWidget(
              text: R.string.connectionEstablished,
              color: R.color.whiteColor,
            ),
            primaryAction: IconButton(
              icon: Icon(
                Icons.close,
                color: R.color.whiteColor,
              ),
              onPressed: () {
                controller.dismiss();
              },
            ),
            icon: Icon(
              Icons.cloud_done,
              // This color is also pulled from the theme. Let's change it to black.
              color: R.color.whiteColor,
            ),
            shouldIconPulse: false,
            showProgressIndicator: false,
            indicatorColor: Colors.green,
          ),
        );
      },
    );

txShowInternetLost(
  BuildContext context, {
  ValueChanged<FlashController>? controllerCallBack,
}) =>
    showFlash(
      context: context,
      builder: (context, controller) {
        if (controllerCallBack != null) controllerCallBack(controller);
        return Flash.bar(
          controller: controller,
          backgroundGradient: LinearGradient(
            colors: [R.color.secondaryColor, Colors.green],
          ),
          position: FlashPosition.top,
          enableVerticalDrag: true,
          horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          forwardAnimationCurve: Curves.easeOutBack,
          reverseAnimationCurve: Curves.easeInOutBack,
          child: FlashBar(
            title: TXTextWidget(
              text: R.string.connectionStatus,
              color: R.color.whiteColor,
            ),
            content: TXTextWidget(
              text: R.string.connectionLost,
              color: R.color.whiteColor,
            ),
            primaryAction: IconButton(
              icon: Icon(
                Icons.close,
                color: R.color.whiteColor,
              ),
              onPressed: () {
                controller.dismiss();
              },
            ),
            icon: Icon(
              Icons.cloud_off,
              // This color is also pulled from the theme. Let's change it to black.
              color: R.color.whiteColor,
            ),
            shouldIconPulse: false,
            showProgressIndicator: false,
            indicatorColor: Colors.red,
          ),
        );
      },
    );

txShowCallingNotification(BuildContext context, String photo, String userName,
        ValueChanged<bool> accepted,
        {ValueChanged<FlashController>? controllerCallBack}) =>
    showFlash(
        context: context,
        builder: (context, controller) {
          if (controllerCallBack != null) controllerCallBack(controller);
          return Flash.bar(
              controller: controller,
              backgroundGradient: LinearGradient(
                colors: [R.color.secondaryColor, Colors.green],
              ),
              position: FlashPosition.top,
              enableVerticalDrag: false,
              //horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              forwardAnimationCurve: Curves.easeOutBack,
              reverseAnimationCurve: Curves.easeInOutBack,
              child: FlashBar(
                title: TXTextWidget(
                  text: R.string.incomingCall,
                  color: R.color.whiteColor,
                ),
                content: TXTextWidget(
                    text: userName.isEmpty
                        ? R.string.anUserIsCalling
                        : R.string.isCallingYou(userName),
                    color: R.color.whiteColor),
                icon: Container(
                  margin: const EdgeInsets.only(left: 10, top: 15),
                  child: TXNetworkImage(
                    imageUrl: photo,
                    userBorderRadius: true,
                    boxFitImage: BoxFit.cover,
                    placeholderImage: Image.asset(
                      R.image.logo,
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => accepted(false),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.red,
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 10, right: 10),
                        onSurface: R.color.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          side: BorderSide(
                              color: R.color.grayDarkColor,
                              style: BorderStyle.solid,
                              width: 1),
                        )),
                    child: Row(
                      children: [
                        const Icon(Icons.call_end_rounded),
                        const SizedBox(width: 3),
                        TXTextWidget(
                            text: R.string.hangDown, color: R.color.whiteColor),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => accepted(true),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.green,
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 10, right: 10),
                        onSurface: R.color.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          side: BorderSide(
                              color: R.color.grayDarkColor,
                              style: BorderStyle.solid,
                              width: 1),
                        )),
                    child: Row(
                      children: [
                        const Icon(Icons.call),
                        const SizedBox(width: 3),
                        TXTextWidget(
                            text: R.string.answer, color: R.color.whiteColor),
                      ],
                    ),
                  ),
                ],
              ));
        });

Future<void> txShowEmojiSelector(BuildContext context,
    {ValueChanged<Emoji>? onEmojiSelected}) async {
  return showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return SafeArea(
          child: EmojiPicker(
            config: Config(
                buttonMode: Platform.isAndroid
                    ? ButtonMode.MATERIAL
                    : ButtonMode.CUPERTINO,
                indicatorColor: R.color.primaryColor,
                columns: 7,
                categoryIcons: const CategoryIcons(),
                showRecentsTab: true,
                recentsLimit: 28,
                replaceEmojiOnLimitExceed: true,
                noRecents: TXTextWidget(text: R.string.noRecents),
                emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                // Issue: https://github.com/flutter/flutter/issues/28894
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT),
            onEmojiSelected: (category, emoji) {
              Navigator.of(context).pop();
              if (onEmojiSelected != null) onEmojiSelected(emoji);
            },
          ),
        );
      });
}
