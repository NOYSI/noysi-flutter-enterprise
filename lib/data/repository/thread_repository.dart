import 'package:code/data/api/remote/result.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/thread/i_thread_api.dart';
import 'package:code/domain/thread/i_thread_repository.dart';
import 'package:code/domain/thread/thread_model.dart';

class ThreadRepository extends BaseRepository implements IThreadRepository {
  final IThreadApi _iThreadApi;

  ThreadRepository(this._iThreadApi);

  @override
  Future<Result<bool>> follow(String teamId, String threadId) async {
    try {
      final res = await _iThreadApi.follow(teamId, threadId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<ThreadModel>> getThread(String teamId, String threadId) async {
    try {
      final res = await _iThreadApi.getThread(teamId, threadId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<ThreadModel>>> getThreads() async {
    try {
      final res = await _iThreadApi.getThreads();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> getThreadsUnreadCount(String teamId) async {
    try {
      final res = await _iThreadApi.getThreadsUnreadCount(teamId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> unFollow(String teamId, String threadId) async {
    try {
      final res = await _iThreadApi.unFollow(teamId, threadId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> markAsRead(String teamId, String threadId) async {
    try {
      final res = await _iThreadApi.markAsRead(teamId, threadId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
