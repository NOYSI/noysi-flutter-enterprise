import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_flat_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/task_create/tx_edit_field_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../_res/R.dart';
import '../../utils/file_manager.dart';
import '../_tx_widget/tx_bottom_sheet.dart';
import '../_tx_widget/tx_cupertino_dialog_widget.dart';
import '../_tx_widget/tx_divider_widget.dart';
import '../_tx_widget/tx_media_selector_widget.dart';
import '../_tx_widget/tx_text_widget.dart';
import '../chat_text_widget/tx_chat_text_input_bloc.dart';

class TXEditFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final bool showFileAttach;

  const TXEditFieldWidget({super .key, this.label = "", this.text = "", this.showFileAttach = true});

  @override
  State<StatefulWidget> createState() => _TXEditFieldState();
}

class _TXEditFieldState
    extends StateWithBloC<TXEditFieldWidget, TXEditFieldBloC> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    textController.text = widget.text;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: TXIconButtonWidget(
            icon: Icon(
              Icons.close,
              color: R.color.secondaryColor,
            ),
            onPressed: () {
              NavigationUtils.pop(context, result: widget.text);
            }),
        actions: [
          TXFlatButtonWidget(
            onPressed: () {
              NavigationUtils.pop(context, result: textController.text);
            },
            title: R.string.ok,
            fontSize: 20,
            textColor: R.color.secondaryColor,
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Stack(
            children: [
              TXGestureHideKeyBoard(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextField(
                        controller: textController,
                        maxLines: null,
                        minLines: 1,
                        focusNode: focusNode,
                        keyboardType: TextInputType.multiline,
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(color: R.color.grayDarkColor, fontSize: 20),
                        decoration: InputDecoration.collapsed(hintText: widget.label),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Material(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.5, color: R.color.grayLightestColor),
                            )),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.showFileAttach ? Container(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: StreamBuilder<bool>(
                                      stream: bloc.showUploadingResult,
                                      initialData: false,
                                      builder: (context, snapshot) {
                                        return InkWell(
                                          borderRadius: const BorderRadius.all(Radius.circular(45)),
                                          onTap: () async {
                                            WidgetsBinding.instance.focusManager.primaryFocus
                                                ?.unfocus();
                                            if (snapshot.data!) {
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
                                                    SizedBox(
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
                                InkWell(
                                  child: const Icon(Icons.format_bold, size: 25),
                                  onTap: () {
                                    textController.text += "**";
                                    if (!focusNode.hasFocus) focusNode.requestFocus();
                                    Future.delayed(Duration(milliseconds: 100))
                                        .then((value) {
                                      textController.selection =
                                          TextSelection.fromPosition(TextPosition(
                                              offset: textController.text.length - 1));
                                    });
                                  },
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  child: Icon(Icons.format_italic, size: 25),
                                  onTap: () {
                                    textController.text += "__";
                                    if (!focusNode.hasFocus) focusNode.requestFocus();
                                    Future.delayed(Duration(milliseconds: 100))
                                        .then((value) {
                                      textController.selection =
                                          TextSelection.fromPosition(TextPosition(
                                              offset: textController.text.length - 1));
                                    });
                                  },
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  child: Icon(Icons.format_strikethrough, size: 25),
                                  onTap: () {
                                    textController.text += "~~";
                                    if (!focusNode.hasFocus) focusNode.requestFocus();
                                    Future.delayed(Duration(milliseconds: 100))
                                        .then((value) {
                                      textController.selection =
                                          TextSelection.fromPosition(TextPosition(
                                              offset: textController.text.length - 1));
                                    });
                                  },
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  child: Icon(Icons.code, size: 25),
                                  onTap: () {
                                    textController.text += "``";
                                    if (!focusNode.hasFocus) focusNode.requestFocus();
                                    Future.delayed(Duration(milliseconds: 100))
                                        .then((value) {
                                      textController.selection =
                                          TextSelection.fromPosition(TextPosition(
                                              offset: textController.text.length - 1));
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showSourceSelector(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TXTextWidget(
            text: R.string.fromLocalStorage,
            color: R.color.secondaryColor,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
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
                    _launchMediaView(allFiles: true);
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
                    _launchMediaView(imageSource: ImageSource.gallery);
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
                    _launchMediaView(
                        imageSource: ImageSource.gallery, lookForVideo: true);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TXDividerWidget(),
          const SizedBox(
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

  void _launchMediaView(
      {ImageSource? imageSource,
      bool lookForVideo = false,
      bool allFiles = false,
      ValueChanged<int>? onFileLoading}) async {
    try {
      NavigationUtils.pop(context);
      final file = await FileManager.getImageFromSource(
          source: imageSource,
          lookForVideo: lookForVideo,
          allFiles: allFiles,
          onFileLoading: onFileLoading);
      if (file != null && file.existsSync()) {
        final fileText = await bloc.attachFile(file);
        if (fileText?.isNotEmpty == true) {
          textController.text += fileText!;
        }
      }
    } catch (ex) {
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
  }

  void _showDialogPermissions(
      {required BuildContext context, required Function onOkAction}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.permissionDenied,
        content: R.string.enablePermissions,
        onOK: () {
          Navigator.pop(context, R.string.ok);
          onOkAction();
        },
        onCancel: () {
          Navigator.pop(context, R.string.cancel);
        },
      ),
    );
  }
}
