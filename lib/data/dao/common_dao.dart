import 'package:code/domain/common_db/i_common_dao.dart';
import 'package:sqflite/sqflite.dart';

import '_base/app_database.dart';
import '_base/db_constants.dart';

class CommonDao implements ICommonDao {
  final AppDatabase _appDatabase;

  CommonDao(this._appDatabase);

  @override
  Future<bool> cleanDB() async {
    try {
      Database db = await _appDatabase.db;
      db.delete(DBConstants.team_joined_table);
      db.delete(DBConstants.team_table);
      db.delete(DBConstants.channel_table);
      // db.delete(DBConstants.member_table);

      ///Add here all lines for complete data remove by each table...
      return true;
    } catch (ex) {
      return false;
    }
  }
}
