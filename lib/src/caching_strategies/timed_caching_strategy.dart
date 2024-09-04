import 'package:soko_soko_db/src/abstracts/abstracts.dart';

class TimedCachingStrategy implements SokoCachingStrategy {
  const TimedCachingStrategy({
    this.duration = const Duration(minutes: 30),
  });

  final Duration duration;

  @override
  Future<void> applyStrategy() async {
    // Implement timed caching logic
  }
}
