import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/utils/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class TXNetworkImage extends StatefulWidget {
  final String imageUrl;
  final String mimeType;
  final Widget? placeholderImage;
  final BoxShape? shape;
  final double width;
  final double height;
  final BoxFit? boxFitImage;
  final bool forceLoad;
  final bool userBorderRadius;
  final Function()? onLongPress;
  final ValueChanged<bool>? onDownloadImage;

  TXNetworkImage({
    Key? key,
    this.shape = BoxShape.rectangle,
    required this.imageUrl,
    this.placeholderImage,
    this.width = 40,
    this.height = 40,
    this.boxFitImage = BoxFit.cover,
    this.forceLoad = false,
    this.mimeType = "image",
    this.userBorderRadius = true,
    this.onLongPress,
    this.onDownloadImage,
  }) : super(key: key);

  @override
  _TXNetworkImageState createState() => _TXNetworkImageState();
}

class _TXNetworkImageState extends State<TXNetworkImage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  bool isFolder = false;

  @override
  void initState() {
    super.initState();
    isFolder = (widget.mimeType.startsWith('text/directory')) ||
        (widget.mimeType.startsWith('application/folder'));
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      value: 0, // initially visible
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String localUri = "";

    if(widget.imageUrl == "*") {
      localUri = R.image.disabledUser;
    } else if (widget.imageUrl.startsWith("http") == true &&
        widget.mimeType.startsWith("image") == true) {
      localUri = "";
    } else if (widget.imageUrl.startsWith("assets") == true ||
        widget.imageUrl.startsWith("lib") == true) {
      localUri =
          Injector.instance.fileCacheManager.resolveLocalUri(widget.imageUrl);
    } else {
      if (widget.mimeType.startsWith("video") == true ||
          widget.mimeType.startsWith("audio") == true)
        localUri = R.image.videoDefaultIcon;
      else if (isFolder)
        localUri = R.image.folder;
      else if (widget.mimeType.startsWith("application")) {
        if (widget.mimeType.endsWith("x-bzip") ||
            widget.mimeType.endsWith("x-bzip2") ||
            widget.mimeType.endsWith("epub+zip") ||
            widget.mimeType.endsWith("gzip") ||
            widget.mimeType.endsWith("zip") ||
            widget.mimeType.endsWith("x-7z-compressed"))
          localUri = R.image.zipDefaultIcon;
        else
          localUri = R.image.document;
      } else
        localUri = R.image.imageDefaultIcon;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(shape: widget.shape ?? BoxShape.rectangle),
      child: localUri.isNotEmpty
          ? _getAssetWidget(localUri)
          : FutureBuilder<String>(
              initialData: "",
              future: Injector.instance.fileCacheManager
                  .resolveUrl(widget.imageUrl),
              builder: (ctx, snapshot) {
                if (snapshot.data?.isNotEmpty == true) {
                  _animationController?.forward();
                }
                return snapshot.data?.isEmpty == true
                    ? widget.placeholderImage ??
                        Image.asset(
                          R.image.logo,
                          fit: widget.boxFitImage ?? BoxFit.cover,
                        )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                widget.userBorderRadius ? 4 : 0))),
                        child: ClipRRect(
                          child: snapshot.data == null
                              ? widget.placeholderImage ??
                                  Image.asset(
                                    R.image.logo,
                                    fit: widget.boxFitImage ?? BoxFit.cover,
                                  )
                              : FadeTransition(
                                  opacity: _animationController!,
                                  child: InkWell(
                                    onLongPress: widget.onLongPress,
                                    onTap: () async {
                                      WidgetsBinding
                                          .instance.focusManager.primaryFocus
                                          ?.unfocus();
                                      // final FileInfo cachedValue = await Injector
                                      //     .instance.fileCacheManager
                                      //     .getFileFromCache(widget.imageUrl);
                                      // await OpenFile.open(cachedValue.file.path);
                                      final isMemberAvatar =
                                          widget.imageUrl.contains('members');

                                      if (!isMemberAvatar &&
                                          widget.onDownloadImage != null)
                                        widget.onDownloadImage!(true);

                                      final imagePath = await Injector
                                          .instance.fileCacheManager
                                          .resolveUrl(isMemberAvatar
                                              ? widget.imageUrl
                                              : widget.imageUrl +
                                                  "?original=true");

                                      if (!isMemberAvatar &&
                                          widget.onDownloadImage != null)
                                        widget.onDownloadImage!(false);

                                      if (imagePath.isNotEmpty) {
                                        await OpenFile.open(imagePath);
                                      }
                                    },
                                    child: FileManager.getFileWidgetByMimeType(
                                        snapshot.data!,
                                        boxFit:
                                            widget.boxFitImage ?? BoxFit.cover,
                                        width: widget.width,
                                        height: widget.height),
                                  ),
                                ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.userBorderRadius ? 4 : 0)),
                        ),
                      );
              },
            ),
    );
  }

  Widget _getAssetWidget(String localUri) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(widget.userBorderRadius ? 4 : 0))),
      child: ClipRRect(
        child: InkWell(
          onLongPress: widget.onLongPress,
          child: Image.asset(
            localUri,
            height: widget.height,
            width: widget.width,
            fit: widget.boxFitImage ?? BoxFit.cover,
          ),
        ),
        borderRadius:
            BorderRadius.all(Radius.circular(widget.userBorderRadius ? 4 : 0)),
      ),
    );
  }

//  Widget _getDefImageWidget() {
//    return Container(
//      height: widget.height,
//      width: widget.width,
//      decoration: BoxDecoration(
//        shape: widget.shape,
//        borderRadius: BorderRadius.all(Radius.circular(4)),
//      ),
//      child: widget.placeholderImage,
//    );
//  }

//  String resolveLocalUri() {
//    String localUri = R.image.logo;
//    String value = widget.imageUrl.split("/").last?.toLowerCase();
//    if (value == "defaultavatar1.png")
//      localUri = R.image.defAvatar1;
//    else if (value == "defaultavatar2.png")
//      localUri = R.image.defAvatar2;
//    else if (value == "defaultavatar3.png")
//      localUri = R.image.defAvatar3;
//    else if (value == "defaultavatar4.png")
//      localUri = R.image.defAvatar4;
//    else if (value == "defaultavatar5.png")
//      localUri = R.image.defAvatar5;
//    else if (value == "defaultavatar6.png")
//      localUri = R.image.defAvatar6;
//    else if (value == "defaultavatar7.png")
//      localUri = R.image.defAvatar7;
//    else if (value == "defaultavatar8.png")
//      localUri = R.image.defAvatar8;
//    else if (value == "defaultavatar9.png")
//      localUri = R.image.defAvatar9;
//    else if (value == "defaultavatar10.png")
//      localUri = R.image.defAvatar10;
//    else if (value == "defaultavatar11.png")
//      localUri = R.image.defAvatar11;
//    else if (value == "defaultavatar12.png")
//      localUri = R.image.defAvatar12;
//    else if (value == "angular.png")
//      localUri = R.image.angular;
//    else if (value == "browsersync.png")
//      localUri = R.image.browserSync;
//    else if (value == "gulp.png")
//      localUri = R.image.gulp;
//    else if (value == "jasmine.png")
//      localUri = R.image.jasmine;
//    else if (value == "karma.png")
//      localUri = R.image.karma;
//    else if (value == "protractor.png")
//      localUri = R.image.protractor;
//    else if (value == "bootstrap.png")
//      localUri = R.image.bootstrap;
//    else if (value == "ui-bootstrap.png")
//      localUri = R.image.uiBootstrap;
//    else if (value == "node-sass.png")
//      localUri = R.image.nodeSass;
//    else if (value == "babel.png")
//      localUri = R.image.babel;
//    else if (value == "jade.png")
//      localUri = R.image.jade;
//    else if (value == "dropbox.png")
//      localUri = R.image.dropbox;
//    else if (value == "github.png")
//      localUri = R.image.github;
//    else if (value == "gdrive.png")
//      localUri = R.image.gDrive;
//    else if (value == "hangouts.png")
//      localUri = R.image.hangouts;
//    else if (value == "hubot.png")
//      localUri = R.image.huBot;
//    else if (value == "jira.png")
//      localUri = R.image.jira;
//    else if (value == "trello.png")
//      localUri = R.image.trello;
//    else if (value == "twitter.png")
//      localUri = R.image.twitter;
//    else if (value == "zendesk.png")
//      localUri = R.image.zendesk;
//    else if (value == "incoming-webhook.png")
//      localUri = R.image.incomingWebHook;
//    else if (value == "outgoing-webhook.png")
//      localUri = R.image.outgoingWebHook;
//    else if (value == "google-calendar.png") localUri = R.image.googleCalendar;
//    return localUri;
//  }

//  Future<String> resolveUrl() async {
//    final FileInfo cachedValue = await Injector.instance.fileCacheManager
//        .getFileFromCache(widget.imageUrl);
//    if (cachedValue != null)
//      return cachedValue.file.path;
//    else {
//      final fileUrlFromGoogleApi = await Injector.instance.fileCacheManager
//          .resolveGoogleApiUrl(widget.imageUrl);
//      final file = await Injector.instance.fileCacheManager
//          .getSingleFile(fileUrlFromGoogleApi);
//
//      final fileBytes = await file.readAsBytes();
//      final fileETag = file.path.split("/").last;
//      final fileExt = fileETag.split(".").last;
//      final filePutted = await Injector.instance.fileCacheManager.putFile(
//          widget.imageUrl, fileBytes,
//          eTag: fileETag, fileExtension: fileExt);
//      return filePutted.path;
//    }
//  }

// Widget _resolveImageContainer(String filePath) {
//   final mime = lookupMimeType(filePath) ?? "text/plain";
//   if (mime.startsWith("image"))
//     return Image.file(
//       File(filePath),
//       fit: BoxFit.cover,
//     );
//   else if (mime.startsWith("video")) {
//     return Image.asset(R.image.videoDefaultIcon);
//   } else if (mime.startsWith("audio")) {
//     return Image.asset(R.image.fileDefaultIcon);
//   } else {
//     return Image.asset(R.image.documentSmall);
//   }
// }

}
