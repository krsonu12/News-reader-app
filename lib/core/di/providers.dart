import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/network/dio_provider.dart';
import 'package:news_reader_app/feature/news/data/datasources/bookmark_datasource.dart';
import 'package:news_reader_app/feature/news/data/datasources/news_cache_datasource.dart';
import 'package:news_reader_app/feature/news/data/datasources/news_remote_datasource.dart';
import 'package:news_reader_app/feature/news/data/repositories/news_repository_impl.dart';
import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';
import 'package:news_reader_app/feature/news/domain/usecases/fetch_feed_page_usecase.dart';
import 'package:news_reader_app/feature/news/domain/usecases/get_cached_feed_usecase.dart';
import 'package:news_reader_app/feature/news/domain/usecases/search_news_usecase.dart';
import 'package:news_reader_app/feature/news/domain/usecases/toggle_bookmark_usecase.dart';
import 'package:news_reader_app/feature/news/domain/usecases/watch_bookmarks_usecase.dart';

// ── Data Sources ─────────────────────────────────────────────────────────────

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  return NewsRemoteDataSourceImpl(ref.watch(dioProvider));
});

final newsCacheDataSourceProvider = Provider<NewsCacheDataSource>((ref) {
  return NewsCacheDataSourceImpl();
});

final bookmarkDataSourceProvider = Provider<BookmarkDataSource>((ref) {
  final ds = BookmarkDataSourceImpl();
  ref.onDispose(ds.dispose);
  return ds;
});

// ── Repository ────────────────────────────────────────────────────────────────

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(
    remoteDataSource: ref.watch(newsRemoteDataSourceProvider),
    cacheDataSource: ref.watch(newsCacheDataSourceProvider),
    bookmarkDataSource: ref.watch(bookmarkDataSourceProvider),
  );
});

// ── Use Cases ─────────────────────────────────────────────────────────────────

final fetchFeedPageUseCaseProvider = Provider<FetchFeedPageUseCase>((ref) {
  return FetchFeedPageUseCase(ref.watch(newsRepositoryProvider));
});

final searchNewsUseCaseProvider = Provider<SearchNewsUseCase>((ref) {
  return SearchNewsUseCase(ref.watch(newsRepositoryProvider));
});

final toggleBookmarkUseCaseProvider = Provider<ToggleBookmarkUseCase>((ref) {
  return ToggleBookmarkUseCase(ref.watch(newsRepositoryProvider));
});

final watchBookmarksUseCaseProvider = Provider<WatchBookmarksUseCase>((ref) {
  return WatchBookmarksUseCase(ref.watch(newsRepositoryProvider));
});

final getCachedFeedUseCaseProvider = Provider<GetCachedFeedUseCase>((ref) {
  return GetCachedFeedUseCase(ref.watch(newsRepositoryProvider));
});
