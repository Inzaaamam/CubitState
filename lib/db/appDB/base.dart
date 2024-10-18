
import 'package:cubit/db/appDB/app_db.dart';
import 'package:sqflite/sqflite.dart';

class DBBase {
  DBBase({
    required this.tableName,
    this.conflictAlgorithm = ConflictAlgorithm.replace,
  }) {
    appDatabase = AppDatabase.get();
  }
  String tableName;
  late final AppDatabase appDatabase;
  final ConflictAlgorithm conflictAlgorithm;

  Future<int> insert(
    Map<String, dynamic> data,
  ) async {
    try {
      Database? db = await appDatabase.getDB();
      return db.insert(tableName, data, conflictAlgorithm: conflictAlgorithm);
    } catch (_) {
      throw Exception(_.toString());
    }
  }

  Future<void> insertList(List<Map<String, dynamic>> dataList) async {
    try {
      Database? db = await appDatabase.getDB();
      final batch = db.batch();
      for (final item in dataList) {
        batch.insert(tableName, item, conflictAlgorithm: conflictAlgorithm);
      }
      batch.commit(noResult: true);
    } catch (e) {
      throw Exception(e);
    }
  }
}
