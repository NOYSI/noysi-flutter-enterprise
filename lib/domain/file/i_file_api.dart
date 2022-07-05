import 'dart:io';

import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IFileApi {
  Future<FileWrapperModel> getChannelFiles(String teamId, String channelId, String path,
      {int max = 50, int offset = 0, String sort = "desc"});

  Future<FolderModel> getFolderReference(String tid, String cid, String id);

  Future<FileModel> uploadChannelFile(String teamId, String channelId,
      File file, FileCreateModel fileCreateModel,
      {ProgressCallback? onProgress, ProgressCallback? onFinish, ValueChanged<CancelToken>? onCancelToken,
      String? pmid, bool showOnChannel = false});

  Future<File> downloadFile(FileModel fileModel);

  Future<bool> createFolder(
      String teamId, String channelId, FolderCreateModel folderCreateModel);

  Future<bool> renameFolder(
      String teamId, String channelId, String folderId, String newName);

  Future<bool> deleteFile(String teamId, String channelId, String fileId, {bool force = false});

  Future<bool> shareFile(
      String teamId,  String fromChannelId, String toChannelId, String fileId, String comment);
}
