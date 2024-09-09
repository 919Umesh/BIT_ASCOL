import 'package:sqflite/sqflite.dart';

import 'database_const.dart';

class CreateTable {
  Database db;

  CreateTable(this.db);

  /// Notes List Info
  dataListTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.dataListTable} (
                                                ${DatabaseDetails.url} TEXT,
                                                ${DatabaseDetails.semester} TEXT,
                                                ${DatabaseDetails.subject} TEXT
                                  ) ''');
  }
}
