import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';

part 'news_state.freezed.dart';

@freezed
abstract class NewsState with _$NewsState {
  const factory NewsState({
    @Default([]) List<NewsModel> newsList,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _NewsState;
}
