import 'dart:async';
import 'dart:io';

import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/task/task_ui_model.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

import '../../data/api/remote/remote_constants.dart';
import '../../data/repository/channel_repository.dart';
import '../../enums.dart';

class SearchGlobalBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final ITeamRepository _iTeamRepository;
  final SharedPreferencesManager _prefs;
  final IFileRepository _iFileRepository;
  final IChannelRepository _iChannelRepository;
  final InMemoryData inMemoryData;
  final IUserRepository _iUserRepository;

  SearchGlobalBloC(this._iTeamRepository, this._prefs, this._iFileRepository,
      this._iChannelRepository, this.inMemoryData, this._iUserRepository);

  @override
  void dispose() {
    _messagesController.close();
    _filesController.close();
    _membersController.close();
    _tasksController.close();
    _pageTabController.close();
    _createChatController.close();
    _tasksUIController.close();
    _pageTabTaskController.close();
    _channelsController.close();
    popToHome.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  final BehaviorSubject<SearchMembersModel?> _membersController = BehaviorSubject();

  Stream<SearchMembersModel?> get membersResult => _membersController.stream;

  final BehaviorSubject<SearchFilesModel?> _filesController = BehaviorSubject();

  Stream<SearchFilesModel?> get filesResult => _filesController.stream;

  final BehaviorSubject<SearchMessagesModel?> _messagesController = BehaviorSubject();

  Stream<SearchMessagesModel?> get messagesResult => _messagesController.stream;

  final BehaviorSubject<SearchTasksModel> _tasksController = BehaviorSubject();

  Stream<SearchTasksModel> get tasksResult => _tasksController.stream;

  final BehaviorSubject<List<ChannelModel>> _channelsController = BehaviorSubject();

  Stream<List<ChannelModel>> get channelsResult => _channelsController.stream;

  final BehaviorSubject<int> _pageTabController = BehaviorSubject();

  Stream<int> get pageTabResult => _pageTabController.stream;

  final BehaviorSubject<bool> _createChatController = BehaviorSubject();

  Stream<bool> get createChatResult => _createChatController.stream;

  final BehaviorSubject<TaskUIModel> _tasksUIController = BehaviorSubject();

  Stream<TaskUIModel> get tasksUIResult => _tasksUIController.stream;

  final BehaviorSubject<int> _pageTabTaskController = BehaviorSubject();

  Stream<int> get pageTabTaskResult => _pageTabTaskController.stream;

  final BehaviorSubject<bool> popToHome = BehaviorSubject();

  String currentTeamId = "";
  int offsetChanel = 0;
  int offsetMember = 0;
  int offsetFile = 0;
  int offsetTask = 0;
  int offsetMessage = 0;
  String currentQuery = "";
  TaskUIModel? taskUIModel;
  int totalTasks = 0;
  int maxLoad = 25;
  bool isLoadingMessages = false;
  bool isLoadingMembers = false;
  bool isLoadingFiles = false;
  bool isLoadingTasks = false;
  bool isLoadingChannels = false;
  int minPixelsToPullRefresh = -100;
  CancelToken? messageCancelToken;
  CancelToken? taskCancelToken;
  CancelToken? fileCancelToken;
  CancelToken? memberCancelToken;
  List<ChannelModel> channels = [];

  void initViewData() async {
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
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    loadChannelsGroups();
    _pageTabController.sinkAddSafe(1);
  }

  void searchByQuery(String query) {
    currentQuery = query;
    if (query.trim().isNotEmpty == true){
      loadMessages(replace: true);
      loadFiles(replace: true);
      loadMembers(replace: true);
      loadTasks(replace: true);
      queryChannels();
    }
  }

  void changePageTab(int tab) async {
    _pageTabController.sinkAddSafe(tab);
    // if (tab == 1 &&
    //     (_messagesController.value?.list ?? []).isEmpty &&
    //     currentQuery.isNotEmpty) loadMessages();
    // if (tab == 2 &&
    //     (_filesController.value?.list ?? []).isEmpty &&
    //     currentQuery.isNotEmpty) loadFiles();
    // if (tab == 3 &&
    //     (_membersController.value?.list ?? []).isEmpty &&
    //     currentQuery.isNotEmpty) loadMembers();
    // if (tab == 4 &&
    //     (_tasksController.value?.list ?? []).isEmpty &&
    //     currentQuery.isNotEmpty) loadTasks();
  }

  Future<void> loadMessages({bool replace = false}) async {
    messageCancelToken?.cancel();
    offsetMessage = !replace ? offsetMessage += maxLoad : 0;
    isLoadingMessages = true;
    final res = await _iTeamRepository.searchMessages(currentTeamId,
        offset: offsetMessage,
        query: currentQuery,
        max: maxLoad, onCancelToken: (token) => messageCancelToken = token);
    if (res is ResultSuccess<SearchMessagesModel>) {
      if (offsetMessage == 0) {
        _messagesController.sinkAddSafe(res.value);
      } else {
        final obj = _messagesController.valueOrNull ?? SearchMessagesModel();
        obj.list.addAll(res.value.list);
        _messagesController.sinkAddSafe(obj);
      }
    } else {
      showErrorMessage(res);
    }
    isLoadingMessages = false;
  }

  Future<void> loadFiles({bool replace = false}) async {
    fileCancelToken?.cancel();
    offsetFile = !replace ? offsetFile += maxLoad : 0;
    isLoadingFiles = true;
    final res = await _iTeamRepository.searchFiles(currentTeamId,
        offset: offsetFile, query: currentQuery, max: maxLoad, onCancelToken: (token) => fileCancelToken = token);
    if (res is ResultSuccess<SearchFilesModel>) {
      if (offsetFile == 0) {
        _filesController.sinkAddSafe(res.value);
      } else {
        final obj = _filesController.valueOrNull ?? SearchFilesModel();
        obj.list.addAll(res.value.list);
        _filesController.sinkAddSafe(obj);
      }
    } else {
      showErrorMessage(res);
    }
    isLoadingFiles = false;
  }

  Future<void> loadMembers({bool replace = false}) async {
    memberCancelToken?.cancel();
    offsetMember = !replace ? offsetMember += maxLoad : 0;
    isLoadingMembers = true;
    final res = await _iTeamRepository.searchMembers(currentTeamId,
        offset: offsetMember, query: currentQuery, max: maxLoad, onCancelToken: (token) => memberCancelToken = token);
    if (res is ResultSuccess<SearchMembersModel>) {
      if (offsetMember == 0) {
        _membersController.sinkAddSafe(res.value);
      } else {
        final obj = _membersController.valueOrNull ?? SearchMembersModel();
        obj.list.addAll(res.value.list);
        _membersController.sinkAddSafe(obj);
      }
    } else {
      showErrorMessage(res);
    }
    isLoadingMembers = false;
  }

  Future<void> loadTasks({bool replace = false}) async {
    taskCancelToken?.cancel();
    offsetTask = !replace ? offsetTask += 40 : 0;
    if (offsetTask == 0) taskUIModel?.allTasks.clear();
    isLoadingTasks = true;
    final res = await _iTeamRepository.searchTasks(currentTeamId,
        offset: offsetTask, query: currentQuery, max: 40, onCancelToken: (token) => taskCancelToken = token);
    if (res is ResultSuccess<SearchTasksModel>) {
      _tasksController.sinkAddSafe(res.value);
      totalTasks = res.value.total;
      for (var element in res.value.list) {
        taskUIModel?.allTasks[element.id] = element;
      }

      taskUIModel?.openList = taskUIModel?.opened() ?? [];
      taskUIModel?.openTotal = taskUIModel?.openList.length ?? 0;
      taskUIModel?.openTotalFiltered = taskUIModel?.openTotal ?? 0;

      taskUIModel?.closedList = taskUIModel?.closed() ?? [];
      taskUIModel?.closedTotal = taskUIModel?.closedList.length ?? 0;
      taskUIModel?.closedTotalFiltered = taskUIModel?.closedTotal ?? 0;

      _tasksUIController.sinkAddSafe(taskUIModel!);
    } else {
      showErrorMessage(res);
    }
    isLoadingTasks = false;
  }

  void queryChannels() {
    if(currentQuery.isEmpty) {
      _channelsController.sinkAddSafe([]);
    } else {
      final queryList = channels.where((e) => e.titleFixed.toLowerCase().trim().contains(currentQuery.toLowerCase())).toList();
      queryList.sort((c1, c2) =>
          c1.titleFixed.toLowerCase().compareTo(c2.titleFixed.toLowerCase()));
      _channelsController.sinkAddSafe(queryList);
    }
  }

  Future<void> loadChannelsGroups() async {
    final futures = [_loadChannels(), _loadGroups()];
    final res = await Future.wait(futures);
    final list = res.first + res.last;
    channels.addAll(list);
    queryChannels();
  }

  Future<List<ChannelModel>> _loadChannels() async {
    final res = await _iChannelRepository.getChannels(currentTeamId, type: RemoteConstants.channel, forceApi: true);
    if (res is ResultSuccess<List<ChannelModel>>) {
      return res.value;
    }
    return [];
  }

  Future<List<ChannelModel>> _loadGroups() async {
    final res = await _iChannelRepository.getChannels(currentTeamId, type: RemoteConstants.group, forceApi: true);
    if (res is ResultSuccess<List<ChannelModel>>) {
      return res.value;
    }
    return [];
  }

  void downloadFile(FileModel fileModel) async {
    isLoading = true;
    final res = await _iFileRepository.downloadFile(fileModel);
    if (res is ResultSuccess<File>) {
      await OpenFile.open(res.value.path);
    }
    isLoading = false;
  }

  void create1x1Message(MemberModel memberModel) async {
    isLoading = true;
    final res = await _iChannelRepository.create1x1Channel(memberModel);
    if (res is ResultSuccess<ChannelModel>) {
      _createChatController.sinkAddSafe(true);
      changeChannelAutoController.sinkAddSafe(
          ChannelCreatedUI(members: [memberModel], channelModel: res.value));
    }
    // else
    //   showErrorMessage(res);
    isLoading = false;
  }

  void onMessageTap(MessageModel messageModel) async {
    String teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _iChannelRepository.getChannel(teamId, messageModel.cid);
    if (res is ResultSuccess<ChannelModel>) {
      popToHome.sinkAddSafe(true);
      changeChannelAutoController.sinkAddSafe(ChannelCreatedUI(
          members: [],
          channelModel: res.value,
          lastReadMessage: messageModel,
      fromSearchMessage: true));
    } else {
      showErrorMessage(res);
    }
  }

  void onMentionClicked(String username) async {
    if (username.isNotEmpty &&
        username != 'channel' &&
        username != 'all' &&
        username != inMemoryData.currentMember!.profile?.name) {
      final membersInMemory = inMemoryData.getMembers(
          excludeMe: true, teamId: inMemoryData.currentTeam!.id);
      final memberIsInMemory = membersInMemory.firstWhereOrNull(
          (element) => element.profile?.name == username);
      if (memberIsInMemory == null) {
        final membersQuery = await _iUserRepository.getTeamMembers(
            inMemoryData.currentTeam!.id,
            max: 1,
            offset: 0,
            action: "search",
            active: true,
            query: username);
        if (membersQuery is ResultSuccess<MemberWrapperModel> &&
            membersQuery.value.list.isNotEmpty &&
            membersQuery.value.list[0].profile?.name == username) {
          final member = membersQuery.value.list[0];
          final res = await _iChannelRepository.create1x1Channel(member);
          if (res is ResultSuccess<ChannelModel>) {
            popToHome.sinkAddSafe(true);
            changeChannelAutoController.sinkAddSafe(
                ChannelCreatedUI(members: [member], channelModel: res.value));
          } else {
            //showErrorMessage(res);
          }
        }
      } else {
        final res =
            await _iChannelRepository.create1x1Channel(memberIsInMemory);
        if (res is ResultSuccess<ChannelModel>) {
          popToHome.sinkAddSafe(true);
          changeChannelAutoController.sinkAddSafe(ChannelCreatedUI(
              members: [memberIsInMemory], channelModel: res.value));
        } else {
          //showErrorMessage(res);
        }
      }
    }
  }

  Future<ChannelModel?> getChannelFromId(String cid) async {
    final res = await _iChannelRepository.getChannel(currentTeamId, cid);
    if(res is ResultSuccess<ChannelModel>) {
      return res.value;
    }
    return null;
  }

  int currentTaskTab = 1;

  void changeTaskPageTab(int tab) async {
    currentTaskTab = tab;
    _pageTabTaskController.sinkAddSafe(tab);
  }

//  void loadChannels({bool replace = false}) async {
//    final res = await _iTeamRepository.searchChannels(currentTeamId,
//        offset: offsetChanel, query: currentQuery, max: 100);
//    if (res is ResultSuccess<SearchChannelsModel>) {
//      totalChannel = res.value.total;
//      _channelsController.sinkAddSafe(res.value.list);
//    }
//  }
}
