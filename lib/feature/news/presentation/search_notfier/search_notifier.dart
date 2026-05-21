import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/di/providers.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_page_result.dart';
import 'package:news_reader_app/feature/news/presentation/search_states/search_state.dart';

const _debounceDuration = Duration(milliseconds: 300);
const _minQueryLength = 3;

class SearchNotifier extends Notifier<SearchState> {
  Timer? _debounceTimer;

  @override
  SearchState build() {
    ref.onDispose(() => _debounceTimer?.cancel());
    return const SearchState();
  }

  void onQueryChanged(String value) {
    _debounceTimer?.cancel();
    final trimmed = value.trim();

    if (trimmed.length < _minQueryLength) {
      state = state.copyWith(
        query: value,
        queryTooShort: trimmed.isNotEmpty,
        articles: [],
        page: 1,
        hasMore: false,
        totalResults: 0,
        hasError: false,
        errorMessage: '',
        isLoading: false,
        isLoadingMore: false,
      );
      return;
    }

    state = state.copyWith(
      query: value,
      queryTooShort: false,
      hasError: false,
      errorMessage: '',
    );

    _debounceTimer = Timer(_debounceDuration, () => search(reset: true));
  }

  Future<void> search({bool reset = false}) async {
    final query = state.query.trim();
    if (query.length < _minQueryLength) return;
    if (state.isLoading || state.isLoadingMore) return;

    final page = reset ? 1 : state.page;

    state = state.copyWith(
      isLoading: reset,
      isLoadingMore: !reset,
      hasError: false,
      errorMessage: '',
    );

    try {
      final result = await ref
          .read(searchNewsUseCaseProvider)
          .call(query: query, page: page);

      final articles = reset
          ? result.articles
          : [...state.articles, ...result.articles];

      state = state.copyWith(
        articles: articles,
        page: result.page,
        hasMore: result.hasMore,
        totalResults: result.totalResults,
        isLoading: false,
        isLoadingMore: false,
      );
    } on AppFailure catch (error) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        hasError: true,
        errorMessage: error.message,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        hasError: true,
        errorMessage: 'Search failed. Please try again.',
      );
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading || state.isLoadingMore) return;
    if (state.query.trim().length < _minQueryLength) return;

    final nextPage = state.page + 1;
    state = state.copyWith(
      isLoadingMore: true,
      hasError: false,
      errorMessage: '',
    );

    try {
      final result = await ref
          .read(searchNewsUseCaseProvider)
          .call(
            query: state.query.trim(),
            page: nextPage,
            pageSize: NewsPageResult.pageSize,
          );

      state = state.copyWith(
        articles: [...state.articles, ...result.articles],
        page: nextPage,
        hasMore: result.hasMore,
        totalResults: result.totalResults,
        isLoadingMore: false,
      );
    } on AppFailure catch (error) {
      state = state.copyWith(
        isLoadingMore: false,
        hasError: true,
        errorMessage: error.message,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingMore: false,
        hasError: true,
        errorMessage: 'Could not load more results.',
      );
    }
  }


}
