import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';

class FetchFeedPageUseCase {
  const FetchFeedPageUseCase(this._repository);

  final NewsRepository _repository;

  Future<NewsPageResult> call({
    required NewsFeedType feed,
    required int page,
    int pageSize = NewsPageResult.pageSize,
  }) {
    return _repository.fetchFeedPage(
      feed: feed,
      page: page,
      pageSize: pageSize,
    );
  }
}
