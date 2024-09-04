import 'package:soko_soko_db/src/abstracts/abstracts.dart';

class SokoQueryBuilder<T extends SokoItem> {
  final _filters = <Function(T)>[];
  int? _limit;
  int? _offset;

  SokoQueryBuilder<T> where(Function(T) filter) {
    _filters.add(filter);

    return this;
  }

  SokoQueryBuilder<T> limit(int limit) {
    _limit = limit;

    return this;
  }

  SokoQueryBuilder<T> offset(int offset) {
    _offset = offset;

    return this;
  }

  Future<List<T>> execute() async {
    // Implement query execution logic

    return [];
  }
}
