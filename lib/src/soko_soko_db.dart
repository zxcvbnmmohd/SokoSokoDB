import 'package:soko_soko_db/src/abstracts/abstracts.dart';
import 'package:soko_soko_db/src/builders/builders.dart';
import 'package:soko_soko_db/src/caching_strategies/caching_strategies.dart';
import 'package:soko_soko_db/src/services/services.dart';
import 'package:soko_soko_db/src/values/values.dart';

class SokoSokoDB {
  static late SokoCachingStrategy _strategy;
  static late List<SokoMiddleware> _middlewares;
  static late bool _enableAnalytics;
  static late SokoDatabaseService _localDatabaseService;
  static SokoDatabaseService? _remoteDatabaseService;

  static void initialize({
    SokoCachingStrategy strategy = const TimedCachingStrategy(),
    List<SokoMiddleware> middlewares = const <SokoMiddleware>[],
    bool enableAnalytics = false,
    SokoDatabaseService localDatabaseService = LocalDatabaseService(),
    SokoDatabaseService? remoteDatabaseService,
  }) {
    _strategy = strategy;
    _middlewares = middlewares;
    _enableAnalytics = enableAnalytics;
    _localDatabaseService = localDatabaseService;
    _remoteDatabaseService = remoteDatabaseService;
  }

  static SokoCachingStrategy get strategy => _strategy;
  static List<SokoMiddleware> get middlewares => _middlewares;
  static bool get enableAnalytics => _enableAnalytics;
  static SokoDatabaseService get localDatabaseService => _localDatabaseService;
  static SokoDatabaseService? get remoteDatabaseService =>
      _remoteDatabaseService;

  static SokoQueryBuilder<T> list<T extends SokoItem>() {
    return SokoQueryBuilder<T>();
  }

  static Future<void> listen<T extends SokoItem>(
    Function(SokoChange change, T item) onChange,
  ) async {
    // Implement subscription logic
  }
}
