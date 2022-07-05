import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/activity/activity_model.dart';
import 'package:code/domain/activity/i_activity_api.dart';
import 'package:code/domain/activity/i_activity_repository.dart';

class ActivityRepository extends BaseRepository implements IActivityRepository {
  final SharedPreferencesManager _prefs;
  final IActivityApi _activityApi;

  ActivityRepository(this._prefs, this._activityApi);

  @override
  Future<Result<ActivityWrapperModel>> getUserActivities(
      {int offset = 0,
      int limit = 50,
      ACTIVITY_TYPE? type,
      String order = "desc",
      DateTime? start,
      DateTime? end}) async {
    try {
      final tid = await _prefs.getStringValue(_prefs.currentTeamId);
      final uid = await _prefs.getStringValue(_prefs.userId);
      ActivityWrapperModel activities = await _activityApi.getUserActivities(
          tid, uid,
          offset: offset,
          type: type,
          limit: limit,
          order: order,
          start: start,
          end: end);
      return ResultSuccess(value: activities);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<SessionModel>>> getActiveSessions() async {
    try {
      final res = await _activityApi.getActiveSessions();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> closeSession(String deviceId) async {
    try {
      final res = await _activityApi.closeSession(deviceId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> closeMultiSessions(List<String> deviceIds) async {
    try {
      final res = await _activityApi.closeMultiSessions(deviceIds);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
