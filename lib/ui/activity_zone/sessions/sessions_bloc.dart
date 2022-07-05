import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/activity/activity_model.dart';
import 'package:code/domain/activity/i_activity_repository.dart';
import 'dart:io';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/utils/extensions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:rxdart/rxdart.dart';

class SessionsBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  IActivityRepository _iActivityRepository;

  SessionsBloC(this._iActivityRepository);

  @override
  void dispose() {
    _sessionsController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<List<SessionModel>> _sessionsController = BehaviorSubject();

  Stream<List<SessionModel>> get sessionsResult => _sessionsController.stream;

  String? deviceId;

  void loadSessions() async {
    isLoading = true;
    late AndroidDeviceInfo androidInfo;
    late IosDeviceInfo iosInfo;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid)
      androidInfo = await deviceInfo.androidInfo;
    else
      iosInfo = await deviceInfo.iosInfo;
    deviceId = Platform.isIOS ? iosInfo.identifierForVendor : androidInfo.androidId;
    final res = await _iActivityRepository.getActiveSessions();
    if(res is ResultSuccess<List<SessionModel>>) {
      _sessionsController.sinkAddSafe(res.value);
    }
    isLoading = false;
  }

  void closeSession(SessionModel session) async {
    await _iActivityRepository.closeSession(session.id);
  }

  void closeAllExceptMine() async {
    final currentSessions = _sessionsController.valueOrNull;
    final toClose = currentSessions?.where((element) => !element.current).map((e) => e.id).toList();
    if(toClose != null)
     await _iActivityRepository.closeMultiSessions(toClose);
  }

  void onSessionClosed(String id) {
    final sessions = _sessionsController.valueOrNull;
    if(sessions != null) {
      sessions.removeWhere((element) => element.id == id);
      _sessionsController.sinkAddSafe(sessions);
    }
  }

  void onSessionOpen(SessionModel session) {
    final sessions = _sessionsController.valueOrNull;
    if(sessions != null) {
      sessions.add(session);
      _sessionsController.sinkAddSafe(sessions);
    }
  }
}
