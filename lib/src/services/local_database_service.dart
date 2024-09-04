import 'dart:convert';
import 'package:path/path.dart';
import 'package:soko_soko_db/src/utilities/utilities.dart';
import 'package:sqflite/sqflite.dart';
import 'package:soko_soko_db/src/abstracts/abstracts.dart';

Database? _database;

class LocalDatabaseService implements SokoDatabaseService {
  const LocalDatabaseService();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'soko_soko_db.db');

    return await openDatabase(path, version: 1);
  }

  Future<void> _createTableIfNotExists(
    Database db,
    String table,
    Map<String, dynamic> data,
  ) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        ${data.keys.map((key) => '$key TEXT').join(', ')}
      )
    ''');
  }

  @override
  Future<Map<String, dynamic>?> get(
    String table,
    Map<String, String> key,
  ) async {
    final db = await database;

    final maps = await db.query(
      table,
      where: key.keys.map((k) => '$k = ?').join(' AND '),
      whereArgs: key.values.toList(),
    );

    if (maps.isNotEmpty) {
      var result = maps.first;

      if (result['encryptData'] == true) {
        result = result.map(
          (key, value) {
            return MapEntry(
              key,
              json.decode(
                EncryptionUtility.decryptData(value as String),
              ),
            );
          },
        );
      }

      return result;
    }

    return null;
  }

  @override
  Future<void> create(
    String table,
    Map<String, String> key,
    Map<String, dynamic> data,
  ) async {
    final db = await database;

    await _createTableIfNotExists(db, table, data);

    if (data['encryptData'] == true) {
      data = data.map(
        (key, value) {
          return MapEntry(
            key,
            EncryptionUtility.encryptData(
              json.encode(value),
            ),
          );
        },
      );
    }

    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(
    String table,
    Map<String, String> key,
    Map<String, dynamic> data,
  ) async {
    final db = await database;

    if (data['encryptData'] == true) {
      data = data.map(
        (key, value) {
          return MapEntry(
            key,
            EncryptionUtility.encryptData(
              json.encode(value),
            ),
          );
        },
      );
    }

    await db.update(
      table,
      data,
      where: key.keys.map((k) => '$k = ?').join(' AND '),
      whereArgs: key.values.toList(),
    );
  }

  @override
  Future<void> delete(String table, Map<String, String> key) async {
    final db = await database;
    await db.delete(
      table,
      where: key.keys.map((k) => '$k = ?').join(' AND '),
      whereArgs: key.values.toList(),
    );
  }
}
