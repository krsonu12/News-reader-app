// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {

 String get query; List<Article> get articles; bool get isLoading; bool get isLoadingMore; bool get hasMore; int get page; int get totalResults; bool get hasError; String get errorMessage; bool get queryTooShort;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.articles, articles)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.queryTooShort, queryTooShort) || other.queryTooShort == queryTooShort));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(articles),isLoading,isLoadingMore,hasMore,page,totalResults,hasError,errorMessage,queryTooShort);

@override
String toString() {
  return 'SearchState(query: $query, articles: $articles, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, page: $page, totalResults: $totalResults, hasError: $hasError, errorMessage: $errorMessage, queryTooShort: $queryTooShort)';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 String query, List<Article> articles, bool isLoading, bool isLoadingMore, bool hasMore, int page, int totalResults, bool hasError, String errorMessage, bool queryTooShort
});




}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? articles = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? page = null,Object? totalResults = null,Object? hasError = null,Object? errorMessage = null,Object? queryTooShort = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<Article>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,queryTooShort: null == queryTooShort ? _self.queryTooShort : queryTooShort // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchState value)  $default,){
final _that = this;
switch (_that) {
case _SearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchState value)?  $default,){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  List<Article> articles,  bool isLoading,  bool isLoadingMore,  bool hasMore,  int page,  int totalResults,  bool hasError,  String errorMessage,  bool queryTooShort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.query,_that.articles,_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.page,_that.totalResults,_that.hasError,_that.errorMessage,_that.queryTooShort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  List<Article> articles,  bool isLoading,  bool isLoadingMore,  bool hasMore,  int page,  int totalResults,  bool hasError,  String errorMessage,  bool queryTooShort)  $default,) {final _that = this;
switch (_that) {
case _SearchState():
return $default(_that.query,_that.articles,_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.page,_that.totalResults,_that.hasError,_that.errorMessage,_that.queryTooShort);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  List<Article> articles,  bool isLoading,  bool isLoadingMore,  bool hasMore,  int page,  int totalResults,  bool hasError,  String errorMessage,  bool queryTooShort)?  $default,) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.query,_that.articles,_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.page,_that.totalResults,_that.hasError,_that.errorMessage,_that.queryTooShort);case _:
  return null;

}
}

}

/// @nodoc


class _SearchState implements SearchState {
  const _SearchState({this.query = '', final  List<Article> articles = const [], this.isLoading = false, this.isLoadingMore = false, this.hasMore = false, this.page = 1, this.totalResults = 0, this.hasError = false, this.errorMessage = '', this.queryTooShort = false}): _articles = articles;
  

@override@JsonKey() final  String query;
 final  List<Article> _articles;
@override@JsonKey() List<Article> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int page;
@override@JsonKey() final  int totalResults;
@override@JsonKey() final  bool hasError;
@override@JsonKey() final  String errorMessage;
@override@JsonKey() final  bool queryTooShort;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateCopyWith<_SearchState> get copyWith => __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._articles, _articles)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.queryTooShort, queryTooShort) || other.queryTooShort == queryTooShort));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_articles),isLoading,isLoadingMore,hasMore,page,totalResults,hasError,errorMessage,queryTooShort);

@override
String toString() {
  return 'SearchState(query: $query, articles: $articles, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, page: $page, totalResults: $totalResults, hasError: $hasError, errorMessage: $errorMessage, queryTooShort: $queryTooShort)';
}


}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(_SearchState value, $Res Function(_SearchState) _then) = __$SearchStateCopyWithImpl;
@override @useResult
$Res call({
 String query, List<Article> articles, bool isLoading, bool isLoadingMore, bool hasMore, int page, int totalResults, bool hasError, String errorMessage, bool queryTooShort
});




}
/// @nodoc
class __$SearchStateCopyWithImpl<$Res>
    implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? articles = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? page = null,Object? totalResults = null,Object? hasError = null,Object? errorMessage = null,Object? queryTooShort = null,}) {
  return _then(_SearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<Article>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,queryTooShort: null == queryTooShort ? _self.queryTooShort : queryTooShort // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
