import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
abstract class NewsModel with _$NewsModel {
  const factory NewsModel({
    @Default('') String title,
    @Default('') String description,
    @Default('') String content,
    @Default('') String url,
    @Default('') String urlToImage,
    @Default('') String publishedAt,
    @Default('') String sourceName,
    @Default('') String author,
  }) = _NewsModel;
  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}

extension NewsModelX on NewsModel {
  String get id {
    if (url.isNotEmpty) return url;
    final composite = '${title.trim()}_${publishedAt.trim()}';
    if (composite != '_') return composite;
    return 'unknown_article';
  }
}
