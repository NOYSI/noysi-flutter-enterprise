class DBConstants {
  static final String db_name = 'noysi_db';
  static final int db_version = 1;

  ///Common table schema
  static final Map<String, String> table_cols = {
    DBConstants.id_key: DBConstants.text_type,
    DBConstants.data_key: DBConstants.text_type,
    DBConstants.parent_key: DBConstants.text_type,
  };

  static final Map<String, String> table_offline_cols = {
    DBConstants.id_key: DBConstants.text_type,
    DBConstants.data_key: DBConstants.text_type,
    DBConstants.parent_key: DBConstants.text_type,
  };

  ///columns names
  static final String id_key = 'id';
  static final String data_key = 'data';
  static final String parent_key = 'parent_id';

  ///columns types
  static final String text_type = 'TEXT';
  static final String real_type = 'REAL';
  static final String int_type = 'INTEGER';

  ///table names
  static final String team_joined_table = 'team_joined_table';
  static final String team_table = 'team_table';
  static final String channel_table = 'channel_table';
  static final String member_table = 'member_table';
}
