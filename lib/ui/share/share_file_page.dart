import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/share/share_file_bloc.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/common_utils.dart';

class ShareFilePage extends StatefulWidget {
  final FileModel fileModel;
  final bool internal;
  final List<ChannelModel> channels;
  final List<ChannelModel> groups;
  final List<ChannelModel> messages1x1;
  final List<MemberModel> members;

  const ShareFilePage(
      {Key? key,
      required this.fileModel,
      this.internal = false,
      required this.groups,
      required this.channels,
      required this.messages1x1,
      required this.members})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShareState();
}

class _ShareState extends StateWithBloC<ShareFilePage, ShareFileBloC> {
  TextEditingController textEditingController = TextEditingController();
  bool isFolder = false;

  _navBack() {
    NavigationUtils.pop(context, result: bloc.selectedChannel?.channelModel);
  }

  @override
  void initState() {
    super.initState();
    isFolder = widget.fileModel.mimeType.startsWith('text/directory');
    bloc.file = widget.fileModel;
    bloc.sharedResult.listen((onData) {
      _navBack();
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navBack();
        return false;
      },
      child: Stack(
        children: <Widget>[
          TXMainAppBarWidget(
            title: isFolder ? R.string.cloneFolder : R.string.shareFile,
            onLeadingTap: () {
              _navBack();
            },
            body: TXGestureHideKeyBoard(
              child: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          margin: EdgeInsets.all(0),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: <Widget>[
                                TXNetworkImage(
                                  height: 80,
                                  width: 80,
                                  imageUrl: widget.fileModel.link ?? "",
                                  mimeType: widget.fileModel.mimeType,
                                  placeholderImage: Image.asset(
                                    R.image.logo,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TXTextWidget(
                                        fontWeight: FontWeight.bold,
                                        color: R.color.blackColor,
                                        text: widget.fileModel.titleFixed,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TXTextWidget(
                                        text: "${widget.fileModel.contentType}",
                                        size: 10,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TXTextWidget(
                                        text: CalendarUtils.showInFormat(
                                                R.string.dateFormat1,
                                                widget.fileModel.ts) ??
                                            '',
                                        size: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TXTextWidget(
                          text: R.string.channel,
                          color: R.color.blackColor,
                          size: 16,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            showTXModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return _showChannels();
                                });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: R.color.grayColor, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: StreamBuilder<DrawerChatModel?>(
                                      stream: bloc.channelResult,
                                      initialData: null,
                                      builder: (context, snapshot) {
                                        final model = snapshot.data;
                                        return TXTextWidget(
                                          text: snapshot.data == null
                                              ? R.string.selectChannel
                                              : model!.channelModel!.isM1x1
                                                  ? "@${CommonUtils.getMemberUsername(model.memberModel)}"
                                                  : model.title,
                                        );
                                      }),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: R.color.blackColor,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        isFolder
                            ? Container(
                                padding: EdgeInsets.only(top: 30),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      color: R.color.grayLightestColor),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.info,
                                        color: R.color.secondaryColor,
                                        size: 60,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TXTextWidget(
                                              color: R.color.blackColor,
                                              size: 14,
                                              textAlign: TextAlign.justify,
                                              text: R.string.cloneFolderInfo,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TXTextWidget(
                                    text: R.string.addCommentOptional,
                                    color: R.color.blackColor,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TXTextFieldWidget(
                                    controller: textEditingController,
                                  )
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: TXButtonWidget(
                            title: isFolder
                                ? R.string.cloneFolder
                                : R.string.share,
                            onPressed: () {
                              if (bloc.selectedChannel == null)
                                ToastUtil.showToast(
                                    R.string.needToSelectChannel,
                                    toastLength: Toast.LENGTH_SHORT);
                              else
                                bloc.shareFile(
                                    textEditingController.text);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          TXLoadingWidget(
            loadingStream: bloc.isLoadingStream,
          )
        ],
      ),
    );
  }

  Widget _showChannels() {
    bloc.loadChannels(
        channels: widget.channels,
        groups: widget.groups,
        ims: widget.messages1x1,
        members: widget.members);
    return Container(
      child: StreamBuilder<List<DrawerChatModel>>(
        stream: bloc.channelsResult,
        initialData: [],
        builder: (ctx, snapshot) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ).copyWith(bottom: 30),
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              final model = snapshot.data![index];
              return Container(
                child: model.isChild
                    ? _getChildWidget(model)
                    : _getHeaderWidget(model),
              );
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }

  Widget _getHeaderWidget(DrawerChatModel model) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TXTextWidget(
        text: model.title,
        color: R.color.grayColor,
      ),
    );
  }

  Widget _getChildWidget(DrawerChatModel model) {
    return InkWell(
      onTap: () {
        bloc.pickChannel(model);
        NavigationUtils.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(left: 15),
        child: TXTextWidget(
          text: model.channelModel?.isM1x1 == true
              ? "@${CommonUtils.getMemberUsername(model.memberModel) ?? ""}"
              : model.title.toLowerCase().trim(),
          color: R.color.blackColor,
        ),
      ),
    );
  }
}
