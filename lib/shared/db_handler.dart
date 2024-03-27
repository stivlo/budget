import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import '../model/account.dart';

class DbHandler {
  // Private constructor
  DbHandler._internal();

  // Factory constructor
  factory DbHandler() => _instance;

  final int _dbVersion = 1;
  static Database? _dbInstance;
  static final DbHandler _instance = DbHandler._internal();

  Future<void> execute(String sql) async => (await _db).execute(sql);

  Future<int> insert(String table, Map<String, dynamic> values) async =>
      (await _db).insert(table, values);

  Future<List<Map<String, Object?>>> query(String table,
          {bool? distinct,
          List<String>? columns,
          String? where,
          List<Object?>? whereArgs,
          String? groupBy,
          String? having,
          String? orderBy,
          int? limit,
          int? offset}) async =>
      (await _db).query(
        table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );

  Future<Database> get _db async {
    var dbPath = path.join(await getDatabasesPath(), 'budget.db');
    _dbInstance ??= await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: (database, version) async {
        var batch = database.batch();
        _createTableAccountV1(batch);
        await batch.commit();
      },
    );
    return _dbInstance!;
  }

  void _createTableAccountV1(Batch batch) {
    // batch.execute('DROP TABLE IF EXISTS account');
    batch.execute('''CREATE TABLE account (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT(${Account.nameMaxLength}),
        currency TEXT(3))''');
  }
}
