import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/domain/usecases/fetch_feed_page_usecase.dart';

import '../../helpers/mock_repository.dart';

void main() {
  late MockNewsRepository repo;
  late FetchFeedPageUseCase useCase;

  setUpAll(registerFallbackValues);

  setUp(() {
    repo = MockNewsRepository();
    useCase = FetchFeedPageUseCase(repo);
  });

  group('FetchFeedPageUseCase', () {
    test('delegates to repository with correct parameters', () async {
      final expected = makePageResult(page: 1, hasMore: true, totalResults: 40);
      when(
        () => repo.fetchFeedPage(
          feed: NewsFeedType.topHeadlines,
          page: 1,
          pageSize: NewsPageResult.pageSize,
        ),
      ).thenAnswer((_) async => expected);

      final result = await useCase(feed: NewsFeedType.topHeadlines, page: 1);

      expect(result, same(expected));
      verify(
        () => repo.fetchFeedPage(
          feed: NewsFeedType.topHeadlines,
          page: 1,
          pageSize: NewsPageResult.pageSize,
        ),
      ).called(1);
    });

    test('passes custom pageSize to repository', () async {
      final expected = makePageResult();
      when(
        () => repo.fetchFeedPage(
          feed: NewsFeedType.business,
          page: 2,
          pageSize: 10,
        ),
      ).thenAnswer((_) async => expected);

      final result = await useCase(
        feed: NewsFeedType.business,
        page: 2,
        pageSize: 10,
      );

      expect(result, same(expected));
    });

    test('propagates AppFailure from repository', () async {
      when(
        () => repo.fetchFeedPage(
          feed: any(named: 'feed'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenThrow(const AppFailure('Network error', code: 503));

      expect(
        () => useCase(feed: NewsFeedType.sports, page: 1),
        throwsA(
          isA<AppFailure>().having(
            (f) => f.message,
            'message',
            'Network error',
          ),
        ),
      );
    });

    test('returns cached result when isFromCache is true', () async {
      final cached = makePageResult(isFromCache: true, hasMore: false);
      when(
        () => repo.fetchFeedPage(
          feed: NewsFeedType.technology,
          page: 1,
          pageSize: NewsPageResult.pageSize,
        ),
      ).thenAnswer((_) async => cached);

      final result = await useCase(feed: NewsFeedType.technology, page: 1);

      expect(result.isFromCache, isTrue);
      expect(result.hasMore, isFalse);
    });

    test('works for every feed type without error', () async {
      for (final feed in NewsFeedType.values) {
        when(
          () => repo.fetchFeedPage(
            feed: feed,
            page: 1,
            pageSize: NewsPageResult.pageSize,
          ),
        ).thenAnswer((_) async => makePageResult());

        await expectLater(useCase(feed: feed, page: 1), completes);
      }
    });
  });
}
