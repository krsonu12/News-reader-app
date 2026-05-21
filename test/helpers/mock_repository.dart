import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';

class MockNewsRepository extends Mock implements NewsRepository {}


Article makeArticle({
  String url = 'https://example.com/article',
  String title = 'Test Article',
  String description = 'A test description',
  String content = '',
  String sourceName = 'Test Source',
  String author = 'Author',
  String publishedAt = '2026-01-01',
  String urlToImage = '',
}) => Article(
  url: url,
  title: title,
  description: description,
  content: content,
  sourceName: sourceName,
  author: author,
  publishedAt: publishedAt,
  urlToImage: urlToImage,
);

NewsPageResult makePageResult({
  List<Article>? articles,
  int page = 1,
  bool hasMore = false,
  bool isFromCache = false,
  int totalResults = 0,
}) => NewsPageResult(
  articles: articles ?? [makeArticle()],
  page: page,
  hasMore: hasMore,
  isFromCache: isFromCache,
  totalResults: totalResults,
);

/// Register fallback values for named parameters used with mocktail.
void registerFallbackValues() {
  registerFallbackValue(NewsFeedType.topHeadlines);
  registerFallbackValue(makeArticle());
  registerFallbackValue(makePageResult());
  registerFallbackValue(<Article>[]);
}
