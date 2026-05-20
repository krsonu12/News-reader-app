// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewsState {

 NewsFeedType get activeFeed; List<NewsModel> get topHeadlines; List<NewsModel> get everything; List<NewsModel> get bookmarks; bool get isLoading; bool get isRefreshing; bool get isLoadingMore; bool get isOffline; bool get topHasMore; bool get everythingHasMore; int get topPage; int get everythingPage; bool get hasError; String get errorMessage;
/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsStateCopyWith<NewsState> get copyWith => _$NewsStateCopyWithImpl<NewsState>(this as NewsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsState&&(identical(other.activeFeed, activeFeed) || other.activeFeed == activeFeed)&&const DeepCollectionEquality().equals(other.topHeadlines, topHeadlines)&&const DeepCollectionEquality().equals(other.everything, everything)&&const DeepCollectionEquality().equals(other.bookmarks, bookmarks)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.topHasMore, topHasMore) || other.topHasMore == topHasMore)&&(identical(other.everythingHasMore, everythingHasMore) || other.everythingHasMore == everythingHasMore)&&(identical(other.topPage, topPage) || other.topPage == topPage)&&(identical(other.everythingPage, everythingPage) || other.everythingPage == everythingPage)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,activeFeed,const DeepCollectionEquality().hash(topHeadlines),const DeepCollectionEquality().hash(everything),const DeepCollectionEquality().hash(bookmarks),isLoading,isRefreshing,isLoadingMore,isOffline,topHasMore,everythingHasMore,topPage,everythingPage,hasError,errorMessage);

@override
String toString() {
  return 'NewsState(activeFeed: $activeFeed, topHeadlines: $topHeadlines, everything: $everything, bookmarks: $bookmarks, isLoading: $isLoading, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, isOffline: $isOffline, topHasMore: $topHasMore, everythingHasMore: $everythingHasMore, topPage: $topPage, everythingPage: $everythingPage, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $NewsStateCopyWith<$Res>  {
  factory $NewsStateCopyWith(NewsState value, $Res Function(NewsState) _then) = _$NewsStateCopyWithImpl;
@useResult
$Res call({
 NewsFeedType activeFeed, List<NewsModel> topHeadlines, List<NewsModel> everything, List<NewsModel> bookmarks, bool isLoading, bool isRefreshing, bool isLoadingMore, bool isOffline, bool topHasMore, bool everythingHasMore, int topPage, int everythingPage, bool hasError, String errorMessage
});




}
/// @nodoc
class _$NewsStateCopyWithImpl<$Res>
    implements $NewsStateCopyWith<$Res> {
  _$NewsStateCopyWithImpl(this._self, this._then);

  final NewsState _self;
  final $Res Function(NewsState) _then;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeFeed = null,Object? topHeadlines = null,Object? everything = null,Object? bookmarks = null,Object? isLoading = null,Object? isRefreshing = null,Object? isLoadingMore = null,Object? isOffline = null,Object? topHasMore = null,Object? everythingHasMore = null,Object? topPage = null,Object? everythingPage = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
activeFeed: null == activeFeed ? _self.activeFeed : activeFeed // ignore: cast_nullable_to_non_nullable
as NewsFeedType,topHeadlines: null == topHeadlines ? _self.topHeadlines : topHeadlines // ignore: cast_nullable_to_non_nullable
as List<NewsModel>,everything: null == everything ? _self.everything : everything // ignore: cast_nullable_to_non_nullable
as List<NewsModel>,bookmarks: null == bookmarks ? _self.bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<NewsModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,topHasMore: null == topHasMore ? _self.topHasMore : topHasMore // ignore: cast_nullable_to_non_nullable
as bool,everythingHasMore: null == everythingHasMore ? _self.everythingHasMore : everythingHasMore // ignore: cast_nullable_to_non_nullable
as bool,topPage: null == topPage ? _self.topPage : topPage // ignore: cast_nullable_to_non_nullable
as int,everythingPage: null == everythingPage ? _self.everythingPage : everythingPage // ignore: cast_nullable_to_non_nullable
as int,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsState].
extension NewsStatePatterns on NewsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsState value)  $default,){
final _that = this;
switch (_that) {
case _NewsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsState value)?  $default,){
final _that = this;
switch (_that) {
case _NewsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NewsFeedType activeFeed,  List<NewsModel> topHeadlines,  List<NewsModel> everything,  List<NewsModel> bookmarks,  bool isLoading,  bool isRefreshing,  bool isLoadingMore,  bool isOffline,  bool topHasMore,  bool everythingHasMore,  int topPage,  int everythingPage,  bool hasError,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsState() when $default != null:
return $default(_that.activeFeed,_that.topHeadlines,_that.everything,_that.bookmarks,_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.isOffline,_that.topHasMore,_that.everythingHasMore,_that.topPage,_that.everythingPage,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NewsFeedType activeFeed,  List<NewsModel> topHeadlines,  List<NewsModel> everything,  List<NewsModel> bookmarks,  bool isLoading,  bool isRefreshing,  bool isLoadingMore,  bool isOffline,  bool topHasMore,  bool everythingHasMore,  int topPage,  int everythingPage,  bool hasError,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _NewsState():
return $default(_that.activeFeed,_that.topHeadlines,_that.everything,_that.bookmarks,_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.isOffline,_that.topHasMore,_that.everythingHasMore,_that.topPage,_that.everythingPage,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NewsFeedType activeFeed,  List<NewsModel> topHeadlines,  List<NewsModel> everything,  List<NewsModel> bookmarks,  bool isLoading,  bool isRefreshing,  bool isLoadingMore,  bool isOffline,  bool topHasMore,  bool everythingHasMore,  int topPage,  int everythingPage,  bool hasError,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _NewsState() when $default != null:
return $default(_that.activeFeed,_that.topHeadlines,_that.everything,_that.bookmarks,_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.isOffline,_that.topHasMore,_that.everythingHasMore,_that.topPage,_that.everythingPage,_that.hasError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _NewsState implements NewsState {
  const _NewsState({this.activeFeed = NewsFeedType.topHeadlines, final  List<NewsModel> topHeadlines = const [], final  List<NewsModel> everything = const [], final  List<NewsModel> bookmarks = const [], this.isLoading = false, this.isRefreshing = false, this.isLoadingMore = false, this.isOffline = false, this.topHasMore = true, this.everythingHasMore = true, this.topPage = 1, this.everythingPage = 1, this.hasError = false, this.errorMessage = ''}): _topHeadlines = topHeadlines,_everything = everything,_bookmarks = bookmarks;
  

@override@JsonKey() final  NewsFeedType activeFeed;
 final  List<NewsModel> _topHeadlines;
@override@JsonKey() List<NewsModel> get topHeadlines {
  if (_topHeadlines is EqualUnmodifiableListView) return _topHeadlines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topHeadlines);
}

 final  List<NewsModel> _everything;
@override@JsonKey() List<NewsModel> get everything {
  if (_everything is EqualUnmodifiableListView) return _everything;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_everything);
}

 final  List<NewsModel> _bookmarks;
@override@JsonKey() List<NewsModel> get bookmarks {
  if (_bookmarks is EqualUnmodifiableListView) return _bookmarks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookmarks);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isOffline;
@override@JsonKey() final  bool topHasMore;
@override@JsonKey() final  bool everythingHasMore;
@override@JsonKey() final  int topPage;
@override@JsonKey() final  int everythingPage;
@override@JsonKey() final  bool hasError;
@override@JsonKey() final  String errorMessage;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsStateCopyWith<_NewsState> get copyWith => __$NewsStateCopyWithImpl<_NewsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsState&&(identical(other.activeFeed, activeFeed) || other.activeFeed == activeFeed)&&const DeepCollectionEquality().equals(other._topHeadlines, _topHeadlines)&&const DeepCollectionEquality().equals(other._everything, _everything)&&const DeepCollectionEquality().equals(other._bookmarks, _bookmarks)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.topHasMore, topHasMore) || other.topHasMore == topHasMore)&&(identical(other.everythingHasMore, everythingHasMore) || other.everythingHasMore == everythingHasMore)&&(identical(other.topPage, topPage) || other.topPage == topPage)&&(identical(other.everythingPage, everythingPage) || other.everythingPage == everythingPage)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,activeFeed,const DeepCollectionEquality().hash(_topHeadlines),const DeepCollectionEquality().hash(_everything),const DeepCollectionEquality().hash(_bookmarks),isLoading,isRefreshing,isLoadingMore,isOffline,topHasMore,everythingHasMore,topPage,everythingPage,hasError,errorMessage);

@override
String toString() {
  return 'NewsState(activeFeed: $activeFeed, topHeadlines: $topHeadlines, everything: $everything, bookmarks: $bookmarks, isLoading: $isLoading, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, isOffline: $isOffline, topHasMore: $topHasMore, everythingHasMore: $everythingHasMore, topPage: $topPage, everythingPage: $everythingPage, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$NewsStateCopyWith<$Res> implements $NewsStateCopyWith<$Res> {
  factory _$NewsStateCopyWith(_NewsState value, $Res Function(_NewsState) _then) = __$NewsStateCopyWithImpl;
@override @useResult
$Res call({
 NewsFeedType activeFeed, List<NewsModel> topHeadlines, List<NewsModel> everything, List<NewsModel> bookmarks, bool isLoading, bool isRefreshing, bool isLoadingMore, bool isOffline, bool topHasMore, bool everythingHasMore, int topPage, int everythingPage, bool hasError, String errorMessage
});




}
/// @nodoc
class __$NewsStateCopyWithImpl<$Res>
    implements _$NewsStateCopyWith<$Res> {
  __$NewsStateCopyWithImpl(this._self, this._then);

  final _NewsState _self;
  final $Res Function(_NewsState) _then;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeFeed = null,Object? topHeadlines = null,Object? everything = null,Object? bookmarks = null,Object? isLoading = null,Object? isRefreshing = null,Object? isLoadingMore = null,Object? isOffline = null,Object? topHasMore = null,Object? everythingHasMore = null,Object? topPage = null,Object? everythingPage = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_NewsState(
activeFeed: null == activeFeed ? _self.activeFeed : activeFeed // ignore: cast_nullable_to_non_nullable
as NewsFeedType,topHeadlines: null == topHeadlines ? _self._topHeadlines : topHeadlines // ignore: cast_nullable_to_non_nullable
as List<NewsModel>,everything: null == everything ? _self._everything : everything // ignore: cast_nullable_to_non_nullable
as List<NewsModel>,bookmarks: null == bookmarks ? _self._bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<NewsModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,topHasMore: null == topHasMore ? _self.topHasMore : topHasMore // ignore: cast_nullable_to_non_nullable
as bool,everythingHasMore: null == everythingHasMore ? _self.everythingHasMore : everythingHasMore // ignore: cast_nullable_to_non_nullable
as bool,topPage: null == topPage ? _self.topPage : topPage // ignore: cast_nullable_to_non_nullable
as int,everythingPage: null == everythingPage ? _self.everythingPage : everythingPage // ignore: cast_nullable_to_non_nullable
as int,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
