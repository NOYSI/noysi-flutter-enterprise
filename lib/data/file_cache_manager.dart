import 'dart:io';

import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileCacheManager {
  static const key = "noysi_files";
  static const int maxNumberOfFiles = 1000;
  static const Duration cacheTimeout = Duration(days: 1);
  final NetworkHandler _networkHandler;

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: cacheTimeout,
      maxNrOfCacheObjects: maxNumberOfFiles,
      repo: JsonCacheInfoRepository(databaseName: key),
    ),
  );

  FileCacheManager(this._networkHandler);

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, key);
  }

  Future<String> resolveGoogleApiUrl(String baseUri) async {
    try {
      final res = await _networkHandler.get(path: baseUri);
      if (res.statusCode == RemoteConstants.code_success) {
        final uri = res.headers["location"];
        return uri![0];
      } else {
        return "";
      }
    } catch (ex) {
      print("URL image exception: $baseUri");
      return "";
    }
  }

  Future<String> resolveUrl(String imageUrl) async {
    final FileInfo? cachedValue = await instance.getFileFromCache(imageUrl);
    if (cachedValue != null)
      return cachedValue.file.path;
    else {
      final fileUrlFromGoogleApi = await resolveGoogleApiUrl(imageUrl);
      if(fileUrlFromGoogleApi.isNotEmpty) {
        File file = await instance.getSingleFile(fileUrlFromGoogleApi);
        String fileETag = file.path.split("/").last;
        String fileExt = fileETag.split(".").last.replaceAll('.', "");
        // if(fileExt.toLowerCase().contains("x-ms-")) {
        //   fileExt = fileExt.toLowerCase().split('-').last;
        //   fileETag = fileETag.split(".")[fileETag.split(".").length - 2] + ".$fileExt";
        // }
        if(fileExt.toLowerCase() == 'heic' && !imageUrl.endsWith("?original=true")) {
          final jpgPath = await HeicToJpg.convert(file.path);
          if(jpgPath?.isNotEmpty == true) {
            if(file.existsSync()) file.deleteSync();
            file = File(jpgPath!);
            fileETag = file.path.split("/").last;
            fileExt = fileETag.split(".").last.replaceAll('.', "");
          }
        }
        final fileBytes = await file.readAsBytes();
        final filePutted = await instance.putFile(imageUrl, fileBytes,
            eTag: fileETag, fileExtension: fileExt);
        if(file.existsSync()) file.deleteSync();
        return filePutted.path;
      }
      return "";
    }
  }

  Future<String> getCachedFile(String fileUrl) async {
    final FileInfo? cachedValue = await instance.getFileFromCache(fileUrl);
    if(cachedValue != null) return cachedValue.file.path;
    return '';
  }

  String resolveLocalUri(String imageUrl) {
    String localUri = R.image.logo;
    String value = imageUrl.split("/").isEmpty ? imageUrl.toLowerCase() : imageUrl.split("/").last.toLowerCase();
    if (value == "defaultavatar1.png")
      localUri = R.image.defAvatar1;
    else if (value == "defaultavatar2.png")
      localUri = R.image.defAvatar2;
    else if (value == "defaultavatar3.png")
      localUri = R.image.defAvatar3;
    else if (value == "defaultavatar4.png")
      localUri = R.image.defAvatar4;
    else if (value == "defaultavatar5.png")
      localUri = R.image.defAvatar5;
    else if (value == "defaultavatar6.png")
      localUri = R.image.defAvatar6;
    else if (value == "defaultavatar7.png")
      localUri = R.image.defAvatar7;
    else if (value == "defaultavatar8.png")
      localUri = R.image.defAvatar8;
    else if (value == "defaultavatar9.png")
      localUri = R.image.defAvatar9;
    else if (value == "defaultavatar10.png")
      localUri = R.image.defAvatar10;
    else if (value == "defaultavatar11.png")
      localUri = R.image.defAvatar11;
    else if (value == "defaultavatar12.png")
      localUri = R.image.defAvatar12;
    else if (value == "angular.png")
      localUri = R.image.angular;
    else if (value == "browsersync.png")
      localUri = R.image.browserSync;
    else if (value == "gulp.png")
      localUri = R.image.gulp;
    else if (value == "jasmine.png")
      localUri = R.image.jasmine;
    else if (value == "karma.png")
      localUri = R.image.karma;
    else if (value == "protractor.png")
      localUri = R.image.protractor;
    else if (value == "bootstrap.png")
      localUri = R.image.bootstrap;
    else if (value == "ui-bootstrap.png")
      localUri = R.image.uiBootstrap;
    else if (value == "node-sass.png")
      localUri = R.image.nodeSass;
    else if (value == "babel.png")
      localUri = R.image.babel;
    else if (value == "jade.png")
      localUri = R.image.jade;
    else if (value == "dropbox.png")
      localUri = R.image.dropbox;
    else if (value == "github.png")
      localUri = R.image.github;
    else if (value == "gdrive.png")
      localUri = R.image.gDrive;
    else if (value == "hangouts.png")
      localUri = R.image.hangouts;
    else if (value == "hubot.png")
      localUri = R.image.huBot;
    else if (value == "jira.png")
      localUri = R.image.jira;
    else if (value == "trello.png")
      localUri = R.image.trello;
    else if (value == "twitter.png")
      localUri = R.image.twitter;
    else if (value == "zendesk.png")
      localUri = R.image.zendesk;
    else if (value == "incoming-webhook.png")
      localUri = R.image.incomingWebHook;
    else if (value == "outgoing-webhook.png")
      localUri = R.image.outgoingWebHook;
    else if (value == "google-calendar.png") localUri = R.image.googleCalendar;
    return localUri;
  }
}
