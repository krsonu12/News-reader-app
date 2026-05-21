import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/usecases/watch_bookmarks_usecase.dart';

import '../../helpers/mock_repository.dart';

void main() {
  late MockNewsRepository repo;
  late WatchBookmarksUseCase useCase;

  setUpAll(registerFallbackValues);

  setUp(() {
    repo = MockNewsRepository();
    useCase = WatchBookmarksUseCase(repo);
  });

  group('WatchBookmarksUseCase', () {
    test('returns the stream from repository', () {
      final controller = StreamController<List<Article>>.broadcast();
      when(() => repo.watchBookmarks()).thenAnswer((_) => controller.stream);

      final stream = useCase();

      expect(stream, isA<Stream<List<Article>>>());
      controller.close();
    });

    test('emits bookmark lists as they arrive', () async {
      final article1 = makeArticle(url: 'https://a.com/1');
      final article2 = makeArticle(url: 'https://a.com/2');
      final controller = StreamController<List<Article>>();
      when(() => repo.watchBookmarks()).thenAnswer((_) => controller.stream);

      final emitted = <List<Article>>[];
      final sub = useCase().listen(emitted.add);

      controller.add([article1]);
      controller.add([article1, article2]);
      controller.add([]);

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await controller.close();

      expect(emitted.length, 3);
      expect(emitted[0], [article1]);
      expect(emitted[1], [article1, article2]);
      expect(emitted[2], isEmpty);
    });

    test('emits empty list when no bookmarks exist', () async {
      final controller = StreamController<List<Article>>();
      when(() => repo.watchBookmarks()).thenAnswer((_) => controller.stream);

      final emitted = <List<Article>>[];
      final sub = useCase().listen(emitted.add);

      controller.add([]);
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await controller.close();

      expect(emitted.first, isEmpty);
    });

    test('calls repository.watchBookmarks exactly once per subscription', () {
      final controller = StreamController<List<Article>>.broadcast();
      when(() => repo.watchBookmarks()).thenAnswer((_) => controller.stream);

      useCase();

      verify(() => repo.watchBookmarks()).called(1);
      controller.close();
    });
  });
}
