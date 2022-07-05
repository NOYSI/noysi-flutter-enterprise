import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TaskFilterBloC extends BaseBloC{

  @override
  void dispose() {
    _initController.close();
  }


  BehaviorSubject<TaskUIModel?> _initController = new BehaviorSubject();

  Stream<TaskUIModel?> get initResult => _initController.stream;

  void get refreshData => _initController.sinkAddSafe(taskUIModel);

  late TaskUIModel taskUIModel;
  String channelId = "";

  void initViewData(TaskUIModel taskUIModel, String channelId, bool showAuthorFilter)async{
    this.taskUIModel = taskUIModel;
    this.channelId = channelId;
    _initController.sinkAddSafe(this.taskUIModel);
  }

  void updateSort(TaskSort taskSort){
    taskUIModel.taskSort = taskSort;
    _initController.sinkAddSafe(taskUIModel);
  }

  void updateAuthor(MemberModel? memberModel){
    taskUIModel.author = memberModel;
    _initController.sinkAddSafe(taskUIModel);
  }

  void updateAssignee(MemberModel? memberModel){
    taskUIModel.assignee = memberModel;
    _initController.sinkAddSafe(taskUIModel);
  }

  void updateLabels(TaskLabelModel label){
    final index = taskUIModel.labels.indexWhere((element) => element.id == label.id);
    if(index >= 0)
      taskUIModel.labels.removeAt(index);
    else
      taskUIModel.labels.add(label);
    _initController.sinkAddSafe(taskUIModel);
  }

  void updateMilestone(TaskMileStoneModel? milestone){
    taskUIModel.milestone = milestone;
    _initController.sinkAddSafe(taskUIModel);
  }
}