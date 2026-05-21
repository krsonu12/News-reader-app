import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/theme/brand_theme_extension.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/search_states/search_state.dart';
import 'package:news_reader_app/feature/news/presentation/shared_providers/providers.dart';
import 'package:news_reader_app/feature/news/presentation/widgets/news_shimmer_list.dart';
import 'package:news_reader_app/feature/news/presentation/widgets/news_tile.dart';

@RoutePage()
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  bool _loadMoreRequested = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final state = ref.read(searchNotifierProvider);
    if (!state.hasMore || state.isLoadingMore || state.isLoading) {
      _loadMoreRequested = false;
      return;
    }

    final threshold = _scrollController.position.maxScrollExtent - 300;
    if (_scrollController.position.pixels >= threshold && !_loadMoreRequested) {
      _loadMoreRequested = true;
      ref.read(searchNotifierProvider.notifier).loadMore().whenComplete(() {
        _loadMoreRequested = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchNotifierProvider);
    final newsNotifier = ref.read(newsNotifierProvider.notifier);
    final highlight = state.query.trim();

    return Scaffold(
      appBar: AppBar(title: const Text('Search News')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search articles (min 3 characters)',
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          ref
                              .read(searchNotifierProvider.notifier)
                              .onQueryChanged('');
                          setState(() {});
                        },
                      ),
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Theme.of(context).extension<BrandTheme>()?.cardRadius ?? 16,
                  ),
                ),
              ),
              onChanged: (value) {
                ref.read(searchNotifierProvider.notifier).onQueryChanged(value);
                setState(() {});
              },
            ),
          ),
          if (state.queryTooShort)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text('Type at least 3 characters to search'),
            ),
          if (state.totalResults > 0 && !state.queryTooShort)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Showing ${state.articles.length} of ${state.totalResults} results',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          Expanded(child: _buildResults(state, newsNotifier, highlight)),
        ],
      ),
    );
  }

  Widget _buildResults(
    SearchState state,
    NewsNotifier newsNotifier,
    String highlight,
  ) {
    if (state.isLoading && state.articles.isEmpty) {
      return const NewsShimmerList();
    }

    if (state.hasError && state.articles.isEmpty) {
      return Center(child: Text(state.errorMessage));
    }

    if (state.articles.isEmpty &&
        !state.queryTooShort &&
        highlight.length >= 3) {
      return const Center(child: Text('No articles found'));
    }

    if (state.articles.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: state.articles.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.articles.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final article = state.articles[index];
        return NewsTile(
          article: article,
          highlightQuery: highlight,
          isBookmarked: newsNotifier.isBookmarked(article.id),
          onBookmarkTap: () => newsNotifier.toggleBookmark(article),
        );
      },
    );
  }
}
