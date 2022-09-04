import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:code/data/dao/_base/app_database.dart';
import 'package:code/data/dao/_base/db_constants.dart';
import 'package:code/domain/team/i_team_converter.dart';
import 'package:code/domain/team/i_team_dao.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:sqflite/sqflite.dart';

class TeamDao extends ITeamDao {
  final AppDatabase _appDatabase;
  final ITeamConverter _iTeamConverter;

  TeamDao(this._appDatabase, this._iTeamConverter);

  @override
  Future<List<TeamModel>> getTeams() async {
    List<TeamModel> list = [];
    try {
      Database db = await _appDatabase.db;
      final data = await db.query(DBConstants.team_table);
      data.forEach((map) {
        final String? value = map[DBConstants.data_key] as String?;
        final TeamModel obj = _iTeamConverter.fromJson(jsonDecode(value ?? ""));
        list.add(obj);
      });
    } catch (ex) {
      print(ex.toString());
    }
    return list;
  }

  @override
  Future<TeamModel?> getTeam(String teamId) async {
    try {
      final teams = await getTeams();
      return teams.firstWhereOrNull((element) => element.id == teamId);
    } catch (ex) {
      return null;
    }
  }

  @override
  Future<bool> saveTeam(TeamModel model) async {
    try {
      Database db = await _appDatabase.db;
      final map = {
        DBConstants.id_key: model.id,
        DBConstants.data_key: jsonEncode(_iTeamConverter.toJson(model)),
      };
      await db.insert(DBConstants.team_table, map,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> saveTeams(List<TeamModel> models) async {
    try {
      await Future.forEach<TeamModel>(models, (model) async {
        await saveTeam(model);
      });
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<TeamJoinedModel?> getJoinedTeam(String teamId) async {
    try {
      final teams = await getJoinedTeams();
      return teams.firstWhereOrNull((element) => element.team.id == teamId);
    } catch (ex) {
      return null;
    }
  }

  @override
  Future<List<TeamJoinedModel>> getJoinedTeams() async {
    List<TeamJoinedModel> list = [];
    try {
      Database db = await _appDatabase.db;
      final data = await db.query(DBConstants.team_joined_table);
      data.forEach((map) {
        final String? value = map[DBConstants.data_key] as String?;
        final TeamJoinedModel obj =
            _iTeamConverter.fromJsonTeamJoined(jsonDecode(value ?? ""));
        list.add(obj);
      });
    } catch (ex) {
      print(ex.toString());
    }
    return list;
  }

  @override
  Future<bool> saveJoinedTeam(TeamJoinedModel model) async {
    try {
      Database db = await _appDatabase.db;
      final map = {
        DBConstants.id_key: model.team.id,
        DBConstants.data_key:
            jsonEncode(_iTeamConverter.toJsonTeamJoined(model)),
      };
      await db.insert(DBConstants.team_joined_table, map,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> saveJoinedTeams(List<TeamJoinedModel> models) async {
    try {
      await Future.forEach<TeamJoinedModel>(models, (model) async {
        await saveJoinedTeam(model);
      });
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<void> removeTeam(String teamId) async {
    try {
      Database db = await _appDatabase.db;
      await db.delete(DBConstants.team_table,
          where: '${DBConstants.id_key}= ?', whereArgs: [teamId]);
    } catch (ex) {
      throw ex;
    }
  }

  @override
  Future<void> removeTeams() async {
    try {
      Database db = await _appDatabase.db;
      await db.delete(DBConstants.team_table);
    } catch (ex) {
      throw ex;
    }
  }
}
