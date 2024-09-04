import 'package:soko_soko_db/src/soko_soko_db.dart';
import 'package:soko_soko_db/src/values/soko_change.dart';

abstract class SokoItem {
  String get table;

  Map<String, String> get key;

  bool get encryptData => false;

  Map<String, dynamic> get toJson;

  Future<void> create({bool createRemotely = false}) async {
    await Future.wait(<Future<void>>[
      for (final middleware in SokoSokoDB.middlewares)
        middleware.onCreate(this),
      SokoSokoDB.strategy.applyStrategy(),
      SokoSokoDB.localDatabaseService.create(table, key, toJson),
      if (createRemotely && SokoSokoDB.remoteDatabaseService != null)
        SokoSokoDB.remoteDatabaseService!.create(table, key, toJson),
    ]);
  }

  Future<void> update({bool updateRemotely = false}) async {
    await Future.wait(<Future<void>>[
      for (final middleware in SokoSokoDB.middlewares)
        middleware.onUpdate(this),
      SokoSokoDB.strategy.applyStrategy(),
      SokoSokoDB.localDatabaseService.update(table, key, toJson),
      if (updateRemotely && SokoSokoDB.remoteDatabaseService != null)
        SokoSokoDB.remoteDatabaseService!.update(table, key, toJson),
    ]);
  }

  Future<void> delete({bool deleteRemotely = false}) async {
    await Future.wait(<Future<void>>[
      for (final middleware in SokoSokoDB.middlewares) middleware.onDelete(key),
      SokoSokoDB.strategy.applyStrategy(),
      SokoSokoDB.localDatabaseService.delete(table, key),
      if (deleteRemotely && SokoSokoDB.remoteDatabaseService != null)
        SokoSokoDB.remoteDatabaseService!.delete(table, key),
    ]);
  }

  static Future<void> sync<T extends SokoItem>(
    Function(SokoChange change, T item) onChange,
  ) async {
    //
  }
}
