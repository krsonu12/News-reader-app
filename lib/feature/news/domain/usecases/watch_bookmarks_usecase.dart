import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';

class WatchBookmarksUseCase {
  const WatchBookmarksUseCase(this._repository);

  final NewsRepository _repository;

  Stream<List<Article>> call() {
    return _repository.watchBookmarks();
  }
}
