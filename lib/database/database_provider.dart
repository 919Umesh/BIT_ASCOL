// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'create_table.dart';
// import 'database_const.dart';
//
// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();
//
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//   static Database? _database;
//
//   Future<Database?> get database async {
//     if (_database != null) return _database;
//     _database = await initiateDatabase();
//     return _database;
//   }
//
//   late String path;
//
//   initiateDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     path = join(directory.path, DatabaseDetails.databaseName);
//     return await openDatabase(
//       path,
//       version: DatabaseDetails.dbVersion,
//       onCreate: onCreate,
//     );
//   }
//
//   Future<void> onDropDatabase() async {
//     Database? db = await instance.database;
//     await db!.delete(DatabaseDetails.pdfListTable);
//
//   }
//
//
//
//
//   Future<void> onCreate(Database db, int version) async {
//     ///
//     await CreateTable(db).pdfListTable();
//
//
//
//     ///
//   }
// }
