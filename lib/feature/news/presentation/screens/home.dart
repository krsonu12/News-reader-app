import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';
import 'package:news_reader_app/feature/news/presentation/screens/search_screen.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/widgets/news_shimmer_list.dart';
import 'package:news_reader_app/feature/news/presentation/widgets/news_tile.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;
  bool _loadMoreRequested = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final state = ref.read(newsNotifierProvider);
    final feed = state.activeFeed;
    final hasMore = feed == NewsFeedType.topHeadlines
        ? state.topHasMore
        : state.everythingHasMore;

    if (!hasMore || state.isLoadingMore || state.isLoading) {
      _loadMoreRequested = false;
      return;
    }

    final threshold = _scrollController.position.maxScrollExtent - 350;
    if (_scrollController.position.pixels >= threshold && !_loadMoreRequested) {
      _loadMoreRequested = true;
      ref
          .read(newsNotifierProvider.notifier)
          .loadMoreCurrentFeed()
          .whenComplete(() {
            _loadMoreRequested = false;
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsNotifierProvider);
    final notifier = ref.read(newsNotifierProvider.notifier);
    final articles = notifier.currentArticles;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top News'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
              },
            ),
          ],
          bottom: TabBar(
            onTap: (index) {
              final feed = index == 0
                  ? NewsFeedType.topHeadlines
                  : NewsFeedType.everything;
              notifier.setActiveFeed(feed);
            },
            tabs: const [
              Tab(text: 'Top Headlines'),
              Tab(text: 'Everything'),
            ],
          ),
        ),
        body: Column(
          children: [
            if (state.isOffline)
              MaterialBanner(
                content: const Text('Offline mode: showing cached news'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            Expanded(
              child: state.isLoading && articles.isEmpty
                  ? const NewsShimmerList()
                  : RefreshIndicator(
                      onRefresh: notifier.refreshCurrentFeed,
                      child: articles.isEmpty
                          ? ListView(
                              children: [
                                const SizedBox(height: 180),
                                Center(
                                  child: Text(
                                    state.hasError
                                        ? state.errorMessage
                                        : 'No news found',
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount:
                                  articles.length +
                                  (state.isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index >= articles.length) {
                                  log(
                                    "loading more articles: ${articles.length}",
                                  );
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                final article = articles[index];
                                return NewsTile(
                                  article: article,
                                  isBookmarked: notifier.isBookmarked(
                                    article.id,
                                  ),
                                  onBookmarkTap: () =>
                                      notifier.toggleBookmark(article),
                                );
                              },
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
