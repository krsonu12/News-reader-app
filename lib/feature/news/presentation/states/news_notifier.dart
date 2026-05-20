import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/data/local/bookmark_local_datasource.dart';
import 'package:news_reader_app/feature/news/data/local/news_cache_local_datasource.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/data/remote_datasource/repository_impl.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';
import 'package:news_reader_app/feature/news/presentation/states/news_state.dart';

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
    return state.activeFeed == NewsFeedType.topHeadlines
        ? state.topHeadlines
        : state.everything;
  }

  Future<void> setActiveFeed(NewsFeedType feed) async {
    state = state.copyWith(activeFeed: feed, hasError: false, errorMessage: '');
    if (currentArticles.isEmpty) {
      await loadFeed(feed: feed, reset: true);
    }
  }

  Future<void> loadFeed({
    required NewsFeedType feed,
    bool reset = false,
    bool isRefresh = false,
  }) async {
    if (state.isLoadingMore) return;
    if (state.isLoading && !isRefresh) return;

    final page = reset ? 1 : _pageForFeed(feed);

    state = state.copyWith(
      isLoading: reset && !isRefresh,
      isRefreshing: isRefresh,
      hasError: false,
      errorMessage: '',
    );

    try {
      final result = await ref.read(newsRepositoryProvider).fetchFeedPage(
        feed: feed,
        page: page,
      );
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
      final result = await ref.read(newsRepositoryProvider).fetchFeedPage(
        feed: feed,
        page: nextPage,
      );
      final merged = [..._articlesForFeed(feed), ...result.articles];
      _setFeedArticles(feed: feed, value: merged);
      _setFeedPage(feed: feed, value: nextPage);
      _setFeedHasMore(feed: feed, value: result.hasMore);
      state = state.copyWith(isLoadingMore: false, isOffline: result.isFromCache);
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
    await ref.read(newsRepositoryProvider).toggleBookmark(article);
  }

  bool isBookmarked(String articleId) {
    return state.bookmarks.any((item) => item.id == articleId);
  }

  int _pageForFeed(NewsFeedType feed) {
    return feed == NewsFeedType.topHeadlines ? state.topPage : state.everythingPage;
  }

  bool _hasMoreForFeed(NewsFeedType feed) {
    return feed == NewsFeedType.topHeadlines
        ? state.topHasMore
        : state.everythingHasMore;
  }

  List<NewsModel> _articlesForFeed(NewsFeedType feed) {
    return feed == NewsFeedType.topHeadlines
        ? state.topHeadlines
        : state.everything;
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
    state = feed == NewsFeedType.topHeadlines
        ? state.copyWith(topHeadlines: value)
        : state.copyWith(everything: value);
  }

  void _setFeedPage({required NewsFeedType feed, required int value}) {
    state = feed == NewsFeedType.topHeadlines
        ? state.copyWith(topPage: value)
        : state.copyWith(everythingPage: value);
  }

  void _setFeedHasMore({required NewsFeedType feed, required bool value}) {
    state = feed == NewsFeedType.topHeadlines
        ? state.copyWith(topHasMore: value)
        : state.copyWith(everythingHasMore: value);
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
