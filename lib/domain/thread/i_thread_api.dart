import 'package:code/domain/thread/thread_model.dart';

abstract class IThreadApi {
  Future<List<ThreadModel>> getThreads();

  Future<int> getThreadsUnreadCount(String teamId);

  Future<ThreadModel> getThread(String teamId, String threadId);

  Future<bool> markAsRead(String teamId, String threadId);

  Future<bool> unFollow(String teamId, String threadId);

  Future<bool> follow(String teamId, String threadId);
}
