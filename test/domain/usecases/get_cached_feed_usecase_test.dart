import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/usecases/get_cached_feed_usecase.dart';

import '../../helpers/mock_repository.dart';

void main() {
  late MockNewsRepository repo;
  late GetCachedFeedUseCase useCase;

  setUpAll(registerFallbackValues);

  setUp(() {
    repo = MockNewsRepository();
    useCase = GetCachedFeedUseCase(repo);
  });

  group('GetCachedFeedUseCase', () {
    test('returns cached articles for the given feed', () async {
      final articles = [
        makeArticle(url: 'https://a.com/1'),
        makeArticle(url: 'https://a.com/2'),
      ];
      when(
        () => repo.getCachedFeed(feed: NewsFeedType.topHeadlines),
      ).thenAnswer((_) async => articles);

      final result = await useCase(feed: NewsFeedType.topHeadlines);

      expect(result, equals(articles));
    });

    test('returns empty list when cache is empty', () async {
      when(
        () => repo.getCachedFeed(feed: any(named: 'feed')),
      ).thenAnswer((_) async => []);

      final result = await useCase(feed: NewsFeedType.sports);

      expect(result, isEmpty);
    });

    test('passes the correct feed type to repository', () async {
      when(
        () => repo.getCachedFeed(feed: NewsFeedType.technology),
      ).thenAnswer((_) async => []);

      await useCase(feed: NewsFeedType.technology);

      verify(() => repo.getCachedFeed(feed: NewsFeedType.technology)).called(1);
    });

    test('works for all feed types', () async {
      for (final feed in NewsFeedType.values) {
        when(
          () => repo.getCachedFeed(feed: feed),
        ).thenAnswer((_) async => [makeArticle(url: 'https://ex.com/$feed')]);

        final result = await useCase(feed: feed);
        expect(result, isNotEmpty);
      }
    });
  });
}
