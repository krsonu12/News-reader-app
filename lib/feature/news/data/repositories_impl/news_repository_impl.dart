import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/data/datasources/bookmark_datasource.dart';
import 'package:news_reader_app/feature/news/data/datasources/news_cache_datasource.dart';
import 'package:news_reader_app/feature/news/data/datasources/news_remote_datasource.dart';
import 'package:news_reader_app/feature/news/data/dtos/article_dto.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';

/// Thin orchestrator: delegates to remote/cache/bookmark datasources and
/// maps DTOs ↔ domain entities.
class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheDataSource,
    required this.bookmarkDataSource,
  });

  final NewsRemoteDataSource remoteDataSource;
  final NewsCacheDataSource cacheDataSource;
  final BookmarkDataSource bookmarkDataSource;

  // ── Feed ─────────────────────────────────────────────────────────────────

  @override
  Future<NewsPageResult> fetchFeedPage({
    required NewsFeedType feed,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String searchQuery = 't',
  }) async {
    try {
      final remote = await remoteDataSource.fetchFeedPage(
        feed: feed,
        page: page,
        pageSize: pageSize,
        searchQuery: searchQuery,
      );

      final articles = remote.articles.map((dto) => dto.toDomain()).toList();

      final hasMore = _hasMorePages(
        page: page,
        pageSize: pageSize,
        totalResults: remote.totalResults,
        fetchedCount: articles.length,
      );

      // Cache first page only.
      if (page == 1) {
        await cacheFeed(feed: feed, articles: articles);
      }

      return NewsPageResult(
        articles: articles,
        isFromCache: false,
        page: page,
        hasMore: hasMore,
        totalResults: remote.totalResults,
      );
    } on AppFailure {
      // On network failure, fall back to cache.
      final cached = page == 1
          ? await getCachedFeed(feed: feed)
          : await getAnyCachedFeed();

      if (cached.isNotEmpty) {
        return NewsPageResult(
          articles: cached,
          isFromCache: true,
          page: 1,
          hasMore: false,
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<Article>> getCachedFeed({required NewsFeedType feed}) async {
    return cacheDataSource
        .getFeed(feed: feed)
        .map((dto) => dto.toDomain())
        .toList();
  }

  @override
  Future<List<Article>> getAnyCachedFeed() async {
    return cacheDataSource.getAnyFeed().map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<void> cacheFeed({
    required NewsFeedType feed,
    required List<Article> articles,
  }) async {
    await cacheDataSource.saveFeed(
      feed: feed,
      articles: articles.map((a) => a.toDto()).toList(),
    );
  }

  // ── Search ────────────────────────────────────────────────────────────────

  @override
  Future<NewsPageResult> searchEverything({
    required String query,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String? from,
  }) async {
    final remote = await remoteDataSource.searchEverything(
      query: query,
      page: page,
      pageSize: pageSize,
      from: from,
    );

    final articles = remote.articles.map((dto) => dto.toDomain()).toList();

    final hasMore = _hasMorePages(
      page: page,
      pageSize: pageSize,
      totalResults: remote.totalResults,
      fetchedCount: articles.length,
    );

    return NewsPageResult(
      articles: articles,
      isFromCache: false,
      page: page,
      hasMore: hasMore,
      totalResults: remote.totalResults,
    );
  }

  // ── Bookmarks ─────────────────────────────────────────────────────────────

  @override
  Future<List<Article>> getBookmarks() async {
    return bookmarkDataSource
        .getBookmarks()
        .map((dto) => dto.toDomain())
        .toList();
  }

  @override
  Stream<List<Article>> watchBookmarks() {
    return bookmarkDataSource.watchBookmarks().map(
      (dtos) => dtos.map((dto) => dto.toDomain()).toList(),
    );
  }

  @override
  Future<bool> isBookmarked(String articleId) {
    return bookmarkDataSource.isBookmarked(articleId);
  }

  @override
  Future<void> toggleBookmark(Article article) {
    return bookmarkDataSource.toggleBookmark(article.toDto());
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  bool _hasMorePages({
    required int page,
    required int pageSize,
    required int totalResults,
    required int fetchedCount,
  }) {
    if (fetchedCount == 0) return false;
    if (page >= NewsPageResult.maxPages) return false;
    return page * pageSize < totalResults;
  }
}
