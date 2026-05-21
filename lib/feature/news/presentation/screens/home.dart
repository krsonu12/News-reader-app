import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/routes/app_router.gr.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';
import 'package:news_reader_app/feature/news/presentation/widgets/animated_news_ticker.dart';
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
    final hasMore = state.feedHasMore[state.activeFeed] ?? true;

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
    final theme = Theme.of(context);
    final state = ref.watch(newsNotifierProvider);
    final notifier = ref.read(newsNotifierProvider.notifier);
    final articles = notifier.currentArticles;

    final categories = [
      NewsFeedType.topHeadlines,
      NewsFeedType.business,
      NewsFeedType.sports,
      NewsFeedType.technology,
      NewsFeedType.health,
    ];
    final categoryLabels = ['Top', 'Business', 'Sports', 'Tech', 'Health'];
    final activeIndex = categories
        .indexOf(state.activeFeed)
        .clamp(0, categories.length - 1);

    final headlineArticles = articles.take(6).toList();

    return DefaultTabController(
      length: categories.length,
      initialIndex: activeIndex,
      child: Scaffold(
        body: RefreshIndicator(
          color: theme.colorScheme.primary,
          onRefresh: notifier.refreshCurrentFeed,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 320,
                stretch: true,
                backgroundColor: theme.colorScheme.primary,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.bookmark),
                    onPressed: () {
                      context.router.push(BookmarksRoute());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      context.router.push(const SearchRoute());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      context.router.push(SettingsRoute());
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                'Top Headlines',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'The latest top stories',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: AnimatedNewsTicker(
                            headlines: headlineArticles,
                            isLoading:
                                state.isLoading && headlineArticles.isEmpty,
                            height: 220,
                            onHeadlineTap: (article) {
                              context.router.push(
                                ArticleDetailRoute(article: article),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                ),

                bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  onTap: (index) => notifier.setActiveFeed(categories[index]),
                  tabs: categoryLabels
                      .map((label) => Tab(text: label))
                      .toList(),
                  labelStyle: theme.textTheme.titleMedium,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  unselectedLabelStyle: theme.textTheme.titleMedium,
                  indicatorColor: Colors.white,
                ),
              ),
              if (state.isOffline)
                SliverToBoxAdapter(
                  child: MaterialBanner(
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
                ),
              if (state.isLoading && articles.isEmpty)
                const SliverFillRemaining(child: NewsShimmerList())
              else if (articles.isEmpty)
                SliverFillRemaining(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 180),
                      Center(
                        child: Text(
                          state.hasError ? state.errorMessage : 'No news found',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= articles.length) {
                        log('loading more articles: ${articles.length}');
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final article = articles[index];
                      return RepaintBoundary(
                        child: NewsTile(
                          article: article,
                          isBookmarked: notifier.isBookmarked(article.id),
                          onBookmarkTap: () => notifier.toggleBookmark(article),
                          onTap: () {
                            context.router.push(
                              ArticleDetailRoute(article: article),
                            );
                          },
                        ),
                      );
                    },
                    childCount: articles.length + (state.isLoadingMore ? 1 : 0),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
