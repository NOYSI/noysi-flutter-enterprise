import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TaskMilestoneCreateEditBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;

  TaskMilestoneCreateEditBloC(this._iTaskRepository, this._prefs);

  @override
  void dispose() {
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
    _addEditMilestoneController.close();
    _initController.close();
  }

  BehaviorSubject<TaskMileStoneModel> _addEditMilestoneController =
      new BehaviorSubject();

  Stream<TaskMileStoneModel> get addEditMilestoneResult =>
      _addEditMilestoneController.stream;

  BehaviorSubject<TaskMileStoneModel> _initController = new BehaviorSubject();

  Stream<TaskMileStoneModel> get initResult => _initController.stream;

  String currentTeamId = "";
  String currentChatId = "";

  void initViewData(
      TaskMileStoneModel? taskMileStoneModel, String channelId) async {
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    currentChatId = channelId;
    if (taskMileStoneModel == null)
      taskMileStoneModel = TaskMileStoneModel(
        id: "",
        tid: currentTeamId,
        cid: currentChatId,
        title: "",
        description: "",
      );
    _initController.sinkAddSafe(taskMileStoneModel);
  }

  void updateDateTime(DateTime dateTime) {
    if(_initController.valueOrNull != null) {
      _initController.value.due = dateTime;
      _initController.sinkAddSafe(_initController.value);
    }
  }

  void createEditMilestone(
      String name, String description, bool isAdding) async {
    isLoading = true;
    if(_initController.valueOrNull != null) {
      if (isAdding) {
        final res = await _iTaskRepository.addMilestone(
            currentTeamId,
            currentChatId,
            TaskMilestoneCreateModel(
                title: name,
                description: description,
                due: _initController.value.due));
        if (res is ResultSuccess<TaskMileStoneModel>) {
          _addEditMilestoneController.sinkAddSafe(res.value);
        } else
          showErrorMessage(res);
      } else {
        final milestone = _initController.value;
        milestone.title = name;
        milestone.description = description;
        final res = await _iTaskRepository.updateMilestone(
            milestone.tid, milestone.cid, milestone);
        if (res is ResultSuccess<bool>) {
          _addEditMilestoneController.sinkAddSafe(milestone);
        } else
          showErrorMessage(res);
      }
    }
    isLoading = false;
  }
}
