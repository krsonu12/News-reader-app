import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';

abstract class NewsRepository {

  Future<NewsPageResult> fetchFeedPage({
    required NewsFeedType feed,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String searchQuery = 't',
  });


  Future<List<Article>> getCachedFeed({required NewsFeedType feed});


  Future<List<Article>> getAnyCachedFeed();


  Future<void> cacheFeed({
    required NewsFeedType feed,
    required List<Article> articles,
  });


  Future<List<Article>> getBookmarks();


  Stream<List<Article>> watchBookmarks();

  Future<bool> isBookmarked(String articleId);


  Future<void> toggleBookmark(Article article);

  Future<NewsPageResult> searchEverything({
    required String query,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String? from,
  });
}
