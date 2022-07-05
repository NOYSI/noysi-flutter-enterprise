import 'package:code/domain/message/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IMessageApi {
  Future<MessageWrapperModel> getMessages(
      String teamId, String channelId, int ts);

  Future<int> getMessagesUnreadCount(String teamId);

  // Future<bool> postMessage(
  //     String teamId, String channelId, MessageCreateModel model);

  Future<bool> deleteMessage(String teamId, String channelId, String messageId);

  Future<bool> putMessage( String messageId, String text);

  Future<MessageModel> getMessage(
      String teamId, String channelId, String messageId);

  Future<List<MessageComment>> getMessageComments(
      String teamId, String channelId, String messageId);

  Future<bool> postMessageComment(
      String teamId, String channelId, String messageId, String text, {List<Map<String, String>>? folders});

  Future<MessageWrapperModel> getMessagePrevious(
      String teamId, String channelId, String messageId, {ValueChanged<CancelToken>? onCancelToken});

  Future<MessageWrapperModel> getMessageNext(
      String teamId, String channelId, String messageId, {ValueChanged<CancelToken>? onCancelToken});

  Future<bool> addRemoveReaction(String teamId, String channelId, String messageId, String reactionKey);

  Future<bool> setFavorite(String mid);

  Future<List<MessageModel>> getFavorites();

  Future<List<MessageModel>> getPinnedMessages(String tid, String cid);

  Future<bool> pinMessage(String tid, String cid, String mid);

  Future<bool> unpinMessage(String tid, String cid, String mid);
}
