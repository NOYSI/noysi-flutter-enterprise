import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/thread/thread_model.dart';

abstract class IThreadRepository {
  Future<Result<List<ThreadModel>>> getThreads();

  Future<Result<int>> getThreadsUnreadCount(String teamId);

  Future<Result<ThreadModel>> getThread(String teamId, String threadId);

  Future<Result<bool>> markAsRead(String teamId, String threadId);

  Future<Result<bool>> unFollow(String teamId, String threadId);

  Future<Result<bool>> follow(String teamId, String threadId);
}
