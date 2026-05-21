import 'package:dio/dio.dart';
import 'package:news_reader_app/core/constants/secret.dart';
import 'package:news_reader_app/core/error/error_mapper.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/core/network/app_urls.dart';
import 'package:news_reader_app/feature/news/data/dtos/article_dto.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';

/// Raw paginated response from the remote API.
class RemoteNewsPage {
  const RemoteNewsPage({required this.articles, required this.totalResults});

  final List<ArticleDto> articles;
  final int totalResults;
}

/// Abstract contract for the remote news API.
abstract class NewsRemoteDataSource {
  Future<RemoteNewsPage> fetchFeedPage({
    required NewsFeedType feed,
    required int page,
    required int pageSize,
    String searchQuery = 't',
  });

  Future<RemoteNewsPage> searchEverything({
    required String query,
    required int page,
    required int pageSize,
    String? from,
  });
}

/// Dio-backed implementation of [NewsRemoteDataSource].
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  const NewsRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  static const _topHeadlinesFeeds = {
    NewsFeedType.topHeadlines,
    NewsFeedType.business,
    NewsFeedType.sports,
    NewsFeedType.technology,
    NewsFeedType.health,
  };

  static const _categoryMap = {
    NewsFeedType.business: 'business',
    NewsFeedType.sports: 'sports',
    NewsFeedType.technology: 'technology',
    NewsFeedType.health: 'health',
  };

  @override
  Future<RemoteNewsPage> fetchFeedPage({
    required NewsFeedType feed,
    required int page,
    required int pageSize,
    String searchQuery = 't',
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _topHeadlinesFeeds.contains(feed)
            ? AppUrls.topHeadlines
            : AppUrls.everything,
        queryParameters: {
          'apiKey': apiKey,
          'page': page,
          'pageSize': pageSize,
          if (_topHeadlinesFeeds.contains(feed)) 'country': 'us',
          if (_categoryMap.containsKey(feed)) 'category': _categoryMap[feed],
          if (feed == NewsFeedType.everything) 'q': searchQuery,
          if (feed == NewsFeedType.everything) 'sortBy': 'publishedAt',
        },
      );

      return _parseResponse(response.data ?? {});
    } on DioException catch (e) {
      throw mapDioExceptionToFailure(e);
    }
  }

  @override
  Future<RemoteNewsPage> searchEverything({
    required String query,
    required int page,
    required int pageSize,
    String? from,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'apiKey': apiKey,
        'q': query,
        'page': page,
        'pageSize': pageSize,
        'sortBy': 'publishedAt',
        'from': from,
      };

      final response = await _dio.get<Map<String, dynamic>>(
        AppUrls.everything,
        queryParameters: queryParameters,
      );

      return _parseResponse(response.data ?? {});
    } on DioException catch (e) {
      throw mapDioExceptionToFailure(e);
    }
  }

  RemoteNewsPage _parseResponse(Map<String, dynamic> payload) {
    final articlesJson = payload['articles'];
    final totalResults = payload['totalResults'] as int? ?? 0;

    if (articlesJson is! List) {
      throw const AppFailure('Invalid articles response.');
    }

    final articles = articlesJson.whereType<Map>().map((item) {
      final json = Map<String, dynamic>.from(item);
      // Flatten nested source object → sourceName field
      final source = json['source'];
      json['sourceName'] = source is Map ? (source['name'] ?? '') : '';
      return ArticleDto.fromJson(json);
    }).toList();

    return RemoteNewsPage(articles: articles, totalResults: totalResults);
  }
}
