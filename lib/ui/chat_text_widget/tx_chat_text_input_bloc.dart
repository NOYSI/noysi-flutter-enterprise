import 'dart:async';
import 'dart:io';
import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/i_rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/chat_text_widget/chat_text_model_ui.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/toast_util.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../utils/file_manager.dart';

class TXChatTextInputBloC extends BaseBloC with ErrorHandlerBloC {
  final IFileRepository _iFileRepository;
  final InMemoryData inMemoryData;
  final SharedPreferencesManager _prefs;
  final IUserRepository _iUserRepository;
  final IRTCManager _irtcManager;

  TXChatTextInputBloC(this._iFileRepository, this.inMemoryData, this._prefs,
      this._iUserRepository, this._irtcManager);

  @override
  void dispose() {
    _uploadingController.close();
    _mentionsController.close();
    _showMentionsController.close();
    _showUploadingController.close();
    _showSendIconController.close();
    _recordingController.close();
    _recordingTimeController.close();
    recordInitializationCompleted?.close();
    textFieldFocusedController.close();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<bool> _showUploadingController = new BehaviorSubject();

  Stream<bool> get showUploadingResult => _showUploadingController.stream;

  BehaviorSubject<UploadProgress> _uploadingController = new BehaviorSubject();

  Stream<UploadProgress> get uploadingResult => _uploadingController.stream;

  BehaviorSubject<List<ChatTextMentionModel>> _mentionsController =
      new BehaviorSubject();

  Stream<List<ChatTextMentionModel>> get mentionsResult =>
      _mentionsController.stream;

  BehaviorSubject<bool> _showMentionsController =
      new BehaviorSubject.seeded(false);

  Stream<bool> get showMentionsResult => _showMentionsController.stream;

  BehaviorSubject<bool> _showSendIconController =
      new BehaviorSubject.seeded(false);

  Stream<bool> get showSendIconResult => _showSendIconController.stream;

  BehaviorSubject<bool> _recordingController = new BehaviorSubject();

  Stream<bool> get recordingResult => _recordingController.stream;

  BehaviorSubject<Duration?> _recordingTimeController = new BehaviorSubject();

  Stream<Duration?> get recordingTimeResult => _recordingTimeController.stream;

  final BehaviorSubject<bool> textFieldFocusedController = BehaviorSubject();

  String currentChatText = "";
  int cursorPosition = 0;
  String currentQuery = "";
  bool chatDisabled = false;

  bool userCanWrite({bool isReadOnly = false}) {
    final currentUser = inMemoryData.currentMember;
    if (currentUser?.userRol == UserRol.Admin) {
      return true;
    } else if (isReadOnly) {
      final currentChannel = inMemoryData.currentChannel;
      bool isOwner = currentUser?.id == currentChannel?.uid;
      return isOwner;
    }
    return true;
  }

  void showMentions(bool show) {
    if (show != (_showMentionsController.valueOrNull ?? false))
      _showMentionsController.sinkAddSafe(show);
    // if(!show)
    //   _mentionsController.sinkAddSafe([]);
  }

  bool sendIconIsShown = false;

  void showSendIcon(bool show) {
    if (show != (_showSendIconController.valueOrNull ?? false)) {
      _showSendIconController.sinkAddSafe(show);
      sendIconIsShown = show;
    }
  }

  CancelToken? cancelToken;

  void cancelTokenPost() async {
    cancelToken?.cancel();
    _uploadingController.sinkAddSafe(UploadProgress.empty());
    Future.delayed(Duration(milliseconds: 100), () {
      _showUploadingController.sinkAddSafe(false);
    });
  }

  Future<String> _getCurrentTeamId() async {
    return await _prefs.getStringValue(_prefs.currentTeamId);
  }

  Future<String> _getCurrentChatId() async {
    return await _prefs.getStringValue(_prefs.currentChatId);
  }

  Future<void> uploadFile(File file,
      {String? pmid, bool? showOnChannel}) async {
    final currentTeamId = await _getCurrentTeamId();
    final currentChatId = await _getCurrentChatId();
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
      _uploadingController
          .sinkAddSafe(UploadProgress.singleFile(progress: count / total));
    }, onFinish: (count, total) {
      print("onFinish --- $count --- $total");
      _showUploadingController.sinkAddSafe(false);
    }, pmid: pmid, showOnChannel: showOnChannel);
    if (res is ResultSuccess<FileModel>) {
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(UploadProgress.empty());
      });
    } else if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_conflict) {
      ToastUtil.showToast(R.string.fileAlreadyShared,
          toastLength: Toast.LENGTH_LONG);
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(UploadProgress.empty());
      });
    } else {
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(UploadProgress.empty());
      });
      showErrorMessage(res);
    }
  }

  Future uploadFiles(
    List<File> files, {
    String? pmid,
    bool? showOnChannel,
  }) async {
    if (files.isEmpty) return;

    final currentTeamId = await _getCurrentTeamId();
    final currentChatId = await _getCurrentChatId();

    for (int index = 0; index < files.length; index++) {
      File file = files[index];

      final fileName = file.path.split("/").last;
      final mime = lookupMimeType(file.path) ?? 'text/plain';

      FileCreateModel fileCreateModel = FileCreateModel(
        type: 'file',
        size: file.lengthSync(),
        path: "/$fileName",
        mime: mime,
      );

      _showUploadingController.sinkAddSafe(true);
      final res = await _iFileRepository.uploadChannelFile(
        currentTeamId,
        currentChatId,
        file,
        fileCreateModel,
        onCancelToken: (cancelTok) {
          cancelToken = cancelTok;
        },
        onProgress: (count, total) {
          final progress = _calcProgress(
            currentUploaded: count,
            currentSize: total,
            currentIndex: index,
            itemsCount: files.length,
          );
          print(
              "onProgress ($fileName) --- item: ${index + 1}/${files.length} --- $count --- $total --- total progress: $progress");
          _uploadingController.sinkAddSafe(UploadProgress.multiFile(
            progress: progress,
            totalItems: files.length,
            currentItem: index,
          ));
        },
        onFinish: (count, total) {
          print("onFinish ($fileName)");
        },
        pmid: pmid,
        showOnChannel: showOnChannel,
      );

      if (res is ResultSuccess<FileModel>) {
      } else if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_conflict) {
        ToastUtil.showToast(
          R.string.fileAlreadyShared,
          toastLength: Toast.LENGTH_LONG,
        );
      } else {
        showErrorMessage(res);
      }
    }
    //DONE
    _showUploadingController.sinkAddSafe(false);
    Future.delayed(Duration(milliseconds: 100), () {
      _uploadingController.sinkAddSafe(UploadProgress.empty());
    });
  }

  double _calcProgress({
    required int currentUploaded,
    required int currentSize,
    required int currentIndex,
    required int itemsCount,
  }) {
    final currentProgress = currentUploaded / currentSize;
    final double rangesPercent = 1 / itemsCount;
    final double currentRangePercent = currentIndex * rangesPercent;
    final double currentItemPercent = currentProgress * rangesPercent;
    final double totalFinal = currentItemPercent + currentRangePercent;

    return totalFinal;
  }

  Future<void> getTeamMembers(String query) async {
    List<ChatTextMentionModel> list = [];
    List<MemberModel> members = [];
    final currentChannel = inMemoryData.currentChannel;
    if (query.trim().isEmpty) {
      members = inMemoryData.getMembers(excludeMe: true, activeOnly: true);
      if (members.isNotEmpty) {
        members = members.length > 5
            ? members.sublist(0, 5)
            : members.sublist(0, members.length);
      }
    } else {
      final currentTeamId = inMemoryData.currentTeam!.id;
      final res = await _iUserRepository.getTeamMembers(currentTeamId,
          query: query, action: "search", max: 5);
      if (res is ResultSuccess<MemberWrapperModel>) {
        members = res.value.list;
      } else {
        showErrorMessageFromString(R.string.errorFetchingData);
      }
    }

    members.forEach((element) {
      list.add(ChatTextMentionModel(
          url: CommonUtils.getMemberPhoto(element),
          displayName: CommonUtils.getMemberUsername(element) ?? "",
          userPresence: element.userPresence,
          isMember: true,
          isActive: element.active && !element.isDeletedUser));
    });

    list.sort((c1, c2) => c1.displayName
        .trim()
        .toLowerCase()
        .compareTo(c2.displayName.trim().toLowerCase()));

    if ((currentChannel!.isOpenChannel || currentChannel.isPrivateGroup) &&
        !(currentChannel.general ?? false)) {
      if (inMemoryData.currentTeam!.channelMentionProtected! &&
          (inMemoryData.currentMember!.userRol == UserRol.Admin ||
              inMemoryData.currentMember!.id ==
                  inMemoryData.currentChannel!.uid)) {
        list.add(ChatTextMentionModel.getChannelMention());
      } else if (!inMemoryData.currentTeam!.channelMentionProtected!) {
        list.add(ChatTextMentionModel.getChannelMention());
      }
    }

    if (currentChannel.general == true) {
      if (inMemoryData.currentTeam!.allMentionProtected! &&
          inMemoryData.currentMember!.userRol == UserRol.Admin) {
        list.add(ChatTextMentionModel.getAllMention());
      } else if (!inMemoryData.currentTeam!.allMentionProtected!) {
        list.add(ChatTextMentionModel.getAllMention());
      }
    }
    _mentionsController.sinkAddSafe(list);
  }

  AnotherAudioRecorder? recorder;
  Timer? recordTimer;

  Future<Recording?> recorderStatus() async {
    return await recorder?.current();
  }

  void onTapForRecord() async {
    final isUndeterminedMic = await Permission.microphone.isDenied;
    final isUndeterminedStorage = await Permission.storage.isDenied;
    if (isUndeterminedMic || isUndeterminedStorage) {
      if (isUndeterminedMic) Permission.microphone.request();
      if (isUndeterminedStorage) Permission.storage.request();
    } else if (await Permission.microphone.request().isGranted &&
        await Permission.storage.request().isGranted) {
      final audioCache = AudioCache(respectSilence: true);
      audioCache.play(R.sound.startRecording,
          mode: Platform.isAndroid
              ? PlayerMode.MEDIA_PLAYER
              : PlayerMode.LOW_LATENCY);
      if ((await Vibration.hasVibrator()) == true &&
          (await Vibration.hasCustomVibrationsSupport()) == true) {
        Vibration.vibrate(
            pattern: [0, 25, 15, 25],
            intensities: Platform.isAndroid ? [0, 100, 0, 200] : [100, 200]);
      }
      ToastUtil.showToast(R.string.keepPressingToRecord,
          backgroundColor: R.color.primaryColor,
          toastLength: Toast.LENGTH_LONG);
    } else {
      openAppSettings();
    }
  }

  bool processStarts = false;

  void playRecordingSound() async {
    processStarts = true;
    recordInitializationCompleted = BehaviorSubject();
    final isUndeterminedMic = await Permission.microphone.isDenied;
    final isUndeterminedStorage = await Permission.storage.isDenied;
    if (isUndeterminedMic || isUndeterminedStorage) {
      Future.delayed(Duration(milliseconds: 500), () {
        recordInitializationSubscription?.cancel();
      });
      if (isUndeterminedMic) Permission.microphone.request();
      if (isUndeterminedStorage) Permission.storage.request();
    } else if (await Permission.microphone.isGranted &&
        await Permission.storage.isGranted) {
      final audioCache = AudioCache(respectSilence: true);
      final player = await audioCache.play(R.sound.startRecording,
          mode: Platform.isAndroid
              ? PlayerMode.MEDIA_PLAYER
              : PlayerMode.LOW_LATENCY);
      StreamSubscription? audioCompleted;
      audioCompleted = player.onPlayerStateChanged.listen((event) async {
        if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
          canVibrate = (await Vibration.hasVibrator()) == true &&
              (await Vibration.hasCustomVibrationsSupport()) == true;
          if (canVibrate) {
            Vibration.vibrate(pattern: [
              0,
              25,
              15,
              25
            ], intensities: Platform.isAndroid ? [0, 100, 0, 200] : [100, 200]);
          }
          _startRecording();
        }
        audioCompleted?.cancel();
      });
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        recordInitializationSubscription?.cancel();
      });
      openAppSettings();
    }
  }

  bool canVibrate = false;
  BehaviorSubject<bool?>? recordInitializationCompleted;
  StreamSubscription? recordInitializationSubscription;

  void _startRecording() async {
    _recordingController.sinkAddSafe(true);
    final path = (await Injector.instance.fileCacheManager.getFilePath()) +
        "/record_${DateTime.now()}.aac".replaceAll(' ', '_');
    recorder = AnotherAudioRecorder(path, audioFormat: AudioFormat.AAC);
    await recorder?.initialized;
    await recorder?.start();
    int count = 1;
    if (recordTimer != null) recordTimer?.cancel();
    recordTimer = Timer.periodic(Duration(seconds: 1), (time) async {
      _recordingTimeController.sinkAddSafe(Duration(seconds: count++));
    });
    recordInitializationCompleted?.sinkAddSafe(true);
  }

  void stopRecording(bool? showOnChannel, String? pmid,
      {canceled = false}) async {
    if (processStarts) {
      processStarts = false;
      recordInitializationSubscription =
          recordInitializationCompleted?.listen((value) async {
        if (value ?? false) {
          _recordingController.sinkAddSafe(false);
          if ((await recorderStatus())?.status == RecordingStatus.Recording) {
            recordTimer?.cancel();
            _recordingTimeController.sinkAddSafe(null);
            final result = await recorder?.stop();
            final audioCache = AudioCache(respectSilence: true);
            audioCache.play(R.sound.stopRecording,
                mode: Platform.isAndroid
                    ? PlayerMode.MEDIA_PLAYER
                    : PlayerMode.LOW_LATENCY);
            if (canVibrate) {
              Vibration.vibrate(
                  pattern: [0, 25, 35, 25],
                  intensities:
                      Platform.isAndroid ? [0, 100, 0, 200] : [100, 200]);
            }
            if (!canceled) {
              if (((await recorderStatus())?.duration?.inMilliseconds ?? 0) >=
                  500) {
                final file = File(result?.path ?? "");
                if (file.existsSync()) {
                  await uploadFile(file,
                      showOnChannel: showOnChannel, pmid: pmid);
                  Future.delayed(Duration(milliseconds: 100), () {
                    file.deleteSync();
                  });
                }
              } else {
                ToastUtil.showToast(R.string.keepPressingToRecord,
                    backgroundColor: R.color.primaryColor);
                File(result?.path ?? "").deleteSync();
              }
            } else {
              final file = File(result?.path ?? "");
              if (file.existsSync()) {
                file.deleteSync();
              }
            }
          }
        }
        recordInitializationSubscription?.cancel();
      });
    }
  }

  void sendUserTyping() {
    _irtcManager.sendWssTyping();
  }
}

class UploadProgress {
  final double progress;
  final int totalItems;
  final int currentItem;

  UploadProgress.multiFile({
    required this.progress,
    required this.totalItems,
    required this.currentItem,
  });

  UploadProgress.singleFile({required this.progress})
      : totalItems = 1,
        currentItem = 0;

  UploadProgress.empty()
      : progress = 0,
        totalItems = 0,
        currentItem = 0;

  String getDescription() {
    if (totalItems <= 1) return "";
    return "${currentItem + 1}/$totalItems";
  }
}
