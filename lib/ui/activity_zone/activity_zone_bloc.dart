import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/activity/activity_model.dart';
import 'package:code/domain/activity/i_activity_repository.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/message/i_message_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

enum ActivityZoneMenu { sessions, memberUsage, teamUsage }

class ActivityZoneBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final IActivityRepository _iActivityRepository;
  final IMessageRepository _iMessageRepository;
  final IChannelRepository _iChannelRepository;
  final IFileRepository _iFileRepository;
  final IUserRepository _iUserRepository;
  final SharedPreferencesManager _prefs;
  final ITeamRepository _iTeamRepository;

  ActivityZoneBloC(
    this._iActivityRepository,
    this._iMessageRepository,
    this._iTeamRepository,
    this._iChannelRepository,
    this._iFileRepository,
    this._prefs,
    this._iUserRepository,
  );

  @override
  void dispose() {
    _activitiesController.close();
    _filterController.close();
    popToHomeController.close();
    changeToFolderController.close();
    changeToTaskController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<ActivityWrapperModel?> _activitiesController =
      new BehaviorSubject();

  Stream<ActivityWrapperModel?> get activitiesResult =>
      _activitiesController.stream;

  BehaviorSubject<ActivityFilter?> _filterController = new BehaviorSubject();

  Stream<ActivityFilter?> get filterResult => _filterController.stream;

  BehaviorSubject<bool?> popToHomeController = BehaviorSubject();

  BehaviorSubject<FilesNavigatorData?> changeToFolderController =
      BehaviorSubject();

  BehaviorSubject<String?> changeToTaskController = BehaviorSubject();

  int max = 50;
  ActivityWrapperModel mainActivityWrapper = ActivityWrapperModel(list: [], offset: 0, total: 0);
  DateTime? firstActivityDate;

  bool get isFiltered =>
      _filterController.valueOrNull != null &&
      (_filterController.valueOrNull?.dateRange != null ||
          _filterController.valueOrNull?.types.isNotEmpty == true);

  bool get isFilteredByDate =>
      isFiltered && _filterController.valueOrNull?.dateRange != null;

  bool get isFilteredByType =>
      isFiltered && _filterController.valueOrNull?.types.isNotEmpty == true;

  Future<void> _loadFirstActivityDate() async {
    final res = await _iActivityRepository.getUserActivities(
        limit: 1, offset: 0, order: "asc");
    if (res is ResultSuccess<ActivityWrapperModel> &&
        res.value.list.isNotEmpty) {
      firstActivityDate = res.value.list.first.ts;
    }
  }

  void loadUserActivities({bool isAdmin = false}) async {
    isLoading = true;
    final res =
        await _iActivityRepository.getUserActivities(limit: max, offset: 0);
    await _loadFirstActivityDate();
    if (res is ResultSuccess<ActivityWrapperModel>) {
      mainActivityWrapper = res.value;
      if (mainActivityWrapper.total < max)
        mainActivityWrapper.offset = mainActivityWrapper.total;
      else
        mainActivityWrapper.offset = max;
      _activitiesController.sinkAddSafe(mainActivityWrapper);
    } else {
      showErrorMessageFromString(R.string.errorFetchingData);
    }
    List<Future> usages = [];
    usages.add(_loadUserUsageData());
    if (isAdmin) usages.add(_loadTeamUsageData());
    await Future.wait(usages);
    isLoading = false;
  }

  UsageModel? userUsage;

  Future<void> _loadUserUsageData() async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final currentMemeberId = await _prefs.getStringValue(_prefs.userId);
    final res = await _iUserRepository.getTeamMemberUsage(
        currentTeamId, currentMemeberId);
    if (res is ResultSuccess<UsageModel>) {
      userUsage = res.value;
    }
  }

  UsageModel? teamUsage;

  Future<void> _loadTeamUsageData() async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _iTeamRepository.teamUsage(currentTeamId);
    if (res is ResultSuccess<UsageModel>) {
      teamUsage = res.value;
    }
  }

  bool isLoadingMore = false;

  void loadMore() async {
    if (!isLoadingMore) {
      final activityWrapper = _activitiesController.valueOrNull;
      if (activityWrapper != null &&
          activityWrapper.offset < activityWrapper.total) {
        isLoadingMore = true;
        final toLoad = activityWrapper.total - activityWrapper.offset >= max
            ? max
            : activityWrapper.total - activityWrapper.offset;
        final res = await _iActivityRepository.getUserActivities(
            start: isFilteredByDate
                ? _filterController.valueOrNull?.dateRange?.start
                : null,
            end: isFilteredByDate
                ? _filterController.valueOrNull?.dateRange?.end
                : null,
            offset: activityWrapper.offset,
            limit: toLoad,
            type:
                isFilteredByType ? _filterController.valueOrNull?.types.first : null);
        if (res is ResultSuccess<ActivityWrapperModel>) {
          activityWrapper.list.addAll(res.value.list);
          activityWrapper.offset += toLoad;
          if (!isFiltered) {
            mainActivityWrapper = activityWrapper;
          }
          _activitiesController.sinkAddSafe(activityWrapper);
        } else {
          showErrorMessageFromString(R.string.errorFetchingData);
        }
        isLoadingMore = false;
      }
    }
  }

  void filterByDateRange(DateTimeRange dateRange) {
    final currentFilter = _filterController.valueOrNull;
    if (currentFilter == null ||
        ((currentFilter.dateRange == null ||
            (currentFilter.dateRange != null &&
                currentFilter.dateRange != dateRange)))) {
      if (currentFilter == null) {
        _filterController.sinkAddSafe(ActivityFilter(dateRange: dateRange));
      } else {
        currentFilter.dateRange = dateRange;
        _filterController.sinkAddSafe(currentFilter);
      }
      _loadViewWithData();
    }
  }

  void filterByType(ACTIVITY_TYPE type) {
    final currentFilter = _filterController.valueOrNull;
    if (currentFilter == null) {
      _filterController.sinkAddSafe(ActivityFilter(types: [type]));
    } else {
      currentFilter.types = [];
      currentFilter.types.add(type);
      _filterController.sinkAddSafe(currentFilter);
    }
    _loadViewWithData();
  }

  void removeFilter({bool removeDate = false, bool removeType = false}) {
    if (removeDate && isFilteredByDate) {
      final filter = _filterController.valueOrNull;
      filter?.dateRange = null;
      _filterController.sinkAddSafe(filter);
    }
    if (removeType && isFilteredByType) {
      final filter = _filterController.valueOrNull;
      filter?.types = [];
      _filterController.sinkAddSafe(filter);
    }
    _loadViewWithData();
  }

  void _loadViewWithData() async {
    if (isFiltered) {
      isLoading = true;
      final res = await _iActivityRepository.getUserActivities(
          start: isFilteredByDate
              ? _filterController.valueOrNull?.dateRange?.start
              : null,
          end:
              isFilteredByDate ? _filterController.valueOrNull?.dateRange?.end : null,
          offset: 0,
          limit: max,
          type: isFilteredByType ? _filterController.valueOrNull?.types.first : null);
      if (res is ResultSuccess<ActivityWrapperModel>) {
        if (res.value.total < max)
          res.value.offset = res.value.total;
        else
          res.value.offset = max;
        _activitiesController.sinkAddSafe(res.value);
      } else {
        showErrorMessageFromString(R.string.errorFetchingData);
      }
      isLoading = false;
    } else {
      _activitiesController.sinkAddSafe(mainActivityWrapper);
    }
  }

  void onTapActivity(ActivityModel model, TeamJoinedModel joinedTeam) {
    if (model.type == ACTIVITY_TYPE.task_assigned_deleted ||
        model.type == ACTIVITY_TYPE.task_assigned ||
        model.type == ACTIVITY_TYPE.task_created)
      _goToTask(model);
    else if (model.type == ACTIVITY_TYPE.mentioned ||
        model.type == ACTIVITY_TYPE.message_sent)
      _goToMessage(model);
    else if (model.type == ACTIVITY_TYPE.file_uploaded ||
        model.type == ACTIVITY_TYPE.file_downloaded)
      _goToFiles(model, joinedTeam);
  }

  void _goToTask(ActivityModel model) {
    changeToTaskController.sinkAddSafe(model.sourceId);
  }

  void _goToMessage(ActivityModel model) async {
    isLoading = true;
    final resMessage = await _iMessageRepository.getMessage(
        model.tid ?? "", model.cid ?? "", model.sourceId ?? "");
    if (resMessage is ResultSuccess<MessageModel>) {
      final needOtherMember = (model.isMentionedActivity &&
              (model.metaData as MentionedMetaModel).is1x1Message) ||
          (model.isMessageSentActivity &&
              (model.metaData as MessageSentMetaModel).is1x1Message);
      MemberModel? otherMember;
      if (needOtherMember) {
        final resMember = await _iUserRepository.getTeamMember(
            model.tid ?? "",
            model.isMessageSentActivity
                ? (model.metaData as MessageSentMetaModel).other ?? ""
                : (model.metaData as MentionedMetaModel).other ?? "");
        if (resMember is ResultSuccess<MemberModel>) {
          otherMember = resMember.value;
        } else {
          showErrorMessageFromString(R.string.messageUnavailable);
          return;
        }
      }
      final res = needOtherMember
          ? await _iChannelRepository.create1x1Channel(otherMember!)
          : await _iChannelRepository.getChannel(model.tid ?? "", model.cid ?? "");
      if (res is ResultSuccess<ChannelModel>) {
        popToHomeController.sinkAddSafe(true);
        changeChannelAutoController.sinkAddSafe(ChannelCreatedUI(
            members: needOtherMember ? [otherMember!] : [],
            channelModel: res.value,
            lastReadMessage: resMessage.value,
            fromSearchMessage: true));
      } else
        showErrorMessageFromString(R.string.messageUnavailable);
    } else
      showErrorMessageFromString(R.string.messageUnavailable);
    isLoading = false;
  }

  void _goToFiles(ActivityModel model, TeamJoinedModel joinedTeam) async {
    if ((model.metaData as FileUploadedMetaModel).parentId?.isNotEmpty == true) {
      isLoading = true;
      final res = await _iFileRepository.getFolderReference(model.tid ?? "",
          model.cid ?? "", (model.metaData as FileUploadedMetaModel).parentId ?? "");
      if (res is ResultSuccess<FolderModel>) {
        changeToFolderController
            .sinkAddSafe(FilesNavigatorData(parent: res.value));
      } else if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_not_found) {
        showErrorMessageFromString(R.string.folderDeleted);
      }
      isLoading = false;
    } else {
      final channel = List.of(
              joinedTeam.messages1x1 + joinedTeam.groups + joinedTeam.channels)
          .firstWhereOrNull((element) => element.id == model.cid);
      if (channel != null) {
        changeToFolderController
            .sinkAddSafe(FilesNavigatorData(channel: channel));
      } else {
        showErrorMessageFromString(R.string.folderIsNotInAvailableChannel);
      }
    }
  }

  onActivityCreated(ActivityModel model) async {
    final tid = await _prefs.getStringValue(_prefs.currentTeamId);
    final uid = await _prefs.getStringValue(_prefs.userId);
    if ((tid == model.tid && uid == model.uid) ||
        model.type == ACTIVITY_TYPE.signed_in) {
      mainActivityWrapper.list.isEmpty
          ? mainActivityWrapper.list.add(model)
          : mainActivityWrapper.list.insert(0, model);
      mainActivityWrapper.offset++;
      mainActivityWrapper.total++;
      final filter = _filterController.valueOrNull;
      if (isFiltered) {
        if ((isFilteredByType &&
                isFilteredByDate &&
                model.type == filter?.types.first &&
                model.ts!.isAfter(filter!.dateRange!.start) &&
                model.ts!.isBefore(filter.dateRange!.end)) ||
            (isFilteredByType &&
                !isFilteredByDate &&
                model.type == filter?.types.first) ||
            (isFilteredByDate &&
                !isFilteredByType &&
                model.ts!.isAfter(filter!.dateRange!.start) &&
                model.ts!.isBefore(filter.dateRange!.end))) {
          final activityWrapper = _activitiesController.valueOrNull;
          activityWrapper!.list.isEmpty
              ? activityWrapper.list.add(model)
              : activityWrapper.list.insert(0, model);
          activityWrapper.offset++;
          activityWrapper.total++;
          _activitiesController.sinkAddSafe(activityWrapper);
        }
      } else {
        _activitiesController.sinkAddSafe(mainActivityWrapper);
      }
    }
  }

  onActivityDeleted(ActivityModel model) async {
    final tid = await _prefs.getStringValue(_prefs.currentTeamId);
    final uid = await _prefs.getStringValue(_prefs.userId);
    if (tid == model.tid && uid == model.uid) {
      final idx = mainActivityWrapper.list
          .indexWhere((element) => element.id == model.id);
      if (idx >= 0) {
        mainActivityWrapper.list.removeAt(idx);
        mainActivityWrapper.offset--;
        mainActivityWrapper.total--;
        if (isFiltered) {
          final activityWrapper = _activitiesController.valueOrNull;
          final idx = activityWrapper?.list
              .indexWhere((element) => element.id == model.id) ?? -1;
          if (idx >= 0) {
            activityWrapper?.list.removeAt(idx);
            activityWrapper?.offset--;
            activityWrapper?.total--;
            _activitiesController.sinkAddSafe(activityWrapper);
          }
        } else {
          _activitiesController.sinkAddSafe(mainActivityWrapper);
        }
      }
    }
  }
}

class FilesNavigatorData {
  FolderModel? parent;
  ChannelModel? channel;

  FilesNavigatorData({this.channel, this.parent});
}
