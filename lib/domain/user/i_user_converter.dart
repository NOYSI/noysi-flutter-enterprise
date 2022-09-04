import 'package:code/domain/user/user_model.dart';

abstract class IUserConverter {
  MemberModel fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(MemberModel model);

  MemberWrapperModel fromJsonMemberWrapper(Map<String, dynamic> json);

  Map<String, dynamic> toJsonMemberWrapper(MemberWrapperModel model);

  MemberProfile fromJsonMemberProfile(Map<String, dynamic> json);

  MemberNotification? fromJsonMemberNotification(Map<String, dynamic> json);

  Map<String, dynamic>? toJsonMemberNotification(MemberNotification model);

  Map<String, dynamic> toJsonMemberProfile(MemberProfile memberProfile);

}
