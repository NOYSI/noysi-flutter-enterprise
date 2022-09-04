import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/message/i_message_api.dart';
import 'package:code/domain/message/i_message_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/enums.dart';
import 'package:code/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MessageRepository extends BaseRepository implements IMessageRepository {
  final IMessageApi _iMessageApi;
  final InMemoryData _inMemoryData;

  MessageRepository(this._iMessageApi, this._inMemoryData);

  @override
  Future<Result<bool>> deleteMessage(
      String teamId, String channelId, String messageId) async {
    try {
      final res =
          await _iMessageApi.deleteMessage(teamId, channelId, messageId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<MessageModel>> getMessage(
      String teamId, String channelId, String messageId) async {
    try {
      final res = await _iMessageApi.getMessage(teamId, channelId, messageId);
      res.messageStatus = MessageStatus.Sent;
      await _inMemoryData.resolveMembersAsync([res.uid]);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<MessageComment>>> getMessageComments(
      String teamId, String channelId, String messageId) async {
    try {
      final res =
          await _iMessageApi.getMessageComments(teamId, channelId, messageId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<MessageWrapperModel>> getMessageNext(
      String teamId, String channelId, String messageId, {ValueChanged<CancelToken>? onCancelToken}) async {
    try {
      final res =
          await _iMessageApi.getMessageNext(teamId, channelId, messageId, onCancelToken: onCancelToken);
      res.list.setToSentStatus();
      // await Future.forEach<MessageModel>(res.list, (element) async {
      //   if (element.isAnswerMessage) {
      //     final answerMessageId = element.getAnswerMessageId;
      //     final m = res.list.firstWhere((mes) => mes.id == answerMessageId,
      //         orElse: () {
      //           return null;
      //         });
      //     element.answerMessage = m != null
      //         ? m
      //         : await _iMessageApi.getMessage(
      //         teamId, channelId, answerMessageId);
      //   }
      // });
      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.uid).toList());
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<MessageWrapperModel>> getMessagePrevious(
      String teamId, String channelId, String messageId, {ValueChanged<CancelToken>? onCancelToken}) async {
    try {
      final res =
          await _iMessageApi.getMessagePrevious(teamId, channelId, messageId, onCancelToken: onCancelToken);
      res.list.setToSentStatus();
      // await Future.forEach<MessageModel>(res.list, (element) async {
      //   if (element.isAnswerMessage) {
      //     final answerMessageId = element.getAnswerMessageId;
      //     final m = res.list.firstWhere((mes) => mes.id == answerMessageId,
      //         orElse: () {
      //           return null;
      //         });
      //     element.answerMessage = m != null
      //         ? m
      //         : await _iMessageApi.getMessage(
      //         teamId, channelId, answerMessageId);
      //   }
      // });
      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.uid).toList());

      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<MessageWrapperModel>> getMessages(
      String teamId, String channelId, int ts) async {
    try {
      final res = await _iMessageApi.getMessages(teamId, channelId, ts);
      res.list.setToSentStatus();
      // await Future.forEach<MessageModel>(res.list, (element) async {
      //   if (element.isAnswerMessage) {
      //     final answerMessageId = element.getAnswerMessageId;
      //     final m = res.list.firstWhere((mes) => mes.id == answerMessageId,
      //         orElse: () {
      //       return null;
      //     });
      //     element.answerMessage = m != null
      //         ? m
      //         : await _iMessageApi.getMessage(
      //             teamId, channelId, answerMessageId);
      //   }
      // });

      await _inMemoryData
          .resolveMembersAsync(res.list.map((e) => e.uid).toList());
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  // Future<List<MessageModel>> _resolverMessageAdditionalInfo(List<MessageModel> list) async{
  //   List<MessageModel> resultList = [];
  //   await Future.forEach<MessageModel>(list, (message) async{
  //     message.messageStatus = MessageStatus.Sent;
  //     if(message.isAnswerMessage || message.threadMetaChild != null){
  //
  //     }
  //     resultList.add(message);
  //   });
  //   return resultList;
  // }
  
  @override
  Future<Result<int>> getMessagesUnreadCount(String teamId) async {
    try {
      final res = await _iMessageApi.getMessagesUnreadCount(teamId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  // @override
  // Future<Result<bool>> postMessage(
  //     String teamId, String channelId, MessageCreateModel model) async {
  //   try {
  //     final res = await _iMessageApi.postMessage(teamId, channelId, model);
  //     return ResultSuccess(value: res);
  //   } catch (ex) {
  //     return resultError(ex);
  //   }
  // }

  @override
  Future<Result<bool>> postMessageComment(
      String teamId, String channelId, String messageId, String text, {List<Map<String, String>> folders = const []}) async {
    try {
      final res = await _iMessageApi.postMessageComment(
          teamId, channelId, messageId, text, folders: folders);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putMessage(String messageId, String text) async {
    try {
      final res = await _iMessageApi.putMessage(messageId, text);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> addRemoveReaction(String teamId, String channelId,
      String messageId, String reactionKey) async {
    try {
      final res = await _iMessageApi.addRemoveReaction(
          teamId, channelId, messageId, reactionKey);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> setFavorite(String mid) async {
    try {
      final res = await _iMessageApi.setFavorite(mid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<MessageModel>>> getFavorites() async {
    try {
      final res = await _iMessageApi.getFavorites();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<MessageModel>>> getPinnedMessages(String tid, String cid) async {
    try {
      final res = await _iMessageApi.getPinnedMessages(tid, cid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> pinMessage(String tid, String cid, String mid) async {
    try {
      final res = await _iMessageApi.pinMessage(tid, cid, mid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> unpinMessage(String tid, String cid, String mid) async {
    try {
      final res = await _iMessageApi.unpinMessage(tid, cid, mid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
