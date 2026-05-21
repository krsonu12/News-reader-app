import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/di/providers.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/presentation/news_states/news_state.dart';

class NewsNotifier extends Notifier<NewsState> {
  StreamSubscription? _bookmarksSub;
  bool _didLoadInitial = false;

  @override
  NewsState build() {
    _listenBookmarks();
    if (!_didLoadInitial) {
      _didLoadInitial = true;
      Future.microtask(() => loadFeed(feed: state.activeFeed, reset: true));
    }
    return const NewsState();
  }

  List<Article> get currentArticles {
    return state.feedArticles[state.activeFeed] ?? [];
  }

  Future<void> setActiveFeed(NewsFeedType feed) async {
    if (feed == state.activeFeed && currentArticles.isNotEmpty) return;
    state = state.copyWith(activeFeed: feed, hasError: false, errorMessage: '');
    await loadFeed(feed: feed, reset: true);
  }

  Future<void> loadFeed({
    required NewsFeedType feed,
    bool reset = false,
    bool isRefresh = false,
  }) async {
    if (state.isLoadingMore) return;
    if (state.isLoading && !isRefresh) return;

    final page = reset ? 1 : _pageForFeed(feed);
    final nextFeedArticles = Map<NewsFeedType, List<Article>>.from(
      state.feedArticles,
    );
    if (reset) nextFeedArticles.remove(feed);

    state = state.copyWith(
      isLoading: reset && !isRefresh,
      isRefreshing: isRefresh,
      hasError: false,
      errorMessage: '',
      feedArticles: nextFeedArticles,
    );

    try {
      final result = await ref
          .read(fetchFeedPageUseCaseProvider)
          .call(feed: feed, page: page);
      _applyPageResult(feed: feed, result: result, reset: reset);
    } on AppFailure catch (error) {
      state = state.copyWith(
        isLoading: false,
        isRefreshing: false,
        hasError: true,
        errorMessage: error.message,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        isRefreshing: false,
        hasError: true,
        errorMessage: 'Something went wrong.',
      );
    }
  }

  Future<void> refreshCurrentFeed() async {
    await loadFeed(feed: state.activeFeed, reset: true, isRefresh: true);
  }

  Future<void> loadMoreCurrentFeed() async {
    final feed = state.activeFeed;
    if (!_hasMoreForFeed(feed) || state.isLoadingMore || state.isLoading) {
      return;
    }

    final nextPage = _pageForFeed(feed) + 1;
    state = state.copyWith(isLoadingMore: true);

    try {
      final result = await ref
          .read(fetchFeedPageUseCaseProvider)
          .call(feed: feed, page: nextPage);
      final merged = [..._articlesForFeed(feed), ...result.articles];
      _setFeedArticles(feed: feed, value: merged);
      _setFeedPage(feed: feed, value: nextPage);
      _setFeedHasMore(feed: feed, value: result.hasMore);
      state = state.copyWith(
        isLoadingMore: false,
        isOffline: result.isFromCache,
      );
    } on AppFailure catch (error) {
      state = state.copyWith(
        isLoadingMore: false,
        hasError: true,
        errorMessage: error.message,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingMore: false,
        hasError: true,
        errorMessage: 'Could not load more news.',
      );
    }
  }

  Future<void> toggleBookmark(Article article) async {
    final currentBookmarks = state.bookmarks;
    final isBookmarked = currentBookmarks.any((item) => item.id == article.id);
    // Optimistic update
    state = state.copyWith(
      bookmarks: isBookmarked
          ? currentBookmarks.where((item) => item.id != article.id).toList()
          : [...currentBookmarks, article],
    );

    try {
      await ref.read(toggleBookmarkUseCaseProvider).call(article);
    } catch (_) {
      // Revert on failure by re-syncing from stream
      _listenBookmarks();
    }
  }

  bool isBookmarked(String articleId) {
    return state.bookmarks.any((item) => item.id == articleId);
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  int _pageForFeed(NewsFeedType feed) => state.feedPages[feed] ?? 1;

  bool _hasMoreForFeed(NewsFeedType feed) => state.feedHasMore[feed] ?? true;

  List<Article> _articlesForFeed(NewsFeedType feed) =>
      state.feedArticles[feed] ?? [];

  void _applyPageResult({
    required NewsFeedType feed,
    required NewsPageResult result,
    required bool reset,
  }) {
    final articles = reset
        ? result.articles
        : [..._articlesForFeed(feed), ...result.articles];

    _setFeedArticles(feed: feed, value: articles);
    _setFeedPage(feed: feed, value: result.page);
    _setFeedHasMore(feed: feed, value: result.hasMore);

    state = state.copyWith(
      isLoading: false,
      isRefreshing: false,
      isLoadingMore: false,
      isOffline: result.isFromCache,
    );
  }

  void _setFeedArticles({
    required NewsFeedType feed,
    required List<Article> value,
  }) {
    final next = Map<NewsFeedType, List<Article>>.from(state.feedArticles);
    next[feed] = value;
    state = state.copyWith(feedArticles: next);
  }

  void _setFeedPage({required NewsFeedType feed, required int value}) {
    final next = Map<NewsFeedType, int>.from(state.feedPages);
    next[feed] = value;
    state = state.copyWith(feedPages: next);
  }

  void _setFeedHasMore({required NewsFeedType feed, required bool value}) {
    final next = Map<NewsFeedType, bool>.from(state.feedHasMore);
    next[feed] = value;
    state = state.copyWith(feedHasMore: next);
  }

  void _listenBookmarks() {
    _bookmarksSub?.cancel();
    _bookmarksSub = ref.read(watchBookmarksUseCaseProvider).call().listen((
      bookmarks,
    ) {
      state = state.copyWith(bookmarks: bookmarks);
    });

    ref.onDispose(() async {
      await _bookmarksSub?.cancel();
    });
  }
}
