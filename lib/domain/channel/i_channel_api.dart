import 'package:code/domain/channel/channel_model.dart';

import '../../enums.dart';

abstract class IChannelApi {
  Future<List<ChannelModel>> getChannels(String teamId, {type = "channel"});

  Future<bool> setFavorite(bool setAsFavorite, String teamId, String channelId);

  Future<ChannelModel> createChannel(String teamId, ChannelModelCreate model);

  Future<ChannelModel> create1x1Channel(String otherId, String currentTeamId);

  Future<ChannelModel> getChannel(String teamId, String channelId);

  Future<int> deleteChannel(String teamId, String channelId);

  Future<ChannelModel> renameChannel(String teamId, String channelId, String name);

  Future<ChannelLinkWrappedModel> geChannelLinks({int max = 50, int offset = 0, CommonSort sort = CommonSort.desc});

  Future<ChannelMentionWrappedModel> geChannelMentions({int max = 50, int offset = 0, CommonSort sort = CommonSort.desc});

  Future<bool> putChannelMemberNotifications(NotificationModel model, String currentTeamId, String currentChannelId);

  Future<int> deleteChannelMember(
      String teamId, String channelId, String memberId);

  Future<ChannelModel> putChannelMember(
      String teamId, String channelId, String memberId);

  Future<int> putChannelMemberMark(String channelId);

  Future<int> putChannelMemberOpen(
      String teamId, String channelId, String memberId);

  Future<int> putChannelMemberClose(
      String teamId, String channelId, String memberId);

  Future<String> getPrivateGroupInvitationLinkToken(String tid, String cid);
}
