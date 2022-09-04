import 'dart:ui';
import '../../utils/extensions.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../../enums.dart';

class TeamJoinedModel {
  TeamModel team;
  List<ChannelModel> channels;
  List<ChannelModel> groups;
  List<ChannelModel> messages1x1;
  MemberWrapperModel memberWrapperModel;

  TeamJoinedModel(
      {required this.team,
      required this.memberWrapperModel,
      this.channels = const [],
      this.groups = const [],
      this.messages1x1 = const []});
}

class TeamModel {
  String id;
  String name;
  String? title;
  String? uid;
  bool? trial;
  DateTime? expiration;
  DateTime? created;
  bool? expired;
  bool isSelected;
  int unreadMessagesCount;
  bool? adminsCanDelete;
  bool? allMentionProtected;
  bool? channelMentionProtected;
  bool? taskUpdateProtected;
  bool? updateUsernameBlocked;
  bool? onlyAdminInvitesAllowed;
  bool? alwaysPush;
  bool showPhoneNumbers;
  bool showEmails;
  bool? active;
  bool? community;
  String? email;
  String? photo;
  TeamCname? cname;
  TeamEnterprise? enterprise;
  TeamTheme theme;

  String get titleFixed => title?.trim().isNotEmpty == true ? title! : name;

  TeamModel(
      {this.id = '',
      this.adminsCanDelete,
      this.allMentionProtected,
      this.channelMentionProtected,
      this.taskUpdateProtected,
      this.updateUsernameBlocked,
      this.onlyAdminInvitesAllowed,
      this.alwaysPush,
      this.showPhoneNumbers = true,
      this.showEmails = true,
      this.active,
      this.community,
      this.email,
      this.photo = '',
      this.name = '',
      this.isSelected = false,
      this.unreadMessagesCount = 0,
      this.title = "",
      this.uid = '',
      this.cname,
      this.enterprise,
      this.trial,
      this.expiration,
      this.created,
      required this.theme,
      this.expired});
}

class TeamCreateModel {
  String name;
  String username;
  String? language;
  bool newsletters;
  List<InvitationsMailModel> invitations;

  TeamCreateModel(
      {this.name = "",
      this.username = "",
      this.language,
      this.newsletters = false,
      this.invitations = const []});
}

class InvitationsMailModel {
  String email;
  String user;

  InvitationsMailModel({this.email = "", this.user = ""});
}

class InvitationTeamModel {
  String? body;
  String? cid;
  List<InvitationsMailModel> invitations;
  String? language;
  String role;
  DateTime? sendDate;

  InvitationTeamModel(
      {this.body,
      this.cid,
      this.invitations = const [],
      this.language,
      this.role = '',
      this.sendDate});
}

class InvitationPendingAcceptedWrappedModel {
  List<InvitationPendingAcceptedModel> list;
  int offset;
  int total;

  InvitationPendingAcceptedWrappedModel(
      {this.list = const [], this.offset = 0, this.total = 0});
}

class InvitationPendingAcceptedModel {
  String? id;
  String? language;
  bool? accepted;
  DateTime? acceptedDate;
  bool? active;
  String? bodyMsg;
  String? cid;
  String? from;
  MemberModel? memberFrom;
  MemberModel? memberTo;
  String? role;
  DateTime? sendDate;
  String? team;
  String? to;
  String? type;
  String? user;

  UserRol get userRol => role?.toLowerCase() == "administrator"
      ? UserRol.Admin
      : role?.toLowerCase() == "member"
          ? UserRol.Member
          : role?.toLowerCase() == "guest"
              ? UserRol.Guest
              : UserRol.None;

  InvitationPendingAcceptedModel(
      {this.id,
      this.accepted,
      this.language,
      this.acceptedDate,
      this.active,
      this.bodyMsg,
      this.cid,
      this.from,
      this.memberFrom,
      this.memberTo,
      this.role = '',
      this.sendDate,
      this.team,
      this.to,
      this.type,
      this.user});
}

class SearchMessagesModel {
  int offset;
  int total;
  List<MessageModel> list;

  SearchMessagesModel({this.offset = 0, this.total = 0, this.list = const []});
}

class SearchTasksModel {
  int offset;
  int total;
  List<TaskModel> list;

  SearchTasksModel({this.offset = 0, this.total = 0, this.list = const []});
}

class SearchMembersModel {
  int offset;
  int total;
  List<MemberModel> list;

  SearchMembersModel({this.offset = 0, this.total = 0, this.list = const []});
}

class SearchFilesModel {
  int offset;
  int total;
  List<FileModel> list;

  SearchFilesModel({this.offset = 0, this.total = 0, this.list = const []});
}

class TeamTheme {
  String themeName;
  TeamColors colors;

  TeamTheme(this.themeName, this.colors);
}

class TeamCname {
  String id;
  String? domain;
  bool enabled;

  TeamCname({this.id = '', this.domain = '', this.enabled = false});
}

class TeamEnterprise {
  bool enabled;

  TeamEnterprise({this.enabled = false});
}

class TeamColors {
  final Color? activeItemBackground,
      activeItemText,
      activePresence,
      inactivePresence,
      notificationBadgeBackground,
      notificationBadgeText,
      sidebarColor,
      textColor;

  Color? get secondaryHeaderColor => sidebarColor?.lighten();

  Color? get primaryHeaderColor => sidebarColor?.darken();

  Color? get subtextColor => textColor?.withOpacity(.9);

  TeamColors(
      {required this.activeItemBackground,
      required this.activeItemText,
      required this.activePresence,
      required this.inactivePresence,
      required this.notificationBadgeBackground,
      required this.notificationBadgeText,
      required this.sidebarColor,
      required this.textColor});
}

class WhiteBrandConfig {
  String domain, helpUrl;
  bool enabled;
  List<SocialMedia> socialMedia;

  WhiteBrandConfig(
      {required this.domain, this.helpUrl = '', this.enabled = true, this.socialMedia = const []});
}

class SocialMedia {
  String name, url;

  SocialMedia({required this.name, required this.url});
}

class AppLinksNavigationModel {
  String link;
  ValueChanged<String>? onLinkTap;

  AppLinksNavigationModel({required this.link, this.onLinkTap});
}
