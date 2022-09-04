import 'package:audioplayers/audioplayers.dart';
import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

class TXAudioPlayer extends StatefulWidget {
  final String? link, mimeType;
  final bool isThumbnail, showBorder;

  const TXAudioPlayer(
      {Key? key,
      required this.link,
      required this.mimeType,
      this.isThumbnail = false,
      this.showBorder = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TXAudioPlayerState();
}

class _TXAudioPlayerState extends State<TXAudioPlayer>
    with TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  Duration _duration = new Duration();
  Duration _position = Duration(milliseconds: 0);
  bool isSongPlaying = false;
  AnimationController? _animationIconController;
  StreamSubscription? _durationChanged,
      _positionChanged,
      _playerCompletion,
      _playerError;

  @override
  void initState() {
    super.initState();
    _animationIconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    _durationChanged = audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    _positionChanged = audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    _playerCompletion = audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(milliseconds: 0);
        _animationIconController?.reverse();
        isSongPlaying = false;
      });
    });
    _playerError = audioPlayer.onPlayerError.listen((event) {
      Fluttertoast.showToast(msg: R.string.formatNotSupported);
      audioPlayer.stop();
      setState(() {
        _position = Duration(milliseconds: 0);
        _animationIconController?.reverse();
        isSongPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _durationChanged?.cancel();
    _positionChanged?.cancel();
    _playerCompletion?.cancel();
    _playerError?.cancel();
    _animationIconController?.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Injector.instance.fileCacheManager.resolveUrl(widget.link ?? ''),
      initialData: null,
      builder: (context, snapshot) {
        String url = snapshot.data ?? '';
        if (widget.isThumbnail) {
          return Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    color: R.color.secondaryColor,
                  ),
                ),
                Container(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.music_note_outlined,
                        size: 20, color: R.color.secondaryColor)),
                Container(
                  child: AbsorbPointer(
                      absorbing: url.isEmpty,
                      child: url.isEmpty
                          ? Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Container(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        R.color.primaryColor),
                                    strokeWidth: 2,
                                    backgroundColor: null,
                                  ),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (url.isNotEmpty) {
                                  _showModalPlayer();
                                }
                              },
                              child: Icon(Icons.play_arrow_sharp,
                                  color: R.color.primaryColor, size: 40),
                            )),
                )
              ],
            ),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: widget.showBorder
              ? BoxDecoration(
                  border:
                      Border.all(color: R.color.grayLightestColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4)))
              : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AbsorbPointer(
                absorbing: url.isEmpty,
                child: url.isEmpty
                    ? Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Container(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  R.color.primaryColor),
                              strokeWidth: 2,
                              backgroundColor: null,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        child: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          size: 40,
                          progress: _animationIconController!,
                          color: R.color.primaryColor,
                        ),
                        onTap: () {
                          if (url.isNotEmpty) {
                            if (isSongPlaying) {
                              audioPlayer.pause();
                              _animationIconController?.reverse();
                            } else {
                              audioPlayer.state == PlayerState.PAUSED
                                  ? audioPlayer.resume()
                                  : audioPlayer.play(url,
                                      stayAwake: true,
                                      isLocal: true,
                                      position: _position);
                              _animationIconController?.forward();
                            }
                            isSongPlaying = !isSongPlaying;
                          }
                        },
                      ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 8,
                        trackShape: CustomTrackShape(),
                        minThumbSeparation: 10,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 8),
                      ),
                      child: Slider(
                        activeColor: R.color.primaryColor,
                        inactiveColor: R.color.grayColor,
                        value:
                            _position.inMilliseconds > _duration.inMilliseconds
                                ? _duration.inMilliseconds.toDouble()
                                : _position.inMilliseconds.toDouble(),
                        max: _duration.inMilliseconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            audioPlayer
                                .seek(Duration(milliseconds: value.toInt()));
                          });
                        },
                      ),
                    ),
                    Container(
                      child: TXTextWidget(
                          size: 14,
                          text:
                              "${_position.inMinutes.toString().padLeft(2, '0')}:${_position.inSeconds.remainder(60).toString().padLeft(2, '0')}"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              TXNetworkImage(
                forceLoad: true,
                boxFitImage: BoxFit.cover,
                mimeType: widget.mimeType ?? "audio",
                width: 40,
                userBorderRadius: false,
                height: 40,
                imageUrl: widget.link ?? "",
                placeholderImage: Image.asset(
                  R.image.videoDefaultIcon,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _showModalPlayer() {
    showTXModalBottomSheetAutoAdjustable(
        context: context,
        builder: (context) {
          return Column(
            children: [
              TXAudioPlayer(
                link: widget.link,
                mimeType: widget.mimeType,
              )
            ],
          );
        });
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy +
        (parentBox.size.height - trackHeight) / 2 +
        (sliderTheme.trackHeight ?? 0);
    final double trackWidth =
        parentBox.size.width - (sliderTheme.minThumbSeparation ?? 10);
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
