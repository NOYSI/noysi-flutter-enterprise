import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TaskMilestoneBloc extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;

  TaskMilestoneBloc(this._iTaskRepository, this._prefs);

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _taskMilestonesOpenController.close();
    _taskMilestonesClosedController.close();
    _pageTabController.close();
  }

  BehaviorSubject<List<TaskMileStoneModel>> _taskMilestonesOpenController =
      new BehaviorSubject();

  Stream<List<TaskMileStoneModel>> get taskMilestonesOpenResult =>
      _taskMilestonesOpenController.stream;

  BehaviorSubject<List<TaskMileStoneModel>> _taskMilestonesClosedController =
  new BehaviorSubject();

  Stream<List<TaskMileStoneModel>> get taskMilestonesClosedResult =>
      _taskMilestonesClosedController.stream;

  BehaviorSubject<int> _pageTabController = new BehaviorSubject();

  Stream<int> get pageTabResult => _pageTabController.stream;

  String currentTeamId = "";
  String currentChannelId = "";

  void loadInitialData(String channelId)async{
    currentChannelId = channelId;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    _pageTabController.sinkAddSafe(1);
    loadOpened();
    loadClosed();
  }
  void loadOpened() async {
    isLoading = true;
    final res = await _iTaskRepository.getMilestones(
        currentTeamId, currentChannelId,
        max: 100, offset: 0, query: "", status: "open");
    if (res is ResultSuccess<List<TaskMileStoneModel>>) {
      _taskMilestonesOpenController.sinkAddSafe(res.value);

    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void loadClosed()async{
    isLoading = true;
    final res = await _iTaskRepository.getMilestones(
        currentTeamId, currentChannelId,
        max: 100, offset: 0, query: "", status: "closed");
    if (res is ResultSuccess<List<TaskMileStoneModel>>) {
      _taskMilestonesClosedController.sinkAddSafe(res.value);

    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void changePageTab(int tab) async {
    _pageTabController.sinkAddSafe(tab);
    if (tab == 2 && (_taskMilestonesClosedController.valueOrNull)?.isEmpty == true)
      loadClosed();
    if (tab == 1 && (_taskMilestonesOpenController.valueOrNull)?.isEmpty == true)
      loadOpened();
  }

  void reopenMilestone(TaskMileStoneModel model)async{
    isLoading = true;
    final res = await _iTaskRepository.reopenMilestone(model.tid, model.cid, model.id);
    if(res is ResultSuccess<bool>){
      final closedList = _taskMilestonesClosedController.valueOrNull ?? [];
      final openList = _taskMilestonesOpenController.valueOrNull ?? [];
      openList.add(model);
      closedList.removeWhere((element) => element.id == model.id);
      _taskMilestonesClosedController.sinkAddSafe(closedList);
      _taskMilestonesOpenController.sinkAddSafe(openList);
    }else
      showErrorMessage(res);
    isLoading = false;
  }

  void closeMilestone(TaskMileStoneModel model)async{
    isLoading = true;
    final res = await _iTaskRepository.closeMilestone(model.tid, model.cid, model.id);
    if(res is ResultSuccess<bool>){
      final closedList = _taskMilestonesClosedController.valueOrNull ?? [];
      final openList = _taskMilestonesOpenController.valueOrNull ?? [];
      closedList.add(model);
      openList.removeWhere((element) => element.id == model.id);
      _taskMilestonesClosedController.sinkAddSafe(closedList);
      _taskMilestonesOpenController.sinkAddSafe(openList);
      _taskMilestonesClosedController.sinkAddSafe(closedList);
      _taskMilestonesOpenController.sinkAddSafe(openList);
    }else
      showErrorMessage(res);
    isLoading = false;
  }

  void remove(TaskMileStoneModel model)async{
    isLoading = true;
    final res = await _iTaskRepository.deleteMilestone(model.tid, model.cid, model.id);
    if(res is ResultSuccess<bool>){
      if(model.state == 'open' ){
        final openList = _taskMilestonesOpenController.valueOrNull ?? [];
        openList.removeWhere((element) => element.id == model.id);
        _taskMilestonesOpenController.sinkAddSafe(openList);
      }else{
        final closedList = _taskMilestonesClosedController.valueOrNull ?? [];
        closedList.removeWhere((element) => false);
        _taskMilestonesClosedController.sinkAddSafe(closedList);
      }
    }else
      showErrorMessage(res);
    isLoading = true;
  }
}
