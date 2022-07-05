import 'dart:io';

import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/channel/i_channel_dao.dart';
import 'package:code/domain/team/i_team_api.dart';
import 'package:code/domain/team/i_team_dao.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:code/enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:code/utils/extensions.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<TeamJoinedModel?> joinedTeamLoaded = BehaviorSubject();

class TeamRepository extends BaseRepository implements ITeamRepository {
  final ITeamApi _iTeamApi;
  final InMemoryData _inMemoryData;
  final ITeamDao _iTeamDao;
  final IChannelDao _iChannelDao;

  TeamRepository(this._iTeamApi, this._inMemoryData,
      this._iTeamDao, this._iChannelDao);

  @override
  Future<Result<List<TeamModel>>> getTeams() async {
    try {
      List<TeamModel> teams = await _iTeamDao.getTeams();
      if (teams.isNotEmpty) {
        _iTeamApi.getTeams().then((value) async {
          await _iTeamDao.removeTeams();
          await _iTeamDao.saveTeams(value);
        });
      } else {
        teams = await _iTeamApi.getTeams();
        await _iTeamDao.removeTeams();
        await _iTeamDao.saveTeams(teams);
      }
      _inMemoryData.addReplaceTeams(teams);
      return ResultSuccess(value: teams);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TeamModel>> getTeam(String teamId) async {
    try {
      TeamModel? team = await _iTeamDao.getTeam(teamId);
      if (team != null) {
        _iTeamApi.getTeam(teamId).then((value) async {
          await _iTeamDao.saveTeam(value);
        });
      } else {
        team = await _iTeamApi.getTeam(teamId);
        await _iTeamDao.saveTeam(team);
      }
      _inMemoryData.addReplaceTeam(team);
      return ResultSuccess(value: team);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> teamMessagesUnreadCount(String teamId) async {
    try {
      final res = await _iTeamApi.teamMessagesUnreadCount(teamId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<UsageModel>> teamUsage(String teamId) async {
    try {
      final res = await _iTeamApi.teamUsage(teamId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TeamModel>> createTeam(TeamCreateModel model) async {
    try {
      final res = await _iTeamApi.createTeam(model);
      await _iTeamDao.saveTeam(res);
      _inMemoryData.addReplaceTeam(res);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TeamJoinedModel>> joinTeam(
      String teamName, {String? teamId, bool forceApi = false}) async {
    try {
      TeamJoinedModel? joinedTeam = forceApi || teamId?.isEmpty == true ? null : await _iTeamDao.getJoinedTeam(teamId ?? "");
      if (joinedTeam != null) {
        _iTeamApi.joinTeam(teamName).then((resJoinedTeam) async {
          joinedTeamLoaded.sinkAddSafe(resJoinedTeam);
          resJoinedTeam.channels.setTeamId(resJoinedTeam.team.id);
          resJoinedTeam.groups.setTeamId(resJoinedTeam.team.id);
          resJoinedTeam.messages1x1.setTeamId(resJoinedTeam.team.id);
          await _iTeamDao.saveJoinedTeam(resJoinedTeam);
          resJoinedTeam.channels.setTeamId(resJoinedTeam.team.id);
          resJoinedTeam.groups.setTeamId(resJoinedTeam.team.id);
          resJoinedTeam.messages1x1.setTeamId(resJoinedTeam.team.id);
          await _iChannelDao.saveChannels([
            ...resJoinedTeam.channels,
            ...resJoinedTeam.groups,
            ...resJoinedTeam.messages1x1
          ]);
          await fillInMemoryData(resJoinedTeam);
        });
      } else {
        joinedTeam = await _iTeamApi.joinTeam(teamName);
        await _iTeamDao.saveJoinedTeam(joinedTeam);
        joinedTeam.channels.setTeamId(joinedTeam.team.id);
        joinedTeam.groups.setTeamId(joinedTeam.team.id);
        joinedTeam.messages1x1.setTeamId(joinedTeam.team.id);
        await _iChannelDao.saveChannels([
          ...joinedTeam.channels,
          ...joinedTeam.groups,
          ...joinedTeam.messages1x1
        ]);
        await fillInMemoryData(joinedTeam);
      }
      return ResultSuccess(value: joinedTeam);
    } catch (ex) {
      print(ex);
      return resultError(ex);
    }
  }

  Future<void> fillInMemoryData(TeamJoinedModel res) async {
    ///Saving in-memory joined team
    _inMemoryData.addReplaceTeam(res.team);

    if(_inMemoryData.currentTeam?.id == res.team.id) {
      _inMemoryData.currentTeam = res.team;
      final idx = (res.channels + res.groups + res.messages1x1).indexWhere((element) => element.id == _inMemoryData.currentChannel?.id);
      if(idx > -1) {
        _inMemoryData.currentChannel = (res.channels + res.groups + res.messages1x1)[idx];
        _inMemoryData.currentChannel?.tid = res.team.id;
      }
    }

    ///Saving in-memory channels
    res.channels.forEach((element) {
      element.tid = res.team.id;
    });
    _inMemoryData.addReplaceChannels(res.channels);

    ///Saving in-memory messages 1x1
    res.messages1x1.forEach((element) {
      element.tid = res.team.id;
    });
    _inMemoryData.addReplaceChannels(res.messages1x1);

    ///Saving in-memory groups
    res.groups.forEach((element) {
      element.tid = res.team.id;
    });
    _inMemoryData.addReplaceChannels(res.groups);

    ///Saving in-memory members
    _inMemoryData.addReplaceMembers(res.memberWrapperModel.list);

    ///Looking for members if necessary
    final membersIds = res.messages1x1.map((e) => e.other).toList();
    await _inMemoryData.resolveMembersAsync(membersIds);
  }

  @override
  Future<Result<List<String>>> invite(
      String teamId, InvitationTeamModel invitationTeamModel) async {
    try {
      final res = await _iTeamApi.invite(teamId, invitationTeamModel);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<InvitationPendingAcceptedWrappedModel>>
      getPendingAcceptedInvitations(String teamId,
          {query: "", status: "", offset: 0, max: 100, dateOrder: 1}) async {
    try {
      final res = await _iTeamApi.getPendingAcceptedInvitations(teamId,
          query: query,
          status: status,
          offset: offset,
          max: max,
          dateOrder: dateOrder);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> resendInvitation(
      String teamId, String invitationId) async {
    try {
      final res = await _iTeamApi.resendInvitation(teamId, invitationId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> revokeInvitation(
      String teamId, String invitationId) async {
    try {
      final res = await _iTeamApi.revokeInvitation(teamId, invitationId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<SearchTasksModel>> searchTasks(String teamId,
      {int max = 100, int offset = 0, String query = "", ValueChanged<CancelToken>? onCancelToken}) async {
    try {
      final res = await _iTeamApi.searchTasks(teamId,
          max: max, offset: offset, query: query, onCancelToken: onCancelToken);
      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.uid ?? "").toList());
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<SearchFilesModel>> searchFiles(String teamId,
      {int max = 100, int offset = 0, String query = "", ValueChanged<CancelToken>? onCancelToken}) async {
    try {
      final res = await _iTeamApi.searchFiles(teamId,
          max: max, offset: offset, query: query, onCancelToken: onCancelToken);
      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.uid ?? "").toList());
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<SearchMembersModel>> searchMembers(String teamId,
      {int max = 100, int offset = 0, String query = "", ValueChanged<CancelToken>? onCancelToken}) async {
    try {
      final res = await _iTeamApi.searchMembers(teamId,
          max: max, offset: offset, query: query, onCancelToken: onCancelToken);
      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.id).toList());
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<SearchMessagesModel>> searchMessages(String teamId,
      {int max = 100, int offset = 0, String query = "", ValueChanged<CancelToken>? onCancelToken}) async {
    try {
      final res = await _iTeamApi.searchMessages(teamId,
          max: max, offset: offset, query: query, onCancelToken: onCancelToken);
      res.list.forEach((element) {
        element.messageStatus = MessageStatus.Sent;
      });
      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.uid).toList());
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> checkTeamNameInUse(String teamName) async {
    try {
      final res = await _iTeamApi.checkTeamNameInUse(teamName);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<WhiteBrandConfig>> getWhiteBrandConfig(String domain) async {
    try {
      final res = await _iTeamApi.getWhiteBrandConfig(domain);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<TeamModel>> updateTeam(TeamModel model, {String newTitle = ""}) async {
    try {
      final res = await _iTeamApi.updateTeam(model, newTitle: newTitle);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> updateAvatar(String tid, File f) async {
    try {
      final res = await _iTeamApi.updateAvatar(tid, f);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> updateTeamTheme(String tid, TeamTheme theme) async {
    try {
      final res = await _iTeamApi.updateTeamTheme(tid, theme);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
