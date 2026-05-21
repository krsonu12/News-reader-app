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

 NewsFeedType get activeFeed; Map<NewsFeedType, List<NewsModel>> get feedArticles; Map<NewsFeedType, int> get feedPages; Map<NewsFeedType, bool> get feedHasMore; List<NewsModel> get bookmarks; bool get isLoading; bool get isRefreshing; bool get isLoadingMore; bool get isOffline; bool get hasError; String get errorMessage;
/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsStateCopyWith<NewsState> get copyWith => _$NewsStateCopyWithImpl<NewsState>(this as NewsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsState&&(identical(other.activeFeed, activeFeed) || other.activeFeed == activeFeed)&&const DeepCollectionEquality().equals(other.feedArticles, feedArticles)&&const DeepCollectionEquality().equals(other.feedPages, feedPages)&&const DeepCollectionEquality().equals(other.feedHasMore, feedHasMore)&&const DeepCollectionEquality().equals(other.bookmarks, bookmarks)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,activeFeed,const DeepCollectionEquality().hash(feedArticles),const DeepCollectionEquality().hash(feedPages),const DeepCollectionEquality().hash(feedHasMore),const DeepCollectionEquality().hash(bookmarks),isLoading,isRefreshing,isLoadingMore,isOffline,hasError,errorMessage);

@override
String toString() {
  return 'NewsState(activeFeed: $activeFeed, feedArticles: $feedArticles, feedPages: $feedPages, feedHasMore: $feedHasMore, bookmarks: $bookmarks, isLoading: $isLoading, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, isOffline: $isOffline, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $NewsStateCopyWith<$Res>  {
  factory $NewsStateCopyWith(NewsState value, $Res Function(NewsState) _then) = _$NewsStateCopyWithImpl;
@useResult
$Res call({
 NewsFeedType activeFeed, Map<NewsFeedType, List<NewsModel>> feedArticles, Map<NewsFeedType, int> feedPages, Map<NewsFeedType, bool> feedHasMore, List<NewsModel> bookmarks, bool isLoading, bool isRefreshing, bool isLoadingMore, bool isOffline, bool hasError, String errorMessage
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
@pragma('vm:prefer-inline') @override $Res call({Object? activeFeed = null,Object? feedArticles = null,Object? feedPages = null,Object? feedHasMore = null,Object? bookmarks = null,Object? isLoading = null,Object? isRefreshing = null,Object? isLoadingMore = null,Object? isOffline = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
activeFeed: null == activeFeed ? _self.activeFeed : activeFeed // ignore: cast_nullable_to_non_nullable
as NewsFeedType,feedArticles: null == feedArticles ? _self.feedArticles : feedArticles // ignore: cast_nullable_to_non_nullable
as Map<NewsFeedType, List<NewsModel>>,feedPages: null == feedPages ? _self.feedPages : feedPages // ignore: cast_nullable_to_non_nullable
as Map<NewsFeedType, int>,feedHasMore: null == feedHasMore ? _self.feedHasMore : feedHasMore // ignore: cast_nullable_to_non_nullable
as Map<NewsFeedType, bool>,bookmarks: null == bookmarks ? _self.bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<NewsModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NewsFeedType activeFeed,  Map<NewsFeedType, List<NewsModel>> feedArticles,  Map<NewsFeedType, int> feedPages,  Map<NewsFeedType, bool> feedHasMore,  List<NewsModel> bookmarks,  bool isLoading,  bool isRefreshing,  bool isLoadingMore,  bool isOffline,  bool hasError,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsState() when $default != null:
return $default(_that.activeFeed,_that.feedArticles,_that.feedPages,_that.feedHasMore,_that.bookmarks,_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.isOffline,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NewsFeedType activeFeed,  Map<NewsFeedType, List<NewsModel>> feedArticles,  Map<NewsFeedType, int> feedPages,  Map<NewsFeedType, bool> feedHasMore,  List<NewsModel> bookmarks,  bool isLoading,  bool isRefreshing,  bool isLoadingMore,  bool isOffline,  bool hasError,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _NewsState():
return $default(_that.activeFeed,_that.feedArticles,_that.feedPages,_that.feedHasMore,_that.bookmarks,_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.isOffline,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NewsFeedType activeFeed,  Map<NewsFeedType, List<NewsModel>> feedArticles,  Map<NewsFeedType, int> feedPages,  Map<NewsFeedType, bool> feedHasMore,  List<NewsModel> bookmarks,  bool isLoading,  bool isRefreshing,  bool isLoadingMore,  bool isOffline,  bool hasError,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _NewsState() when $default != null:
return $default(_that.activeFeed,_that.feedArticles,_that.feedPages,_that.feedHasMore,_that.bookmarks,_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.isOffline,_that.hasError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _NewsState implements NewsState {
  const _NewsState({this.activeFeed = NewsFeedType.topHeadlines, final  Map<NewsFeedType, List<NewsModel>> feedArticles = const <NewsFeedType, List<NewsModel>>{}, final  Map<NewsFeedType, int> feedPages = const <NewsFeedType, int>{}, final  Map<NewsFeedType, bool> feedHasMore = const <NewsFeedType, bool>{}, final  List<NewsModel> bookmarks = const [], this.isLoading = false, this.isRefreshing = false, this.isLoadingMore = false, this.isOffline = false, this.hasError = false, this.errorMessage = ''}): _feedArticles = feedArticles,_feedPages = feedPages,_feedHasMore = feedHasMore,_bookmarks = bookmarks;
  

@override@JsonKey() final  NewsFeedType activeFeed;
 final  Map<NewsFeedType, List<NewsModel>> _feedArticles;
@override@JsonKey() Map<NewsFeedType, List<NewsModel>> get feedArticles {
  if (_feedArticles is EqualUnmodifiableMapView) return _feedArticles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_feedArticles);
}

 final  Map<NewsFeedType, int> _feedPages;
@override@JsonKey() Map<NewsFeedType, int> get feedPages {
  if (_feedPages is EqualUnmodifiableMapView) return _feedPages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_feedPages);
}

 final  Map<NewsFeedType, bool> _feedHasMore;
@override@JsonKey() Map<NewsFeedType, bool> get feedHasMore {
  if (_feedHasMore is EqualUnmodifiableMapView) return _feedHasMore;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_feedHasMore);
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
@override@JsonKey() final  bool hasError;
@override@JsonKey() final  String errorMessage;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsStateCopyWith<_NewsState> get copyWith => __$NewsStateCopyWithImpl<_NewsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsState&&(identical(other.activeFeed, activeFeed) || other.activeFeed == activeFeed)&&const DeepCollectionEquality().equals(other._feedArticles, _feedArticles)&&const DeepCollectionEquality().equals(other._feedPages, _feedPages)&&const DeepCollectionEquality().equals(other._feedHasMore, _feedHasMore)&&const DeepCollectionEquality().equals(other._bookmarks, _bookmarks)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,activeFeed,const DeepCollectionEquality().hash(_feedArticles),const DeepCollectionEquality().hash(_feedPages),const DeepCollectionEquality().hash(_feedHasMore),const DeepCollectionEquality().hash(_bookmarks),isLoading,isRefreshing,isLoadingMore,isOffline,hasError,errorMessage);

@override
String toString() {
  return 'NewsState(activeFeed: $activeFeed, feedArticles: $feedArticles, feedPages: $feedPages, feedHasMore: $feedHasMore, bookmarks: $bookmarks, isLoading: $isLoading, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, isOffline: $isOffline, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$NewsStateCopyWith<$Res> implements $NewsStateCopyWith<$Res> {
  factory _$NewsStateCopyWith(_NewsState value, $Res Function(_NewsState) _then) = __$NewsStateCopyWithImpl;
@override @useResult
$Res call({
 NewsFeedType activeFeed, Map<NewsFeedType, List<NewsModel>> feedArticles, Map<NewsFeedType, int> feedPages, Map<NewsFeedType, bool> feedHasMore, List<NewsModel> bookmarks, bool isLoading, bool isRefreshing, bool isLoadingMore, bool isOffline, bool hasError, String errorMessage
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
@override @pragma('vm:prefer-inline') $Res call({Object? activeFeed = null,Object? feedArticles = null,Object? feedPages = null,Object? feedHasMore = null,Object? bookmarks = null,Object? isLoading = null,Object? isRefreshing = null,Object? isLoadingMore = null,Object? isOffline = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_NewsState(
activeFeed: null == activeFeed ? _self.activeFeed : activeFeed // ignore: cast_nullable_to_non_nullable
as NewsFeedType,feedArticles: null == feedArticles ? _self._feedArticles : feedArticles // ignore: cast_nullable_to_non_nullable
as Map<NewsFeedType, List<NewsModel>>,feedPages: null == feedPages ? _self._feedPages : feedPages // ignore: cast_nullable_to_non_nullable
as Map<NewsFeedType, int>,feedHasMore: null == feedHasMore ? _self._feedHasMore : feedHasMore // ignore: cast_nullable_to_non_nullable
as Map<NewsFeedType, bool>,bookmarks: null == bookmarks ? _self._bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<NewsModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
