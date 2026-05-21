// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleDto {

 String get title; String get description; String get content; String get url; String get urlToImage; String get publishedAt; String get sourceName; String get author;
/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleDtoCopyWith<ArticleDto> get copyWith => _$ArticleDtoCopyWithImpl<ArticleDto>(this as ArticleDto, _$identity);

  /// Serializes this ArticleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.content, content) || other.content == content)&&(identical(other.url, url) || other.url == url)&&(identical(other.urlToImage, urlToImage) || other.urlToImage == urlToImage)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,content,url,urlToImage,publishedAt,sourceName,author);

@override
String toString() {
  return 'ArticleDto(title: $title, description: $description, content: $content, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, sourceName: $sourceName, author: $author)';
}


}

/// @nodoc
abstract mixin class $ArticleDtoCopyWith<$Res>  {
  factory $ArticleDtoCopyWith(ArticleDto value, $Res Function(ArticleDto) _then) = _$ArticleDtoCopyWithImpl;
@useResult
$Res call({
 String title, String description, String content, String url, String urlToImage, String publishedAt, String sourceName, String author
});




}
/// @nodoc
class _$ArticleDtoCopyWithImpl<$Res>
    implements $ArticleDtoCopyWith<$Res> {
  _$ArticleDtoCopyWithImpl(this._self, this._then);

  final ArticleDto _self;
  final $Res Function(ArticleDto) _then;

/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? content = null,Object? url = null,Object? urlToImage = null,Object? publishedAt = null,Object? sourceName = null,Object? author = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,urlToImage: null == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleDto].
extension ArticleDtoPatterns on ArticleDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleDto value)  $default,){
final _that = this;
switch (_that) {
case _ArticleDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleDto value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String content,  String url,  String urlToImage,  String publishedAt,  String sourceName,  String author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleDto() when $default != null:
return $default(_that.title,_that.description,_that.content,_that.url,_that.urlToImage,_that.publishedAt,_that.sourceName,_that.author);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String content,  String url,  String urlToImage,  String publishedAt,  String sourceName,  String author)  $default,) {final _that = this;
switch (_that) {
case _ArticleDto():
return $default(_that.title,_that.description,_that.content,_that.url,_that.urlToImage,_that.publishedAt,_that.sourceName,_that.author);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String content,  String url,  String urlToImage,  String publishedAt,  String sourceName,  String author)?  $default,) {final _that = this;
switch (_that) {
case _ArticleDto() when $default != null:
return $default(_that.title,_that.description,_that.content,_that.url,_that.urlToImage,_that.publishedAt,_that.sourceName,_that.author);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleDto implements ArticleDto {
  const _ArticleDto({this.title = '', this.description = '', this.content = '', this.url = '', this.urlToImage = '', this.publishedAt = '', this.sourceName = '', this.author = ''});
  factory _ArticleDto.fromJson(Map<String, dynamic> json) => _$ArticleDtoFromJson(json);

@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String content;
@override@JsonKey() final  String url;
@override@JsonKey() final  String urlToImage;
@override@JsonKey() final  String publishedAt;
@override@JsonKey() final  String sourceName;
@override@JsonKey() final  String author;

/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleDtoCopyWith<_ArticleDto> get copyWith => __$ArticleDtoCopyWithImpl<_ArticleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.content, content) || other.content == content)&&(identical(other.url, url) || other.url == url)&&(identical(other.urlToImage, urlToImage) || other.urlToImage == urlToImage)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,content,url,urlToImage,publishedAt,sourceName,author);

@override
String toString() {
  return 'ArticleDto(title: $title, description: $description, content: $content, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, sourceName: $sourceName, author: $author)';
}


}

/// @nodoc
abstract mixin class _$ArticleDtoCopyWith<$Res> implements $ArticleDtoCopyWith<$Res> {
  factory _$ArticleDtoCopyWith(_ArticleDto value, $Res Function(_ArticleDto) _then) = __$ArticleDtoCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String content, String url, String urlToImage, String publishedAt, String sourceName, String author
});




}
/// @nodoc
class __$ArticleDtoCopyWithImpl<$Res>
    implements _$ArticleDtoCopyWith<$Res> {
  __$ArticleDtoCopyWithImpl(this._self, this._then);

  final _ArticleDto _self;
  final $Res Function(_ArticleDto) _then;

/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? content = null,Object? url = null,Object? urlToImage = null,Object? publishedAt = null,Object? sourceName = null,Object? author = null,}) {
  return _then(_ArticleDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,urlToImage: null == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
