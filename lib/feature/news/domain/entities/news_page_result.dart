import 'package:news_reader_app/feature/news/domain/entities/article.dart';

/// Value object returned by paginated news fetches.
class NewsPageResult {
  const NewsPageResult({
    required this.articles,
    required this.isFromCache,
    required this.page,
    required this.hasMore,
    this.totalResults = 0,
  });

  final List<Article> articles;
  final bool isFromCache;
  final int page;
  final bool hasMore;
  final int totalResults;

  static const int pageSize = 20;
  static const int maxPages = 10;
}
