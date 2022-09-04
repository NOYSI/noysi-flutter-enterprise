import 'dart:io';

import 'package:code/domain/usage/usage_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IUserApi {
  Future<MemberWrapperModel> getTeamMembers(String teamId,
      {String action, bool active = true, int max, int offset, String query, ValueChanged<CancelToken>? onCancelToken});

  Future<MemberModel> getTeamMember(String teamId, String memberId);

  Future<MemberProfile> getTeamMemberProfile(String teamId, String memberId);

  Future<UsageModel> getTeamMemberUsage(String teamId, String memberId);

  Future<bool> putTeamMemberNotifications(MemberNotification model);

  Future<bool> putTeamMemberUpload(File file);

  Future<String> putTeamMemberRole(String teamId, String memberId, String role);

  Future<int> getTeamMembersCount(String teamId);

  Future<MemberWrapperModel> getChannelMembers(String teamId, String channelId,{
    int max = 50,
    int offset = 0,
    bool all = false, bool active = true,
    String query = "", ValueChanged<CancelToken>? onCancelToken});

  Future<bool> changePassword(String password);

  Future<bool> updateProfile(MemberProfile memberProfile);

  Future<bool> updateUserStatus(String icon, String txt);

  Future<bool> deleteUserStatus();

  Future<bool> deactivateUserTeam(String tid, String uid);

  Future<bool> activateUserTeam(String tid, String uid);

  Future<bool> deactivateUserTeams(String uid);

  Future<bool> deleteAccount(String uid);
}
