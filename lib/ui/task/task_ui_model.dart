import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';

class TaskUIModel {
  Map<String, TaskModel> allTasks;
  String channelId;
  TaskSort taskSort;
  MemberModel? author;
  MemberModel? assignee;
  List<TaskLabelModel> labels;
  TaskMileStoneModel? milestone;
  int openTotal;
  int openTotalFiltered;
  int closedTotal;
  int closedTotalFiltered;
  int openOffset;
  int closedOffset;
  List<TaskModel> openList;
  List<TaskModel> closedList;

  String get sortCode => taskSort == TaskSort.dueDateFar
      ? "due:asc"
      : taskSort == TaskSort.dueDateEarly
          ? "due:desc"
          : taskSort == TaskSort.newest
              ? "created:desc"
              : "created:asc";

  List<TaskModel> opened({String query = ""}) {
    final openedCreatedList =
        allTasks.values.toList().where((element) => element.isOpen).toList();
    if (query.isNotEmpty) {
      return filteredByQuery(query, openedCreatedList);
    }
    return openedCreatedList;
  }

  List<TaskModel> closed({String query = ""}) {
    final closedCreatedList =
        allTasks.values.toList().where((element) => !element.isOpen).toList();
    if (query.isNotEmpty) {
      return filteredByQuery(query, closedCreatedList);
    }
    return closedCreatedList;
  }

  List<TaskModel> filteredByQuery(String query, List<TaskModel> list) {
    final filterByQuery = list
        .where((element) => element.title
            .trim()
            .toLowerCase()
            .contains(query.trim().toLowerCase()))
        .toList();
    return filterByQuery;
  }

  TaskUIModel(
      {this.taskSort = TaskSort.newest,
      this.author,
      this.assignee,
      this.openList = const [],
      this.closedList = const [],
      this.closedOffset = 0,
      this.openOffset = 0,
      this.channelId = '',
      this.allTasks = const {},
      this.openTotal = 0,
      this.closedTotal = 0,
      this.closedTotalFiltered = 0,
      this.openTotalFiltered = 0,
      this.labels = const [],
      this.milestone});
}

class TaskDetailUIModel {
  TaskModel taskModel;
  bool isEditingTitle;
  List<TaskDetailUIFileModel> files;

  TaskDetailUIModel({required this.taskModel, this.isEditingTitle = false, this.files = const []});
}

class TaskDetailUIFileModel {
  String name;
  String size;
  String mimeType;

  TaskDetailUIFileModel({this.name = '', this.size = '', this.mimeType = ''});
}
