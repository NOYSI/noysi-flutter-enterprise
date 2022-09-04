import 'dart:convert';
import 'dart:io';

import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/_base_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/usage/i_usage_converter.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:code/domain/user/i_user_api.dart';
import 'package:code/domain/user/i_user_converter.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/file_manager.dart';

class UserApi extends BaseApi implements IUserApi {
  final NetworkHandler _networkHandler;
  final IUserConverter _iUserConverter;
  final IUsageConverter _iUsageConverter;
  final SharedPreferencesManager _prefs;

  UserApi(this._networkHandler, this._iUserConverter, this._iUsageConverter, this._prefs);

  @override
  Future<MemberModel> getTeamMember(String teamId, String memberId) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.members}/$memberId");
    if (res.statusCode == RemoteConstants.code_success) {
      MemberModel model = _iUserConverter.fromJson(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<MemberProfile> getTeamMemberProfile(
      String teamId, String memberId) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.members}/$memberId/profile");
    if (res.statusCode == RemoteConstants.code_success) {
      MemberProfile model = _iUserConverter.fromJsonMemberProfile(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<UsageModel> getTeamMemberUsage(String teamId, String memberId) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.members}/$memberId/usage");
    if (res.statusCode == RemoteConstants.code_success) {
      UsageModel model = _iUsageConverter.fromJson(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<MemberWrapperModel> getTeamMembers(String teamId,
      {String action = 'im.open',
      bool active = true,
      int max = 50,
      int offset = 0,
      String query = "",
      ValueChanged<CancelToken>? onCancelToken}) async {
    String activeStr =
        active ? "${action.isEmpty ? "" : "&"}active=$active" : "";
    String actionStr = action.isEmpty ? "" : "action=$action";
    String maxStr =
        activeStr.isNotEmpty || actionStr.isNotEmpty ? "&max=$max" : "max=$max";
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.members}?$actionStr$activeStr$maxStr&offset=$offset&q=${Uri.encodeFull(query)}",
        onCancelToken: onCancelToken);
    if (res.statusCode == RemoteConstants.code_success) {
      return _iUserConverter.fromJsonMemberWrapper(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<MemberWrapperModel> getChannelMembers(String teamId, String channelId,
      {int max = 50,
      int offset = 0,
      bool all = false, bool active = true,
      String query = "",
      ValueChanged<CancelToken>? onCancelToken}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.members}?active=$active&${all ? "all=$all" : "max=$max&skip=$offset&q=${Uri.encodeFull(query)}"}",
        onCancelToken: onCancelToken);
    if (res.statusCode == RemoteConstants.code_success) {
      return _iUserConverter.fromJsonMemberWrapper(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<int> getTeamMembersCount(String teamId) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.members}/count");
    if (res.statusCode == RemoteConstants.code_success) {
      int model = res.data["count"];
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<bool> putTeamMemberNotifications(MemberNotification model) async {
    final userId = await _prefs.getStringValue(_prefs.userId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final body = jsonEncode(_iUserConverter.toJsonMemberNotification(model));
    final res = await _networkHandler.put(
        body: body,
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.members}/$userId/notifications");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<String> putTeamMemberRole(
      String teamId, String memberId, String role) async {
    final body = jsonEncode({"role": role});
    final res = await _networkHandler.put(
        body: body,
        path: "${Endpoint.teams}/$teamId/${Endpoint.members}/$memberId/role");
    if (res.statusCode == RemoteConstants.code_success) {
      String model = res.data["role"];
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<bool> putTeamMemberUpload(File file) async {
    final FileCreateModel fileCreateModel = FileCreateModel(
        size: file.lengthSync(),
        mime: FileManager.lookupMime(file.path),
        type: 'file',
        path: file.path);
    final userId = await _prefs.getStringValue(_prefs.userId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final path =
        "${Endpoint.teams}/$currentTeamId${Endpoint.members}/$userId/upload";
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${Endpoint.apiVersion}$path";
    final res = await _networkHandler.postFile(
        path: url,
        file: file,
        fileCreateModel: fileCreateModel,
        useTokenAuthorization: true);
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> changePassword(String password) async {
    final body = jsonEncode({"password": password});
    final userId = await _prefs.getStringValue(_prefs.userId);
    final res =
        await _networkHandler.put(path: "/users/$userId/password", body: body);
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> updateProfile(MemberProfile memberProfile) async {
    final body = _iUserConverter.toJsonMemberProfile(memberProfile);
    final userId = await _prefs.getStringValue(_prefs.userId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.members}/$userId/profile",
        body: jsonEncode(body));
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deleteUserStatus() async {
    final userId = await _prefs.getStringValue(_prefs.userId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    // final res = await _networkHandler.delete(
    //     path:
    //         "${Endpoint.teams}/$currentTeamId${Endpoint.members}/$userId/status");
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.members}/$userId/status",
        body: jsonEncode({"status_icon": "", "status_txt": ""}));
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> updateUserStatus(String icon, String txt) async {
    final userId = await _prefs.getStringValue(_prefs.userId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.members}/$userId/status",
        body: jsonEncode({"status_icon": icon, "status_txt": txt}));
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deactivateUserTeam(String tid, String uid) async {
    final res = await _networkHandler.put(
        path: "${Endpoint.teams}/$tid${Endpoint.members}/$uid/deactivate");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> activateUserTeam(String tid, String uid) async {
    final res = await _networkHandler.put(
        path: "${Endpoint.teams}/$tid${Endpoint.members}/$uid/activate");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deactivateUserTeams(String uid) async {
    final res =
        await _networkHandler.put(path: "${Endpoint.users}/$uid/deactivate");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deleteAccount(String uid) async {
    final res = await _networkHandler.delete(path: "${Endpoint.users}/$uid/delete");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }
}
