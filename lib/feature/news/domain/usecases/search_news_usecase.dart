import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/domain/repositories/news_repository.dart';

class SearchNewsUseCase {
  const SearchNewsUseCase(this._repository);

  final NewsRepository _repository;

  Future<NewsPageResult> call({
    required String query,
    required int page,
    int pageSize = NewsPageResult.pageSize,
    String? from,
  }) {
    return _repository.searchEverything(
      query: query,
      page: page,
      pageSize: pageSize,
      from: from ?? _thirtyDaysAgo(),
    );
  }

  /// Returns an ISO-8601 date string 30 days in the past.
  static String _thirtyDaysAgo() {
    final date = DateTime.now().subtract(const Duration(days: 30));
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    return '${date.year}-$mm-$dd';
  }
}
