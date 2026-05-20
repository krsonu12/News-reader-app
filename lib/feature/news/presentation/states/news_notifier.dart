import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/feature/news/presentation/states/news_state.dart';

class NewsNotifier extends Notifier<NewsState> {
  @override
  NewsState build() {
    return const NewsState();
  }

  Future<void> getNews() async {
    state = state.copyWith(isLoading: true);
  }
}
