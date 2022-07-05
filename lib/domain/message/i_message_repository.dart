import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IMessageRepository{
  Future<Result<MessageWrapperModel>> getMessages(
      String teamId, String channelId, int ts);

  Future<Result<int>> getMessagesUnreadCount(String teamId);

  // Future<Result<bool>> postMessage(
  //     String teamId, String channelId, MessageCreateModel model);

  Future<Result<bool>> deleteMessage(String teamId, String channelId, String messageId);

  Future<Result<bool>> putMessage(String messageId, String text);

  Future<Result<MessageModel>> getMessage(
      String teamId, String channelId, String messageId);

  Future<Result<List<MessageComment>>> getMessageComments(
      String teamId, String channelId, String messageId);

  Future<Result<bool>> postMessageComment(
      String teamId, String channelId, String messageId, String text, {List<Map<String, String>> folders});

  Future<Result<MessageWrapperModel>> getMessagePrevious(
      String teamId, String channelId, String messageId, {ValueChanged<CancelToken>? onCancelToken});

  Future<Result<MessageWrapperModel>> getMessageNext(
      String teamId, String channelId, String messageId, {ValueChanged<CancelToken>? onCancelToken});

  Future<Result<bool>> addRemoveReaction(
      String teamId, String channelId, String messageId, String reactionKey);

  Future<Result<bool>> setFavorite(String mid);

  Future<Result<List<MessageModel>>> getFavorites();

  Future<Result<List<MessageModel>>> getPinnedMessages(String tid, String cid);

  Future<Result<bool>> pinMessage(String tid, String cid, String mid);

  Future<Result<bool>> unpinMessage(String tid, String cid, String mid);

}