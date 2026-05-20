import 'package:dio/dio.dart';
import 'package:news_reader_app/core/constants/app_urls.dart';
import 'package:news_reader_app/core/constants/secret.dart';
import 'package:news_reader_app/core/error/error_mapper.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/data/local/bookmark_local_datasource.dart';
import 'package:news_reader_app/feature/news/data/local/news_cache_local_datasource.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';

class RepositoryImpl implements NewsRepository {
  RepositoryImpl({
    required this.dio,
    required this.newsCacheLocalDataSource,
    required this.bookmarkLocalDataSource,
  });

  final Dio dio;
  final NewsCacheLocalDataSource newsCacheLocalDataSource;
  final BookmarkLocalDataSource bookmarkLocalDataSource;

  @override
  Future<NewsPageResult> fetchFeedPage({
    required NewsFeedType feed,
    required int page,
    int pageSize = 20,
    String searchQuery = 't',
  }) async {
    try {
      final topHeadlinesFeeds = {
        NewsFeedType.topHeadlines,
        NewsFeedType.business,
        NewsFeedType.sports,
        NewsFeedType.technology,
        NewsFeedType.health,
      };
      final categoryMap = {
        NewsFeedType.business: 'business',
        NewsFeedType.sports: 'sports',
        NewsFeedType.technology: 'technology',
        NewsFeedType.health: 'health',
      };
      final response = await dio.get<Map<String, dynamic>>(
        topHeadlinesFeeds.contains(feed)
            ? AppUrls.topHeadlines
            : AppUrls.everything,
        queryParameters: {
          'apiKey': apiKey,
          'page': page,
          'pageSize': pageSize,
          if (topHeadlinesFeeds.contains(feed)) 'country': 'us',
          if (categoryMap.containsKey(feed)) 'category': categoryMap[feed],
          if (feed == NewsFeedType.everything) 'q': searchQuery,
          if (feed == NewsFeedType.everything) 'sortBy': 'publishedAt',
        },
      );

      final payload = response.data ?? <String, dynamic>{};
      final articlesJson = payload['articles'];
      final totalResults = payload['totalResults'] as int? ?? 0;

      if (articlesJson is! List) {
        throw const AppFailure('Invalid articles response.');
      }

      final articles = articlesJson.whereType<Map>().map((item) {
        final json = Map<String, dynamic>.from(item);
        final source = json['source'];
        json['sourceName'] = source is Map ? (source['name'] ?? '') : '';
        return NewsModel.fromJson(json);
      }).toList();

      final hasMore = _hasMorePages(
        page: page,
        pageSize: pageSize,
        totalResults: totalResults,
        fetchedCount: articles.length,
      );

      if (page == 1) {
        await cacheFeed(feed: feed, articles: articles);
      }

      return NewsPageResult(
        articles: articles,
        isFromCache: false,
        page: page,
        hasMore: hasMore,
        totalResults: totalResults,
      );
    } on DioException catch (error) {
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
      throw mapDioExceptionToFailure(error);
    }
  }

  @override
  Future<void> cacheFeed({
    required NewsFeedType feed,
    required List<NewsModel> articles,
  }) async {
    await newsCacheLocalDataSource.saveFeed(feed: feed, articles: articles);
  }

  @override
  Future<List<NewsModel>> getAnyCachedFeed() async {
    return newsCacheLocalDataSource.getAnyFeed();
  }

  @override
  Future<List<NewsModel>> getCachedFeed({required NewsFeedType feed}) async {
    return newsCacheLocalDataSource.getFeed(feed: feed);
  }

  @override
  Future<List<NewsModel>> getBookmarks() async {
    return bookmarkLocalDataSource.getBookmarks();
  }

  @override
  Future<bool> isBookmarked(String articleId) async {
    return bookmarkLocalDataSource.isBookmarked(articleId);
  }

  @override
  Future<void> toggleBookmark(NewsModel article) async {
    await bookmarkLocalDataSource.toggleBookmark(article);
  }

  @override
  Stream<List<NewsModel>> watchBookmarks() {
    return bookmarkLocalDataSource.watchBookmarks();
  }

  @override
  Future<NewsPageResult> searchEverything({
    required String query,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String? from,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        AppUrls.everything,
        queryParameters: {
          'apiKey': apiKey,
          'q': query,
          'page': page,
          'pageSize': pageSize,
          'sortBy': 'publishedAt',
          'from': ?from,
        },
      );

      final payload = response.data ?? <String, dynamic>{};
      final articlesJson = payload['articles'];
      final totalResults = payload['totalResults'] as int? ?? 0;

      if (articlesJson is! List) {
        throw const AppFailure('Invalid articles response.');
      }

      final articles = articlesJson.whereType<Map>().map((item) {
        final json = Map<String, dynamic>.from(item);
        final source = json['source'];
        json['sourceName'] = source is Map ? (source['name'] ?? '') : '';
        return NewsModel.fromJson(json);
      }).toList();

      final hasMore = _hasMorePages(
        page: page,
        pageSize: pageSize,
        totalResults: totalResults,
        fetchedCount: articles.length,
      );

      return NewsPageResult(
        articles: articles,
        isFromCache: false,
        page: page,
        hasMore: hasMore,
        totalResults: totalResults,
      );
    } on DioException catch (error) {
      throw mapDioExceptionToFailure(error);
    }
  }

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
