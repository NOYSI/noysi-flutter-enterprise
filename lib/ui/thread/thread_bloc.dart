import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/thread/i_thread_repository.dart';
import 'package:code/domain/thread/thread_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class ThreadBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final IThreadRepository _iThreadRepository;
  final InMemoryData _inMemoryData;
  final SharedPreferencesManager _prefs;

  ThreadBloC(this._iThreadRepository, this._inMemoryData, this._prefs);

  @override
  void dispose() {
    _threadsController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<List<ThreadModel>> _threadsController = new BehaviorSubject();

  Stream<List<ThreadModel>> get threadsResult => _threadsController.stream;

  List<MemberModel> members = [];
  List<ChannelModel> channels = [];
  String currentTeamId = '';
  List<ThreadModel> threadsList = [];

  final maxToShow = 3;
  void loadThreads() async {
    members = _inMemoryData.getMembers();
    channels = _inMemoryData.getChannels();
    isLoading = true;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _iThreadRepository.getThreads();
    if (res is ResultSuccess<List<ThreadModel>>) {
      threadsList = res.value;
      res.value.sort((v1, v2) {
        {
          if(v1.tsLastReply != null && v2.tsLastReply != null) return v2.tsLastReply!.compareTo(v1.tsLastReply!);
          else if (v1.tsLastReply == null && v2.tsLastReply != null) return 1;
          else if (v1.tsLastReply != null && v2.tsLastReply == null) return -1;
          else return 0;
        }
      });
      res.value.forEach((element) {
        element.childMessages.sort((v1, v2) {
          if(v1.ts != null && v2.ts != null) return v2.ts!.compareTo(v1.ts!);
          else if (v1.ts == null && v2.ts != null) return 1;
          else if (v1.ts != null && v2.ts == null) return -1;
          else return 0;
        });
        List<MessageModel> selectedToShow = [];
        Iterator<MessageModel> traversal = element.childMessages.iterator;
        while(traversal.moveNext() && selectedToShow.length < maxToShow) {
          if(selectedToShow.isEmpty){
            selectedToShow.add(traversal.current);
          }else{
            selectedToShow.insert(0, traversal.current);
          }
        }
        element.childMessages = selectedToShow;
      });
      _threadsController.sinkAddSafe(res.value);
    }
    isLoading = false;
  }

  void onMessageArrived(MessageModel messageModel)async{
    final threads = _threadsController.valueOrNull;
    threads?.forEach((element) {
      if(messageModel.threadMetaChild != null){
        if(element.pmid == messageModel.threadMetaChild?.pmid){
          element.tsLastReply = DateTime.now();
          threads.sort((v1, v2) {
            if(v1.tsLastReply != null && v2.tsLastReply != null) return v2.tsLastReply!.compareTo(v1.tsLastReply!);
            else if (v1.tsLastReply == null && v2.tsLastReply != null) return 1;
            else if (v1.tsLastReply != null && v2.tsLastReply == null) return -1;
            else return 0;
          });
          if(element.childMessages.length == maxToShow) element.childMessages.removeAt(0);
          element.childMessages.add(messageModel);
          _threadsController.sinkAddSafe(threads);
          return;
        }
      }
    });
  }

  void removeThread(ThreadModel thread){
    List<ThreadModel> threads = _threadsController.valueOrNull ?? [];
    threads.remove(thread);
    _threadsController.sinkAddSafe(threads);
  }

  Future<bool> markAsRead(String threadId) async {
    final res = await _iThreadRepository.markAsRead(currentTeamId, threadId);
    if(res is ResultSuccess<bool> && res.value){
      return true;
    }
    return false;
  }

  Future<bool> unfollow(String threadId) async {
    isLoading = true;
    final res = await _iThreadRepository.unFollow(currentTeamId, threadId);
    isLoading = false;
    if(res is ResultSuccess<bool> && res.value){
      return true;
    }
    showErrorMessageFromString("Operation Error");
    return false;
  }
}
