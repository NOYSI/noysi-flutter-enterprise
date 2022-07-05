import 'dart:convert';
import 'dart:io';

import 'package:code/data/api/_base_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/team/i_team_api.dart';
import 'package:code/domain/team/i_team_converter.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/usage/i_usage_converter.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/file/file_model.dart';
import '../../utils/file_manager.dart';
import '../_shared_prefs.dart';

class TeamApi extends BaseApi implements ITeamApi {
  final NetworkHandler _networkHandler;
  final ITeamConverter _iTeamConverter;
  final IUsageConverter _iUsageConverter;
  final SharedPreferencesManager _prefs;

  TeamApi(this._networkHandler, this._iTeamConverter, this._iUsageConverter,
      this._prefs);

  @override
  Future<List<TeamModel>> getTeams() async {
    final res = await _networkHandler.get(path: Endpoint.teams);
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = jsonDecode(res.data)["list"];
      return l.map((model) => _iTeamConverter.fromJson(model)).toList();
    }
    throw serverException(res);
  }

  @override
  Future<TeamModel> getTeam(String teamId) async {
    final res = await _networkHandler.get(path: "${Endpoint.teams}/$teamId");
    if (res.statusCode == RemoteConstants.code_success) {
      TeamModel model = _iTeamConverter.fromJson(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<TeamModel> createTeam(TeamCreateModel model) async {
    final body = jsonEncode(_iTeamConverter.toJsonCreate(model));
    final res = await _networkHandler.post(path: Endpoint.teams, body: body);
    if (res.statusCode == RemoteConstants.code_success) {
      TeamModel model = _iTeamConverter.fromJson(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<UsageModel> teamUsage(String teamId) async {
    final res =
        await _networkHandler.get(path: "${Endpoint.teams}/$teamId/usage");
    if (res.statusCode == RemoteConstants.code_success) {
      UsageModel model = _iUsageConverter.fromJson(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<int> teamMessagesUnreadCount(String teamId) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.messages}${Endpoint.unread_count}");
    if (res.statusCode == RemoteConstants.code_success) {
      int count = res.data["count"];
      return count;
    }
    throw serverException(res);
  }

  @override
  Future<TeamJoinedModel> joinTeam(String teamName) async {
    final res =
        await _networkHandler.put(path: "${Endpoint.teams}/$teamName/join");
    if (res.statusCode == RemoteConstants.code_success) {
      TeamJoinedModel model =
          _iTeamConverter.fromJsonTeamJoined(jsonDecode(res.data));
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<List<String>> invite(
      String teamId, InvitationTeamModel invitationTeamModel) async {
    final invitations = invitationTeamModel.invitations
        .map((e) => _iTeamConverter.toJsonInvitations(e))
        .toList();
    final body =
        invitationTeamModel.cid != null && invitationTeamModel.cid!.isNotEmpty
            ? {
                "body": invitationTeamModel.body,
                "cid": invitationTeamModel.cid,
                "invitations": [...invitations],
                "language": invitationTeamModel.language,
                "role": invitationTeamModel.role.toLowerCase(),
                "senddate": invitationTeamModel.sendDate?.millisecondsSinceEpoch
              }
            : {
                "body": invitationTeamModel.body,
                "invitations": [...invitations],
                "language": invitationTeamModel.language,
                "role": invitationTeamModel.role.toLowerCase(),
                "senddate": invitationTeamModel.sendDate?.millisecondsSinceEpoch
              };
    final res = await _networkHandler.post(
        path: "${Endpoint.teams}/$teamId/invitations", body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success) {
      final map = jsonDecode(res.data);
      List<String> model = List.from(map["emails"]);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<InvitationPendingAcceptedWrappedModel> getPendingAcceptedInvitations(
      String teamId,
      {query: "",
      status: "",
      offset: 0,
      max: 100,
      dateOrder: 1}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId/invitations?q=${Uri.encodeFull(query)}&status=$status&offset=$offset&max=$max&dateorder=$dateOrder");
    if (res.statusCode == RemoteConstants.code_success) {
      InvitationPendingAcceptedWrappedModel model = _iTeamConverter
          .fromJsonInvitationPendingAcceptedWrappedModel(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<bool> resendInvitation(String teamId, String invitationId) async {
    final res = await _networkHandler.put(
        path: "${Endpoint.teams}/$teamId/invitations/$invitationId/resend");
    if (res.statusCode == RemoteConstants.code_success) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> revokeInvitation(String teamId, String invitationId) async {
    final res = await _networkHandler.delete(
        path: "${Endpoint.teams}/$teamId/invitations/$invitationId");
    if (res.statusCode == RemoteConstants.code_success) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<SearchTasksModel> searchTasks(String teamId,
      {int max = 100,
      int offset = 0,
      String query = "",
      ValueChanged<CancelToken>? onCancelToken}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId/search?entity=tasks&offset=$offset&max=$max&q=${Uri.encodeFull(query)}",
        onCancelToken: onCancelToken);
    if (res.statusCode == RemoteConstants.code_success) {
      SearchTasksModel model =
          _iTeamConverter.fromJsonSearchTasks(jsonDecode(res.data));
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<SearchFilesModel> searchFiles(String teamId,
      {int max = 100,
      int offset = 0,
      String query = "",
      ValueChanged<CancelToken>? onCancelToken}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId/search?entity=files&offset=$offset&max=$max&q=${Uri.encodeFull(query)}",
        onCancelToken: onCancelToken);
    if (res.statusCode == RemoteConstants.code_success) {
      SearchFilesModel model =
          _iTeamConverter.fromJsonSearchFiles(jsonDecode(res.data));
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<SearchMembersModel> searchMembers(String teamId,
      {int max = 100,
      int offset = 0,
      String query = "",
      ValueChanged<CancelToken>? onCancelToken}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId/search?active=true&entity=members&offset=$offset&max=$max&q=${Uri.encodeFull(query)}",
        onCancelToken: onCancelToken);
    if (res.statusCode == RemoteConstants.code_success) {
      SearchMembersModel model =
          _iTeamConverter.fromJsonSearchMembers(jsonDecode(res.data));
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<SearchMessagesModel> searchMessages(String teamId,
      {int max = 100,
      int offset = 0,
      String query = "",
      ValueChanged<CancelToken>? onCancelToken}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId/search?entity=messages&offset=$offset&max=$max&q=${Uri.encodeFull(query)}",
        onCancelToken: onCancelToken);
    if (res.statusCode == RemoteConstants.code_success) {
      SearchMessagesModel model =
          _iTeamConverter.fromJsonSearchMessages(jsonDecode(res.data));
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<bool> checkTeamNameInUse(String teamName) async {
    final res = await _networkHandler.head(
        path: "${Endpoint.teams}/$teamName", useVersionInUrl: true);
    if (res.statusCode == RemoteConstants.code_not_found) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<WhiteBrandConfig> getWhiteBrandConfig(String domain) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.public}${Endpoint.enterprise}/$domain");
    if (res.statusCode == RemoteConstants.code_success) {
      return _iTeamConverter.fromJsonWhiteBrandConfig(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<TeamModel> updateTeam(TeamModel model, {String newTitle = ""}) async {
    final res = await _networkHandler.put(
        path: "${Endpoint.teams}/${model.id}/update",
        body: jsonEncode(
            _iTeamConverter.toJsonUpdate(model, newTitle: newTitle)));
    if (res.statusCode == RemoteConstants.code_success) {
      return _iTeamConverter.fromJson(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<bool> updateAvatar(String tid, File f) async {
    final FileCreateModel fileCreateModel = FileCreateModel(
        size: f.lengthSync(),
        mime: FileManager.lookupMime(f.path),
        type: 'file',
        path: f.path);
    final path = "${Endpoint.teams}/$tid/upload";
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${Endpoint.apiVersion}$path";
    final res = await _networkHandler.postFile(
        path: url,
        file: f,
        fileCreateModel: fileCreateModel,
        useTokenAuthorization: true);
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> updateTeamTheme(String tid, TeamTheme theme) async {
    final res = await _networkHandler.put(
        path: "${Endpoint.teams}/$tid/theme",
        body: jsonEncode(_iTeamConverter.toJsonTheme(theme)));
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }
}
