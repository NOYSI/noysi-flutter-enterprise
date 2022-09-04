
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/i_user_api.dart';
import 'package:code/domain/user/user_model.dart';

class InMemoryData {
  final IUserApi _iUserApi;

  InMemoryData(this._iUserApi);

  Map<String, TeamModel> _teams = {};
  Map<String, ChannelModel> _channels = {};
  Map<String, MemberModel> _members = {};
  Map<String, MessageModel> _messages = {};

  MemberModel? currentMember;
  TeamModel? currentTeam;
  ChannelModel? currentChannel;
  WhiteBrandConfig? currentWhiteBrandConfig;
  static bool isInForeground = true;

  void cleanData() {
    _teams.clear();
    _members.clear();
    _channels.clear();
    _messages.clear();

    currentWhiteBrandConfig = null;
    currentMember = null;
    currentTeam = null;
    currentChannel = null;
  }

  // Future<TeamModel> resolveTeamAsync(String teamId) async {
  //   final team = _teams[teamId] ?? await _iTeamApi.getTeam(teamId);
  //   if (team is TeamModel) {
  //     addReplaceTeam(team);
  //     return team;
  //   }
  //   return null;
  // }
  //
  // Future<ChannelModel> resolveChannelAsync(String channelId,
  //     {String teamId}) async {
  //   final channel = _channels[channelId] ??
  //       await _channelApi.getChannel((teamId ?? currentTeam.id), channelId);
  //   if (channel is ChannelModel) {
  //     channel.tid = teamId;
  //     addReplaceChannel(channel);
  //     return channel;
  //   }
  //   return null;
  // }

  // Future<MemberModel> resolveMemberAsync(String memberId,
  //     {String teamId}) async {
  //   final member = _members[memberId] ??
  //       await _iUserApi.getTeamMember((teamId ?? currentTeam.id), memberId);
  //   if (member is MemberModel) {
  //     addReplaceMember(member);
  //     return member;
  //   }
  //   return null;
  // }

  Future<void> resolveMembersAsync(List<String> ids, {String? teamId}) async {
    final notFoundMembersIds = ids
        .where(
            (id) => id.trim().isNotEmpty && getMember(id) == null)
        .toSet()
        .toList();
    List<Future> futures = [];
    notFoundMembersIds.forEach((userId) {
      if(!userId.contains('@')) {
        futures.add(_iUserApi
            .getTeamMember((teamId ?? (currentTeam?.id ?? '')), userId)
            .then((value) {
          addReplaceMember(value);
        }).catchError((onError) {
          print(onError.toString());
        }));
      }
    });
    await Future.wait(futures);
  }

  TeamModel addReplaceTeam(TeamModel teamModel) {
    _teams[teamModel.id] = teamModel;
    return teamModel;
  }

  void addReplaceTeams(List<TeamModel> teams) {
    teams.forEach((element) {
      addReplaceTeam(element);
    });
  }

  ChannelModel addReplaceChannel(ChannelModel channelModel) {
    _channels[channelModel.id] = channelModel;
    return channelModel;
  }

  void addReplaceChannels(List<ChannelModel> channels) {
    channels.forEach((element) {
      addReplaceChannel(element);
    });
  }

  MemberModel addReplaceMember(MemberModel memberModel) {
    _members[memberModel.id] = memberModel;
    return memberModel;
  }

  void addReplaceMembers(List<MemberModel> members) async {
    members.forEach((element) {
      addReplaceMember(element);
    });
  }

  // TeamModel getTeam(String id) => _teams[id];
  //
  // List<TeamModel> getTeams() => _teams.values.toList();
  //
  // ChannelModel getChannel(String id) => _channels[id];

  List<ChannelModel> getChannels() => _channels.values
      .where((element) => element.tid == currentTeam?.id)
      .toList();

  MemberModel? getMember(String id) => _members[id];

  List<MemberModel> getMembers({bool excludeMe = false, String? teamId, bool activeOnly = false}) {
    return _members.values
        .where((element) => element.tid == (teamId ?? currentTeam?.id))
        .where((element) => excludeMe ? element.id != currentMember?.id : true)
        .where((element) => activeOnly ? element.active == true && !element.isDeletedUser : true)
        .toList();
  }

  void removeChannel(ChannelModel channel) {
    _channels.remove(channel.id);
  }
}
