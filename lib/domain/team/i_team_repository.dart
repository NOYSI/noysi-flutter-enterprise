import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';

abstract class ITeamRepository {
  Future<Result<List<TeamModel>>> getTeams();

  Future<Result<TeamModel>> getTeam(String teamId);

  Future<Result<List<String>>> invite(
      String teamId, InvitationTeamModel invitationTeamModel);

  Future<Result<InvitationPendingAcceptedWrappedModel>>
      getPendingAcceptedInvitations(String teamId,
          {String query, String status, int offset, int max, int dateOrder});

  Future<Result<bool>> revokeInvitation(String teamId, String invitationId);

  Future<Result<bool>> resendInvitation(String teamId, String invitationId);

  Future<Result<TeamJoinedModel>> joinTeam(String teamName, {String? teamId, bool forceApi = false});

  Future<Result<TeamModel>> createTeam(TeamCreateModel model);

  Future<Result<bool>> checkTeamNameInUse(String teamName);

  Future<Result<UsageModel>> teamUsage(String teamId);

  Future<Result<int>> teamMessagesUnreadCount(String teamId);

  Future<Result<SearchMembersModel>> searchMembers(
      String teamId,{ int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<Result<SearchFilesModel>> searchFiles(
      String teamId,{ int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<Result<SearchMessagesModel>> searchMessages(
      String teamId,{ int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<Result<SearchTasksModel>> searchTasks(
      String teamId,{ int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<Result<WhiteBrandConfig>> getWhiteBrandConfig(String domain);

  Future<Result<TeamModel>> updateTeam(TeamModel model, {String newTitle = ""});

  Future<Result<bool>> updateAvatar(String tid, File f);

  Future<Result<bool>> updateTeamTheme(String tid, TeamTheme theme);
}
