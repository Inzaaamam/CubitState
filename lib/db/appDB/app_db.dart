import 'dart:async';

import 'package:cubit/db/table/table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();
  AppDatabase._internal();
  static const tablename = 'Account';
  // ignore: unused_field
  late Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didinIt = false;
  Future<Database> getDB() async {
    if (!didinIt) await _init();
    return _database;
  }

  Future _init() async {
    // ignore: unused_local_variable
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, tablename);
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await _createOfflineTable(db);
      },
    );
    didinIt = true;
  }

  // ignore: unused_element
  Future _createOfflineTable(Database db) {
    return db.execute(
        "CREATE TABLE ${OfflineTable.offlineTable} ("
            "${OfflineTable.dbId} TEXT PRIMARY KEY,"
            "${OfflineTable.dbIsSynced} TEXT,"
            "${OfflineTable.dbServerData} TEXT"
            ")"
    );
  }
}
