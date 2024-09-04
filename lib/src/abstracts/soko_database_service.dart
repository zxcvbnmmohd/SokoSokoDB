abstract class SokoDatabaseService {
  Future<Map<String, dynamic>?> get(
    String table,
    Map<String, String> key,
  );

  Future<void> create(
    String table,
    Map<String, String> key,
    Map<String, dynamic> data,
  );

  Future<void> update(
    String table,
    Map<String, String> key,
    Map<String, dynamic> data,
  );

  Future<void> delete(
    String table,
    Map<String, String> key,
  );
}
