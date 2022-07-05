
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TaskMilestoneSelectorBloC extends BaseBloC
    with FormValidatorBloC, ErrorHandlerBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;

  TaskMilestoneSelectorBloC(this._iTaskRepository, this._prefs);

  @override
  void dispose() {
    _milestonesController.close();
  }

  BehaviorSubject<List<TaskMileStoneModel>> _milestonesController =
      new BehaviorSubject();

  Stream<List<TaskMileStoneModel>> get milestonesResult =>
      _milestonesController.stream;

  List<TaskMileStoneModel> allMilestones = [];
  String currentTeamId = "";
  String currentChatId = "";
  String currentQuery = "";

  void loadMilestones(String channelId) async {
    currentChatId = channelId;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);

    final res = await _iTaskRepository.getMilestones(
        currentTeamId, currentChatId,
        max: 100, offset: 0, query: "");
    if (res is ResultSuccess<List<TaskMileStoneModel>>) {
      _milestonesController.sinkAddSafe(res.value.reversed.toList());
      allMilestones.clear();
      allMilestones.addAll(res.value.reversed.toList());
    }
  }

  void query(String query) {
    currentQuery = query;
    final filteredLabels = allMilestones
        .where((element) => element.title.contains(query.trim().toLowerCase()))
        .toList();
    _milestonesController.sinkAddSafe(filteredLabels);
  }
}
