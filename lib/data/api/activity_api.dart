import 'dart:convert';

import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/activity/activity_model.dart';
import 'package:code/domain/activity/i_activity_api.dart';
import 'package:code/domain/activity/i_activity_converter.dart';
import 'package:code/data/api/_base_api.dart';

class ActivityApi extends BaseApi implements IActivityApi {
  final NetworkHandler _networkHandler;
  final IActivityConverter _iActivityConverter;

  ActivityApi(this._networkHandler, this._iActivityConverter);

  @override
  Future<ActivityWrapperModel> getUserActivities(String tid, String uid,
      {int offset = 0,
      int limit = 50,
      ACTIVITY_TYPE? type,
      String order = "desc",
      DateTime? start,
      DateTime? end}) async {
    String dateRange = start != null && end != null
        ? "&start=${start.toUtc().millisecondsSinceEpoch}&end=${end.toUtc().millisecondsSinceEpoch}"
        : "";
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$tid${Endpoint.activities}/$uid?offset=$offset&limit=$limit${type != null ? "&type=${type.toString().split('.').last}" : ""}&order=$order$dateRange");
    if (res.statusCode == RemoteConstants.code_success) {
      return _iActivityConverter.fromJsonWrapperModel(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<List<SessionModel>> getActiveSessions() async {
    final res = await _networkHandler.get(
        path: "${Endpoint.sessions}", useApiVersion: false);
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = res.data["list"];
      return l.map((e) => _iActivityConverter.fromJsonSessionModel(e)).toList();
    }
    throw serverException(res);
  }

  @override
  Future<bool> closeSession(String deviceId) async {
    final res = await _networkHandler.post(
        path: "${Endpoint.logout}/$deviceId", useApiVersion: false);
    if (res.statusCode == RemoteConstants.code_success) return true;
    throw serverException(res);
  }

  @override
  Future<bool> closeMultiSessions(List<String> deviceIds) async {
    final body = jsonEncode({"uuids": deviceIds});
    final res = await _networkHandler.post(
        path: "${Endpoint.logoutSessions}", body: body, useApiVersion: false);
    if (res.statusCode == RemoteConstants.code_success) return true;
    throw serverException(res);
  }
}
