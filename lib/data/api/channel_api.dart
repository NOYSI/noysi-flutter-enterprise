import 'dart:convert';

import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/_base_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_api.dart';
import 'package:code/domain/channel/i_channel_converter.dart';

import '../../enums.dart';

class ChannelApi extends BaseApi implements IChannelApi {
  final NetworkHandler _networkHandler;
  final IChannelConverter _iChannelConverter;
  final SharedPreferencesManager _prefs;

  ChannelApi(this._networkHandler, this._iChannelConverter, this._prefs);

  @override
  Future<ChannelModel> createChannel(
      String teamId, ChannelModelCreate model) async {
    final body = jsonEncode(_iChannelConverter.toJsonCreate(model));
    final res = await _networkHandler.post(
        path: "${Endpoint.teams}/$teamId${Endpoint.channels}", body: body);
    if (res.statusCode == RemoteConstants.code_success) {
      ChannelModel model = _iChannelConverter.fromJson(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<List<ChannelModel>> getChannels(String teamId,
      {type = "channel"}) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.channels}?type=$type");
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = jsonDecode(res.data)["list"];
      return l.map((model) => _iChannelConverter.fromJson(model)).toList();
    }
    throw serverException(res);
  }

  @override
  Future<int> deleteChannel(String teamId, String channelId) async {
    final res = await _networkHandler.delete(
        path: "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return res.statusCode ?? RemoteConstants.code_host_unable;
    }
    throw serverException(res);
  }

  @override
  Future<ChannelModel> getChannel(String teamId, String channelId) async {
    final res = await _networkHandler.get(
        path: "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId");
    if (res.statusCode == RemoteConstants.code_success) {
      ChannelModel model = _iChannelConverter.fromJson(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<ChannelModel> renameChannel(String teamId, String channelId, String name) async {
    final body = jsonEncode({"name": name});
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId/rename",
      body: body);
    if (res.statusCode == RemoteConstants.code_success) {
      return _iChannelConverter.fromJson(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<ChannelLinkWrappedModel> geChannelLinks(
      {int max = 50, int offset = 0, CommonSort sort = CommonSort.desc}) async {
    final currentChannelId = await _prefs.getStringValue(_prefs.currentChatId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final sortStr = sort == CommonSort.desc ? "desc" : "asc";
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.channels}/$currentChannelId/links?max=$max&offset=$offset&sort=ts:$sortStr");
    if (res.statusCode == RemoteConstants.code_success) {
      return _iChannelConverter.fromJsonChannelLinkWrapped(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<ChannelMentionWrappedModel> geChannelMentions(
      {int max = 50, int offset = 0, CommonSort sort = CommonSort.desc}) async {
    final currentChannelId = await _prefs.getStringValue(_prefs.currentChatId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final sortStr = sort == CommonSort.desc ? "desc" : "asc";
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.channels}/$currentChannelId/mentions?max=$max&offset=$offset&sort=ts:$sortStr");
    if (res.statusCode == RemoteConstants.code_success) {
      return _iChannelConverter.fromJsonChannelMentionWrapped(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<ChannelModel> create1x1Channel(
      String otherId, String currentTeamId) async {
    final body = jsonEncode({"other": otherId});
    final res = await _networkHandler.post(
        path: "${Endpoint.teams}/$currentTeamId${Endpoint.channels}",
        body: body);

    if (res.statusCode == RemoteConstants.code_success) {
      return _iChannelConverter.fromJson(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<bool> setFavorite(
      bool setAsFavorite, String currentTeamId, String channelId) async {
    if (setAsFavorite) {
      final res = await _networkHandler.put(
          path:
              "${Endpoint.teams}/$currentTeamId${Endpoint.channels}/$channelId/favorite");
      if (res.statusCode == RemoteConstants.code_success_accepted) {
        return true;
      }
      throw serverException(res);
    } else {
      final res = await _networkHandler.delete(
          path:
              "${Endpoint.teams}/$currentTeamId${Endpoint.channels}/$channelId/favorite");
      if (res.statusCode == RemoteConstants.code_success_accepted) {
        return true;
      }
      if (res.statusCode == RemoteConstants.code_success_accepted) {
        return true;
      }
      throw serverException(res);
    }
  }

  @override
  Future<bool> putChannelMemberNotifications(NotificationModel model,
      String currentTeamId, String currentChannelId) async {
    final currentUserId = await _prefs.getStringValue(_prefs.userId);
    final body = jsonEncode(_iChannelConverter.toJsonNotification(model));
    final res = await _networkHandler.put(
        body: body,
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.channels}/$currentChannelId${Endpoint.members}/$currentUserId/notifications");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<int> deleteChannelMember(
      String teamId, String channelId, String memberId) async {
    final res = await _networkHandler.delete(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.members}/$memberId");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return res.statusCode ?? RemoteConstants.code_host_unable;
    }
    throw serverException(res);
  }

  @override
  Future<ChannelModel> putChannelMember(
      String teamId, String channelId, String memberId) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.members}/$memberId");
    if (res.statusCode == RemoteConstants.code_success) {
      ChannelModel model = _iChannelConverter.fromJson(res.data);
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<int> putChannelMemberClose(
      String teamId, String channelId, String memberId) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.members}/$memberId/close");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return res.statusCode ?? RemoteConstants.code_host_unable;
    }
    throw serverException(res);
  }

  @override
  Future<int> putChannelMemberMark(String channelId) async {
    final userId = await _prefs.getStringValue(_prefs.userId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.channels}/$channelId${Endpoint.members}/$userId/mark");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return res.statusCode ?? RemoteConstants.code_host_unable;
    }
    throw serverException(res);
  }

  @override
  Future<int> putChannelMemberOpen(
      String teamId, String channelId, String memberId) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId/${Endpoint.channels}/$channelId/${Endpoint.members}/$memberId/open");
    if (res.statusCode == RemoteConstants.code_success) {
      return res.statusCode ?? RemoteConstants.code_host_unable;
    }
    throw serverException(res);
  }

  @override
  Future<String> getPrivateGroupInvitationLinkToken(String tid, String cid) async {
    final res = await _networkHandler.put(path: "${Endpoint.teams}/$tid${Endpoint.channels}/$cid${Endpoint.members}/link");
    if (res.statusCode == RemoteConstants.code_success) {
      return res.data['token_group'] ?? "";
    }
    throw serverException(res);
  }


}
