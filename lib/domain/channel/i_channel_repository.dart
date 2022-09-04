import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/user/user_model.dart';

import '../../enums.dart';

abstract class IChannelRepository {
  Future<Result<List<ChannelModel>>> getChannels(String teamId, {String? type, forceApi = false});

  Future<Result<bool>> setFavorite(bool setAsFavorite);

  Future<Result<ChannelModel>> createChannel(
      String teamId, ChannelModelCreate model);

  Future<Result<ChannelModel>> getChannel(String teamId, String channelId);

  // Future<void> syncLocalChannel(ChannelModel channel, LocalSyncOperation localSyncOperation);

  Future<Result<int>> deleteChannel(String teamId, String channelId);

  Future<Result<ChannelLinkWrappedModel>> geChannelLinks({int max = 50, int offset = 0, CommonSort sort = CommonSort.desc});

  Future<Result<ChannelMentionWrappedModel>> geChannelMentions({int max = 50, int offset = 0, CommonSort sort = CommonSort.desc});

  Future<Result<ChannelModel>> create1x1Channel(MemberModel other, {String tid});

  Future<Result<bool>> putChannelMemberNotifications(NotificationModel model);

  Future<Result<int>> deleteChannelMember(
      String teamId, String channelId, String memberId);

  Future<Result<ChannelModel>> putChannelMember(
      String teamId, String channelId, String memberId);

  Future<Result<int>> putChannelMemberMark(ChannelModel channel);

  Future<void> resetChannelMark(String cid, DateTime? marked);

  Future<Result<int>> putChannelMemberOpen(
      String teamId, String channelId, String memberId);

  Future<Result<int>> putChannelMemberClose(
      String teamId, String channelId, String memberId);

  Future<ChannelModel?> updateNameLocally(String cid, String title, String name);

  Future<Result<ChannelModel>> renameChannel(String teamId, String channelId, String name);

  Future<Result<String>> getPrivateGroupInvitationLinkToken(String tid, String cid);
}
