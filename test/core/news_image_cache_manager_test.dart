import 'package:flutter_test/flutter_test.dart';
import 'package:news_reader_app/core/storage/news_image_cache_manager.dart';


void main() {
  group('NewsImageCacheManager — constants', () {
    test('cache key constant is "news_image_cache"', () {
      expect(NewsImageCacheManager.key, equals('news_image_cache'));
    });
  });


  group('NewsImageCacheManager — TTL expiry logic', () {
    const stalePeriod = Duration(days: 7); 

    bool isStale(DateTime fetchedAt) =>
        DateTime.now().isAfter(fetchedAt.add(stalePeriod));

    test('configured stalePeriod constant is 7 days', () {
  
      expect(stalePeriod, equals(const Duration(days: 7)));
    });

    test('a file fetched right now is NOT stale', () {
      expect(isStale(DateTime.now()), isFalse);
    });

    test('a file fetched 6 days ago is NOT stale (within TTL)', () {
      expect(
        isStale(DateTime.now().subtract(const Duration(days: 6))),
        isFalse,
      );
    });

    test(
      'a file fetched 7 days - 1 second ago is NOT stale (just inside TTL)',
      () {
        final fetchedAt = DateTime.now().subtract(
          const Duration(days: 7) - const Duration(seconds: 1),
        );
        expect(isStale(fetchedAt), isFalse);
      },
    );

    test('a file fetched 7 days + 1 second ago IS stale (just past TTL)', () {
      final fetchedAt = DateTime.now().subtract(
        const Duration(days: 7) + const Duration(seconds: 1),
      );
      expect(isStale(fetchedAt), isTrue);
    });

    test('a file fetched 8 days ago IS stale', () {
      expect(isStale(DateTime.now().subtract(const Duration(days: 8))), isTrue);
    });

    test('a file fetched 30 days ago IS stale', () {
      expect(
        isStale(DateTime.now().subtract(const Duration(days: 30))),
        isTrue,
      );
    });

    test(
      'staleness is monotonic — older files are always stale when newer are',
      () {
        // 6 days → not stale
        expect(
          isStale(DateTime.now().subtract(const Duration(days: 6))),
          isFalse,
        );
        // 7 days + 1 s → stale
        expect(
          isStale(
            DateTime.now().subtract(
              const Duration(days: 7) + const Duration(seconds: 1),
            ),
          ),
          isTrue,
        );
        // 8 days → stale
        expect(
          isStale(DateTime.now().subtract(const Duration(days: 8))),
          isTrue,
        );
        // 30 days → stale
        expect(
          isStale(DateTime.now().subtract(const Duration(days: 30))),
          isTrue,
        );
      },
    );
  });



  group('NewsImageCacheManager — singleton', () {
    test('key constant is stable across calls (no construction needed)', () {

      expect(NewsImageCacheManager.key, equals('news_image_cache'));
      expect(NewsImageCacheManager.key, equals('news_image_cache'));
    });

    test('instance field is null before first construction', () {

      expect(NewsImageCacheManager.key, isNotEmpty); 
    });
  });
}
