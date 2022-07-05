
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/_base_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/thread/i_thread_api.dart';
import 'package:code/domain/thread/i_thread_converter.dart';
import 'package:code/domain/thread/thread_model.dart';

class ThreadApi extends BaseApi implements IThreadApi {
  final NetworkHandler _networkHandler;
  final IThreadConverter _iThreadConverter;
  final SharedPreferencesManager _prefs;

  ThreadApi(this._networkHandler, this._iThreadConverter, this._prefs);

  @override
  Future<ThreadModel> getThread(String teamId, String threadId) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.threads}/$threadId");
    if (res.statusCode == RemoteConstants.code_success) {
      return _iThreadConverter.fromJson(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<List<ThreadModel>> getThreads() async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$currentTeamId${Endpoint.threads}");
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = res.data;
      return l.map((model) => _iThreadConverter.fromJson(model)).toList();
    }
    throw serverException(res);
  }

  @override
  Future<int> getThreadsUnreadCount(String teamId) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.threads}/unreadCount");
    if (res.statusCode == RemoteConstants.code_success) {
      return res.data["count"];
    }
    throw serverException(res);
  }

  @override
  Future<bool> follow(String teamId, String threadId) async {
    final res = await _networkHandler.put(
        path: "${Endpoint.teams}/$teamId${Endpoint.threads}/$threadId/follow");
    if (res.statusCode == RemoteConstants.code_success_accepted) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> unFollow(String teamId, String threadId) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.threads}/$threadId/unfollow");
    if (res.statusCode == RemoteConstants.code_success_accepted) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> markAsRead(String teamId, String threadId) async {
    final res = await _networkHandler.put(
        path:"${Endpoint.teams}/$teamId${Endpoint.threads}/$threadId/mark");
    if (res.statusCode == RemoteConstants.code_success_accepted) {
      return true;
    }
    throw serverException(res);
  }
}
