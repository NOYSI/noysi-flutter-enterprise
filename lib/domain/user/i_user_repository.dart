import 'dart:io';

import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IUserRepository {
  Future<Result<MemberWrapperModel>> getTeamMembers(String teamId,
      {String action, bool active = true, int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<Result<MemberModel>> getTeamMember(String teamId, String memberId);

  Future<Result<MemberProfile>> getTeamMemberProfile(
      String teamId, String memberId);

  Future<Result<UsageModel>> getTeamMemberUsage(String teamId, String memberId);

  Future<Result<bool>> putTeamMemberNotifications(MemberNotification model);

  Future<Result<bool>> putTeamMemberUpload(File file);

  Future<Result<String>> putTeamMemberRole(
      String teamId, String memberId, String role);

  Future<Result<int>> getTeamMembersCount(String teamId);

  Future<Result<MemberWrapperModel>> getChannelMembers(
      String teamId, String channelId,
      {int max = 50, int offset = 0, bool all = false, bool active = true, String query = "", ValueChanged<CancelToken>? onCancelToken});

  Future<Result<bool>> changePassword(String password);

  Future<Result<bool>> updateProfile(MemberProfile memberProfile);

  Future<Result<bool>> deleteUserStatus();

  Future<Result<bool>> updateUserStatus(String icon, String text);

  Future<Result<bool>> deactivateUserTeam(String tid, String uid);

  Future<Result<bool>> activateUserTeam(String tid, String uid);

  Future<Result<bool>> deactivateUserTeams(String uid);

  Future<Result<bool>> deleteAccount(String uid);
}
