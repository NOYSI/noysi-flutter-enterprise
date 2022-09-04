import 'package:code/data/api/remote/remote_constants.dart';

import '../../enums.dart';

class MemberWrapperModel {
  List<MemberModel> list;
  int? totalUsers;
  int? totalMembers;
  int? totalGuests;
  int? totalAdmins;
  int? offset;
  int? total;

  MemberWrapperModel(
      {this.list = const [],
      this.total = 0,
      this.totalUsers = 0,
      this.totalAdmins = 0,
      this.totalGuests = 0,
      this.totalMembers = 0,
      this.offset = 0});
}

class MemberModel {
  String id;
  String tid;
  String photo;
  String role;
  bool active;
  String presence;
  bool? tour;
  MemberProfile? profile;
  MemberNotification? notifications;
  DateTime? lastEmailNotification;
  String statusIcon, statusText;

  bool get isNoysiRobot => id == RemoteConstants.noysiRobot;

  bool get isDeletedUser => profile?.email == "deleted@noysi.com";

  UserPresence get userPresence => presence.toLowerCase() == "online"
      ? UserPresence.online
      : presence.toLowerCase() == "offline"
          ? UserPresence.offline
          : UserPresence.out;

  UserRol get userRol => role.toLowerCase() == "administrator"
      ? UserRol.Admin
      : role.toLowerCase() == "member"
          ? UserRol.Member
          : role.toLowerCase() == "guest"
              ? UserRol.Guest
              : role.toLowerCase() == "integration"
                  ? UserRol.Guest
                  : role.toLowerCase() == "robot"
                      ? UserRol.Robot
                      : UserRol.None;

  MemberModel(
      {this.id = '',
      this.tid = '',
      this.profile,
      this.photo = '',
      this.role = '',
      this.active = true,
      this.presence = 'offline',
      this.tour,
      this.statusIcon = '',
      this.statusText = '',
      this.notifications,
      this.lastEmailNotification});
}

class MemberProfile {
  String name;
  String? firstName;
  String? lastName;
  String? skype;
  String? phone;
  String? email;
  bool? verified;
  String? position;
  String? description;
  String? language;
  String? country;

  String get fullName =>
      ("${firstName ?? ""} ${lastName ?? ""}".trim()).isEmpty
          ? name
          : "$firstName $lastName".trim();

  String get fullNameWithUsername =>
      ("${firstName ?? ""} ${lastName ?? ""}".trim()).isEmpty
          ? name
          : "$firstName $lastName - @$name".trim();

  MemberProfile(
      {this.name = "",
      this.firstName = "",
      this.lastName = "",
      this.skype = '',
      this.phone = '',
      this.email = "",
      this.verified,
      this.position = '',
      this.description = "",
      this.language = '',
      this.country = ''});
}

class MemberNotification {
  String? sounds;
  bool? newsLetters;
  String? emails;
  bool? push;

  MemberNotification({this.sounds, this.newsLetters, this.emails, this.push});
}
