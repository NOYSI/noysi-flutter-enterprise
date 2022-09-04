import 'dart:io';

import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_api.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/utils/toast_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class FileRepository extends BaseRepository implements IFileRepository {
  final IFileApi _iFileApi;

  FileRepository(this._iFileApi);

  @override
  Future<Result<FileWrapperModel>> getChannelFiles(String teamId, String channelId, String path,
      {int max = 50, int offset = 0, String sort = "desc"}) async {
    try {
      final res = await _iFileApi.getChannelFiles(teamId, channelId, path, max: max, offset: offset, sort: sort);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<FolderModel>> getFolderReference(String tid, String cid, String id) async {
    try {
      final res = await _iFileApi.getFolderReference(tid, cid, id);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<FileModel>> uploadChannelFile(String teamId, String channelId,
      File file, FileCreateModel fileCreateModel,
      {ProgressCallback? onProgress, ProgressCallback? onFinish, ValueChanged<CancelToken>? onCancelToken,
        String? pmid,
        bool? showOnChannel = false}) async {
    try {
      final res = await _iFileApi.uploadChannelFile(
          teamId, channelId, file, fileCreateModel,
          onProgress: onProgress, onFinish: onFinish, onCancelToken: onCancelToken, pmid: pmid, showOnChannel: showOnChannel ?? false);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> createFolder(String teamId, String channelId,
      FolderCreateModel folderCreateModel) async {
    try {
      final res =
          await _iFileApi.createFolder(teamId, channelId, folderCreateModel);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> deleteFile(
      String teamId, String channelId, String fileId, {bool force = false}) async {
    try {
      final res = await _iFileApi.deleteFile(teamId, channelId, fileId, force: force);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> renameFolder(
      String teamId, String channelId, String fileId, String newName) async {
    try {
      final res =
          await _iFileApi.renameFolder(teamId, channelId, fileId, newName);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> shareFile(
      String teamId,  String fromChannelId, String toChannelId, String fileId, String comment) async {
    try {
      final res = await _iFileApi.shareFile(teamId, fromChannelId, toChannelId, fileId, comment);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<File>> downloadFile(FileModel fileModel) async {
    try {
      if(await Permission.storage.request().isGranted){
        final res = await _iFileApi.downloadFile(fileModel);
        return ResultSuccess(value: res);
      }else if(await Permission.storage.isPermanentlyDenied){
        ToastUtil.showToast(R.string.permissionDenied);
      }
      return Result.error(code: 401, error: null);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
