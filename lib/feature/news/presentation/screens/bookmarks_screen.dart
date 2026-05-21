import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/image/news_image_cache_manager.dart';
import 'package:news_reader_app/core/routes/app_router.gr.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';

@RoutePage()
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newsNotifierProvider);
    final notifier = ref.read(newsNotifierProvider.notifier);
    final bookmarks = state.bookmarks;

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: bookmarks.isEmpty
          ? Center(
              child: Text(
                'No bookmarks',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final article = bookmarks[index];
                return Dismissible(
                  key: Key(article.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Theme.of(context).colorScheme.error,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    notifier.toggleBookmark(article);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bookmark removed')),
                    );
                  },
                  child: ListTile(
                    leading: article.urlToImage.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 72,
                              height: 72,
                              child: CachedNetworkImage(
                                imageUrl: article.urlToImage,
                                cacheManager: newsImageCacheManager,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Container(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
                    title: Text(article.title),
                    subtitle: Text(article.sourceName),
                    onTap: () {
                      context.router.push(ArticleDetailRoute(article: article));
                    },
                  ),
                );
              },
            ),
    );
  }
}
