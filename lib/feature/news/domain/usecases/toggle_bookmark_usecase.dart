import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';

class ToggleBookmarkUseCase {
  const ToggleBookmarkUseCase(this._repository);

  final NewsRepository _repository;

  Future<void> call(Article article) {
    return _repository.toggleBookmark(article);
  }
}
