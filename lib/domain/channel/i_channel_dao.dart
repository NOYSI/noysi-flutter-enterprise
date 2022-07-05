import 'package:code/domain/channel/channel_model.dart';

abstract class IChannelDao {
  Future<List<ChannelModel>> getChannels(String teamId, String type);

  Future<ChannelModel?> getChannel(String channelId);

  Future<bool> saveChannel(ChannelModel model);

  Future<bool> saveChannels(List<ChannelModel> models);

  Future<bool> removeChannel(String channelId);

  Future<void> removeChannels(List<String> channelIds);
}
