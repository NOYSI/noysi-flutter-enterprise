import 'dart:async';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/chat_text_widget/chat_text_model_ui.dart';
import 'package:code/ui/chat_text_widget/tx_chat_text_input_bloc.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_media_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_user_presence_widget.dart';
import 'package:code/ui/home/tx_anwer_message_widget.dart';
import 'package:code/utils/extensions.dart';
import 'package:code/utils/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class TXChatTextInputWidget extends StatefulWidget {
  final ValueChanged<String> onSendTap;
  final ValueChanged<String>? onChange;
  final MessageModel? answerInMessageModel;
  final GestureTapCallback? onCloseAnswerInMessage;
  final String? pmid;
  final ValueChanged<bool>? showOnChannel;
  final bool showFileAttach;
  final GestureTapCallback? onTapAnswerInMessage;
  final bool isReadOnlyChannel;

  const TXChatTextInputWidget(
      {Key? key,
      required this.onSendTap,
      this.onChange,
      this.answerInMessageModel,
      this.onCloseAnswerInMessage,
      this.pmid,
      this.showFileAttach = true,
      this.isReadOnlyChannel = false,
      this.showOnChannel,
      this.onTapAnswerInMessage})
      : super(key: key);

  @override
  _TXChatTextInputWidgetState createState() => _TXChatTextInputWidgetState();
}

class _TXChatTextInputWidgetState
    extends StateWithBloC<TXChatTextInputWidget, TXChatTextInputBloC>
    with TickerProviderStateMixin {
  TextEditingController chatTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isFocused = false;

  late AnimationController _animationMicRecordingController;
  late AnimationController _animationLeftArrowController;

  late Animation<Offset> _animationLeftArrowOffset;

  late AnimationController _animationRecordingController;
  late AnimationController _animationMessagingController;
  late AnimationController _animationMultiOptionController;
  late AnimationController _animationTextOptionController;
  late Animation<Offset> _animationRecordingOffset;
  late Animation<Offset> _animationMessagingOffset;
  late Animation<Offset> _animationMultiOptionOffset;
  late Animation<Offset> _animationTextOptionOffset;
  StreamSubscription? subscriptionRecordingController;
  bool publishInChannel = false;

  @override
  void initState() {
    super.initState();
    messageDismissed.listen((value) {
      if (value) {
        focusWasAlreadyRequested = false;
      }
    });
    if (!(widget.showFileAttach == true)) bloc.showSendIcon(true);
    chatTextController.addListener(listenController);
    focusNode.addListener(_onFocusChange);
    subscriptionRecordingController = bloc.recordingResult.listen((event) {
      if (event) {
        _animationRecordingController.forward();
        _animationMessagingController.forward();
      } else {
        _animationRecordingController.reverse();
        _animationMessagingController.reverse();
      }
    });
    _animationMicRecordingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _animationLeftArrowController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animationLeftArrowOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(-.5, 0)).animate(
            CurvedAnimation(
                parent: _animationLeftArrowController,
                curve: Curves.elasticIn));

    _animationRecordingController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationMessagingController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationRecordingOffset =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
            .animate(_animationRecordingController);
    _animationMessagingOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(1.0, 0.0))
            .animate(_animationMessagingController);
    _animationMultiOptionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationTextOptionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationMultiOptionOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.5))
            .animate(_animationMultiOptionController);
    _animationTextOptionOffset =
        Tween<Offset>(begin: Offset(0.0, 1.5), end: Offset.zero)
            .animate(_animationTextOptionController);
  }

  @override
  void dispose() {
    chatTextController.removeListener(listenController);
    chatTextController.dispose();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    subscriptionRecordingController?.cancel();
    _animationLeftArrowController.dispose();
    _animationMicRecordingController.dispose();
    _animationMessagingController.dispose();
    _animationRecordingController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (bloc.textFieldFocusedController.valueOrNull != focusNode.hasFocus) {
      bloc.textFieldFocusedController.sinkAddSafe(focusNode.hasFocus);
    }
  }

  void listenController() {
    bloc.cursorPosition = chatTextController.selection.base.offset >= 0
        ? chatTextController.selection.base.offset
        : bloc.cursorPosition;
    if (bloc.cursorPosition == 0) {
      bloc.showMentions(false);
    }
    if (widget.showFileAttach == true)
      bloc.showSendIcon(chatTextController.text.trim().isNotEmpty);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: bloc.textFieldFocusedController.stream,
      builder: (context, snapshot) {
        return snapshot.data! ? focusedWidget() : unfocusedWidget();
      },
    );
  }

  Widget unfocusedWidget() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 1.5, color: R.color.grayLightestColor),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.answerInMessageModel == null
              ? Container()
              : _showAnswerMessageWidget(),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ClipRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SlideTransition(
                      position: _animationRecordingOffset,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        key: ValueKey(2),
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: FadeTransition(
                              opacity: _animationMicRecordingController,
                              child:
                                  Icon(Icons.mic, color: Colors.red, size: 21),
                            ),
                          ),
                          StreamBuilder<Duration?>(
                            initialData: null,
                            stream: bloc.recordingTimeResult,
                            builder: (context, snapshotTimer) {
                              return TXTextWidget(
                                  text:
                                      "${snapshotTimer.data?.inMinutes.toString().padLeft(2, '0') ?? '00'}:${snapshotTimer.data?.inSeconds.remainder(60).toString().padLeft(2, '0') ?? '00'}");
                            },
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  SlideTransition(
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: R.color.grayColor,
                                      size: 20,
                                    ),
                                    position: _animationLeftArrowOffset,
                                  ),
                                  Expanded(
                                    child: TXTextWidget(
                                      text: R.string.slideToCancel,
                                    ),
                                  ),
                                ],
                              ),
                              constraints: BoxConstraints(
                                maxHeight: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SlideTransition(
                      position: _animationMessagingOffset,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        key: ValueKey(1),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: StreamBuilder<bool>(
                                stream: bloc.showUploadingResult,
                                initialData: false,
                                builder: (context, snapshot) {
                                  return InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(45)),
                                    onTap: () async {
                                      WidgetsBinding
                                          .instance.focusManager.primaryFocus
                                          ?.unfocus();
                                      if (bloc.inMemoryData.currentChannel
                                                  ?.isM1x1 ==
                                              true &&
                                          (bloc.inMemoryData
                                              .getMember(bloc
                                              .inMemoryData
                                              .currentChannel
                                              ?.other ??
                                              "")
                                              ?.active ==
                                              false || bloc.inMemoryData
                                              .getMember(bloc
                                              .inMemoryData
                                              .currentChannel
                                              ?.other ??
                                              "")?.isDeletedUser == true)) {
                                        Fluttertoast.showToast(
                                            msg: R.string.userIsInactiveToChat,
                                            backgroundColor: Colors.redAccent,
                                            textColor: R.color.whiteColor);
                                        return;
                                      } else if (!bloc.userCanWrite(
                                          isReadOnly:
                                              widget.isReadOnlyChannel)) {
                                        Fluttertoast.showToast(
                                            msg: R.string
                                                .createNewChannelForAdminsOnly,
                                            backgroundColor: Colors.redAccent,
                                            textColor: R.color.whiteColor);
                                        return;
                                      } else if (!widget.showFileAttach) {
                                        return;
                                      } else if (snapshot.data!) {
                                        bloc.cancelTokenPost();
                                        return;
                                      }
                                      showTXModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return _showSourceSelector(context);
                                          });
                                    },
                                    child: widget.showFileAttach ? StreamBuilder<UploadProgress>(
                                      stream: bloc.uploadingResult,
                                      initialData: UploadProgress.empty(),
                                      builder: (context, progressSnapshot) {
                                        return Container(
                                          height: 38,
                                          width: 38,
                                          decoration: BoxDecoration(
                                              color:
                                              R.color.grayLightestColor,
                                              borderRadius:
                                              BorderRadius.circular(45)),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Icon(snapshot.data!
                                                  ? Icons.close
                                                  : Icons.add),
                                              Container(
                                                width: 38,
                                                height: 38,
                                                child:
                                                CircularProgressIndicator(
                                                  valueColor:
                                                  AlwaysStoppedAnimation<
                                                      Color>(
                                                      R.color
                                                          .secondaryColor),
                                                  strokeWidth: 3,
                                                  backgroundColor: R.color
                                                      .grayLightestColor,
                                                  value: progressSnapshot
                                                      .data!.progress,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ) : Container(),
                                  );
                                }),
                          ),
                          widget.pmid?.isNotEmpty == true ? Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(45),
                              child: InkWell(
                                child: Icon(
                                  Icons.message,
                                  color: publishInChannel ? R.color.secondaryColor : R.color.grayLightColor,
                                ),
                                onTap: () {
                                  if(widget.showOnChannel != null) {
                                    publishInChannel = !publishInChannel;
                                    widget.showOnChannel!(publishInChannel);
                                    setState((){});
                                  }
                                },
                              ),
                              onTap: () {
                                if(widget.showOnChannel != null) {
                                  publishInChannel = !publishInChannel;
                                  widget.showOnChannel!(publishInChannel);
                                  setState((){});
                                }
                              },
                            ),
                          ) : Container(),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: InkWell(
                                onTap: () {
                                  bloc.textFieldFocusedController
                                      .sinkAddSafe(true);
                                  focusNode.requestFocus();
                                },
                                child: TXTextWidget(
                                  text: chatTextController.text.isEmpty
                                      ? R.string.typeMessage
                                      : chatTextController.text,
                                  size: 20,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              GestureDetector(
                child: InkWell(
                  radius: 45,
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: R.color.secondaryColor, shape: BoxShape.circle),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(45))),
                        padding: EdgeInsets.all(11),
                        child: widget.showFileAttach == true
                            ? StreamBuilder<bool>(
                                initialData: false,
                                stream: bloc.showSendIconResult,
                                builder: (context, sendIconSnapshot) => Icon(
                                  sendIconSnapshot.data!
                                      ? Icons.send
                                      : Icons.mic,
                                  color: R.color.whiteColor,
                                  size: 20,
                                ),
                              )
                            : Icon(
                                Icons.send,
                                color: R.color.whiteColor,
                                size: 20,
                              )),
                  ),
                  onTap: () async {
                    if (bloc.inMemoryData.currentChannel?.isM1x1 == true &&
                        (bloc.inMemoryData
                            .getMember(
                            bloc.inMemoryData.currentChannel?.other ??
                                "")
                            ?.active ==
                            false || bloc.inMemoryData
                            .getMember(bloc
                            .inMemoryData
                            .currentChannel
                            ?.other ??
                            "")?.isDeletedUser == true)) {
                      Fluttertoast.showToast(
                          msg: R.string.userIsInactiveToChat,
                          backgroundColor: Colors.redAccent,
                          textColor: R.color.whiteColor);
                    } else if (!bloc.userCanWrite(
                        isReadOnly: widget.isReadOnlyChannel)) {
                      Fluttertoast.showToast(
                          msg: R.string.createNewChannelForAdminsOnly,
                          backgroundColor: Colors.redAccent,
                          textColor: R.color.whiteColor);
                    } else if (bloc.sendIconIsShown &&
                        chatTextController.text.trim().isNotEmpty) {
                      widget.onSendTap(chatTextController.text.trim());
                      chatTextController.text = "";
                    } else if(widget.showFileAttach == true &&
                        !bloc.sendIconIsShown) {
                      bloc.onTapForRecord();
                    }
                  },
                ),
                onLongPressStart: (details) async {
                  if (bloc.inMemoryData.currentChannel?.isM1x1 == true &&
                      (!(bloc.inMemoryData
                          .getMember(
                          bloc.inMemoryData.currentChannel?.other ?? "")
                          ?.active ==
                          true) || bloc.inMemoryData
                          .getMember(bloc
                          .inMemoryData
                          .currentChannel
                          ?.other ??
                          "")?.isDeletedUser == true)) {
                    Fluttertoast.showToast(
                        msg: R.string.userIsInactiveToChat,
                        backgroundColor: Colors.redAccent,
                        textColor: R.color.whiteColor);
                  } else if (!bloc.userCanWrite(
                      isReadOnly: widget.isReadOnlyChannel)) {
                    Fluttertoast.showToast(
                        msg: R.string.createNewChannelForAdminsOnly,
                        backgroundColor: Colors.redAccent,
                        textColor: R.color.whiteColor);
                  } else if (widget.showFileAttach == true &&
                      !bloc.sendIconIsShown) {
                    bloc.playRecordingSound();
                  }
                },
                onLongPressEnd: (details) {
                  if (widget.showFileAttach == true && !bloc.sendIconIsShown) {
                    bloc.stopRecording(publishInChannel, widget.pmid);
                  }
                },
                onLongPressMoveUpdate: (details) {
                  if (details.localOffsetFromOrigin.dx < -100)
                    bloc.stopRecording(publishInChannel, widget.pmid,
                        canceled: true);
                },
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget focusedWidget() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 1.5, color: R.color.grayLightestColor),
      )),
      child: Column(
        children: [
          widget.answerInMessageModel == null
              ? Container()
              : _showAnswerMessageWidget(),
          StreamBuilder<bool>(
            stream: bloc.showMentionsResult,
            initialData: false,
            builder: (ctx, snapshotShowMentions) {
              return snapshotShowMentions.data!
                  ? _getAvailableMentionsList(onMentionSelected: (mention) {
                      int pos = bloc.cursorPosition;
                      setState(() {
                        List<String> charList =
                            chatTextController.text.split("");
                        while (pos >= 1 && charList[pos - 1] != "@") {
                          pos -= 1;
                        }
                        charList.removeRange(pos, bloc.cursorPosition);
                        charList.insert(pos, "$mention ");

                        chatTextController.text = charList.join();
                        bloc.showMentions(false);
                      });
                      Future.delayed(Duration(milliseconds: 100), () {
                        setState(() => chatTextController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: pos + "$mention ".length)));
                      });
                    })
                  : Container();
            },
          ),
          SizedBox(height: 10),
          Container(
            constraints: BoxConstraints(
              maxHeight: 100,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: TextField(
                controller: chatTextController,
                keyboardType: TextInputType.multiline,
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                focusNode: focusNode,
                style: TextStyle(color: R.color.grayDarkColor, fontSize: 20),
                decoration:
                    InputDecoration.collapsed(hintText: R.string.typeMessage),
                onChanged: (value) {
                  if (widget.onChange != null) widget.onChange!(value);
                  showUserMentions(value);
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ClipRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SlideTransition(
                      position: _animationRecordingOffset,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        key: ValueKey(2),
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: FadeTransition(
                              opacity: _animationMicRecordingController,
                              child:
                                  Icon(Icons.mic, color: Colors.red, size: 21),
                            ),
                          ),
                          StreamBuilder<Duration?>(
                            initialData: null,
                            stream: bloc.recordingTimeResult,
                            builder: (context, snapshotTimer) {
                              return TXTextWidget(
                                  text:
                                      "${snapshotTimer.data?.inMinutes.toString().padLeft(2, '0') ?? '00'}:${snapshotTimer.data?.inSeconds.remainder(60).toString().padLeft(2, '0') ?? '00'}");
                            },
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  SlideTransition(
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: R.color.grayColor,
                                      size: 20,
                                    ),
                                    position: _animationLeftArrowOffset,
                                  ),
                                  Expanded(
                                    child: TXTextWidget(
                                      text: R.string.slideToCancel,
                                    ),
                                  ),
                                ],
                              ),
                              constraints: BoxConstraints(
                                maxHeight: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SlideTransition(
                      position: _animationMessagingOffset,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        key: ValueKey(1),
                        children: [getMultiOptionsComponent()],
                      ),
                    ),
                  ],
                ),
              )),
              GestureDetector(
                child: InkWell(
                  radius: 45,
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: R.color.secondaryColor, shape: BoxShape.circle),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(45))),
                        padding: EdgeInsets.all(11),
                        child: widget.showFileAttach == true
                            ? StreamBuilder<bool>(
                                initialData: false,
                                stream: bloc.showSendIconResult,
                                builder: (context, sendIconSnapshot) => Icon(
                                  sendIconSnapshot.data!
                                      ? Icons.send
                                      : Icons.mic,
                                  color: R.color.whiteColor,
                                  size: 20,
                                ),
                              )
                            : Icon(
                                Icons.send,
                                color: R.color.whiteColor,
                                size: 20,
                              )),
                  ),
                  onTap: () async {
                    if (bloc.inMemoryData.currentChannel?.isM1x1 == true &&
                        (bloc.inMemoryData
                            .getMember(
                            bloc.inMemoryData.currentChannel?.other ??
                                "")
                            ?.active ==
                            false || bloc.inMemoryData
                            .getMember(bloc
                            .inMemoryData
                            .currentChannel
                            ?.other ??
                            "")?.isDeletedUser == true)) {
                      Fluttertoast.showToast(
                          msg: R.string.userIsInactiveToChat,
                          backgroundColor: Colors.redAccent,
                          textColor: R.color.whiteColor);
                    } else if (!bloc.userCanWrite(
                        isReadOnly: widget.isReadOnlyChannel)) {
                      Fluttertoast.showToast(
                          msg: R.string.createNewChannelForAdminsOnly,
                          backgroundColor: Colors.redAccent,
                          textColor: R.color.whiteColor);
                    } else if (bloc.sendIconIsShown &&
                        chatTextController.text.trim().isNotEmpty) {
                      widget.onSendTap(chatTextController.text.trim());
                      chatTextController.text = "";
                    } else if(widget.showFileAttach == true &&
                        !bloc.sendIconIsShown) {
                      bloc.onTapForRecord();
                    }
                  },
                ),
                onLongPressStart: (details) async {
                  if (bloc.inMemoryData.currentChannel?.isM1x1 == true &&
                      (!(bloc.inMemoryData
                          .getMember(
                          bloc.inMemoryData.currentChannel?.other ?? "")
                          ?.active ==
                          true) || bloc.inMemoryData
                          .getMember(bloc
                          .inMemoryData
                          .currentChannel
                          ?.other ??
                          "")?.isDeletedUser == true)) {
                    Fluttertoast.showToast(
                        msg: R.string.userIsInactiveToChat,
                        backgroundColor: Colors.redAccent,
                        textColor: R.color.whiteColor);
                  } else if (!bloc.userCanWrite(
                      isReadOnly: widget.isReadOnlyChannel)) {
                    Fluttertoast.showToast(
                        msg: R.string.createNewChannelForAdminsOnly,
                        backgroundColor: Colors.redAccent,
                        textColor: R.color.whiteColor);
                  } else if (widget.showFileAttach == true &&
                      !bloc.sendIconIsShown) {
                    bloc.playRecordingSound();
                  }
                },
                onLongPressEnd: (details) {
                  if (widget.showFileAttach == true && !bloc.sendIconIsShown) {
                    bloc.stopRecording(publishInChannel, widget.pmid);
                  }
                },
                onLongPressMoveUpdate: (details) {
                  if (details.localOffsetFromOrigin.dx < -100)
                    bloc.stopRecording(publishInChannel, widget.pmid,
                        canceled: true);
                },
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget getMultiOptionsComponent() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SlideTransition(
            position: _animationMultiOptionOffset,
            child: Row(
              key: ValueKey(4),
              children: [
                widget.showFileAttach ? Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: StreamBuilder<bool>(
                      stream: bloc.showUploadingResult,
                      initialData: false,
                      builder: (context, snapshot) {
                        return InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                          onTap: () async {
                            WidgetsBinding.instance.focusManager.primaryFocus
                                ?.unfocus();
                            if (bloc.inMemoryData.currentChannel?.isM1x1 ==
                                true &&
                                (bloc.inMemoryData
                                    .getMember(bloc.inMemoryData
                                    .currentChannel?.other ??
                                    "")
                                    ?.active ==
                                    false || bloc.inMemoryData
                                    .getMember(bloc
                                    .inMemoryData
                                    .currentChannel
                                    ?.other ??
                                    "")?.isDeletedUser == true)) {
                              Fluttertoast.showToast(
                                  msg: R.string.userIsInactiveToChat,
                                  backgroundColor: Colors.redAccent,
                                  textColor: R.color.whiteColor);
                              return;
                            } else if (!bloc.userCanWrite(
                                isReadOnly: widget.isReadOnlyChannel)) {
                              Fluttertoast.showToast(
                                  msg: R.string.createNewChannelForAdminsOnly,
                                  backgroundColor: Colors.redAccent,
                                  textColor: R.color.whiteColor);
                              return;
                            } else if (!widget.showFileAttach) {
                              return;
                            } else if (snapshot.data!) {
                              bloc.cancelTokenPost();
                              return;
                            }
                            showTXModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return _showSourceSelector(context);
                                });
                          },
                          child: StreamBuilder<UploadProgress>(
                            stream: bloc.uploadingResult,
                            initialData: UploadProgress.empty(),
                            builder: (context, progressSnapshot) {
                              return Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                    color: R.color.grayLightestColor,
                                    borderRadius: BorderRadius.circular(45)),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(snapshot.data!
                                        ? Icons.close
                                        : Icons.add),
                                    Container(
                                      width: 38,
                                      height: 38,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                            R.color.secondaryColor),
                                        strokeWidth: 3,
                                        backgroundColor:
                                        R.color.grayLightestColor,
                                        value: progressSnapshot.data!.progress,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ) : Container(),
                Container(
                  margin: EdgeInsets.only(
                    left: widget.showFileAttach ? 0 : 10,
                    right: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.alternate_email,
                          color: R.color.grayDarkColor,
                        ),
                        onTap: () {
                          chatTextController.text += '@';
                          if (!isFocused) focusNode.requestFocus();
                          if (widget.onChange != null)
                            widget.onChange!(chatTextController.text);
                          Future.delayed(Duration(milliseconds: 100))
                              .then((value) {
                            chatTextController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: chatTextController.text.length));
                          });
                          Future.delayed(Duration(milliseconds: 200))
                              .then((value) {
                            showUserMentions(chatTextController.text);
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.text_fields,
                          color: R.color.grayDarkColor,
                        ),
                        onTap: () {
                          _animationMultiOptionController.forward();
                          _animationTextOptionController.forward();
                        },
                      ),
                      widget.pmid?.isNotEmpty == true
                        ? Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: InkWell(
                          child: Icon(
                            Icons.message,
                            color: publishInChannel ? R.color.secondaryColor : R.color.grayLightColor,
                          ),
                          onTap: () {
                            if(widget.showOnChannel != null) {
                              publishInChannel = !publishInChannel;
                              widget.showOnChannel!(publishInChannel);
                              setState((){});
                            }
                          },
                        ),
                      )
                        : Container()
                      // widget.showFileAttach
                      //     ? Row(
                      //   children: [
                      //     InkWell(
                      //       child: Icon(
                      //         Icons.photo_camera,
                      //         color: R.color.grayDarkColor,
                      //       ),
                      //       onTap: () {
                      //         if (bloc.inMemoryData.currentChannel?.isM1x1 ==
                      //             true &&
                      //             bloc.inMemoryData
                      //                 .getMember(bloc.inMemoryData
                      //                 .currentChannel?.other ??
                      //                 "")
                      //                 ?.active ==
                      //                 false) {
                      //           Fluttertoast.showToast(
                      //               msg: R.string.userIsInactiveToChat,
                      //               backgroundColor: Colors.redAccent,
                      //               textColor: R.color.whiteColor);
                      //         } else if (!bloc.userCanWrite(
                      //             isReadOnly: widget.isReadOnlyChannel)) {
                      //           Fluttertoast.showToast(
                      //               msg: R.string.createNewChannelForAdminsOnly,
                      //               backgroundColor: Colors.redAccent,
                      //               textColor: R.color.whiteColor);
                      //         } else {
                      //           _launchMediaView(
                      //               imageSource: ImageSource.camera,
                      //               makePopContext: false);
                      //         }
                      //       },
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     InkWell(
                      //       child: Icon(
                      //         Icons.videocam,
                      //         size: 30,
                      //         color: R.color.grayDarkColor,
                      //       ),
                      //       onTap: () {
                      //         if (bloc.inMemoryData.currentChannel?.isM1x1 ==
                      //             true &&
                      //             bloc.inMemoryData
                      //                 .getMember(bloc.inMemoryData
                      //                 .currentChannel?.other ??
                      //                 "")
                      //                 ?.active ==
                      //                 false) {
                      //           Fluttertoast.showToast(
                      //               msg: R.string.userIsInactiveToChat,
                      //               backgroundColor: Colors.redAccent,
                      //               textColor: R.color.whiteColor);
                      //         } else if (!bloc.userCanWrite(
                      //             isReadOnly: widget.isReadOnlyChannel)) {
                      //           Fluttertoast.showToast(
                      //               msg: R.string.createNewChannelForAdminsOnly,
                      //               backgroundColor: Colors.redAccent,
                      //               textColor: R.color.whiteColor);
                      //         } else {
                      //           _launchMediaView(
                      //               imageSource: ImageSource.camera,
                      //               makePopContext: false,
                      //               lookForVideo: true);
                      //         }
                      //       },
                      //     )
                      //   ],
                      // )
                      //     : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SlideTransition(
            position: _animationTextOptionOffset,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              key: ValueKey(3),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      _animationMultiOptionController.reverse();
                      _animationTextOptionController.reverse();
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                          color: R.color.secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(45)),
                      child: Icon(
                        Icons.close,
                        color: R.color.whiteColor,
                      ),
                    ),
                  ),
                ),
                Expanded(child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children:  [
                      InkWell(
                        child: const Icon(Icons.format_bold, size: 25),
                        onTap: () {
                          chatTextController.text += "**";
                          if (!isFocused) focusNode.requestFocus();
                          if (widget.onChange != null) {
                            widget.onChange!(chatTextController.text);
                          }
                          Future.delayed(Duration(milliseconds: 100))
                              .then((value) {
                            chatTextController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: chatTextController.text.length - 1));
                          });
                        },
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        child: Icon(Icons.format_italic, size: 25),
                        onTap: () {
                          chatTextController.text += "__";
                          if (!isFocused) focusNode.requestFocus();
                          if (widget.onChange != null) {
                            widget.onChange!(chatTextController.text);
                          }
                          Future.delayed(Duration(milliseconds: 100))
                              .then((value) {
                            chatTextController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: chatTextController.text.length - 1));
                          });
                        },
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        child: Icon(Icons.format_strikethrough, size: 25),
                        onTap: () {
                          chatTextController.text += "~~";
                          if (!isFocused) focusNode.requestFocus();
                          if (widget.onChange != null) {
                            widget.onChange!(chatTextController.text);
                          }
                          Future.delayed(Duration(milliseconds: 100))
                              .then((value) {
                            chatTextController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: chatTextController.text.length - 1));
                          });
                        },
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        child: Icon(Icons.code, size: 25),
                        onTap: () {
                          chatTextController.text += "``";
                          if (!isFocused) focusNode.requestFocus();
                          if (widget.onChange != null) {
                            widget.onChange!(chatTextController.text);
                          }
                          Future.delayed(Duration(milliseconds: 100))
                              .then((value) {
                            chatTextController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: chatTextController.text.length - 1));
                          });
                        },
                      ),
                    ],
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void placeCursorAtTheEnd() {
    chatTextController.selection =
        TextSelection.fromPosition(TextPosition(offset: bloc.cursorPosition));
  }

  void showUserMentions(String value) async {
    List<String> charList = value.split("");
    int pos = bloc.cursorPosition;
    while (pos >= 1 && charList[pos - 1] != "@") {
      pos -= 1;
    }
    if (pos >= 1 && value[pos - 1] == '@') {
      for (int i = pos; i < value.length; i++) {
        if (value[i] == ' ') {
          bloc.showMentions(false);
          return;
        }
      }
    } else {
      bloc.showMentions(false);
      return;
    }

//    print(value.substring(math.max(pos - 1, 0), bloc.cursorPosition));
    final cond1 = value.startsWith("@");
    final cond2 = value
        .substring(math.max(pos - 2, 0), bloc.cursorPosition)
        .startsWith(" @");
    final cond3 = value
        .substring(math.max(pos - 2, 0), bloc.cursorPosition)
        .endsWith(" @");
    final cond4 = value
        .substring(math.max(pos - 1, 0), bloc.cursorPosition)
        .startsWith(" @");
    final cond5 = value
        .substring(math.max(pos - 1, 0), bloc.cursorPosition)
        .endsWith(" @");

    bool show = cond1 || cond2 || cond3 || cond4 || cond5;
    if (show) {
      String filterValue = charList.getRange(pos, bloc.cursorPosition).join();
      bloc.getTeamMembers(filterValue);
    }
    bloc.showMentions(show);
  }

  List<Widget> _getMentionItemList(List<ChatTextMentionModel> list,
      {ValueChanged<String>? onMentionSelected}) {
    return list
        .map((e) => _getMentionItem(e, onMentionSelected: onMentionSelected))
        .toList();
  }

  Widget _getMentionItem(ChatTextMentionModel mention,
      {ValueChanged<String>? onMentionSelected}) {
    return Material(
      child: InkWell(
        onTap: () {
          if (onMentionSelected != null) onMentionSelected(mention.displayName);
        },
        child: Container(
          padding: EdgeInsets.all(5),
          color: null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              mention.isMember == true
                  ? TXNetworkImage(
                      width: 30,
                      height: 30,
                      forceLoad: true,
                      imageUrl: mention.url ?? "",
                      placeholderImage: Image.asset(R.image.logo),
                    )
                  : Container(
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.alternate_email,
                        color: R.color.primaryColor,
                        size: 20,
                      ),
                    ),
              SizedBox(
                width: 5,
              ),
              mention.isMember == true
                  ? TXUserPresenceWidget(
                      userPresence: mention.userPresence,
                      isUserEnabled: mention.isActive,
                    )
                  : Container(),
              SizedBox(
                width: 5,
              ),
              TXTextWidget(
                text: mention.displayName,
                color: R.color.primaryColor,
                fontWeight: mention.displayName == RemoteConstants.all ||
                        mention.displayName == RemoteConstants.channel
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
              SizedBox(
                width: mention.displayName == RemoteConstants.all ||
                        mention.displayName == RemoteConstants.channel
                    ? 5
                    : 0,
              ),
              mention.displayName == RemoteConstants.all ||
                      mention.displayName == RemoteConstants.channel
                  ? Expanded(
                      child: TXTextWidget(
                        maxLines: 1,
                        text: mention.displayName == RemoteConstants.all
                            ? R.string.notifyAllMembers
                            : R.string.notifyAllInThisChannel,
                        color: R.color.primaryColor,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAvailableMentionsList({ValueChanged<String>? onMentionSelected}) {
    return Container(
        child: StreamBuilder<List<ChatTextMentionModel>>(
      stream: bloc.mentionsResult,
      initialData: [],
      builder: (ctx, snapshot) {
        return Container(
          constraints: BoxConstraints(maxHeight: 250),
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   physics: BouncingScrollPhysics(),
          //   itemBuilder: (ctx, index) {
          //     final mention = snapshot.data[index];
          //
          //   },
          //   itemCount: snapshot.data.length,
          // ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ..._getMentionItemList(snapshot.data!,
                    onMentionSelected: onMentionSelected),
              ],
            ),
          ),
        );
      },
    ));
  }

  Widget _showSourceSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TXTextWidget(
            text: R.string.fromLocalStorage,
            color: R.color.secondaryColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.library_add,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  title: R.string.documents,
                  titleColor: R.color.blackColor,
                  onTap: () {
                    //_launchMediaView(allFiles: true);
                    _launchMediaViewMulti(type: Types.documents);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.photo_library,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.photoGallery,
                  onTap: () {
                    //_launchMediaView(imageSource: ImageSource.gallery);
                    _launchMediaViewMulti(type: Types.images);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.video_library,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.videoGallery,
                  onTap: () {
                    //_launchMediaView(imageSource: ImageSource.gallery, lookForVideo: true);
                    _launchMediaViewMulti(type: Types.video);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TXDividerWidget(),
          SizedBox(
            height: 10,
          ),
          TXTextWidget(
            text: R.string.useCamera,
            color: R.color.secondaryColor,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.photo_camera,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.takePhoto,
                  onTap: () {
                    _launchMediaView(imageSource: ImageSource.camera);
                  },
                ),
                TXMediaSelectorWidget(
                  icon: Icon(
                    Icons.videocam,
                    color: R.color.grayDarkColor,
                  ),
                  showVertically: false,
                  titleColor: R.color.blackColor,
                  title: R.string.recordVideo,
                  onTap: () {
                    _launchMediaView(
                        imageSource: ImageSource.camera, lookForVideo: true);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchMediaViewMulti({
    required Types type,
  }) async {
    NavigationUtils.pop(context);
    try {
      final files = (await FileManager.getMultiFiles(type: type))
          .where((file) => file.existsSync())
          .toList();
      bloc.uploadFiles(
        files,
        showOnChannel: publishInChannel,
        pmid: widget.pmid,
      );
    } catch (ex) {
      onError(ex);
    }
  }

  void _launchMediaView(
      {ImageSource? imageSource,
      bool lookForVideo = false,
      bool allFiles = false,
      makePopContext = true,
      ValueChanged<int>? onFileLoading}) async {
    try {
      if (makePopContext) NavigationUtils.pop(context);
      final file = await FileManager.getImageFromSource(
          source: imageSource,
          lookForVideo: lookForVideo,
          allFiles: allFiles,
          onFileLoading: onFileLoading);
      if (file != null && file.existsSync()) {
        bloc.uploadFile(file,
            showOnChannel: publishInChannel, pmid: widget.pmid);
      }
    } catch (ex) {
      onError(ex);
    }
  }

  void onError(ex) {
    if (ex is PlatformException) {
      if (ex.code == "photo_access_denied" ||
          ex.code == "camera_access_denied") {
        _showDialogPermissions(
            context: context,
            onOkAction: () async {
              openAppSettings();
            });
      }
    }
  }

  void _showDialogPermissions(
      {required BuildContext context, Function? onOkAction}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.permissionDenied,
        content: R.string.enablePermissions,
        onOK: () {
          Navigator.pop(context, R.string.ok);
          if (onOkAction != null) onOkAction();
        },
        onCancel: () {
          Navigator.pop(context, R.string.cancel);
        },
      ),
    );
  }

  // Widget _showEmojiView(
  //     {required BuildContext context, ValueChanged<String>? emojiSelected}) {
  //   return Material(
  //     child: Container(
  //       height: 300,
  //       width: double.infinity,
  //       child: TXIconButtonWidget(
  //         icon: Icon(Icons.add_circle_outline),
  //         onPressed: () {
  //           chatTextController.text = chatTextController.text + "asd";
  //           placeCursorAtTheEnd();
  //         },
  //       ),
  //     ),
  //   );
  // }

  bool focusWasAlreadyRequested = false;

  Widget _showAnswerMessageWidget() {
    if (!focusWasAlreadyRequested && !focusNode.hasFocus) {
      focusNode.requestFocus();
    }
    focusWasAlreadyRequested = true;
    return TXAnswerMessageWidget(
      answerInMessageModel: widget.answerInMessageModel,
      onCloseAnswerInMessage: widget.onCloseAnswerInMessage,
      showCloseOption: true,
      onTap: widget.onTapAnswerInMessage,
    );
  }
}
