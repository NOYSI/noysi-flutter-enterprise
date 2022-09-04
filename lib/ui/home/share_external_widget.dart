import 'dart:io';

import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/home/share_external_bloc.dart';
import 'package:code/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../utils/common_utils.dart';
import '../../utils/file_manager.dart';

class ShareExternalWidget extends StatefulWidget {
  final String content;
  final bool isFile;

  const ShareExternalWidget({
    required this.content,
    required this.isFile,
  });

  @override
  State<StatefulWidget> createState() => _ShareExternalWidgetState();
}

class _ShareExternalWidgetState
    extends StateWithBloC<ShareExternalWidget, ShareExternalBloC> {
  Image? placeholder;
  String? mimeType;

  @override
  void initState() {
    super.initState();
    if (widget.isFile) _resolveImageContainer(widget.content);
    bloc.loadTeams();
  }

  void _resolveImageContainer(String filePath) {
    mimeType = FileManager.lookupMime(filePath);
    if (mimeType!.startsWith("image"))
      placeholder = Image.file(
        File(filePath),
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      );
    else if (mimeType!.startsWith("video")) {
      placeholder = Image.asset(
        R.image.videoDefaultIcon,
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      );
    } else if (mimeType!.startsWith("audio")) {
      placeholder = Image.asset(
        R.image.videoDefaultIcon,
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      );
    } else {
      placeholder = Image.asset(
        R.image.document,
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      );
    }
  }

  void _navBack() {
    NavigationUtils.pop(context);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navBack();
        return false;
      },
      child: Container(
        height: 400,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TXButtonWidget(
                          mainColor: Colors.red,
                          onPressed: () async {
                            bloc.cancelTokenPost();
                            _navBack();
                          },
                          title: R.string.cancel,
                        ),
                        TXButtonWidget(
                            mainColor: Colors.green,
                            onPressed: () {
                              if (!(bloc.isUploading == true)) {
                                if (widget.isFile) {
                                  if (bloc.selectedChannel == null) {
                                    ToastUtil.showToast(
                                        R.string.needToSelectChannel,
                                        toastLength: Toast.LENGTH_SHORT);
                                  } else {
                                    bloc.uploadFile(
                                      File(widget.content),
                                      channelId:
                                      bloc.selectedChannel?.channelModel?.id ?? "",
                                      bottomModalContext: context,
                                      teamId: bloc.selectedTeam?.id ?? "",
                                    );
                                  }
                                } else {
                                  bloc.shareText(
                                    widget.content,
                                    channelId:
                                    bloc.selectedChannel?.channelModel?.id ?? "",
                                    bottomModalContext: context,
                                    teamId: bloc.selectedTeam?.id ?? "",
                                  );
                                }
                              }
                            },
                            title: R.string.share)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: widget.isFile
                            ? Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () => OpenFile.open(widget.content),
                              child: placeholder,
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
                                    text: widget.content.split('/').last,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TXTextWidget(
                                    text: "$mimeType",
                                    size: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                            : Container(
                          child: TXTextWidget(
                            text: widget.content,
                            textOverflow: TextOverflow.clip,
                            textAlign: TextAlign.start,
                            color: Colors.black,
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TXTextWidget(
                      text: R.string.yourTeams,
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
                              return _showTeams();
                            });
                      },
                      child: Container(
                        width: double.infinity,
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: R.color.grayColor, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: StreamBuilder<TeamModel>(
                                  stream: bloc.teamResult,
                                  initialData: null,
                                  builder: (context, snapshot) {
                                    final model = snapshot.data;
                                    return TXTextWidget(
                                      text: model == null
                                          ? R.string.selectChannel
                                          : model.titleFixed,
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
                    SizedBox(
                      height: 10,
                    ),
                    TXTextWidget(
                      text: R.string.channels,
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
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: R.color.grayColor, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: StreamBuilder<DrawerChatModel>(
                                  stream: bloc.channelResult,
                                  initialData: null,
                                  builder: (context, snapshot) {
                                    final model = snapshot.data;
                                    return TXTextWidget(
                                      text: snapshot.data == null
                                          ? R.string.selectChannel
                                          : model?.channelModel?.isM1x1 == true
                                          ? "@${CommonUtils.getMemberUsername(model?.memberModel) ?? ""}"
                                          : model?.title ?? "",
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: StreamBuilder<bool>(
                        stream: bloc.showUploadingResult,
                        initialData: false,
                        builder: (ctx, snapshot) {
                          return snapshot.data == true
                              ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: StreamBuilder<double>(
                                stream: bloc.uploadingResult,
                                builder: (context, snapshotUploading) {
                                  return LinearPercentIndicator(
                                    progressColor: R.color.primaryColor,
                                    backgroundColor: R.color.grayLightColor,
                                    lineHeight: 20,
                                    barRadius: Radius.circular(45),
                                    padding: EdgeInsets.all(0),
                                    animation: false,
                                    trailing: TXIconButtonWidget(
                                      icon: Icon(
                                        Icons.close,
                                        size: 20,
                                        color: R.color.blackColor,
                                      ),
                                      onPressed: () {
                                        bloc.cancelTokenPost();
                                      },
                                    ),
                                    percent: snapshotUploading.data ?? 0,
                                  );
                                }),
                          )
                              : Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TXLoadingWidget(
              loadingStream: bloc.isLoadingStream,
            ),
          ],
        )
      ),
    );
  }

  Widget _showTeams() {
    return Container(
      child: StreamBuilder<List<TeamModel>>(
        initialData: [],
        stream: bloc.teamsResult,
        builder: (context, snapshot) {
          snapshot.data!.sort((e1, e2) => e1.titleFixed
              .toLowerCase()
              .trim()
              .compareTo(e2.titleFixed.toLowerCase().trim()));
          return ListView.builder(
              padding: EdgeInsets.only(bottom: 30),
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return _getTeamWidget(snapshot.data![index]);
              });
        },
      ),
    );
  }

  Widget _getTeamWidget(TeamModel team) {
    return Column(
      children: [
        ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            onTap: () async {
              await NavigationUtils.pop(context);
              bloc.pickTeam(team);
            },
            leading: TXNetworkImage(
              forceLoad: true,
              imageUrl: team.photo ?? '',
              placeholderImage: Image.asset(R.image.logo),
            ),
            title: TXTextWidget(
              text: team.titleFixed,
              color: R.color.blackColor,
              fontWeight: FontWeight.bold,
            )
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          child: TXDividerWidget(),
        )
      ],
    );
    //   InkWell(
    //   onTap: () async {
    //     await NavigationUtils.pop(context);
    //     bloc.pickTeam(model);
    //   },
    //   child: Container(
    //     padding: EdgeInsets.symmetric(vertical: 10),
    //     margin: EdgeInsets.only(left: 15),
    //     child: TXTextWidget(
    //       text: model.titleFixed,
    //       color: R.color.blackColor,
    //     ),
    //   ),
    // );
  }

  Widget _showChannels() {
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
