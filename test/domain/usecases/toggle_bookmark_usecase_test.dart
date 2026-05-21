import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/usecases/toggle_bookmark_usecase.dart';

import '../../helpers/mock_repository.dart';

void main() {
  late MockNewsRepository repo;
  late ToggleBookmarkUseCase useCase;

  setUpAll(registerFallbackValues);

  setUp(() {
    repo = MockNewsRepository();
    useCase = ToggleBookmarkUseCase(repo);
  });

  group('ToggleBookmarkUseCase', () {
    test('calls repository.toggleBookmark with the given article', () async {
      final article = makeArticle(url: 'https://example.com/1');
      when(() => repo.toggleBookmark(article)).thenAnswer((_) async {});

      await useCase(article);

      verify(() => repo.toggleBookmark(article)).called(1);
    });

    test('completes without error on success', () async {
      final article = makeArticle();
      when(() => repo.toggleBookmark(any())).thenAnswer((_) async {});

      await expectLater(useCase(article), completes);
    });

    test('propagates AppFailure when repository throws', () async {
      final article = makeArticle();
      when(
        () => repo.toggleBookmark(any()),
      ).thenThrow(const AppFailure('Storage error'));

      expect(() => useCase(article), throwsA(isA<AppFailure>()));
    });

    test('passes the exact article instance to the repository', () async {
      final article = makeArticle(
        url: 'https://example.com/specific',
        title: 'Specific Title',
        author: 'Jane Doe',
      );
      Article? captured;
      when(() => repo.toggleBookmark(any())).thenAnswer((inv) async {
        captured = inv.positionalArguments.first as Article;
      });

      await useCase(article);

      expect(captured?.url, equals(article.url));
      expect(captured?.title, equals(article.title));
      expect(captured?.author, equals(article.author));
    });
  });
}
