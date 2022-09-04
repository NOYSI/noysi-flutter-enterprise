import 'dart:convert';
import 'dart:io';

import 'package:code/rtc/i_rtc_manager.dart';
import 'package:code/data/api/_base_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_api.dart';
import 'package:code/domain/file/i_file_converter.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FileApi extends BaseApi implements IFileApi {
  final NetworkHandler _networkHandler;
  final IFileConverter _iFileConverter;
  final IRTCManager _irtcManager;

  FileApi(this._networkHandler, this._iFileConverter, this._irtcManager);

  @override
  Future<FileWrapperModel> getChannelFiles(
      String teamId, String channelId, String path,
      {int max = 50, int offset = 0, String sort = "desc"}) async {
    path = path.endsWith("/") ? path : "$path/";
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/files?max=$max&offset=$offset&path=${Uri.encodeFull(path)}&sort=ts:$sort");
    if (res.statusCode == RemoteConstants.code_success) {
      return _iFileConverter.fromJsonFileWrapper(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<FolderModel> getFolderReference(String tid, String cid, String id) async {
    final res = await _networkHandler.get(
        path:
        "${Endpoint.teams}/$tid${Endpoint.channels}/$cid${Endpoint.files}/$id");
    if (res.statusCode == RemoteConstants.code_success) {
      final folder = _iFileConverter.fromJsonFolder(res.data);
      return folder;
    }
    throw serverException(res);
  }

  @override
  Future<FileModel> uploadChannelFile(String teamId, String channelId,
      File file, FileCreateModel fileCreateModel,
      {ProgressCallback? onProgress,
        ProgressCallback? onFinish,
        ValueChanged<CancelToken>? onCancelToken,
      String? pmid,
      bool showOnChannel = false}) async {
//    Map<int, int> progress = {};
//    if(onProgress != null){
//      progress[]
//      onProgress(Map().addAll({}));
//    }
    FileModel fileModel;
    final body = _iFileConverter.toJsonFileCreate(fileCreateModel);
    final headers = {
      "Content-Type": "application/json",
      "Content-Length": fileCreateModel.size
    };
    CancelToken cancelToken = CancelToken();
    if (onCancelToken != null) onCancelToken(cancelToken);
    final res = await _networkHandler.post(
        path: "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/files",
        body: jsonEncode(body),
        cancelToken: cancelToken,
        additionHeaders: headers);
    if (res.statusCode == RemoteConstants.code_success) {
      fileModel = _iFileConverter.fromJson(res.data);
      final uploadRes = await _networkHandler.postFile(
          path: fileModel.url ?? "",
          file: file,
          fileCreateModel: fileCreateModel,
          onSendProgress: onProgress,
          onReceiveProgress: onFinish,
          cancelToken: cancelToken);
      if (uploadRes.statusCode == RemoteConstants.code_success) {
        FileCreateConfirmModel fileCreateConfirmModel = FileCreateConfirmModel(
            path: fileModel.path,
            size: fileModel.size,
            title: file.path.split("/").last,
            mime: fileModel.mimeType,
            provider: Endpoint.apiBaseUrlProd,
            pmid: pmid,
            showOnChannel: showOnChannel);
        final bodyPut = _iFileConverter.toJsonFileCreateConfirm(fileCreateConfirmModel);
        final resPut = await _networkHandler.put(
            path:
                "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/files/${fileModel.ref}",
            body: jsonEncode(bodyPut), cancelToken: cancelToken);
        if (resPut.statusCode == RemoteConstants.code_success_no_content)
          return fileModel;
      }
    }

    throw serverException(res);
  }

  @override
  Future<bool> createFolder(String teamId, String channelId,
      FolderCreateModel folderCreateModel) async {
    final body = _iFileConverter.toJsonFolderCreate(folderCreateModel);
    final res = await _networkHandler.post(
        path: "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/files",
        body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success_no_content) return true;
    throw serverException(res);
  }

  @override
  Future<bool> renameFolder(
      String teamId, String channelId, String folderId, String newName) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/files/$folderId/rename",
        body: jsonEncode({"to": newName}));

    if (res.statusCode == RemoteConstants.code_success_no_content) return true;
    throw serverException(res);
  }

  @override
  Future<bool> deleteFile(
      String teamId, String channelId, String fileId, {bool force = false}) async {
    final res = await _networkHandler.delete(
      path:
          "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/files/$fileId${force ? "?force=true" : ""}",
    );
    if (res.statusCode == RemoteConstants.code_success_no_content) return true;
    throw serverException(res);
  }

  @override
  Future<bool> shareFile(
      String teamId,  String fromChannelId, String toChannelId, String fileId, String comment) async {
    final body = jsonEncode({"comment": comment, "cid": toChannelId});
    final res = await _networkHandler.post(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$fromChannelId/files/$fileId/share",
        body: body);
    if (res.statusCode == RemoteConstants.code_success_no_content) return true;
    throw serverException(res);
  }

  @override
  Future<File> downloadFile(FileModel fileModel) async {
    final res = await _networkHandler.get(
      path: fileModel.mimeType.startsWith('image')
          ? (fileModel.url ?? "") + "?original=true"
          : (fileModel.url ?? ""),
    );
    final googleUrl = res.headers["location"]![0];
    final fileRes =
        await _networkHandler.downloadFile(googleUrl, fileModel.name ?? "", fileModel.mimeType);
    if (fileRes is File) {
      _irtcManager.sendWssFileFolderDownloaded(fileModel.id ?? "");
      return fileRes;
    }
    throw serverException(res);
  }
}
