import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TaskTagBloc extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;

  TaskTagBloc(this._iTaskRepository, this._prefs);

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _taskLabelController.close();
  }

  BehaviorSubject<List<TaskLabelModel>> _taskLabelController =
      new BehaviorSubject();

  Stream<List<TaskLabelModel>> get taskLabelResult =>
      _taskLabelController.stream;

  String currentTeamId = "";
  String currentChannelId = "";

  void loadTags(String channelId) async {
    currentChannelId = channelId;
    isLoading = true;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _iTaskRepository.getLabels(
        currentTeamId, currentChannelId,
        max: 100, offset: 0, query: "");
    if (res is ResultSuccess<List<TaskLabelModel>>) {
      _taskLabelController.sinkAddSafe(res.value);
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void deleteTag(TaskLabelModel taskLabelModel) async {
    isLoading = true;
    final res = await _iTaskRepository.deleteLabel(
        currentTeamId, currentChannelId, taskLabelModel.id);
    if (res is ResultSuccess<bool>) {
      final labels = _taskLabelController.valueOrNull ?? [];
      labels.removeWhere((element) => element.id == taskLabelModel.id);
      _taskLabelController.sinkAddSafe(labels);
    } else{
      showErrorMessage(res);
    }
    isLoading = false;
  }
}
