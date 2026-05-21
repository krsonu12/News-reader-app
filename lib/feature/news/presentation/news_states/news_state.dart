import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';

part 'news_state.freezed.dart';

@freezed
abstract class NewsState with _$NewsState {
  const factory NewsState({
    @Default(NewsFeedType.topHeadlines) NewsFeedType activeFeed,
    @Default(<NewsFeedType, List<Article>>{})
    Map<NewsFeedType, List<Article>> feedArticles,
    @Default(<NewsFeedType, int>{}) Map<NewsFeedType, int> feedPages,
    @Default(<NewsFeedType, bool>{}) Map<NewsFeedType, bool> feedHasMore,
    @Default([]) List<Article> bookmarks,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isOffline,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _NewsState;
}
