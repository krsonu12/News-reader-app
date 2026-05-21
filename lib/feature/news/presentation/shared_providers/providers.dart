import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/network/dio_provider.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/bookmark_local_datasource.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/news_cache_local_datasource.dart';
import 'package:news_reader_app/feature/news/data/remote_datasource/repository_impl.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/news_states/news_state.dart';
import 'package:news_reader_app/feature/news/presentation/search_notfier/search_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/search_states/search_state.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return RepositoryImpl(
    dio: ref.watch(dioProvider),
    newsCacheLocalDataSource: NewsCacheLocalDataSource(),
    bookmarkLocalDataSource: BookmarkLocalDataSource(),
  );
});

final newsNotifierProvider = NotifierProvider<NewsNotifier, NewsState>(
  NewsNotifier.new,
);

final searchNotifierProvider = NotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
