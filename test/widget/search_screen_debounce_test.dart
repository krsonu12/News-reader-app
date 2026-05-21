import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/core/di/providers.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/news_states/news_state.dart';
import 'package:news_reader_app/feature/news/presentation/search_notfier/search_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/search_states/search_state.dart';
import 'package:news_reader_app/feature/news/presentation/shared_providers/providers.dart';

import '../helpers/widget_test_helpers.dart';

// ── Controllable SearchNotifier ───────────────────────────────────────────────
//
// Extends SearchNotifier (required by NotifierProvider type constraint) and
// overrides build/onQueryChanged to use a configurable debounce duration and
// count search calls — without touching any real use cases.

class _ControllableSearchNotifier extends SearchNotifier {
  _ControllableSearchNotifier({this.debounceMs = 300, this.searchResult});

  final int debounceMs;
  final NewsPageResult? searchResult;

  int searchCallCount = 0;
  final List<String> searchedQueries = [];
  Timer? _localTimer;

  @override
  SearchState build() {
    ref.onDispose(() => _localTimer?.cancel());
    return const SearchState();
  }

  @override
  void onQueryChanged(String value) {
    _localTimer?.cancel();
    final trimmed = value.trim();

    if (trimmed.length < 3) {
      state = state.copyWith(
        query: value,
        queryTooShort: trimmed.isNotEmpty,
        articles: [],
        page: 1,
        hasMore: false,
        totalResults: 0,
        hasError: false,
        errorMessage: '',
        isLoading: false,
        isLoadingMore: false,
      );
      return;
    }

    state = state.copyWith(
      query: value,
      queryTooShort: false,
      hasError: false,
      errorMessage: '',
    );

    _localTimer = Timer(Duration(milliseconds: debounceMs), _doSearch);
  }

  Future<void> _doSearch() async {
    final query = state.query.trim();
    if (query.length < 3) return;
    if (state.isLoading || state.isLoadingMore) return;

    searchCallCount++;
    searchedQueries.add(query);
    state = state.copyWith(isLoading: true);

    await Future<void>.delayed(Duration.zero); // simulate async work

    final result =
        searchResult ??
        NewsPageResult(
          articles: [makeArticle(title: 'Result for $query')],
          page: 1,
          hasMore: false,
          isFromCache: false,
          totalResults: 1,
        );

    state = state.copyWith(
      articles: result.articles,
      page: result.page,
      hasMore: result.hasMore,
      totalResults: result.totalResults,
      isLoading: false,
    );
  }
}

// ── No-op NewsNotifier ────────────────────────────────────────────────────────

class _NoOpNewsNotifier extends NewsNotifier {
  @override
  NewsState build() => const NewsState();

  @override
  Future<void> loadFeed({
    required feed,
    bool reset = false,
    bool isRefresh = false,
  }) async {}
}

// ── Inline search UI ──────────────────────────────────────────────────────────

class _SearchBody extends ConsumerStatefulWidget {
  const _SearchBody();

  @override
  ConsumerState<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends ConsumerState<_SearchBody> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchNotifierProvider);
    return Column(
      children: [
        TextField(
          key: const Key('search_field'),
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search articles (min 3 characters)',
          ),
          onChanged: (value) {
            (ref.read(searchNotifierProvider.notifier)
                    as _ControllableSearchNotifier)
                .onQueryChanged(value);
            setState(() {});
          },
        ),
        if (state.queryTooShort)
          const Text('Type at least 3 characters to search'),
        if (state.isLoading)
          const CircularProgressIndicator(key: Key('loading_indicator')),
        ...state.articles.map((a) => Text(a.title, key: Key('result_${a.id}'))),
      ],
    );
  }
}

// ── Pump helper ───────────────────────────────────────────────────────────────

Future<_ControllableSearchNotifier> pumpSearchScreen(
  WidgetTester tester, {
  int debounceMs = 300,
  NewsPageResult? searchResult,
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

  late _ControllableSearchNotifier fakeSearch;

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        fetchFeedPageUseCaseProvider.overrideWithValue(fetchUseCase),
        searchNewsUseCaseProvider.overrideWithValue(searchUseCase),
        toggleBookmarkUseCaseProvider.overrideWithValue(toggleUseCase),
        watchBookmarksUseCaseProvider.overrideWithValue(watchUseCase),
        newsNotifierProvider.overrideWith(() => _NoOpNewsNotifier()),
        searchNotifierProvider.overrideWith(() {
          fakeSearch = _ControllableSearchNotifier(
            debounceMs: debounceMs,
            searchResult: searchResult,
          );
          return fakeSearch;
        }),
      ],
      child: const MaterialApp(home: Scaffold(body: _SearchBody())),
    ),
  );

  await tester.pump();
  addTearDown(bookmarkStream.close);
  return fakeSearch;
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  setUpAll(registerWidgetFallbackValues);

  group('SearchScreen — debounce', () {
    testWidgets('typing 5 characters rapidly triggers only 1 search call', (
      tester,
    ) async {
      final fake = await pumpSearchScreen(tester, debounceMs: 300);

      for (final text in ['f', 'fl', 'flu', 'flut', 'flutt']) {
        await tester.enterText(find.byKey(const Key('search_field')), text);
        await tester.pump();
      }

      expect(fake.searchCallCount, 0); // debounce still pending

      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump(); // async search completes

      expect(fake.searchCallCount, 1);
      expect(fake.searchedQueries.last, 'flutt');
    });

    testWidgets(
      'each keystroke resets the debounce timer — only last query fires',
      (tester) async {
        final fake = await pumpSearchScreen(tester, debounceMs: 300);

        await tester.enterText(find.byKey(const Key('search_field')), 'abc');
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 200)); // < debounce
        expect(fake.searchCallCount, 0);

        await tester.enterText(find.byKey(const Key('search_field')), 'abcd');
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pump();

        expect(fake.searchCallCount, 1);
        expect(fake.searchedQueries.last, 'abcd');
      },
    );

    testWidgets(
      'two separate queries each separated by > debounce each fire 1 call',
      (tester) async {
        final fake = await pumpSearchScreen(tester, debounceMs: 300);

        await tester.enterText(find.byKey(const Key('search_field')), 'abc');
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pump();
        expect(fake.searchCallCount, 1);

        await tester.enterText(find.byKey(const Key('search_field')), 'xyz');
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pump();
        expect(fake.searchCallCount, 2);
        expect(fake.searchedQueries, ['abc', 'xyz']);
      },
    );

    testWidgets('query shorter than 3 chars does NOT trigger a search', (
      tester,
    ) async {
      final fake = await pumpSearchScreen(tester, debounceMs: 300);

      await tester.enterText(find.byKey(const Key('search_field')), 'ab');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump();

      expect(fake.searchCallCount, 0);
    });

    testWidgets('empty string does NOT trigger a search', (tester) async {
      final fake = await pumpSearchScreen(tester, debounceMs: 300);

      await tester.enterText(find.byKey(const Key('search_field')), '');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump();

      expect(fake.searchCallCount, 0);
    });

    testWidgets('10 rapid keystrokes still produce exactly 1 search call', (
      tester,
    ) async {
      final fake = await pumpSearchScreen(tester, debounceMs: 300);

      const chars = [
        'f',
        'fl',
        'flu',
        'flut',
        'flutt',
        'flutte',
        'flutter',
        'flutter ',
        'flutter d',
        'flutter da',
      ];
      for (final text in chars) {
        await tester.enterText(find.byKey(const Key('search_field')), text);
        await tester.pump(const Duration(milliseconds: 20));
      }

      expect(fake.searchCallCount, 0);

      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();

      expect(fake.searchCallCount, 1);
    });
  });

  group('SearchScreen — UI feedback', () {
    testWidgets('shows "too short" hint for 1-char input', (tester) async {
      await pumpSearchScreen(tester, debounceMs: 300);

      await tester.enterText(find.byKey(const Key('search_field')), 'a');
      await tester.pump();

      expect(find.text('Type at least 3 characters to search'), findsOneWidget);
    });

    testWidgets('hides "too short" hint once query reaches 3 chars', (
      tester,
    ) async {
      await pumpSearchScreen(tester, debounceMs: 300);

      await tester.enterText(find.byKey(const Key('search_field')), 'ab');
      await tester.pump();
      expect(find.text('Type at least 3 characters to search'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('search_field')), 'abc');
      await tester.pump();
      expect(find.text('Type at least 3 characters to search'), findsNothing);
    });

    testWidgets('shows loading indicator while search is in progress', (
      tester,
    ) async {
      final fake = await pumpSearchScreen(tester, debounceMs: 0);

      await tester.enterText(find.byKey(const Key('search_field')), 'flutter');
      await tester.pump(); // onQueryChanged → Timer(0) fires
      await tester.pump(Duration.zero); // _doSearch sets isLoading=true

      expect(find.byKey(const Key('loading_indicator')), findsOneWidget);

      await tester.pump(); // async search completes
      expect(find.byKey(const Key('loading_indicator')), findsNothing);
      expect(fake.searchCallCount, 1);
    });

    testWidgets('shows search results after debounce completes', (
      tester,
    ) async {
      final result = NewsPageResult(
        articles: [makeArticle(title: 'Flutter News', url: 'https://f.com/1')],
        page: 1,
        hasMore: false,
        isFromCache: false,
        totalResults: 1,
      );

      await pumpSearchScreen(tester, debounceMs: 300, searchResult: result);

      await tester.enterText(find.byKey(const Key('search_field')), 'flutter');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();

      expect(find.text('Flutter News'), findsOneWidget);
    });
  });
}
