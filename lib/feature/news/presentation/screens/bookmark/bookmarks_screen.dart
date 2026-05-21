import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/storage/news_image_cache_manager.dart';
import 'package:news_reader_app/core/routes/app_router.gr.dart';
import 'package:news_reader_app/core/theme/brand_theme_extension.dart';
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

    final theme = Theme.of(context);
    final brand = theme.extension<BrandTheme>();

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: bookmarks.isEmpty
          ? Center(
              child: Text('No bookmarks', style: theme.textTheme.bodyLarge),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final article = bookmarks[index];
                return Dismissible(
                  key: Key(article.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: theme.colorScheme.error,
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
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    color: theme.colorScheme.surfaceContainerHighest,
                    shadowColor: theme.colorScheme.shadow,
                    elevation: brand?.cardElevation ?? 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        brand?.cardRadius ?? 16,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      tileColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          brand?.cardRadius ?? 16,
                        ),
                      ),
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
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        color: theme.colorScheme.surface,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.white54,
                                        ),
                                      ),
                                ),
                              ),
                            )
                          : Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.image_not_supported,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                      title: Text(
                        article.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        article.sourceName,
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        context.router.push(
                          ArticleDetailRoute(article: article),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
