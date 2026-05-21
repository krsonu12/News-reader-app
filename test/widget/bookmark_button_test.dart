import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/news_states/news_state.dart';
import 'package:news_reader_app/feature/news/presentation/shared_providers/providers.dart';
import 'package:news_reader_app/feature/news/presentation/widgets/news_tile.dart';

import '../helpers/widget_test_helpers.dart';


class _ControllableNewsNotifier extends NewsNotifier {
  _ControllableNewsNotifier(this._initial);
  final NewsState _initial;

  final List<Article> toggledArticles = [];

  @override
  NewsState build() => _initial;

  @override
  Future<void> toggleBookmark(Article article) async {
    toggledArticles.add(article);
    final already = state.bookmarks.any((b) => b.id == article.id);
    state = state.copyWith(
      bookmarks: already
          ? state.bookmarks.where((b) => b.id != article.id).toList()
          : [...state.bookmarks, article],
    );
  }
}

// ── Pump helper ───────────────────────────────────────────────────────────────

/// Pumps a [NewsTile] whose bookmark state is driven by
/// [_ControllableNewsNotifier].  Returns the notifier for assertions.
Future<_ControllableNewsNotifier> pumpBookmarkTile(
  WidgetTester tester, {
  required Article article,
  required NewsState initialState,
}) async {
  final watchUseCase = MockWatchBookmarksUseCase();
  final fetchUseCase = MockFetchFeedPageUseCase();
  final searchUseCase = MockSearchNewsUseCase();
  final toggleUseCase = MockToggleBookmarkUseCase();
  final bookmarkStream = StreamController<List<Article>>.broadcast();

  when(() => watchUseCase.call()).thenAnswer((_) => bookmarkStream.stream);
  when(() => toggleUseCase.call(any())).thenAnswer((_) async {});
  when(
    () => fetchUseCase.call(
      feed: any(named: 'feed'),
      page: any(named: 'page'),
      pageSize: any(named: 'pageSize'),
    ),
  ).thenAnswer((_) async => makePageResult());

  late _ControllableNewsNotifier notifier;

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        fetchFeedPageUseCaseProvider.overrideWithValue(fetchUseCase),
        searchNewsUseCaseProvider.overrideWithValue(searchUseCase),
        toggleBookmarkUseCaseProvider.overrideWithValue(toggleUseCase),
        watchBookmarksUseCaseProvider.overrideWithValue(watchUseCase),
        // Override the entire newsNotifierProvider with our controllable notifier.
        newsNotifierProvider.overrideWith(() {
          notifier = _ControllableNewsNotifier(initialState);
          return notifier;
        }),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Consumer(
            builder: (context, ref, _) {
              final ctrl =
                  ref.read(newsNotifierProvider.notifier)
                      as _ControllableNewsNotifier;
              final isBookmarked = ref
                  .watch(newsNotifierProvider)
                  .bookmarks
                  .any((b) => b.id == article.id);
              return NewsTile(
                article: article,
                isBookmarked: isBookmarked,
                onBookmarkTap: () => ctrl.toggleBookmark(article),
              );
            },
          ),
        ),
      ),
    ),
  );

  addTearDown(bookmarkStream.close);
  return notifier;
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  setUpAll(registerWidgetFallbackValues);

  // ── Initial icon state ────────────────────────────────────────────────────

  group('BookmarkButton — initial icon state', () {
    testWidgets('shows bookmark_border when article is NOT bookmarked', (
      tester,
    ) async {
      final article = makeArticle(url: 'https://a.com/1');
      await pumpBookmarkTile(
        tester,
        article: article,
        initialState: const NewsState(),
      );

      expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
      expect(find.byIcon(Icons.bookmark), findsNothing);
    });

    testWidgets('shows filled bookmark when article IS bookmarked', (
      tester,
    ) async {
      final article = makeArticle(url: 'https://a.com/2');
      await pumpBookmarkTile(
        tester,
        article: article,
        initialState: NewsState(bookmarks: [article]),
      );

      expect(find.byIcon(Icons.bookmark), findsOneWidget);
      expect(find.byIcon(Icons.bookmark_border), findsNothing);
    });
  });

  // ── Toggle: not bookmarked → bookmarked ───────────────────────────────────

  group('BookmarkButton — toggle add', () {
    testWidgets(
      'tapping bookmark_border calls toggleBookmark and icon changes to filled',
      (tester) async {
        final article = makeArticle(url: 'https://a.com/3', title: 'Toggle Me');
        final notifier = await pumpBookmarkTile(
          tester,
          article: article,
          initialState: const NewsState(),
        );

        expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
        expect(notifier.toggledArticles, isEmpty);

        await tester.tap(find.byIcon(Icons.bookmark_border));
        await tester.pump();

        expect(find.byIcon(Icons.bookmark), findsOneWidget);
        expect(find.byIcon(Icons.bookmark_border), findsNothing);
        expect(notifier.toggledArticles, hasLength(1));
        expect(notifier.toggledArticles.first.id, equals(article.id));
      },
    );

    testWidgets('toggleBookmark is called with the correct article', (
      tester,
    ) async {
      final article = makeArticle(
        url: 'https://a.com/4',
        title: 'Specific Article',
        sourceName: 'Reuters',
      );
      final notifier = await pumpBookmarkTile(
        tester,
        article: article,
        initialState: const NewsState(),
      );

      await tester.tap(find.byIcon(Icons.bookmark_border));
      await tester.pump();

      expect(notifier.toggledArticles.first.url, equals(article.url));
      expect(notifier.toggledArticles.first.title, equals(article.title));
    });
  });

  // ── Toggle: bookmarked → not bookmarked ───────────────────────────────────

  group('BookmarkButton — toggle remove', () {
    testWidgets(
      'tapping filled bookmark calls toggleBookmark and icon changes to border',
      (tester) async {
        final article = makeArticle(url: 'https://a.com/5');
        final notifier = await pumpBookmarkTile(
          tester,
          article: article,
          initialState: NewsState(bookmarks: [article]),
        );

        expect(find.byIcon(Icons.bookmark), findsOneWidget);

        await tester.tap(find.byIcon(Icons.bookmark));
        await tester.pump();

        expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
        expect(find.byIcon(Icons.bookmark), findsNothing);
        expect(notifier.toggledArticles, hasLength(1));
      },
    );
  });

  // ── Multiple toggles ──────────────────────────────────────────────────────

  group('BookmarkButton — multiple toggles', () {
    testWidgets('icon alternates correctly on repeated taps', (tester) async {
      final article = makeArticle(url: 'https://a.com/6');
      final notifier = await pumpBookmarkTile(
        tester,
        article: article,
        initialState: const NewsState(),
      );

      // Tap 1: add
      await tester.tap(find.byIcon(Icons.bookmark_border));
      await tester.pump();
      expect(find.byIcon(Icons.bookmark), findsOneWidget);

      // Tap 2: remove
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pump();
      expect(find.byIcon(Icons.bookmark_border), findsOneWidget);

      // Tap 3: add again
      await tester.tap(find.byIcon(Icons.bookmark_border));
      await tester.pump();
      expect(find.byIcon(Icons.bookmark), findsOneWidget);

      expect(notifier.toggledArticles, hasLength(3));
    });
  });
}
