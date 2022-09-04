import 'package:code/_di/injector.dart';
import 'package:code/_res/values/config.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';
import 'package:collection/collection.dart';

class SearchUserBloC extends BaseBloC with ErrorHandlerBloC {
  final IUserRepository _iUserRepository;
  final SharedPreferencesManager _prefs;
  final InMemoryData _inMemoryData;
  final IChannelRepository _iChannelRepository;

  SearchUserBloC(this._iUserRepository, this._prefs, this._inMemoryData, this._iChannelRepository);

  @override
  void dispose() {
    _membersController.close();
    generatingLinkController.close();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<MemberWrapperModel> _membersController =
      new BehaviorSubject();

  Stream<MemberWrapperModel> get membersResult => _membersController.stream;

  BehaviorSubject<bool> generatingLinkController = BehaviorSubject.seeded(false);

  List<String> excludeMembers = [];
  bool excludeBotMembers = false;
  String currentTeamId = "";
  int max = 50;
  int offset = 0;
  bool activeMembersOnly = true;
  String action = "im.open";
  String currentQuery = "";
  bool isLoadingUsers = false;
  UserGroupBy? userGroupBy;
  String channelId = "";
  MemberWrapperModel memberWrapperModel =
      MemberWrapperModel(list: [], totalUsers: 0);

  CancelToken? cancelToken;

  void initDataView(
      String action,
      UserGroupBy userGroupBy,
      String? channelId,
      List<String>? excludeMembers,
      bool excludeBotMembers,
      bool activeMembersOnly) async {
    this.excludeMembers = excludeMembers ?? [];
    this.userGroupBy = userGroupBy;
    this.excludeBotMembers = excludeBotMembers;
    this.channelId = channelId ?? "";
    this.action = action.isEmpty ? "im.open" : action;
    this.activeMembersOnly = activeMembersOnly;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    await loadMembers(replace: true);
  }

  void onUserPresenceChangeController(RTCPresenceChangeModel value) {
    final index = memberWrapperModel.list
        .indexWhere((element) => element.id == value.uid);
    if (index >= 0) {
      memberWrapperModel.list[index].presence =
          _inMemoryData.currentMember?.id == value.uid
              ? "online"
              : value.presence;
    }
    _membersController.sinkAddSafe(memberWrapperModel);
  }

  void onMemberDisabledEnabled(RTCMemberDisabledEnabledModel? value) async {
    if (value != null) {
      if (currentTeamId == value.tid) {
        final index = memberWrapperModel.list
            .indexWhere((element) => element.id == value.uid);
        if (index >= 0) {
          memberWrapperModel.list[index].active = value.enable;
        }
        _membersController.sinkAddSafe(memberWrapperModel);
      }
    }
  }

  void onMemberLeftChannel(RTCChannelLeftDeleted value, String currentChannel) {
    if(currentTeamId == value.tid && currentChannel == value.cid) {
      final index = memberWrapperModel.list
          .indexWhere((element) => element.id == value.uid);
      if (index >= 0) {
        memberWrapperModel.list.removeAt(index);
      }
      _membersController.sinkAddSafe(memberWrapperModel);
    }
  }

  Future<void> loadMembers({bool replace = false}) async {
    if(!isLoadingUsers || replace) {
      isLoadingUsers = true;
      cancelToken?.cancel();
      offset = replace ? 0 : offset += max;
      if (userGroupBy == UserGroupBy.team) {
        final res = await _iUserRepository.getTeamMembers(currentTeamId,
            max: max,
            offset: offset,
            active: activeMembersOnly,
            action: action,
            query: currentQuery,
            onCancelToken: (token) => cancelToken = token);
        if (res is ResultSuccess<MemberWrapperModel>) {
          if (replace) memberWrapperModel.list.clear();
          memberWrapperModel.list.addAll(res.value.list);
          removeExcludeMembers();
        } else
          showErrorMessage(res);
      } else if (channelId.isNotEmpty) {
        final res = await _iUserRepository.getChannelMembers(
            currentTeamId, channelId,
            query: currentQuery,
            offset: offset,
            active: activeMembersOnly,
            max: max,
            onCancelToken: (token) => cancelToken = token);
        if (res is ResultSuccess<MemberWrapperModel>) {
          if (replace) memberWrapperModel.list.clear();
          memberWrapperModel.list.addAll(res.value.list);
          removeExcludeMembers();
        } else
          showErrorMessage(res);
      }
      isLoadingUsers = false;
    }
  }

  void searchByQuery(String query) async {
    currentQuery = query;
    loadMembers(replace: true);
  }

  void removeExcludeMembers() {
    memberWrapperModel.list.removeWhere((element) =>
        excludeMembers.map((e) => e).toList().contains(element.id));
    if (excludeBotMembers) {
      memberWrapperModel.list
          .removeWhere((element) => element.id.contains("robot"));
    }
    _membersController.sinkAddSafe(memberWrapperModel);
  }

  void onMemberRoleUpdated(RTCMemberRoleUpdated model) async {
    if ((await _prefs.getStringValue(_prefs.currentTeamId)) == model.tid) {
      final memberWrapper = _membersController.valueOrNull;
      if(memberWrapper != null) {
        memberWrapper.list
            .firstWhereOrNull((element) => element.id == model.uid)!
            .role = model.role;
        _membersController.sinkAddSafe(memberWrapper);
      }
    }
  }

  Future<String> generatePrivateGroupInvitationLink() async {
    generatingLinkController.sinkAddSafe(true);
    final res = await _iChannelRepository.getPrivateGroupInvitationLinkToken(currentTeamId, channelId);
    final cname = await _prefs.getStringValue(_prefs.currentTeamCname);
    generatingLinkController.sinkAddSafe(false);
    if(res is ResultSuccess<String> && res.value.isNotEmpty) {
      final baseUrl =
      cname.isNotEmpty ? "https://$cname" : Injector.instance.baseUrl;
      return "$baseUrl/site-${AppConfig.localeCode}/group/$currentTeamId/$channelId/${res.value}";
    }
    return "";
  }

  void kickOutUser(String userId) async {
    _iChannelRepository.deleteChannelMember(currentTeamId, channelId, userId);
  }
}
