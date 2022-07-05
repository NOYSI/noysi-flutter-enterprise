import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';

abstract class ITeamApi {
  Future<List<TeamModel>> getTeams();

  Future<List<String>> invite(
      String teamId, InvitationTeamModel invitationTeamModel);

  Future<InvitationPendingAcceptedWrappedModel> getPendingAcceptedInvitations(
      String teamId,
      {String query,
      String status,
      int offset,
      int max,
      int dateOrder});

  Future<bool> revokeInvitation(String teamId, String invitationId);

  Future<bool> resendInvitation(String teamId, String invitationId);

  Future<TeamModel> getTeam(String teamId);

  Future<TeamJoinedModel> joinTeam(String teamName);

  Future<TeamModel> createTeam(TeamCreateModel model);

  Future<UsageModel> teamUsage(String teamId);

  Future<int> teamMessagesUnreadCount(String teamId);

  Future<SearchMembersModel> searchMembers(
      String teamId,{ int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<SearchFilesModel> searchFiles(
      String teamId,{int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<SearchMessagesModel> searchMessages(
      String teamId,{ int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<bool> checkTeamNameInUse(String teamName);

  Future<SearchTasksModel> searchTasks(
      String teamId,{int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<WhiteBrandConfig> getWhiteBrandConfig(String domain);

  Future<TeamModel> updateTeam(TeamModel model, {String newTitle = ""});

  Future<bool> updateAvatar(String tid, File f);

  Future<bool> updateTeamTheme(String tid, TeamTheme theme);
}
