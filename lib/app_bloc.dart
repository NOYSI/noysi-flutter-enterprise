import 'dart:io';

import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/extensions.dart';
import 'package:code/utils/file_manager.dart';
import 'package:code/utils/toast_util.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';

import 'domain/app_common_model.dart';

class AppBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final SharedPreferencesManager _prefs;
  final InMemoryData inMemoryData;
  final IFileRepository _iFileRepository;

  AppBloC(this._prefs, this.inMemoryData, this._iFileRepository);

  @override
  void dispose() {
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
    _showUploadingController.close();
    _uploadingController.close();
  }

  BehaviorSubject<bool> _showUploadingController = new BehaviorSubject();

  Stream<bool> get showUploadingResult => _showUploadingController.stream;

  BehaviorSubject<double> _uploadingController = new BehaviorSubject();

  Stream<double> get uploadingResult => _uploadingController.stream;

  Future<void> loadLang() async {
    String current = await _prefs.getStringValue(_prefs.language);
    if (current.isEmpty) {
      current = CommonUtils.getDefLang();
      await _prefs.setStringValue(_prefs.language, current);
    }
    languageCodeController.sinkAddSafe(
        AppSettingsModel(isDarkMode: false, languageCode: current));
  }

  // void setLang(String code, String script) {
  //   String langCode = code;
  //   if(code == "zh" && script == "Hans")
  //     langCode = "sc";
  //   else if(code == "zh" && script == "Hant")
  //     langCode = "tc";
  //   final res = languageCodeController.value;
  //   if (res != null) res.languageCode = langCode;
  //   languageCodeController.sinkAddSafe(
  //       res ?? AppSettingsModel(isDarkMode: false, languageCode: langCode));
  //   _prefs.setStringValue(_prefs.language, langCode);
  // }
  //
  // void sendMessage(String text) async {
  //   await _irtcManager.sendMessage(
  //     text,
  //   );
  // }

  CancelToken? cancelToken;

  void cancelTokenPost() async {
    cancelToken?.cancel();
    _uploadingController.sinkAddSafe(0);
    Future.delayed(Duration(milliseconds: 100), () {
      _showUploadingController.sinkAddSafe(false);
    });
  }

  void uploadFile(File file, {String? pmid, bool showOnChannel = false}) async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final currentChatId = await _prefs.getStringValue(_prefs.currentChatId);
    final fileName = file.path.split("/").last;
    final mime = FileManager.lookupMime(file.path);
    FileCreateModel fileCreateModel = FileCreateModel(
        type: 'file', size: file.lengthSync(), path: "/$fileName", mime: mime);
    _showUploadingController.sinkAddSafe(true);
    final res = await _iFileRepository
        .uploadChannelFile(currentTeamId, currentChatId, file, fileCreateModel,
            onCancelToken: (cancelTok) {
      cancelToken = cancelTok;
    }, onProgress: (count, total) {
      print("onProgress --- $count --- $total --- ${count / total}");
      _uploadingController.sinkAddSafe(count / total);
    }, onFinish: (count, total) {
      print("onFinish --- $count --- $total");
      _showUploadingController.sinkAddSafe(false);
    }, pmid: pmid, showOnChannel: showOnChannel);
    if (res is ResultSuccess<FileModel>) {
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(0);
      });
    } else if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_conflict) {
      ToastUtil.showToast(R.string.fileAlreadyShared,
          toastLength: Toast.LENGTH_LONG);
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(0);
      });
    } else {
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(0);
      });
      showErrorMessage(res);
    }
  }

  Future<bool> isLoggedIn() async {
    return (await _prefs.getStringValue(_prefs.accessToken)).isNotEmpty;
  }
}
