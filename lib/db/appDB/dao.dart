import 'package:cubit/db/appDB/base.dart';
import 'package:cubit/db/table/table.dart';
import 'package:sqflite/sqflite.dart';

class OfflineDao extends DBBase {
  // ignore: unused_field
  static final OfflineDao _offline = OfflineDao._internal();
  OfflineDao._internal() : super(tableName: OfflineTable.offlineTable);
  static OfflineDao get() {
    return _offline;
  }

  Future<void> addOfflineData(
    dynamic data,
  ) async {
    try {
      Database? db = await appDatabase.getDB();
      final batch = db.batch();
      for (final item in data) {
        batch.insert(tableName, item, conflictAlgorithm: conflictAlgorithm);
      }
      batch.commit(noResult: true);
    } catch (e) {
      throw Exception(e);
    }
  }
}
