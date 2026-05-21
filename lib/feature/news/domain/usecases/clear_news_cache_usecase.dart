import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';

class ClearNewsCacheUseCase {
  const ClearNewsCacheUseCase(this._repository);

  final NewsRepository _repository;

  Future<void> call() => _repository.clearCache();
}
