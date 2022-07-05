import 'package:chewie/chewie.dart';
import 'package:code/_di/injector.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/_res/R.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';
import 'package:code/utils/extensions.dart';

import 'package:video_player/video_player.dart';

class TXVideoPlayer extends StatefulWidget {
  final String link;
  final bool isThumbnail;

  const TXVideoPlayer({
    Key? key,
    required this.link,
    this.isThumbnail = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TXVideoPlayer();
}

class _TXVideoPlayer extends StateWithBloC<TXVideoPlayer, TXVideoPlayerBloC> {
  @override
  void initState() {
    super.initState();
    bloc.checkIfCached(widget.link);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return initializedVideos[widget.link] != null &&
            File(initializedVideos[widget.link]
                        ?.videoPlayerController
                        .dataSource ??
                    '')
                .existsSync()
        ? TXVideoPlayerMedia(
            path: initializedVideos[widget.link]!
                .videoPlayerController
                .dataSource,
            link: widget.link,
            isThumbnail: widget.isThumbnail,
          )
        : StreamBuilder<String>(
            initialData: '',
            stream: bloc.cachedPathController.stream,
            builder: (context, snapshot) {
              return snapshot.data!.isNotEmpty
                  ? TXVideoPlayerMedia(
                      path: snapshot.data!,
                      link: widget.link,
                      isThumbnail: widget.isThumbnail,
                    )
                  : StreamBuilder<bool>(
                      stream: bloc.cachingController.stream,
                      initialData: false,
                      builder: (context, cachingSnapshot) {
                        return Stack(
                          children: [
                            Container(
                                height: 200,
                                width: double.infinity,
                                color: R.color.blackColor,
                                child: cachingSnapshot.data!
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          bloc.cacheVideo(widget.link);
                                        },
                                        child: Icon(
                                          Icons.cloud_download,
                                          color: R.color.whiteColor,
                                          size: 50,
                                        ),
                                      )),
                            cachingSnapshot.data!
                                ? Container(
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                R.color.whiteColor),
                                        strokeWidth: 3,
                                        backgroundColor: null,
                                      ),
                                    ))
                                : Container()
                          ],
                        );
                      },
                    );
            },
          );
  }
}

class TXVideoPlayerMedia extends StatefulWidget {
  final String path, link;
  final bool isThumbnail;

  const TXVideoPlayerMedia({
    Key? key,
    required this.path,
    required this.link,
    this.isThumbnail = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TXVideoPlayerMediaState();
}

class _TXVideoPlayerMediaState
    extends StateWithBloC<TXVideoPlayerMedia, TXVideoPlayerBloC> {
  @override
  void initState() {
    super.initState();
    bloc.init(widget.path, widget.link);
  }

  @override
  void dispose() {
    bloc._videoPlayerController.pause();
    bloc._videoPlayerController.seekTo(Duration(milliseconds: 0));
    super.dispose();
  }

  void _showMediaPlayer() {
    txShowVideoDialog(context,
        content: TXVideoPlayerMedia(path: widget.path, link: widget.link));
  }

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc.playerInitialized.stream,
        initialData: false,
        builder: (context, snapshot) {
          return snapshot.data!
              ? widget.isThumbnail
                  ? Container(
                      child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 0.2,
                          child: Container(
                            color: R.color.tagColor5,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: TXNetworkImage(
                            forceLoad: true,
                            boxFitImage: BoxFit.fill,
                            mimeType: "video",
                            userBorderRadius: false,
                            height: 25,
                            width: 20,
                            imageUrl: widget.link,
                            placeholderImage: Image.asset(
                              R.image.videoDefaultIcon,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _showMediaPlayer();
                          },
                          icon: Icon(Icons.play_arrow_sharp,
                              color: R.color.primaryColor, size: 40),
                        )
                      ],
                    ))
                  : AspectRatio(
                      aspectRatio:
                          bloc._videoPlayerController.value.aspectRatio,
                      child: Chewie(
                        controller: bloc._chewieController,
                      ),
                    )
              : Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: R.color.blackColor,
                    ),
                    Container(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                R.color.whiteColor),
                            strokeWidth: 3,
                            backgroundColor: null,
                          ),
                        ))
                  ],
                );
        });
  }
}

class TXVideoPlayerBloC extends BaseBloC with LoadingBloC {
  @override
  void dispose() {
    disposeLoadingBloC();
    playerInitialized.close();
    cachedPathController.close();
    cachingController.close();
  }

  BehaviorSubject<bool> playerInitialized = BehaviorSubject();
  BehaviorSubject<String> cachedPathController = BehaviorSubject();
  BehaviorSubject<bool> cachingController = BehaviorSubject();

  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  void cacheVideo(String url) async {
    if (url.isNotEmpty) {
      cachingController.sinkAddSafe(true);
      final res = await Injector.instance.fileCacheManager.resolveUrl(url);
      cachingController.sinkAddSafe(false);
      cachedPathController.sinkAddSafe(res);
    }
  }

  void checkIfCached(String url) async {
    final res = await Injector.instance.fileCacheManager.getCachedFile(url);
    cachedPathController.sinkAddSafe(res);
  }

  void init(String path, String link) async {
    if (initializedVideos[link] == null) {
      _videoPlayerController = VideoPlayerController.file(File(path));
      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: false,
          looping: false,
          allowFullScreen: true,
          allowMuting: true,
          allowPlaybackSpeedChanging: false,
          deviceOrientationsAfterFullScreen: [
            DeviceOrientation.portraitUp,
          ],
          deviceOrientationsOnEnterFullScreen: [
            DeviceOrientation.portraitUp,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight
          ]);
      await _videoPlayerController.initialize();
      if (_videoPlayerController.value.isInitialized)
        initializedVideos[link] = _chewieController;
    } else {
      _videoPlayerController = initializedVideos[link]!.videoPlayerController;
      _chewieController = initializedVideos[link]!;
    }
    playerInitialized.sinkAddSafe(_videoPlayerController.value.isInitialized);
  }
}
