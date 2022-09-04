
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/tasks_tag_selector/tag_colo_ui_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TaskTagSelectorBloC extends BaseBloC
    with FormValidatorBloC, ErrorHandlerBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;

  TaskTagSelectorBloC(this._iTaskRepository, this._prefs);

  @override
  void dispose() {
    _taskLabelController.close();
    _labelColorController.close();
  }

  BehaviorSubject<List<TaskLabelModel>> _taskLabelController =
      new BehaviorSubject();

  Stream<List<TaskLabelModel>> get taskLabelResult =>
      _taskLabelController.stream;

  BehaviorSubject<List<TagColorUIModel>> _labelColorController =
      new BehaviorSubject();

  Stream<List<TagColorUIModel>> get labelColorResult =>
      _labelColorController.stream;

  List<TaskLabelModel> allLabels = [];
  String currentTeamId = "";
  String currentChatId = "";
  String currentQuery = "";

  void selectLabel(int id) {
    final labels = _labelColorController.valueOrNull ?? [];
    labels.forEach((element) {
      element.isSelected = element.id == id;
    });
    _labelColorController.sinkAddSafe(labels);
  }

  void loadTags(String channelId) async {
    currentChatId = channelId;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    _labelColorController.sinkAddSafe(TagColorUIModel.getTagColorsList());

    final res = await _iTaskRepository.getLabels(currentTeamId, currentChatId,
        max: 100, offset: 0, query: "");
    if (res is ResultSuccess<List<TaskLabelModel>>) {
      _taskLabelController.sinkAddSafe(res.value);
      allLabels.clear();
      allLabels.addAll(res.value);
    }
  }

  void query(String query) {
    currentQuery = query;
    final filteredLabels = allLabels
        .where((element) => element.name.contains(query.trim().toLowerCase()))
        .toList();
    _taskLabelController.sinkAddSafe(filteredLabels);
  }
}
