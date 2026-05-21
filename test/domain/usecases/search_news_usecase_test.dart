import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/domain/usecases/search_news_usecase.dart';

import '../../helpers/mock_repository.dart';

void main() {
  late MockNewsRepository repo;
  late SearchNewsUseCase useCase;

  setUpAll(registerFallbackValues);

  setUp(() {
    repo = MockNewsRepository();
    useCase = SearchNewsUseCase(repo);
  });

  group('SearchNewsUseCase', () {
    test('passes query, page and pageSize to repository', () async {
      final expected = makePageResult(totalResults: 100, hasMore: true);
      when(
        () => repo.searchEverything(
          query: 'flutter',
          page: 1,
          pageSize: NewsPageResult.pageSize,
          from: any(named: 'from'),
        ),
      ).thenAnswer((_) async => expected);

      final result = await useCase(query: 'flutter', page: 1);

      expect(result, same(expected));
    });

    test('injects a 30-day from date when none is provided', () async {
      String? capturedFrom;
      when(
        () => repo.searchEverything(
          query: any(named: 'query'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          from: any(named: 'from'),
        ),
      ).thenAnswer((inv) async {
        capturedFrom = inv.namedArguments[#from] as String?;
        return makePageResult();
      });

      await useCase(query: 'dart', page: 1);

      expect(capturedFrom, isNotNull);
      // Should be a valid ISO date 30 days ago
      final parsed = DateTime.tryParse(capturedFrom!);
      expect(parsed, isNotNull);
      final diff = DateTime.now().difference(parsed!).inDays;
      expect(diff, closeTo(30, 1)); // allow ±1 day for test timing
    });

    test('uses caller-supplied from date when provided', () async {
      const customFrom = '2026-01-01';
      String? capturedFrom;
      when(
        () => repo.searchEverything(
          query: any(named: 'query'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          from: any(named: 'from'),
        ),
      ).thenAnswer((inv) async {
        capturedFrom = inv.namedArguments[#from] as String?;
        return makePageResult();
      });

      await useCase(query: 'news', page: 1, from: customFrom);

      expect(capturedFrom, equals(customFrom));
    });

    test('propagates AppFailure from repository', () async {
      when(
        () => repo.searchEverything(
          query: any(named: 'query'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          from: any(named: 'from'),
        ),
      ).thenThrow(const AppFailure('Rate limit reached.', code: 429));

      expect(
        () => useCase(query: 'test', page: 1),
        throwsA(isA<AppFailure>().having((f) => f.code, 'code', 429)),
      );
    });

    test(
      'returns paginated results with hasMore=true on large result sets',
      () async {
        final expected = makePageResult(
          articles: List.generate(
            20,
            (i) => makeArticle(url: 'https://ex.com/$i'),
          ),
          hasMore: true,
          totalResults: 200,
          page: 1,
        );
        when(
          () => repo.searchEverything(
            query: any(named: 'query'),
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
            from: any(named: 'from'),
          ),
        ).thenAnswer((_) async => expected);

        final result = await useCase(query: 'big query', page: 1);

        expect(result.articles.length, 20);
        expect(result.hasMore, isTrue);
        expect(result.totalResults, 200);
      },
    );
  });
}
