import 'package:soko_soko_db/src/abstracts/soko_item.dart';

abstract class SokoMiddleware {
  Future<void> onCreate(SokoItem item);
  Future<void> onUpdate(SokoItem item);
  Future<void> onDelete(Map<String, String> key);
}
