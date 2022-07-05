import 'package:code/domain/user/i_user_converter.dart';
import 'package:code/domain/user/user_model.dart';

class UserConverter implements IUserConverter {
  @override
  MemberModel fromJson(Map<String, dynamic> json) {
    final MemberModel model = MemberModel(
        id: json["id"],
        tid: json["tid"],
        photo: json["photo"] ?? "",
        role: json["role"],
        active: json["active"],
        presence: json["presence"],
        tour: json["tour"],
        statusIcon: json.containsKey("status_icon") && json['status_icon'] != null  ? json["status_icon"].replaceAll("-", "-200d-") : "",
        statusText: json['status_txt'] ?? "",
        profile: json.containsKey("profile") && json["profile"] != null
            ? fromJsonMemberProfile(json["profile"])
            : null,
        notifications: json.containsKey("notifications") && json["notifications"] != null
            ? fromJsonMemberNotification(json["notifications"])
            : null,
        lastEmailNotification: json.containsKey("lastEmailNotification")
            ? (json["lastEmailNotification"] != null
                ? DateTime.fromMillisecondsSinceEpoch(
                    json["lastEmailNotification"],
                    isUtc: true).toLocal()
                : null)
            : null);
    if(model.statusIcon.isEmpty && model.statusText.isNotEmpty) model.statusIcon = "1F4AC";
    return model;
  }

  @override
  Map<String, dynamic> toJson(MemberModel model) {
    final map = {
      "id": model.id,
      "tid": model.tid,
      "photo": model.photo,
      "role": model.role,
      "active": model.active,
      "presence": model.presence,
      "tour": model.tour,
      "profile": toJsonMemberProfile(model.profile!),
      "notifications": toJsonMemberNotification(model.notifications),
      "lastEmailNotification":
          model.lastEmailNotification?.millisecondsSinceEpoch,
      "status_icon": model.statusIcon.replaceAll("-200d-", "-"),
      "status_txt": model.statusText,
    };
    return map;
  }

  @override
  MemberNotification? fromJsonMemberNotification(Map<String, dynamic>? json) {
    if (json == null) return null;
    final MemberNotification model = MemberNotification(
        sounds: json["sounds"],
        newsLetters: json["newsletters"],
        emails: json["emails"],
        push: json["push"]);
    return model;
  }

  @override
  MemberProfile fromJsonMemberProfile(Map<String, dynamic> json) {
    final MemberProfile model = MemberProfile(
        name: json["name"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        skype: json["skype"],
        phone: json["phone"],
        email: json["email"],
        position: json["position"],
        description: json["description"],
        language: json["language"],
        country: json["country"],
        verified: json["verified"]);
    return model;
  }

  @override
  Map<String, dynamic> toJsonMemberProfile(MemberProfile model) {
    final map = {
      "name": model.name,
      "firstName": model.firstName,
      "lastName": model.lastName,
      "skype": model.skype,
      "phone": model.phone,
      "email": model.email,
      "position": model.position,
      "description": model.description,
      "language": model.language,
      "country": model.country,
      "verified": model.verified
    };
    return map;
  }

  @override
  Map<String, dynamic>? toJsonMemberNotification(MemberNotification? model) {
    if (model == null) return null;
    final map = {
      "sounds": model.sounds,
      "newsletters": model.newsLetters,
      "emails": model.emails,
      "push": model.push
    };
    return map;
  }

  @override
  MemberWrapperModel fromJsonMemberWrapper(Map<String, dynamic> json) {
    final MemberWrapperModel model = MemberWrapperModel(
        list: (json["list"] as List<dynamic>).map((e) => fromJson(e)).toList(),
        totalUsers: json["totalusers"],
        total: json["total"],
        totalMembers: json["totalmembers"],
        totalGuests: json["totalguests"],
        totalAdmins: json["totaladmins"],
        offset: json["offset"]);
    return model;
  }

  @override
  Map<String, dynamic> toJsonMemberWrapper(MemberWrapperModel model) {
    final map = {
      "list": model.list.map((e) => toJson(e)).toList(),
      "totalusers": model.totalUsers,
      "total": model.total,
      "totalmembers": model.totalMembers,
      "totalguests": model.totalGuests,
      "totaladmins": model.totalAdmins,
      "offset": model.offset
    };
    return map;
  }
}
