import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';

part 'news_state.freezed.dart';

@freezed
abstract class NewsState with _$NewsState {
  const factory NewsState({
    @Default(NewsFeedType.topHeadlines) NewsFeedType activeFeed,
    @Default([]) List<NewsModel> topHeadlines,
    @Default([]) List<NewsModel> everything,
    @Default([]) List<NewsModel> bookmarks,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isOffline,
    @Default(true) bool topHasMore,
    @Default(true) bool everythingHasMore,
    @Default(1) int topPage,
    @Default(1) int everythingPage,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _NewsState;
}
