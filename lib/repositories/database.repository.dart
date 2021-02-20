import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  static const String tableName = 'register';
  static const String id = 'id';
  static const String username = 'username';

  static const String tableSql = 'CREATE TABLE $tableName('
      '$id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$username TEXT)';

  static Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'flutterSql.db');

    return openDatabase(path, onCreate: (db, version) {
      db.execute(tableSql);
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  }
}
