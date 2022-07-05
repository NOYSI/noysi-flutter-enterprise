import 'dart:convert';

import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/_base_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/message/i_message_api.dart';
import 'package:code/domain/message/i_message_converter.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MessageApi extends BaseApi implements IMessageApi {
  final NetworkHandler _networkHandler;
  final IMessageConverter _iMessageConverter;
  final SharedPreferencesManager _prefs;

  MessageApi(this._networkHandler, this._iMessageConverter, this._prefs);

  @override
  Future<MessageModel> getMessage(
      String teamId, String channelId, String messageId) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}/$messageId");
    if (res.statusCode == RemoteConstants.code_success) {
      final message = _iMessageConverter.fromJson(res.data);
      return message;
    }
    throw serverException(res);
  }

  @override
  Future<MessageWrapperModel> getMessageNext(
      String teamId, String channelId, String messageId, {ValueChanged<CancelToken>? onCancelToken}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}/$messageId/next", onCancelToken: onCancelToken);
    if (res.statusCode == RemoteConstants.code_success) {
      final message = _iMessageConverter.fromJsonWrapper(res.data);
      return message;
    }
    throw serverException(res);
  }

  @override
  Future<MessageWrapperModel> getMessagePrevious(
      String teamId, String channelId, String messageId, {ValueChanged<CancelToken>? onCancelToken}) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}/$messageId/previous", onCancelToken: onCancelToken);
    if (res.statusCode == RemoteConstants.code_success) {
      return _iMessageConverter.fromJsonWrapper(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<MessageWrapperModel> getMessages(
      String teamId, String channelId, int ts) async {
    String tsQuery = "";
    // if (ts != null) {
    //   final DateTime mark = DateTime.fromMillisecondsSinceEpoch(ts);
    //   print("last visit ${mark.toIso8601String()}");
    //   int timeInMillis = mark.toUtc().millisecondsSinceEpoch;
    //   tsQuery = "?ts=$timeInMillis";
    // }

    final res = await _networkHandler.get(
      path:
          "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}$tsQuery",
    );
    if (res.statusCode == RemoteConstants.code_success) {
      return _iMessageConverter.fromJsonWrapper(res.data);
    }
    throw serverException(res);
  }

  @override
  Future<int> getMessagesUnreadCount(String teamId) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.messages}${Endpoint.unread_count}");
    if (res.statusCode == RemoteConstants.code_success) {
      return res.data["count"];
    }
    throw serverException(res);
  }

  @override
  Future<bool> putMessage(String messageId, String text) async {
    final channelId = await _prefs.getStringValue(_prefs.currentChatId);
    final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);

    final body = jsonEncode({"text": text});
    final res = await _networkHandler.put(
        body: body,
        path:
            "${Endpoint.teams}/$currentTeamId${Endpoint.channels}/$channelId${Endpoint.messages}/$messageId");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> deleteMessage(
      String teamId, String channelId, String messageId) async {
    final res = await _networkHandler.delete(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}/$messageId");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  // @override
  // Future<bool> postMessage(
  //     String teamId, String channelId, MessageCreateModel model) async {
  //   final map = _iMessageConverter.toJsonCreate(model);
  //   final body = jsonEncode(map);
  //   final res = await _networkHandler.post(
  //       body: body,
  //       path:
  //           "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}");
  //   if (res.statusCode == RemoteConstants.code_success_no_content) {
  //     return true;
  //   }
  //   throw serverException(res);
  // }

  @override
  Future<List<MessageComment>> getMessageComments(
      String teamId, String channelId, String messageId) async {
    final res = await _networkHandler.get(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}/$messageId${Endpoint.comments}");
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = res.data["list"];
      return l
          .map((model) => _iMessageConverter.fromJsonComment(model))
          .toList();
    }
    throw serverException(res);
  }

  @override
  Future<bool> postMessageComment(
      String teamId, String channelId, String messageId, String text, {List<Map<String, String>>? folders}) async {
    final body = jsonEncode({"text": text, "folders": folders ?? []});
    final res = await _networkHandler.post(
        body: body,
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}/$messageId${Endpoint.comments}");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> addRemoveReaction(String teamId, String channelId,
      String messageId, String reactionKey) async {
    final res = await _networkHandler.put(
        path:
            "${Endpoint.teams}/$teamId${Endpoint.channels}/$channelId${Endpoint.messages}/$messageId${Endpoint.reactions}/$reactionKey");
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> setFavorite(String mid) async {
    final teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final body = jsonEncode({"mid": mid});
    final res = await _networkHandler.put(
        path: "${Endpoint.teams}/$teamId${Endpoint.favorites}", body: body);
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<List<MessageModel>> getFavorites() async {
    final teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _networkHandler.get(path: "${Endpoint.teams}/$teamId${Endpoint.favorites}");
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = res.data["list"];
      return l.map((e) => _iMessageConverter.fromJson(e)).toList();
    }
    throw serverException(res);
  }

  @override
  Future<List<MessageModel>> getPinnedMessages(String tid, String cid) async {
    final res = await _networkHandler.get(path: "${Endpoint.teams}/$tid${Endpoint.channels}/$cid${Endpoint.pinned}");
    if (res.statusCode == RemoteConstants.code_success) {
      Iterable l = res.data["list"];
      return l.map((e) => _iMessageConverter.fromJson(e)).toList();
    }
    throw serverException(res);
  }

  @override
  Future<bool> pinMessage(String tid, String cid, String mid) async {
    final res = await _networkHandler.patch(path: "${Endpoint.teams}/$tid${Endpoint.channels}/$cid${Endpoint.messages}/$mid${Endpoint.pinned}", body: jsonEncode({
      "pinned": true
    }));
    if(res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> unpinMessage(String tid, String cid, String mid) async {
    final res = await _networkHandler.patch(path: "${Endpoint.teams}/$tid${Endpoint.channels}/$cid${Endpoint.messages}/$mid${Endpoint.pinned}", body: jsonEncode({
      "pinned": false
    }));
    if(res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

}
