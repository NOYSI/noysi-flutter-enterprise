import 'dart:io';

import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:code/domain/user/i_user_api.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserRepository extends BaseRepository implements IUserRepository {
  final IUserApi _iUserApi;
  final InMemoryData _inMemoryData;

  UserRepository(this._iUserApi, this._inMemoryData);

  @override
  Future<Result<MemberWrapperModel>> getChannelMembers(
      String teamId, String channelId,
      {int max = 50, int offset = 0, bool all = false, bool active = true, String query = "", ValueChanged<CancelToken>? onCancelToken}) async {
    try {
      final res = await _iUserApi.getChannelMembers(teamId, channelId, active: active, all: all,
          max: max, offset: offset, query: query, onCancelToken: onCancelToken);
      _inMemoryData.addReplaceMembers(res.list);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<MemberModel>> getTeamMember(
      String teamId, String memberId) async {
    try {
      final res = await _iUserApi.getTeamMember(teamId, memberId);
      _inMemoryData.addReplaceMember(res);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<MemberProfile>> getTeamMemberProfile(
      String teamId, String memberId) async {
    try {
      final res = await _iUserApi.getTeamMemberProfile(teamId, memberId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<UsageModel>> getTeamMemberUsage(
      String teamId, String memberId) async {
    try {
      final res = await _iUserApi.getTeamMemberUsage(teamId, memberId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<MemberWrapperModel>> getTeamMembers(String teamId,
      {String action = 'im.open',
      bool active = true,
      int max = 50,
      int offset = 0,
      String query = "", ValueChanged<CancelToken>? onCancelToken}) async {
    try {
      final res = await _iUserApi.getTeamMembers(teamId,
          action: action,
          active: active,
          max: max,
          offset: offset,
          query: query, onCancelToken: onCancelToken);
      if(active) {
        res.list.removeWhere((element) => element.isDeletedUser);
      }
      _inMemoryData.addReplaceMembers(res.list);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> getTeamMembersCount(String teamId) async {
    try {
      final res = await _iUserApi.getTeamMembersCount(teamId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTeamMemberNotifications(
      MemberNotification model) async {
    try {
      final res = await _iUserApi.putTeamMemberNotifications(model);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<String>> putTeamMemberRole(
      String teamId, String memberId, String role) async {
    try {
      final res = await _iUserApi.putTeamMemberRole(teamId, memberId, role);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putTeamMemberUpload(File file) async {
    try {
      final res = await _iUserApi.putTeamMemberUpload(file);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> changePassword(String password) async {
    try {
      final res = await _iUserApi.changePassword(password);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> updateProfile(MemberProfile memberProfile) async {
    try {
      final res = await _iUserApi.updateProfile(memberProfile);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> deleteUserStatus() async {
    try {
      final res = await _iUserApi.deleteUserStatus();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> updateUserStatus(String icon, String text) async {
    try {
      final res = await _iUserApi.updateUserStatus(icon, text);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  Future<Result<bool>> deactivateUserTeam(String tid, String uid) async {
    try {
      final res = await _iUserApi.deactivateUserTeam(tid, uid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> activateUserTeam(String tid, String uid) async {
    try {
      final res = await _iUserApi.activateUserTeam(tid, uid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  Future<Result<bool>> deactivateUserTeams(String uid) async {
    try {
      final res = await _iUserApi.deactivateUserTeams(uid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> deleteAccount(String uid) async {
    try {
      final res = await _iUserApi.deleteAccount(uid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
