import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';

part 'article_dto.freezed.dart';
part 'article_dto.g.dart';

/// Data Transfer Object for a news article.
/// Handles JSON serialisation/deserialisation and maps to/from the domain [Article].
@freezed
abstract class ArticleDto with _$ArticleDto {
  const factory ArticleDto({
    @Default('') String title,
    @Default('') String description,
    @Default('') String content,
    @Default('') String url,
    @Default('') String urlToImage,
    @Default('') String publishedAt,
    @Default('') String sourceName,
    @Default('') String author,
  }) = _ArticleDto;

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);
}

extension ArticleDtoMapper on ArticleDto {
  /// Converts this DTO to a domain [Article].
  Article toDomain() => Article(
    title: title,
    description: description,
    content: content,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    sourceName: sourceName,
    author: author,
  );
}

extension ArticleMapper on Article {
  /// Converts a domain [Article] to an [ArticleDto] for local persistence.
  ArticleDto toDto() => ArticleDto(
    title: title,
    description: description,
    content: content,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    sourceName: sourceName,
    author: author,
  );
}
