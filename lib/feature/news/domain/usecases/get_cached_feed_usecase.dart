import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';
import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';

class GetCachedFeedUseCase {
  const GetCachedFeedUseCase(this._repository);

  final NewsRepository _repository;

  Future<List<Article>> call({required NewsFeedType feed}) {
    return _repository.getCachedFeed(feed: feed);
  }
}
