import 'package:code/_res/R.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_tx_widget/TXAudioPlayer/tx_audio_player_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_video_player.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:flutter/material.dart';

class TXFileWidget extends StatelessWidget {
  final FileModel file;
  final Function()? onTap;
  final Function()? onLongPress;
  final FileViewMode? fileViewMode;

  const TXFileWidget({
    Key? key,
    required this.file,
    this.onTap,
    this.fileViewMode,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fileViewMode == FileViewMode.grid ? _getGridView() : _getListView();
  }

  Widget _getGridView() {
    final isAudio = file.mimeType.startsWith("audio") == true;
    final isVideo = file.mimeType.startsWith("video") == true;

    return Card(
      shape: Border(
          top: BorderSide.none,
          right: BorderSide.none,
          bottom: BorderSide.none,
          left: BorderSide.none),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: !isVideo && !isAudio
                      ? TXNetworkImage(
                          mimeType: file.mimeType,
                          forceLoad: true,
                          width: double.infinity,
                          imageUrl: file.link ?? "",
                          shape: BoxShape.rectangle,
                          boxFitImage: BoxFit.cover,
                          userBorderRadius: false,
                          placeholderImage: Image.asset(
                            file.mimeType.startsWith("image") == true
                                ? R.image.imageDefaultIcon
                                : R.image.logo,
                            fit: BoxFit.contain,
                          ),
                        )
                      : !isVideo
                          ? TXAudioPlayer(
                              link: file.link,
                              mimeType: file.mimeType,
                              isThumbnail: true,
                            )
                          : TXVideoPlayer(
                              link: file.link ?? "",
                              isThumbnail: true,
                            ),
                ),
              ),
              Container(
                height: 1,
                color: R.color.grayLightestColor,
              ),
              SizedBox(height: 5),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TXTextWidget(
                  fontWeight: FontWeight.bold,
                  color: R.color.blackColor,
                  text: file.titleFixed,
                  size: 12,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          TXTextWidget(
                            text: "${file.contentType}",
                            size: 10,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          TXTextWidget(
                            text: CalendarUtils.showInFormat(
                                R.string.dateFormat1, file.ts) ?? '',
                            size: 10,
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      child: Material(
                        color: R.color.whiteColor,
                        child: InkWell(
                          child: Icon(
                            Icons.more_vert,
                            size: 20,
                            color: R.color.darkColor,
                          ),
                          onTap: () {
                            onLongPress!();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getListView() {
    final isAudio = file.mimeType.startsWith("audio") == true;
    final isVideo = file.mimeType.startsWith("video") == true;
    return Card(
      shape: Border(
          top: BorderSide.none,
          right: BorderSide.none,
          bottom: BorderSide.none,
          left: BorderSide.none),
      child: Container(
        child: InkWell(
          onTap: () {},
          child: Row(
            children: <Widget>[
              !isAudio && !isVideo
                  ? TXNetworkImage(
                      imageUrl: file.link ?? "",
                      shape: BoxShape.rectangle,
                      height: double.infinity,
                      width: 80,
                      mimeType: file.mimeType,
                      boxFitImage: BoxFit.cover,
                      userBorderRadius: false,
                      placeholderImage: Image.asset(
                        file.mimeType.startsWith("image") == true
                            ? R.image.imageDefaultIcon
                            : R.image.logo,
                        fit: BoxFit.cover,
                      ),
                    )
                  : !isVideo
                      ? Container(
                          width: 80,
                          child: TXAudioPlayer(
                            link: file.link,
                            mimeType: file.mimeType,
                            isThumbnail: true,
                          ),
                        )
                      : Container(
                          width: 80,
                          child: TXVideoPlayer(
                            link: file.link ?? "",
                            isThumbnail: true,
                          ),
                        ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TXTextWidget(
                      fontWeight: FontWeight.bold,
                      color: R.color.blackColor,
                      text: file.titleFixed,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      size: 12,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TXTextWidget(
                      text: "${file.contentType}",
                      size: 10,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TXTextWidget(
                      text: CalendarUtils.showInFormat(
                          R.string.dateFormat1, file.ts) ?? '',
                      size: 10,
                    )
                  ],
                ),
              ),
              TXIconButtonWidget(
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: R.color.darkColor,
                ),
                onPressed: () {
                  onLongPress!();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
