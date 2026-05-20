// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => _NewsModel(
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  content: json['content'] as String? ?? '',
  url: json['url'] as String? ?? '',
  urlToImage: json['urlToImage'] as String? ?? '',
  publishedAt: json['publishedAt'] as String? ?? '',
  sourceName: json['sourceName'] as String? ?? '',
  author: json['author'] as String? ?? '',
);

Map<String, dynamic> _$NewsModelToJson(_NewsModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'sourceName': instance.sourceName,
      'author': instance.author,
    };
