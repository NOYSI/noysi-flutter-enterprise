import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_api.dart';
import 'package:code/domain/channel/i_channel_dao.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/team/i_team_dao.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/utils/extensions.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<List<ChannelModel>>? channelsLoadedFromApi;
class ChannelRepository extends BaseRepository implements IChannelRepository {
  final IChannelApi _channelApi;
  final IChannelDao _iChannelDao;
  final ITeamDao _iTeamDao;
  final SharedPreferencesManager _prefs;
  final InMemoryData _inMemoryData;

  ChannelRepository(this._channelApi, this._iChannelDao, this._iTeamDao,
      this._prefs, this._inMemoryData);

  @override
  Future<Result<ChannelModel>> createChannel(
      String teamId, ChannelModelCreate model) async {
    try {
      final channel = await _channelApi.createChannel(teamId, model);
      channel.tid = teamId;
      await _syncLocalChannel(channel, LocalSyncOperation.Add);
      _inMemoryData.addReplaceChannel(channel);
      return ResultSuccess(value: channel);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> deleteChannel(String teamId, String channelId) async {
    try {
      final res = await _channelApi.deleteChannel(teamId, channelId);
      final channel = await _iChannelDao.getChannel(channelId);
      if (channel != null) {
        _inMemoryData.removeChannel(channel);
        await _syncLocalChannel(channel, LocalSyncOperation.Remove);
      }
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<ChannelModel>> getChannel(
      String teamId, String channelId) async {
    try {
      ChannelModel? channel = await _iChannelDao.getChannel(channelId);
      if (channel == null) {
        channel = await _channelApi.getChannel(teamId, channelId);
        channel.tid = teamId;
        await _iChannelDao.saveChannel(channel);
        final joinedTeam = await _iTeamDao.getJoinedTeam(teamId);
        if (joinedTeam != null) {
          if (channel.isOpenChannel)
            joinedTeam.channels.add(channel);
          else if (channel.isPrivateGroup)
            joinedTeam.groups.add(channel);
          else
            joinedTeam.messages1x1.add(channel);
          await _iTeamDao.saveJoinedTeam(joinedTeam);
        }
      }
      _inMemoryData.addReplaceChannel(channel);
      return ResultSuccess(value: channel);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<ChannelModel>>> getChannels(String teamId,
      {String? type, forceApi = false}) async {
    try {
      channelsLoadedFromApi = BehaviorSubject();
      List<ChannelModel> channels = forceApi ? [] :
          await _iChannelDao.getChannels(teamId, type ?? "");
      if (channels.isEmpty) {
        channels = await _channelApi.getChannels(teamId, type: type);
        channels.setTeamId(teamId);
        await _iChannelDao.saveChannels(channels);
        _inMemoryData.addReplaceChannels(channels);
        channelsLoadedFromApi?.sinkAddSafe(channels);
      } else {
        _channelApi.getChannels(teamId, type: type).then((res) async {
          await _iChannelDao.removeChannels(channels.map((e) => e.id).toList());
          res.setTeamId(teamId);
          await _iChannelDao.saveChannels(res);
          _inMemoryData.addReplaceChannels(res);
          channelsLoadedFromApi?.sinkAddSafe(res);
        });
      }
      return ResultSuccess(value: channels);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<ChannelLinkWrappedModel>> geChannelLinks(
      {int max = 50, int offset = 0, CommonSort sort = CommonSort.desc}) async {
    try {
      final res = await _channelApi.geChannelLinks(
          max: max, offset: offset, sort: sort);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<ChannelMentionWrappedModel>> geChannelMentions(
      {int max = 50, int offset = 0, CommonSort sort = CommonSort.desc}) async {
    try {
      final res = await _channelApi.geChannelMentions(
          max: max, offset: offset, sort: sort);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<ChannelModel>> create1x1Channel(MemberModel other, {String? tid}) async {
    try {
      final teamId = tid ?? (await _prefs.getStringValue(_prefs.currentTeamId));
      final channel =
          await _channelApi.create1x1Channel(other.id, teamId);
      channel.tid = teamId;
      await _syncLocalChannel(channel, LocalSyncOperation.Add, member: other);
      _inMemoryData.addReplaceChannel(channel);
      return ResultSuccess(value: channel);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> setFavorite(bool setAsFavorite) async {
    try {
      final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
      final currentChannelId =
          await _prefs.getStringValue(_prefs.currentChatId);
      final res = await _channelApi.setFavorite(
          setAsFavorite, currentTeamId, currentChannelId);
      final channel = await _iChannelDao.getChannel(currentChannelId);
      channel?.isFavorite = setAsFavorite;
      if(channel != null) await _syncLocalChannel(channel, LocalSyncOperation.Update);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> putChannelMemberNotifications(
      NotificationModel model) async {
    try {
      final currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
      final currentChannelId =
          await _prefs.getStringValue(_prefs.currentChatId);

      final res = await _channelApi.putChannelMemberNotifications(
          model, currentTeamId, currentChannelId);

      final channel = await _iChannelDao.getChannel(currentChannelId);
      channel?.notifications = model;
      if(channel != null) await _syncLocalChannel(channel, LocalSyncOperation.Update);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> deleteChannelMember(
      String teamId, String channelId, String memberId) async {
    try {
      final res =
          await _channelApi.deleteChannelMember(teamId, channelId, memberId);
      ChannelModel? channel = await _iChannelDao.getChannel(channelId);
      if (channel != null) {
        channel.joined = false;

        if (channel.isPrivateGroup) {
          _inMemoryData.removeChannel(channel);
          await _syncLocalChannel(channel, LocalSyncOperation.Remove);
        } else {
          _inMemoryData.addReplaceChannel(channel);
          await _syncLocalChannel(channel, LocalSyncOperation.Update);
        }
      }

      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<ChannelModel>> putChannelMember(
      String teamId, String channelId, String memberId) async {
    try {
      final res =
          await _channelApi.putChannelMember(teamId, channelId, memberId);
      res.tid = teamId;
      await _syncLocalChannel(res, LocalSyncOperation.Update);
      _inMemoryData.addReplaceChannel(res);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> putChannelMemberClose(
      String teamId, String channelId, String memberId) async {
    try {
      final res =
          await _channelApi.putChannelMemberClose(teamId, channelId, memberId);
      ChannelModel? channel = await _iChannelDao.getChannel(channelId);
      if (channel != null) {
        await _syncLocalChannel(channel, LocalSyncOperation.Remove);
        _inMemoryData.removeChannel(channel);
      } else {
        final jTeam = await _iTeamDao.getJoinedTeam(teamId);
        int idx =
            jTeam?.messages1x1.indexWhere((element) => element.id == channelId) ?? -1;
        if (idx < 0) {
          idx = jTeam?.groups.indexWhere((element) => element.id == channelId) ?? -1;
        }
        if (idx < 0) {
          idx = jTeam?.channels.indexWhere((element) => element.id == channelId) ?? -1;
        }
        if (idx >= 0) {
          await _syncLocalChannel(
              jTeam!.messages1x1[idx], LocalSyncOperation.Remove);
          _inMemoryData.removeChannel(jTeam.messages1x1[idx]);
        }
      }
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> putChannelMemberMark(ChannelModel channel) async {
    try {
      final res = await _channelApi.putChannelMemberMark(channel.id);
      // channel.mark = DateTime.now();
      // channel.unreadMessages = [];
      // channel.unreadCount = 0;
      // await _syncLocalChannel(channel, LocalSyncOperation.Update);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<void> resetChannelMark(String cid, DateTime? marked) async {
    final channel = await _iChannelDao.getChannel(cid);
    if(channel != null) {
      channel.mark = marked;
      channel.unreadMessages = [];
      channel.unreadCount = 0;
      _syncLocalChannel(channel, LocalSyncOperation.Update);
    }
  }

  @override
  Future<Result<int>> putChannelMemberOpen(
      String teamId, String channelId, String memberId) async {
    try {
      final res =
          await _channelApi.putChannelMemberOpen(teamId, channelId, memberId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  Future<void> _syncLocalChannel(
      ChannelModel channel, LocalSyncOperation localSyncOperation,
      {MemberModel? member}) async {
    await _iChannelDao.removeChannel(channel.id);
    if (localSyncOperation != LocalSyncOperation.Remove)
      await _iChannelDao.saveChannel(channel);

    TeamJoinedModel? joinedTeam = await _iTeamDao.getJoinedTeam(channel.tid ?? "");
    if (joinedTeam != null) {
      if (localSyncOperation == LocalSyncOperation.Add) {
        if (member != null && channel.isM1x1) {
          final mIdx = joinedTeam.memberWrapperModel.list
              .indexWhere((element) => element.id == member.id);
          if (mIdx < 0)
            joinedTeam.memberWrapperModel.list.add(member);
          else
            joinedTeam.memberWrapperModel.list[mIdx] = member;
        }
        if (channel.isPrivateGroup &&
            joinedTeam.groups
                    .indexWhere((element) => element.id == channel.id) <
                0)
          joinedTeam.groups.add(channel);
        else if (channel.isOpenChannel &&
            joinedTeam.channels
                    .indexWhere((element) => element.id == channel.id) <
                0)
          joinedTeam.channels.add(channel);
        else if (joinedTeam.messages1x1
                .indexWhere((element) => element.id == channel.id) <
            0) joinedTeam.messages1x1.add(channel);
      } else {
        final openChanelIndex = joinedTeam.channels
            .indexWhere((element) => element.id == channel.id);
        if (openChanelIndex >= 0) {
          if (localSyncOperation == LocalSyncOperation.Remove)
            joinedTeam.channels.removeAt(openChanelIndex);
          else
            joinedTeam.channels[openChanelIndex] = channel;
        }

        final privateGroupIndex =
            joinedTeam.groups.indexWhere((element) => element.id == channel.id);
        if (privateGroupIndex >= 0) {
          if (localSyncOperation == LocalSyncOperation.Remove)
            joinedTeam.groups.removeAt(privateGroupIndex);
          else
            joinedTeam.groups[privateGroupIndex] = channel;
        }

        final message1x1Index = joinedTeam.messages1x1
            .indexWhere((element) => element.id == channel.id);
        if (message1x1Index >= 0) {
          if (localSyncOperation == LocalSyncOperation.Remove)
            joinedTeam.messages1x1.removeAt(message1x1Index);
          else
            joinedTeam.messages1x1[message1x1Index] = channel;
        }
      }
      await _iTeamDao.saveJoinedTeam(joinedTeam);
    }
  }

  @override
  Future<ChannelModel?> updateNameLocally(String cid, String title, String name) async {
    final channel = await _iChannelDao.getChannel(cid);
    if (channel != null) {
      channel.name = name;
      channel.title = title;
      await _syncLocalChannel(channel, LocalSyncOperation.Update);
      _inMemoryData.addReplaceChannel(channel);
    }
    return channel;
  }

  @override
  Future<Result<ChannelModel>> renameChannel(
      String teamId, String channelId, String name) async {
    try {
      final res = await _channelApi.renameChannel(teamId, channelId, name);
      res.tid = teamId;
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<String>> getPrivateGroupInvitationLinkToken(String tid, String cid) async {
    try {
      final res = await _channelApi.getPrivateGroupInvitationLinkToken(tid, cid);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
