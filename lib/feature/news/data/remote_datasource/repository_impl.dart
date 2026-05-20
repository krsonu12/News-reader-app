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
    String searchQuery = 'technology',
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        feed == NewsFeedType.topHeadlines
            ? AppUrls.topHeadlines
            : AppUrls.everything,
        queryParameters: {
          'apiKey': apiKey,
          'page': page,
          'pageSize': pageSize,
          if (feed == NewsFeedType.topHeadlines) 'country': 'us',
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

      final articles = articlesJson
          .whereType<Map>()
          .map((item) {
            final json = Map<String, dynamic>.from(item);
            final source = json['source'];
            json['sourceName'] = source is Map ? (source['name'] ?? '') : '';
            return NewsModel.fromJson(json);
          })
          .toList();

      final hasMore = (page * pageSize) < totalResults;

      if (page == 1) {
        await cacheFeed(feed: feed, articles: articles);
      }

      return NewsPageResult(
        articles: articles,
        isFromCache: false,
        page: page,
        hasMore: hasMore,
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
}
