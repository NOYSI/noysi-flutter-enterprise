
import 'dart:io';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';

import '../../_res/R.dart';
import '../../data/api/remote/result.dart';
import '../chat_text_widget/tx_chat_text_input_bloc.dart';

class TXEditFieldBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final ITaskRepository _iTaskRepository;

  TXEditFieldBloC(this._iTaskRepository);

  final BehaviorSubject<bool> _showUploadingController = BehaviorSubject();
  Stream<bool> get showUploadingResult => _showUploadingController.stream;

  final BehaviorSubject<UploadProgress> _uploadingController = BehaviorSubject();
  Stream<UploadProgress> get uploadingResult => _uploadingController.stream;

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _showUploadingController.close();
    _uploadingController.close();
  }

  Future<String?> attachFile(File file) async {
    cancelToken = CancelToken();
    _showUploadingController.sinkAddSafe(true);
    final res = await _iTaskRepository.attachFile(file, cancelToken: cancelToken, onProgress: (count, total) {
      final progress = count / total;
      if (kDebugMode) {
        print("progress -> ${progress * 100}%");
      }
      _uploadingController.sinkAddSafe(UploadProgress.singleFile(
        progress: progress,
      ));
    });
    _showUploadingController.sinkAddSafe(false);
    Future.delayed(const Duration(milliseconds: 100), () {
      _uploadingController.sinkAddSafe(UploadProgress.empty());
    });
    if (res is ResultSuccess<String>) {
      String fileName = file.path.split("/").last;
      String fileFormatted = "![$fileName](${res.value})";
      return fileFormatted;
    } else {
      showErrorMessageFromString(R.string.errorFetchingData);
    }
    return null;
  }

  CancelToken? cancelToken;

  void cancelTokenPost() async {
    cancelToken?.cancel();
    _uploadingController.sinkAddSafe(UploadProgress.empty());
    Future.delayed(const Duration(milliseconds: 100), () {
      _showUploadingController.sinkAddSafe(false);
    });
  }

}