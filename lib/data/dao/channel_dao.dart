import 'dart:convert';

import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/dao/_base/app_database.dart';
import 'package:code/data/dao/_base/db_constants.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_converter.dart';
import 'package:code/domain/channel/i_channel_dao.dart';
import 'package:sqflite/sqflite.dart';

class ChannelDao extends IChannelDao {
  final AppDatabase _appDatabase;
  final IChannelConverter _iChannelConverter;

  ChannelDao(this._appDatabase, this._iChannelConverter);

  @override
  Future<ChannelModel?> getChannel(String channelId) async {
    try {
      Database db = await _appDatabase.db;
      final data = await db.query(DBConstants.channel_table,
          where: '${DBConstants.id_key}= ?', whereArgs: [channelId]);
      if (data.isNotEmpty) {
        final String? value = data[0][DBConstants.data_key] as String?;
        final ChannelModel obj = _iChannelConverter.fromJson(jsonDecode(value ?? ""));
        return obj;
      }
      return null;
    } catch (ex) {
      return null;
    }
  }

  @override
  Future<List<ChannelModel>> getChannels(String teamId, String type) async {
    List<ChannelModel> list = [];
    try {
      Database db = await (_appDatabase.db);
      final data = await db.query(DBConstants.channel_table,
          where: '${DBConstants.parent_key}= ?', whereArgs: [teamId]);
      await Future.forEach(data, (Map<String, Object?> map) {
        final String? value = map[DBConstants.data_key] as String?;
        final ChannelModel obj = _iChannelConverter.fromJson(jsonDecode(value ?? ""));
        if (type.isNotEmpty == true) {
          if (type == RemoteConstants.channel && obj.isOpenChannel)
            list.add(obj);
          else if (type == RemoteConstants.group && obj.isPrivateGroup)
            list.add(obj);
        } else
          list.add(obj);
      });
    } catch (ex) {
      print(ex.toString());
    }
    return list;
  }

  @override
  Future<bool> saveChannel(ChannelModel model) async {
    try {
      Database db = await _appDatabase.db;
      final map = {
        DBConstants.id_key: model.id,
        DBConstants.data_key: jsonEncode(_iChannelConverter.toJson(model)),
        DBConstants.parent_key: model.tid
      };
      await db.insert(DBConstants.channel_table, map,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> saveChannels(List<ChannelModel> models) async {
    try {
      await Future.forEach<ChannelModel>(models, (model) async {
        await saveChannel(model);
      });
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> removeChannel(String channelId) async {
    try {
      Database db = await _appDatabase.db;
      final rows = await db.delete(DBConstants.channel_table,
          where: '${DBConstants.id_key}= ?', whereArgs: [channelId]);
      return rows > 0;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<void> removeChannels(List<String> channelIds) async {
    await Future.forEach<String>(channelIds, (id) async {
      await removeChannel(id);
    });
  }
}
