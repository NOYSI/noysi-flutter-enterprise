
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/tasks_tag_selector/tag_colo_ui_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TaskTagCreateEditBloc extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;

  TaskTagCreateEditBloc(this._iTaskRepository, this._prefs);

  @override
  void dispose() {
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
    _labelColorController.close();
    _addEditLabelController.close();
    _initController.close();
  }

  BehaviorSubject<TaskLabelModel> _addEditLabelController =
  new BehaviorSubject();

  Stream<TaskLabelModel> get addEditLabelResult =>
      _addEditLabelController.stream;

  BehaviorSubject<TaskLabelModel> _initController =
  new BehaviorSubject();

  Stream<TaskLabelModel> get initResult =>
      _initController.stream;

  BehaviorSubject<List<TagColorUIModel>> _labelColorController =
  new BehaviorSubject();

  Stream<List<TagColorUIModel>> get labelColorResult =>
      _labelColorController.stream;

  String currentTeamId = "";
  String currentChatId = "";

  void initViewData(TaskLabelModel? taskLabelModel, String channelId) async {
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    currentChatId = channelId;
    final colors = TagColorUIModel.getTagColorsList();
    if (taskLabelModel != null)
      colors.forEach((element) {
        element.isSelected = taskLabelModel?.background == element.code;
      });
    _labelColorController.sinkAddSafe(colors);
    if (taskLabelModel == null)
      taskLabelModel = TaskLabelModel(
          id: "",
          tid: currentTeamId,
          cid: currentChatId,
          name: "",
          background: "#FF6666",
          taskCount: 0,
          text: "#FFFFFF");
    else {

    }
    _initController.sinkAddSafe(taskLabelModel);
  }

  void selectLabel(int id) {
    final labels = _labelColorController.valueOrNull ?? [];
    labels.forEach((element) {
      element.isSelected = element.id == id;
    });
    _labelColorController.sinkAddSafe(labels);
  }

  void createEditTag(String name, bool isAdding) async {
    isLoading = true;
    final tag =
    _labelColorController.valueOrNull?.firstWhere((element) => element.isSelected);

    if(tag != null) {
      if(isAdding){
        final res = await _iTaskRepository.addLabel(
            currentTeamId,
            currentChatId,
            TaskLabelCreateModel(
                background: tag.code, name: name, text: tag.textCodeColor));
        if (res is ResultSuccess<TaskLabelModel>) {
          _addEditLabelController.sinkAddSafe(res.value);
        } else
          showErrorMessage(res);
      }else{
        final label = _initController.valueOrNull;
        if(label != null) {
          label.name = name;
          label.background = tag.code;
          label.text = tag.textCodeColor;
          final res = await _iTaskRepository.updateLabel(currentTeamId, currentChatId, label);
          if(res is ResultSuccess<bool>){
            _addEditLabelController.sinkAddSafe(label);
          }
          else
            showErrorMessage(res);
        }
      }
    }
    isLoading = false;
  }
}
