import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/ui/_base/bloc_base.dart';

class InviteBloC extends BaseBloC {
  final SharedPreferencesManager _prefs;
  final InMemoryData _inMemoryData;

  InviteBloC(this._prefs, this._inMemoryData);

  @override
  void dispose() {}

  MemberModel? memberModel;

  void loadMember() async {
    final userId = await _prefs.getStringValue(_prefs.userId);
    memberModel = _inMemoryData.getMember(userId);
  }
}
