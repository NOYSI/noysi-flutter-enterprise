import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/task/i_task_repository.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TaskBloC extends BaseBloC with ErrorHandlerBloC {
  final ITaskRepository _iTaskRepository;
  final SharedPreferencesManager _prefs;
  final InMemoryData inMemoryData;

  TaskBloC(this._iTaskRepository, this._prefs, this.inMemoryData);

  @override
  void dispose() {
    _tasksController.close();
    _pageTabController.close();
    _activeFilterController.close();
    _createdFilterController.close();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<TaskUIModel> _tasksController = new BehaviorSubject();

  Stream<TaskUIModel> get tasksResult => _tasksController.stream;

  BehaviorSubject<int> _pageTabController = new BehaviorSubject();

  Stream<int> get pageTabResult => _pageTabController.stream;

  BehaviorSubject<bool> _activeFilterController = new BehaviorSubject();

  Stream<bool> get activeFilterResult => _activeFilterController.stream;

  BehaviorSubject<bool> _createdFilterController = new BehaviorSubject();

  Stream<bool> get createdFilterResult => _createdFilterController.stream;

  String teamId = "";
  late TaskUIModel taskUIModel;
  String channelId = "";
  String currentUserId = "";
  int maxLoad = 25;


  void initDataView() async {
    taskUIModel = TaskUIModel(
        taskSort: TaskSort.newest,
        milestone: null,
        author: null,
        allTasks: {},
        closedOffset: 0,
        openOffset: 0,
        labels: [],
        assignee: null,
        openList: [],
        closedList: []);
    currentUserId = await _prefs.getStringValue(_prefs.userId);
    teamId = await _prefs.getStringValue(_prefs.currentTeamId);

    loadOpened();
    loadClosed();
  }

  int currentTab = 1;

  void changePageTab(int tab) async {
    currentTab = tab;
    _pageTabController.sinkAddSafe(tab);
  }

  bool isCreatedByMeTab = false;

  void changeCreatedFilter(bool isCreated) async {
    isCreatedByMeTab = isCreated;
    _createdFilterController.sinkAddSafe(isCreated);
    loadOpened();
    loadClosed();
  }

  void activeFilter() {
    final isActive = taskUIModel.author != null ||
        taskUIModel.assignee != null ||
        taskUIModel.labels.isNotEmpty == true ||
        taskUIModel.milestone != null;
    _activeFilterController.sinkAddSafe(isActive);
  }

  void clearFilter() {
    taskUIModel.allTasks.clear();
    taskUIModel.author = null;
    taskUIModel.assignee = null;
    taskUIModel.labels = [];
    taskUIModel.milestone = null;
    loadOpened();
    loadClosed();
    _activeFilterController.sinkAddSafe(false);
  }

  bool isLoadingMoreOpen = false;
  bool hasMoreOpen = true;

  Future<void> loadOpened({isAddingMore = false}) async {
    if (isLoadingMoreOpen) return;
    isLoadingMoreOpen = true;
    taskUIModel.openOffset = isAddingMore ? taskUIModel.openOffset += maxLoad : 0;
    if (!isAddingMore) {
      taskUIModel.allTasks.clear();
    }
    String? authorId;

    if (channelId.isEmpty && isCreatedByMeTab)
      authorId = inMemoryData.currentMember?.id;
    else
      authorId = taskUIModel.author?.id;

    final res = await _iTaskRepository.getTasks(teamId,
        channelId: channelId,
        offset: taskUIModel.openOffset,
        status: RemoteConstants.open,
        max: maxLoad,
        sort: taskUIModel.sortCode,
        authors: authorId,
        assignee: taskUIModel.assignee?.id,
        milestone: taskUIModel.milestone?.id,
        labels: taskUIModel.labels.map((e) => e.id).toList());
    if (res is ResultSuccess<TaskStatsModel>) {
      taskUIModel.openTotal = res.value.total;
      taskUIModel.openTotalFiltered = taskUIModel.openTotal;
      res.value.list.forEach((element) {
        taskUIModel.allTasks[element.id] = element;
      });
      taskUIModel.openList = taskUIModel.opened();
      hasMoreOpen = taskUIModel.openTotal > taskUIModel.openList.length;
      _tasksController.sinkAddSafe(taskUIModel);
    }
    isLoadingMoreOpen = false;
  }

  bool isLoadingMoreClosed = false;
  bool hasMoreClosed = true;

  Future<void> loadClosed({isAddingMore = false}) async {
    if (isLoadingMoreClosed) return;
    isLoadingMoreClosed = true;
    taskUIModel.closedOffset =
        isAddingMore ? taskUIModel.closedOffset += maxLoad : 0;
    if (!isAddingMore) {
      taskUIModel.allTasks.clear();
    }
    String? authorId;
    if (channelId.isEmpty && isCreatedByMeTab)
      authorId = inMemoryData.currentMember?.id;
    else
      authorId = taskUIModel.author?.id;

    final res = await _iTaskRepository.getTasks(teamId,
        channelId: channelId,
        offset: taskUIModel.closedOffset,
        status: RemoteConstants.closed,
        max: maxLoad,
        sort: taskUIModel.sortCode,
        authors: authorId,
        assignee: taskUIModel.assignee?.id,
        milestone: taskUIModel.milestone?.id,
        labels: taskUIModel.labels.map((e) => e.id).toList());
    if (res is ResultSuccess<TaskStatsModel>) {
      taskUIModel.closedTotal = res.value.total;
      taskUIModel.closedTotalFiltered = taskUIModel.closedTotal;
      res.value.list.forEach((element) {
        taskUIModel.allTasks[element.id] = element;
      });
      hasMoreClosed = res.value.list.isNotEmpty;
      taskUIModel.closedList = taskUIModel.closed();
      hasMoreClosed = taskUIModel.closedTotal > taskUIModel.closedList.length;
      _tasksController.sinkAddSafe(taskUIModel);
    }
    isLoadingMoreClosed = false;
  }

  String currentQuery = "";

  void query(String query) {
    currentQuery = query;
    taskUIModel.openList = taskUIModel.opened(query: query);
    taskUIModel.openTotalFiltered = query.trim().isEmpty
        ? taskUIModel.openTotal
        : taskUIModel.openList.length;
    taskUIModel.closedList = taskUIModel.closed(query: query);
    taskUIModel.closedTotalFiltered = query.trim().isEmpty
        ? taskUIModel.closedTotal
        : taskUIModel.closedList.length;
    _tasksController.sinkAddSafe(taskUIModel);
  }
}
