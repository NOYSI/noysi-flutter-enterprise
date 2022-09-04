import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:code/data/dao/_base/app_database.dart';
import 'package:code/data/dao/_base/db_constants.dart';
import 'package:code/domain/user/i_user_converter.dart';
import 'package:code/domain/user/i_user_dao.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDao extends IUserDao {
  final AppDatabase _appDatabase;
  final IUserConverter _iUserConverter;

  UserDao(this._appDatabase, this._iUserConverter);

  @override
  Future<MemberModel?> getMember(String memberId) async {
    try {
      final members = await getMembers();
      return members.firstWhereOrNull((element) => element.id == memberId);
    } catch (ex) {
      return null;
    }
  }

  @override
  Future<List<MemberModel>> getMembers() async {
    List<MemberModel> list = [];
    try {
      Database db = await _appDatabase.db;
      final data = await db.query(DBConstants.member_table);
      data.forEach((map) {
        final String? value = map[DBConstants.data_key] as String?;
        final MemberModel obj = _iUserConverter.fromJson(jsonDecode(value ?? ""));
        list.add(obj);
      });
    } catch (ex) {
      print(ex.toString());
    }
    return list;
  }

  @override
  Future<List<MemberModel>> getMembersByTeam(String teamId) async {
    List<MemberModel> list = [];
    try {
      Database db = await _appDatabase.db;
      final data = await db.query(DBConstants.member_table,
          where: '${DBConstants.parent_key}= ?', whereArgs: [teamId]);
      data.forEach((map) {
        final String? value = map[DBConstants.data_key] as String?;
        final MemberModel obj = _iUserConverter.fromJson(jsonDecode(value ?? ""));
        list.add(obj);
      });
    } catch (ex) {
      print(ex.toString());
    }
    return list;
  }

  @override
  Future<bool> saveMember(MemberModel model) async {
    try {
      Database db = await _appDatabase.db;
      final map = {
        DBConstants.id_key: model.id,
        DBConstants.data_key: jsonEncode(_iUserConverter.toJson(model)),
        DBConstants.parent_key: model.tid
      };
      await db.insert(DBConstants.member_table, map,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> saveMembers(List<MemberModel> models) async {
    try {
      await Future.forEach<MemberModel>(models, (model) async {
        await saveMember(model);
      });
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> removeMember(String memberId) async {
    try {
      Database db = await _appDatabase.db;
      final rows = await db.delete(DBConstants.member_table,
          where: '${DBConstants.id_key}= ?', whereArgs: [memberId]);
      return rows > 0;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<void> removeMembersByTeam(String teamId) async {
    final members = await getMembersByTeam(teamId);
    await Future.forEach<MemberModel>(members, (element) async {
      await removeMember(element.id);
    });
  }
}
