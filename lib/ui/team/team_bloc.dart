import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/domain/common_db/i_common_dao.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/rtc/rtc_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/utils/extensions.dart';
import 'package:rxdart/subjects.dart';

import '../../_di/injector.dart';

class TeamBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final ITeamRepository _iTeamRepository;
  final SharedPreferencesManager _prefs;
  final ICommonDao _iCommonDao;
  final IAccountRepository _iAccountRepository;

  TeamBloC(this._iTeamRepository, this._prefs, this._iCommonDao, this._iAccountRepository);

  final BehaviorSubject<List<TeamModel>> _teamsController = BehaviorSubject.seeded([]);

  Stream<List<TeamModel>> get teamsResult => _teamsController.stream;

  final BehaviorSubject<bool> _hideLeadingController = BehaviorSubject();

  Stream<bool> get hideLeadingResult => _hideLeadingController.stream;

  bool get teamIsEnterprise => Injector.instance.inMemoryData.currentWhiteBrandConfig != null;
  void loadData({RTCMemberDisabledEnabledModel? memberDisabled}) async {
    isLoading = true;
    //teamIsEnterprise = await _prefs.getBoolValue(_prefs.currentTeamEnterprise);
    final currentMemberId = await _prefs.getStringValue(_prefs.userId);
    String currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (memberDisabled != null &&
        !memberDisabled.enable &&
        memberDisabled.tid == currentTeamId &&
        memberDisabled.uid == currentMemberId) {
      await _prefs.setStringValue(_prefs.currentTeamId, "");
      await _prefs.setStringValue(_prefs.currentTeamName, "");
      await _prefs.setStringValue(_prefs.currentChatId, "");
      currentTeamId = "";
      _hideLeadingController.sinkAddSafe(true);
    }
    final teamsRes = await _iTeamRepository.getTeams();
    if (teamsRes is ResultSuccess<List<TeamModel>>) {
      if (currentTeamId.isEmpty && teamsRes.value.isNotEmpty) {
        currentTeamId = teamsRes.value[0].id;
        await _prefs.setStringValue(_prefs.currentTeamId, teamsRes.value[0].id);
        await _prefs.setStringValue(
            _prefs.currentTeamName, teamsRes.value[0].name);
      }
      if (memberDisabled != null && !memberDisabled.enable) {
        teamsRes.value
            .removeWhere((element) => element.id == memberDisabled.tid);
      }
      for (var element in teamsRes.value) {
        element.isSelected = element.id == currentTeamId;
      }
      loadUnreadMessages(teamsRes.value);
      _teamsController.sinkAddSafe(teamsRes.value);
    }
    isLoading = false;
  }

  void doOnTeamUpdated(RTCTeamUpdated value) async {
    if(value.title?.isNotEmpty == true || value.name?.isNotEmpty == true) {
      final teams = _teamsController.valueOrNull ?? [];
      for (var element in teams) {
        if(element.id == value.tid) {
          if(value.title?.isNotEmpty == true) {
            element.title = value.title ?? "";
          }
          if(value.name?.isNotEmpty == true) {
            element.name = value.name ?? "";
          }
        }
      }
      _teamsController.sinkAddSafe(teams);
    }
  }

  void doOnTeamDisabled(String tid) async {
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (currentTeamId == tid) {
      final currentUserId = await _prefs.getStringValue(_prefs.userId);
      loadData(
          memberDisabled: RTCMemberDisabledEnabledModel(
              enable: false, tid: currentTeamId, uid: currentUserId));
    } else {
      final currentTeams = _teamsController.valueOrNull ?? [];
      currentTeams.removeWhere((element) => element.id == tid);
      _teamsController.sinkAddSafe(currentTeams);
      _iTeamRepository.getTeams();
    }
  }

  void doOnMemberDisabledEnabled(RTCMemberDisabledEnabledModel model) async {
    final currentUserId = await _prefs.getStringValue(_prefs.userId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (currentUserId == model.uid &&
        currentTeamId == model.tid &&
        !model.enable) {
      loadData(memberDisabled: model);
    } else if (currentUserId == model.uid && currentTeamId != model.tid) {
      if (model.enable) {
        isLoading = true;
        final currentTeams = _teamsController.valueOrNull ?? [];
        final newTeam = await _iTeamRepository.getTeam(model.tid);
        if (newTeam is ResultSuccess<TeamModel>) {
          newTeam.value.isSelected = false;
          currentTeams.add(newTeam.value);
        }
        loadUnreadMessages(currentTeams);
        _teamsController.sinkAddSafe(currentTeams);
        isLoading = false;
      } else {
        final currentTeams = _teamsController.valueOrNull ?? [];
        currentTeams.removeWhere((element) => element.id == model.tid);
        _teamsController.sinkAddSafe(currentTeams);
        _iTeamRepository.getTeams();
      }
    }
  }

  void loadUnreadMessages(List<TeamModel> teams) async {
    teams.forEach((t) async {
      final res = await _iTeamRepository.teamMessagesUnreadCount(t.id);
      if (res is ResultSuccess<int>) {
        t.unreadMessagesCount = res.value;
        _teamsController.sinkAddSafe(teams);
      }
    });
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      _iAccountRepository.logout();
      await _prefs.logout();
      await _iCommonDao.cleanDB();
      isLoading = false;
    } catch (ex) {
      isLoading = false;
    }
  }

  @override
  void dispose() {
    _teamsController.close();
    _hideLeadingController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }
}
