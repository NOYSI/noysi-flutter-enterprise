import 'package:code/data/api/remote/result.dart';
import 'activity_model.dart';

abstract class IActivityRepository {
  Future<Result<ActivityWrapperModel>> getUserActivities(
      {int offset,
      int limit,
      ACTIVITY_TYPE? type,
      String order,
      DateTime? start,
      DateTime? end});

  Future<Result<List<SessionModel>>> getActiveSessions();

  Future<Result<bool>> closeSession(String deviceId);

  Future<Result<bool>> closeMultiSessions(List<String> deviceIds);
}
