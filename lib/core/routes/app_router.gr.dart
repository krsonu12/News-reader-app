// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:news_reader_app/feature/news/data/models/news_model.dart'
    as _i9;
import 'package:news_reader_app/feature/news/presentation/screens/article_details/article_detail_screen.dart'
    as _i1;
import 'package:news_reader_app/feature/news/presentation/screens/bookmark/bookmarks_screen.dart'
    as _i2;
import 'package:news_reader_app/feature/news/presentation/screens/home/home.dart'
    as _i3;
import 'package:news_reader_app/feature/news/presentation/screens/search/search_screen.dart'
    as _i4;
import 'package:news_reader_app/feature/news/presentation/screens/splash/splash_screen.dart'
    as _i6;
import 'package:news_reader_app/feature/news/presentation/screens/settings/settings_screen.dart'
    as _i5;

/// generated route for
/// [_i1.ArticleDetailScreen]
class ArticleDetailRoute extends _i7.PageRouteInfo<ArticleDetailRouteArgs> {
  ArticleDetailRoute({
    _i8.Key? key,
    required _i9.NewsModel article,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         ArticleDetailRoute.name,
         args: ArticleDetailRouteArgs(key: key, article: article),
         initialChildren: children,
       );

  static const String name = 'ArticleDetailRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ArticleDetailRouteArgs>();
      return _i1.ArticleDetailScreen(key: args.key, article: args.article);
    },
  );
}

class ArticleDetailRouteArgs {
  const ArticleDetailRouteArgs({this.key, required this.article});

  final _i8.Key? key;

  final _i9.NewsModel article;

  @override
  String toString() {
    return 'ArticleDetailRouteArgs{key: $key, article: $article}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ArticleDetailRouteArgs) return false;
    return key == other.key && article == other.article;
  }

  @override
  int get hashCode => key.hashCode ^ article.hashCode;
}

/// generated route for
/// [_i2.BookmarksScreen]
class BookmarksRoute extends _i7.PageRouteInfo<void> {
  const BookmarksRoute({List<_i7.PageRouteInfo>? children})
    : super(BookmarksRoute.name, initialChildren: children);

  static const String name = 'BookmarksRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.BookmarksScreen();
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.SearchScreen]
class SearchRoute extends _i7.PageRouteInfo<void> {
  const SearchRoute({List<_i7.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.SearchScreen();
    },
  );
}

/// generated route for
/// [_i5.SettingsScreen]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashScreen();
    },
  );
}
