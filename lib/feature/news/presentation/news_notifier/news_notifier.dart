import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/bookmark_local_datasource.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/news_cache_local_datasource.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/data/remote_datasource/repository_impl.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';
import 'package:news_reader_app/feature/news/presentation/news_states/news_state.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return RepositoryImpl(
    dio: ref.watch(dioProvider),
    newsCacheLocalDataSource: NewsCacheLocalDataSource(),
    bookmarkLocalDataSource: BookmarkLocalDataSource(),
  );
});

final newsNotifierProvider = NotifierProvider<NewsNotifier, NewsState>(
  NewsNotifier.new,
);

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

  List<NewsModel> get currentArticles {
    return state.feedArticles[state.activeFeed] ?? [];
  }

  Future<void> setActiveFeed(NewsFeedType feed) async {
    if (feed == state.activeFeed && currentArticles.isNotEmpty) {
      return;
    }

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
    final nextFeedArticles = Map<NewsFeedType, List<NewsModel>>.from(
      state.feedArticles,
    );
    if (reset) {
      nextFeedArticles.remove(feed);
    }

    state = state.copyWith(
      isLoading: reset && !isRefresh,
      isRefreshing: isRefresh,
      hasError: false,
      errorMessage: '',
      feedArticles: nextFeedArticles,
    );

    try {
      final result = await ref
          .read(newsRepositoryProvider)
          .fetchFeedPage(feed: feed, page: page);
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
          .read(newsRepositoryProvider)
          .fetchFeedPage(feed: feed, page: nextPage);
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

  Future<void> toggleBookmark(NewsModel article) async {
    final currentBookmarks = state.bookmarks;
    final isBookmarked = currentBookmarks.any((item) => item.id == article.id);
    state = state.copyWith(
      bookmarks: isBookmarked
          ? currentBookmarks.where((item) => item.id != article.id).toList()
          : [...currentBookmarks, article],
    );

    try {
      await ref.read(newsRepositoryProvider).toggleBookmark(article);
    } catch (_) {
      // If saving fails, refresh local bookmarks from storage.
      _listenBookmarks();
    }
  }

  bool isBookmarked(String articleId) {
    return state.bookmarks.any((item) => item.id == articleId);
  }

  int _pageForFeed(NewsFeedType feed) {
    return state.feedPages[feed] ?? 1;
  }

  bool _hasMoreForFeed(NewsFeedType feed) {
    return state.feedHasMore[feed] ?? true;
  }

  List<NewsModel> _articlesForFeed(NewsFeedType feed) {
    return state.feedArticles[feed] ?? [];
  }

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
    required List<NewsModel> value,
  }) {
    final next = Map<NewsFeedType, List<NewsModel>>.from(state.feedArticles);
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
    _bookmarksSub = ref.read(newsRepositoryProvider).watchBookmarks().listen((
      bookmarks,
    ) {
      state = state.copyWith(bookmarks: bookmarks);
    });

    ref.onDispose(() async {
      await _bookmarksSub?.cancel();
    });
  }
}
