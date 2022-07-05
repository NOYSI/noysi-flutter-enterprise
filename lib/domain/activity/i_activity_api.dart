import 'package:code/domain/activity/activity_model.dart';

abstract class IActivityApi {
  Future<ActivityWrapperModel> getUserActivities(String tid, String uid,
      {int offset,
      int limit,
      ACTIVITY_TYPE? type,
      String order,
      DateTime? start,
      DateTime? end});

  Future<List<SessionModel>> getActiveSessions();

  Future<bool> closeSession(String deviceId);

  Future<bool> closeMultiSessions(List<String> deviceIds);
}
