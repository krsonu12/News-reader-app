import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/domain/usecases/fetch_feed_page_usecase.dart';
import 'package:news_reader_app/feature/news/domain/usecases/search_news_usecase.dart';
import 'package:news_reader_app/feature/news/domain/usecases/toggle_bookmark_usecase.dart';
import 'package:news_reader_app/feature/news/domain/usecases/watch_bookmarks_usecase.dart';

// ── Mock use cases ────────────────────────────────────────────────────────────

class MockFetchFeedPageUseCase extends Mock implements FetchFeedPageUseCase {}

class MockSearchNewsUseCase extends Mock implements SearchNewsUseCase {}

class MockToggleBookmarkUseCase extends Mock implements ToggleBookmarkUseCase {}

class MockWatchBookmarksUseCase extends Mock implements WatchBookmarksUseCase {}

// ── Fallback registration ─────────────────────────────────────────────────────

void registerWidgetFallbackValues() {
  registerFallbackValue(NewsFeedType.topHeadlines);
  registerFallbackValue(
    const Article(
      title: '',
      description: '',
      content: '',
      url: '',
      urlToImage: '',
      publishedAt: '',
      sourceName: '',
      author: '',
    ),
  );
}

// ── Article / PageResult factories ───────────────────────────────────────────

Article makeArticle({
  String url = 'https://example.com/article',
  String title = 'Test Article Title',
  String description = 'A short description of the article.',
  String content = '',
  String sourceName = 'Test Source',
  String author = 'Author Name',
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
