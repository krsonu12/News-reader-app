// Re-export core DI providers so existing presentation imports keep working.
export 'package:news_reader_app/core/di/providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/news_states/news_state.dart';
import 'package:news_reader_app/feature/news/presentation/search_notfier/search_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/search_states/search_state.dart';

final newsNotifierProvider = NotifierProvider<NewsNotifier, NewsState>(
  NewsNotifier.new,
);

final searchNotifierProvider = NotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
