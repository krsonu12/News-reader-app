import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';

/// Abstract repository contract — defined in domain, implemented in data.
abstract class NewsRepository {
  /// Fetches a paginated feed page from remote or cache.
  Future<NewsPageResult> fetchFeedPage({
    required NewsFeedType feed,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String searchQuery = 't',
  });

  /// Returns locally cached articles for [feed].
  Future<List<Article>> getCachedFeed({required NewsFeedType feed});

  /// Returns the first non-empty cached feed (offline fallback).
  Future<List<Article>> getAnyCachedFeed();

  /// Persists [articles] for [feed] to local cache.
  Future<void> cacheFeed({
    required NewsFeedType feed,
    required List<Article> articles,
  });

  /// Returns all bookmarked articles.
  Future<List<Article>> getBookmarks();

  /// Emits the current bookmark list and subsequent changes.
  Stream<List<Article>> watchBookmarks();

  /// Returns whether [articleId] is bookmarked.
  Future<bool> isBookmarked(String articleId);

  /// Adds or removes [article] from bookmarks.
  Future<void> toggleBookmark(Article article);

  /// Searches articles matching [query] with pagination.
  Future<NewsPageResult> searchEverything({
    required String query,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String? from,
  });
}
