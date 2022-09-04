import 'dart:io';

import 'package:android_external_storage/android_external_storage.dart';
import 'package:code/_res/R.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<File?> getImageFromSource(
      {ImageSource? source,
      bool lookForVideo = false,
      bool allFiles = false,
      ValueChanged<int>? onFileLoading}) async {
    try {
      final picker = ImagePicker();
      XFile? pickedFile;

      if (lookForVideo && source != null) {
        pickedFile = await picker.pickVideo(source: source);
        if (pickedFile != null && pickedFile.path.isNotEmpty == true)
          return File(pickedFile.path);
      } else {
        if (allFiles) {
          final FilePickerResult? file =
              await FilePicker.platform.pickFiles(onFileLoading: (status) {
            if (onFileLoading != null)
              onFileLoading(status == FilePickerStatus.picking ? 0 : 1);
          });
          if (file != null) return File(file.files.single.path!);
        } else if (source != null) {
          pickedFile = await picker.pickImage(source: source);
          if (pickedFile != null && pickedFile.path.isNotEmpty == true)
            return File(pickedFile.path);
        }
      }
      return null;
    } catch (ex) {
      if (ex is PlatformException) {
        if (ex.code == "photo_access_denied" ||
            ex.code == "camera_access_denied") {
          throw ex;
        }
      }
      return null;
    }
  }

  // static Future<bool> deleteFile(String filePath) async {
  //   try {
  //     String rootDir = await getRootFilesDirPath();
  //     File f = File(filePath);
  //     if (f.existsSync()) f.deleteSync();
  //     return true;
  //   } catch (ex) {
  //     return false;
  //   }
  // }

  static double convertBytesToGigabytes(int bytes) {
    return (bytes / 1024 / 1024 / 1024).toDouble();
  }

  static String? _localMimes(String filePath) {
    final ext = filePath.split('.').last.toLowerCase();
    if (ext == "heic") return 'image/heic';
    return null;
  }

  static String lookupMime(String filePath) => lookupMimeType(filePath) ?? (_localMimes(filePath) ?? "text/plain");

  static Widget getFileWidgetByMimeType(String filePath,
      {BoxFit boxFit: BoxFit.cover, double width = 10, double height = 10}) {
    final mime = lookupMime(filePath);
    if (mime.startsWith("image") &&
        (mime.endsWith("jpeg") ||
            mime.endsWith("jpg") ||
            mime.endsWith("png") ||
            mime.endsWith("gif")))
      return Image.file(
        File(filePath),
        fit: boxFit,
        width: width,
        height: height,
      );
    else if (mime.startsWith("video") || mime.startsWith("audio")) {
      return Image.asset(
        R.image.videoDefaultIcon,
        fit: boxFit,
      );
    } else if (mime.startsWith("image")) {
      return Image.asset(R.image.imageDefaultIcon, fit: boxFit);
    } else if (mime.startsWith("application") &&
        (mime.endsWith("x-bzip") ||
            mime.endsWith("x-bzip2") ||
            mime.endsWith("epub+zip") ||
            mime.endsWith("gzip") ||
            mime.endsWith("zip") ||
            mime.endsWith("x-7z-compressed"))) {
      return Image.asset(R.image.zipDefaultIcon, fit: boxFit);
    } else {
      return Image.asset(R.image.document, fit: boxFit);
    }
  }

  static Future<String> getRootFilesDirPath() async {
    try {
      Directory? appDocDir = await getRootFilesDirectory();
      return appDocDir != null ? appDocDir.path : '';
    } catch (ex) {
      return '';
    }
  }

  static Future<Directory?> getRootFilesDirectory() async {
    Directory? appDocDir = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getExternalStorageDirectory();
    return appDocDir;
  }

  static Future<String?> getDownloadPath() async {
    try {
      return Platform.isIOS
          ? (await getApplicationDocumentsDirectory()).path
          : await _getDownloadDirAndroid();
    } catch (ex) {
      return '';
    }
  }

  static Future<String?> _getDownloadDirAndroid() async {
    return await AndroidExternalStorage.getExternalStoragePublicDirectory(
        DirType.downloadDirectory);
  }

  static Future<String?> getVideoDirAndroid() async {
    return await AndroidExternalStorage.getExternalStoragePublicDirectory(
        DirType.moviesDirectory);
  }

  static Future<String?> getImageDirAndroid() async {
    return await AndroidExternalStorage.getExternalStoragePublicDirectory(
        DirType.picturesDirectory);
  }

  static Future<String?> getMusicDirAndroid() async {
    return await AndroidExternalStorage.getExternalStoragePublicDirectory(
        DirType.musicDirectory);
  }

  // static Future<void> createImageCacheFolder() async {
  //   final rootPath = await getRootFilesDirectory();
  //   final cacheFolder = rootPath
  //       .listSync()
  //       .firstWhere((element) => element.path.endsWith("image_cache_folder"), orElse: (){return null;});
  //   if (cacheFolder == null || !cacheFolder.existsSync()) {
  //     final folder = Directory("${rootPath.path}/image_cache_folder/");
  //     folder.createSync();
  //   }
  // }

  static Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker().retrieveLostData();
    if (response.file != null) {
//      setState(() {
//        if (response.type == RetrieveType.video) {
//          _handleVideo(response.file);
//        } else {
//          _handleImage(response.file);
//        }
//      });
    } else {
//      _handleError(response.exception);
    }
  }

//   static void _showPermissionRequired(BuildContext context, String content) {
//    showCupertinoDialog<String>(
//      context: context,
//      builder: (BuildContext context) => TXCupertinoDialogWidget(
//        title: R.string.deniedPermissionTitle,
//        content: content,
//        onOK: () {
//          Navigator.pop(context, R.string.logout);
//          openAppSettings();
//        },
//        onCancel: () {
//          Navigator.pop(context, R.string.cancel);
//        },
//      ),
//    );
// }

  static Future<File> getLocalFileFromAsset(
      String fileName, String assetPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File('$tempPath/$fileName');
    ByteData bd = await rootBundle.load('$assetPath/$fileName');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return tempFile;
  }

//  static _showWarningDialog(
//    BuildContext context, {
//    String title,
//    String content,
//    ValueChanged<bool> okAction,
//  }) {
//    return showBlurDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            backgroundColor: R.color.dialog_background,
//            title: TXTextWidget(
//              text: title,
//              maxLines: 2,
//              textAlign: TextAlign.start,
//              fontWeight: FontWeight.bold,
//            ),
//            content: TXTextWidget(
//              text: content,
//              textAlign: TextAlign.start,
//              color: R.color.gray_dark,
//              textOverflow: TextOverflow.visible,
//            ),
//            actions: <Widget>[
//              FlatButton(
//                child: TXTextWidget(
//                  text: "OK",
//                  fontWeight: FontWeight.bold,
//                  color: R.color.primary_color,
//                ),
//                onPressed: () {
//                  okAction(true);
//                  Navigator.of(context).pop();
//                },
//              ),
//              FlatButton(
//                child: TXTextWidget(
//                  text: R.string.cancel,
//                  fontWeight: FontWeight.bold,
//                  color: Colors.red,
//                ),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              )
//            ],
//          );
//        });
//  }

  static Future<List<File>> getMultiFiles({required Types type}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: type._getFileType(),
    );

    List<File> files = result?.paths
            .where((path) => path != null && path.isNotEmpty)
            .map((path) => File(path!))
            .toList() ??
        [];

    return files;
  }
}

enum Types { documents, images, video }

extension TypesMapper on Types {
  FileType _getFileType() {
    switch (this) {
      case Types.documents:
        return FileType.any;
      case Types.images:
        return FileType.image;
      case Types.video:
        return FileType.video;
    }
  }
}
