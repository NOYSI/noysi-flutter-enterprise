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

class TaskCommentAddEditBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;

  TaskCommentAddEditBloC(this._iTaskRepository, this._prefs);

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _addEditActionController.close();
  }

  BehaviorSubject<bool> _addEditActionController = new BehaviorSubject();

  Stream<bool> get addEditActionResult => _addEditActionController.stream;

  TaskModel? taskModel;

  void postTaskComment(String comment) async {
    isLoading = true;
    final teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res =
        await _iTaskRepository.postTaskComment(teamId, taskModel!.id, comment);
    if (res is ResultSuccess<bool>) {
      _addEditActionController.sinkAddSafe(true);
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void putTaskComment(String comment, int commentPos) async {
    isLoading = true;
    final teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _iTaskRepository.putTaskComment(
        teamId, taskModel!.id, comment, commentPos);
    if (res is ResultSuccess<bool>) {
      _addEditActionController.sinkAddSafe(true);
    } else
      showErrorMessage(res);
    isLoading = false;
  }
}
