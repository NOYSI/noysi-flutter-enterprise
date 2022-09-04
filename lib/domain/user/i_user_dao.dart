import 'package:code/domain/user/user_model.dart';

abstract class IUserDao {
  Future<List<MemberModel>> getMembers();

  Future<MemberModel?> getMember(String memberId);

  Future<List<MemberModel>> getMembersByTeam(String teamId);

  Future<bool> saveMember(MemberModel model);

  Future<bool> saveMembers(List<MemberModel> models);

  Future<bool> removeMember(String memberId);

  Future<void> removeMembersByTeam(String teamId);
}
