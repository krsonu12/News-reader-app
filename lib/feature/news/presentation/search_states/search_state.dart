import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';

part 'search_state.freezed.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default('') String query,
    @Default([]) List<NewsModel> articles,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(1) int page,
    @Default(0) int totalResults,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
    @Default(false) bool queryTooShort,
  }) = _SearchState;
}
