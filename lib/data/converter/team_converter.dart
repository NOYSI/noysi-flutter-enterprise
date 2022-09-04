import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/channel/i_channel_converter.dart';
import 'package:code/domain/file/i_file_converter.dart';
import 'package:code/domain/message/i_message_converter.dart';
import 'package:code/domain/task/i_task_converter.dart';
import 'package:code/domain/team/i_team_converter.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/i_user_converter.dart';
import 'package:code/ui/_base/hex_colors.dart';

class TeamConverter implements ITeamConverter {
  final IChannelConverter _iChannelConverter;
  final ITaskConverter _iTaskConverter;
  final IUserConverter _iUserConverter;
  final IFileConverter _fileConverter;
  final IMessageConverter _iMessageConverter;

  TeamConverter(this._iChannelConverter, this._iUserConverter,
      this._fileConverter, this._iMessageConverter, this._iTaskConverter);

  @override
  TeamModel fromJson(Map<String, dynamic> json) {
    final TeamModel model = TeamModel(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        adminsCanDelete: json["adminscandelete"],
        allMentionProtected: json["allmentionprotected"],
        channelMentionProtected: json["channelmentionprotected"],
        taskUpdateProtected: json["taskupdateprotected"],
        updateUsernameBlocked: json["updateusernameblocked"],
        onlyAdminInvitesAllowed: json["onlyadmininvitesallowed"],
        alwaysPush: json.containsKey('alwaysPush') && json['alwaysPush'] != null
            ? json['alwaysPush']
            : false,
        showPhoneNumbers: json.containsKey('show-phone-numbers') && json['show-phone-numbers'] != null
            ? json['show-phone-numbers']
            : true,
        showEmails: json.containsKey('show-emails') && json['show-emails'] != null
            ? json['show-emails']
            : true,
        active: json["active"],
        community: json["community"],
        email: json["email"],
        photo: json["photo"],
        uid: json["uid"],
        trial: json["trial"],
        cname: json.containsKey("cname") && json["cname"] != null
            ? fromJsonTeamCname(json["cname"])
            : null,
        enterprise: json.containsKey("enterprise") && json["enterprise"] != null
            ? fromJsonTeamEnterprise(json["enterprise"])
            : null,
        expiration: json.containsKey("expiration") && json["expiration"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["expiration"],
                    isUtc: true)
                .toLocal()
            : null,
        created: json.containsKey("created") && json["created"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["created"], isUtc: true)
                .toLocal()
            : null,
        expired: json["expired"],
        theme: json['theme'] != null
            ? fromJsonTheme(json['theme'])
            : R.color.defaultTheme);
    return model;
  }

  @override
  Map<String, dynamic> toJson(TeamModel model) {
    final map = {
      "id": model.id,
      "name": model.name,
      "title": model.title,
      "adminscandelete": model.adminsCanDelete,
      "allmentionprotected": model.allMentionProtected,
      "channelmentionprotected": model.channelMentionProtected,
      "taskupdateprotected": model.taskUpdateProtected,
      "updateusernameblocked": model.updateUsernameBlocked,
      "onlyadmininvitesallowed": model.onlyAdminInvitesAllowed,
      "active": model.active,
      "community": model.community,
      "email": model.email,
      "photo": model.photo,
      "uid": model.uid,
      "trial": model.trial,
      "expiration": model.expiration?.millisecondsSinceEpoch,
      "created": model.created?.millisecondsSinceEpoch,
      "expired": model.expired,
      "alwaysPush": model.alwaysPush,
      "cname": model.cname != null ? toJsonTeamCname(model.cname!) : null,
      "enterprise": model.enterprise != null ? toJsonTeamEnterprise(model.enterprise!) : null
    };
    return map;
  }

  @override
  Map<String, dynamic> toJsonCreate(TeamCreateModel model) {
    final map = {
      "name": model.name,
      "username": model.username,
      "language": model.language,
      "newsletters": model.newsletters,
      "invitations": model.invitations.map((e) => toJsonInvitations(e)).toList()
    };
    return map;
  }

  @override
  Map<String, dynamic> toJsonInvitations(InvitationsMailModel model) {
    final map = {"email": model.email, "user": model.user};
    return map;
  }

  @override
  TeamJoinedModel fromJsonTeamJoined(Map<String, dynamic> json) {
    try {
      final TeamJoinedModel model = TeamJoinedModel(
          team: fromJson(json["team"]),
          channels: (json["channels"] as List<dynamic>)
              .map((e) => _iChannelConverter.fromJson(e))
              .toList(),
          groups: (json["groups"] as List<dynamic>)
              .map((e) => _iChannelConverter.fromJson(e))
              .toList(),
          messages1x1: (json["ims"] as List<dynamic>)
              .map((e) => _iChannelConverter.fromJson(e))
              .toList(),
          memberWrapperModel:
              _iUserConverter.fromJsonMemberWrapper(json["members"]));
      return model;
    } catch (ex) {
      throw ex;
    }
  }

  @override
  Map<String, dynamic> toJsonTeamJoined(TeamJoinedModel model) {
    final map = {
      "team": toJson(model.team),
      "channels":
          model.channels.map((e) => _iChannelConverter.toJson(e)).toList(),
      "groups": model.groups.map((e) => _iChannelConverter.toJson(e)).toList(),
      "ims":
          model.messages1x1.map((e) => _iChannelConverter.toJson(e)).toList(),
      "members": _iUserConverter.toJsonMemberWrapper(model.memberWrapperModel)
    };
    return map;
  }

  @override
  InvitationPendingAcceptedModel fromJsonInvitationPendingAcceptedModel(
      Map<String, dynamic> json) {
    InvitationPendingAcceptedModel model = InvitationPendingAcceptedModel(
        id: json["id"],
        active: json["active"],
        language: json["language"],
        acceptedDate:
            json.containsKey("accepteddate") && json["accepteddate"] != null
                ? DateTime.fromMillisecondsSinceEpoch(json["accepteddate"],
                        isUtc: true)
                    .toLocal()
                : null,
        accepted: json["accepted"],
        bodyMsg: json["body_msg"],
        cid: json["cid"],
        from: json["from"],
        memberFrom: json.containsKey("memberFrom") && json["memberFrom"] != null
            ? _iUserConverter.fromJson(json["memberFrom"])
            : null,
        memberTo: json.containsKey("memberTo") && json["memberTo"] != null
            ? _iUserConverter.fromJson(json["memberTo"])
            : null,
        role: json["role"],
        sendDate: json.containsKey("senddate") && json["senddate"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["senddate"], isUtc: true)
                .toLocal()
            : null,
        team: json["team"],
        to: json["to"],
        type: json["type"],
        user: json["user"]);
    return model;
  }

  @override
  InvitationPendingAcceptedWrappedModel
      fromJsonInvitationPendingAcceptedWrappedModel(Map<String, dynamic> json) {
    InvitationPendingAcceptedWrappedModel model =
        InvitationPendingAcceptedWrappedModel(
            list: (json["list"] as List<dynamic>)
                .map((e) => fromJsonInvitationPendingAcceptedModel(e))
                .toList(),
            offset: json["offset"] ?? 0,
            total: json["total"] ?? 0);
    return model;
  }

  @override
  SearchTasksModel fromJsonSearchTasks(Map<String, dynamic> json) {
    SearchTasksModel model = SearchTasksModel(
        offset: json["offset"],
        total: json["total"],
        list: (json["list"] as List<dynamic>)
            .map((e) => _iTaskConverter.fromJsonTask(e))
            .toList());
    return model;
  }

  @override
  SearchFilesModel fromJsonSearchFiles(Map<String, dynamic> json) {
    SearchFilesModel model = SearchFilesModel(
        offset: json["offset"],
        total: json["total"],
        list: (json["list"] as List<dynamic>)
            .map((e) => _fileConverter.fromJson(e))
            .toList());
    return model;
  }

  @override
  SearchMembersModel fromJsonSearchMembers(Map<String, dynamic> json) {
    SearchMembersModel model = SearchMembersModel(
        offset: json["offset"],
        total: json["total"],
        list: (json["list"] as List<dynamic>)
            .map((e) => _iUserConverter.fromJson(e))
            .toList());
    return model;
  }

  @override
  SearchMessagesModel fromJsonSearchMessages(Map<String, dynamic> json) {
    SearchMessagesModel model = SearchMessagesModel(
        offset: json["offset"],
        total: json["total"],
        list: (json["list"] as List<dynamic>)
            .map((e) => _iMessageConverter.fromJson(e))
            .toList());
    return model;
  }

  @override
  TeamTheme fromJsonTheme(Map<String, dynamic> json) {
    return TeamTheme(
        json['name'], fromJsonThemeColors(json['name'], json['colors']));
  }

  @override
  TeamCname fromJsonTeamCname(Map<String, dynamic> json) {
    return TeamCname(
        id: json['id'],
        domain: json['domain'],
        enabled: json.containsKey('status') &&
            json['status'] != null &&
            json['status'] == RemoteConstants.cname_status_enabled);
  }

  @override
  TeamColors fromJsonThemeColors(String name, Map<String, dynamic> json) {
    final defaultThemeConfig = name == RemoteConstants.defaultTheme
        ? R.color.defaultTheme
        : name == RemoteConstants.bluejeansTheme
            ? R.color.bluejeansTheme
            : name == RemoteConstants.blackboardTheme
                ? R.color.blackboardTheme
                : name == RemoteConstants.lightTheme
                    ? R.color.lightTheme
                    : R.color.greenbeansTheme;
    return TeamColors(
        activeItemBackground: json['activeItemBackground'] != null
            ? (HexColor.fromHex(json['activeItemBackground']) ??
                defaultThemeConfig.colors.activeItemBackground)
            : defaultThemeConfig.colors.activeItemBackground,
        activeItemText: json['activeItemText'] != null
            ? (HexColor.fromHex(json['activeItemText']) ??
                defaultThemeConfig.colors.activeItemText)
            : defaultThemeConfig.colors.activeItemText,
        notificationBadgeBackground: json['notificationBadgeBackground'] != null
            ? (HexColor.fromHex(json['notificationBadgeBackground']) ??
                defaultThemeConfig.colors.notificationBadgeBackground)
            : defaultThemeConfig.colors.notificationBadgeBackground,
        notificationBadgeText: json['notificationBadgeText'] != null
            ? (HexColor.fromHex(json['notificationBadgeText']) ??
                defaultThemeConfig.colors.notificationBadgeText)
            : defaultThemeConfig.colors.notificationBadgeText,
        sidebarColor: json['sidebarColor'] != null
            ? (HexColor.fromHex(json['sidebarColor']) ??
                defaultThemeConfig.colors.sidebarColor)
            : defaultThemeConfig.colors.sidebarColor,
        textColor: json['textColor'] != null
            ? (HexColor.fromHex(json['textColor']) ??
                defaultThemeConfig.colors.textColor)
            : defaultThemeConfig.colors.textColor,
        activePresence: json['activePresence'] != null
            ? (HexColor.fromHex(json['activePresence']) ??
                defaultThemeConfig.colors.activePresence)
            : defaultThemeConfig.colors.activePresence,
        inactivePresence: json['inactivePresence'] != null
            ? (HexColor.fromHex(json['inactivePresence']) ??
                defaultThemeConfig.colors.inactivePresence)
            : defaultThemeConfig.colors.inactivePresence);
  }

  @override
  WhiteBrandConfig fromJsonWhiteBrandConfig(Map<String, dynamic> json) {
    final socialMedia =
        json.containsKey('social-media') && json['social-media'] != null
            ? json['social-media'] as List<dynamic>
            : [];
    return WhiteBrandConfig(
        domain: json['domain'],
        enabled: json['enabled'] ?? false,
        helpUrl: json['help-url'] ?? "",
        socialMedia: socialMedia
            .map((e) => SocialMedia(name: e['name'], url: e['url']))
            .toList());
  }

  @override
  Map<String, dynamic> toJsonTeamCname(TeamCname model) {
    final a = {
      "id": model.id,
      "domain": model.domain,
      "status": model.enabled ? RemoteConstants.cname_status_enabled : null
    };
    return a;
  }

  @override
  Map<String, dynamic> toJsonUpdate(TeamModel model, {String newTitle = ""}) {
    return newTitle.isEmpty
        ? {
            "adminscandelete": model.adminsCanDelete,
            "allmentionprotected": model.allMentionProtected,
            "channelmentionprotected": model.channelMentionProtected,
            "taskupdateprotected": model.taskUpdateProtected,
            "updateusernameblocked": model.updateUsernameBlocked,
            "onlyadmininvitesallowed": model.onlyAdminInvitesAllowed,
            "alwaysPush": model.alwaysPush,
            "show-phone-numbers": model.showPhoneNumbers,
            "show-emails": model.showEmails
          }
        : {
            "title": newTitle,
            "adminscandelete": model.adminsCanDelete,
            "allmentionprotected": model.allMentionProtected,
            "channelmentionprotected": model.channelMentionProtected,
            "taskupdateprotected": model.taskUpdateProtected,
            "updateusernameblocked": model.updateUsernameBlocked,
            "onlyadmininvitesallowed": model.onlyAdminInvitesAllowed,
            "alwaysPush": model.alwaysPush,
            "show-phone-numbers": model.showPhoneNumbers,
            "show-emails": model.showEmails
          };
  }

  @override
  Map<String, dynamic> toJsonTheme(TeamTheme model) {
    return {
      'theme': model.themeName,
      'colors': toJsonThemeColors(model.colors)
    };
  }

  @override
  Map<String, dynamic> toJsonThemeColors(TeamColors model) {
    return {
      'activeItemBackground': model.activeItemBackground != null
          ? HexColor.toHex(model.activeItemBackground!)
              .toLowerCase()
              .replaceRange(1, 3, "")
          : null,
      'notificationBadgeText': model.notificationBadgeText != null
          ? HexColor.toHex(model.notificationBadgeText!)
              .toLowerCase()
              .replaceRange(1, 3, "")
          : null,
      'notificationBadgeBackground': model.notificationBadgeBackground != null
          ? HexColor.toHex(model.notificationBadgeBackground!)
              .toLowerCase()
              .replaceRange(1, 3, "")
          : null,
      'activePresence': model.activePresence != null
          ? HexColor.toHex(model.activePresence!)
              .toLowerCase()
              .replaceRange(1, 3, "")
          : null,
      'activeItemText': model.activeItemText != null
          ? HexColor.toHex(model.activeItemText!)
              .toLowerCase()
              .replaceRange(1, 3, "")
          : null,
      'sidebarColor': model.sidebarColor != null
          ? HexColor.toHex(model.sidebarColor!)
              .toLowerCase()
              .replaceRange(1, 3, "")
          : null,
      'textColor': model.textColor != null
          ? HexColor.toHex(model.textColor!)
              .toLowerCase()
              .replaceRange(1, 3, "")
          : null,
      'inactivePresence': model.inactivePresence != null
          ? HexColor.toHex(model.inactivePresence!)
              .toLowerCase()
              .replaceRange(1, 3, "")
          : null
    };
  }

  @override
  TeamEnterprise fromJsonTeamEnterprise(Map<String, dynamic> json) {
    return TeamEnterprise(enabled: json["enabled"] ?? false);
  }

  @override
  Map<String, dynamic> toJsonTeamEnterprise(TeamEnterprise model) {
    return {"enabled": model.enabled};
  }
}
