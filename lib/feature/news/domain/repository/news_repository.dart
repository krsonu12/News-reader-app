import 'package:news_reader_app/feature/news/data/models/news_model.dart';

enum NewsFeedType { topHeadlines, everything }

class NewsPageResult {
  const NewsPageResult({
    required this.articles,
    required this.isFromCache,
    required this.page,
    required this.hasMore,
    this.totalResults = 0,
  });

  final List<NewsModel> articles;
  final bool isFromCache;
  final int page;
  final bool hasMore;
  final int totalResults;

  static const int pageSize = 20;
  static const int maxPages = 10;
}

abstract class NewsRepository {
  Future<NewsPageResult> fetchFeedPage({
    required NewsFeedType feed,
    required int page,
    int pageSize = 20,
    String searchQuery = 't',
  });

  Future<List<NewsModel>> getCachedFeed({required NewsFeedType feed});

  Future<List<NewsModel>> getAnyCachedFeed();

  Future<void> cacheFeed({
    required NewsFeedType feed,
    required List<NewsModel> articles,
  });

  Future<List<NewsModel>> getBookmarks();

  Stream<List<NewsModel>> watchBookmarks();

  Future<bool> isBookmarked(String articleId);

  Future<void> toggleBookmark(NewsModel article);

  Future<NewsPageResult> searchEverything({
    required String query,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String? from,
  });
}
