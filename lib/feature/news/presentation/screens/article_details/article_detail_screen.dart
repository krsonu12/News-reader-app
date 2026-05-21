import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/storage/news_image_cache_manager.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';
import 'package:news_reader_app/feature/news/presentation/shared_providers/providers.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class ArticleDetailScreen extends ConsumerWidget {
  const ArticleDetailScreen({super.key, required this.article});

  final Article article;

  int _estimateReadMinutes() {
    final text = '${article.content} ${article.description} ${article.title}'
        .trim();
    if (text.isEmpty) return 1;
    final words = text.split(RegExp(r'\s+')).length;
    const wpm = 200;
    return (words / wpm).ceil().clamp(1, 60);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(newsNotifierProvider.notifier);
    final isBookmarked = ref
        .watch(newsNotifierProvider)
        .bookmarks
        .any((item) => item.id == article.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.sourceName.isNotEmpty ? article.sourceName : 'Article',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              final urlToShare = article.url.isNotEmpty
                  ? article.url
                  : 'No URL available to share.';
              SharePlus.instance.share(ShareParams(text: urlToShare));
            },
          ),
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () async {
              await notifier.toggleBookmark(article);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: article.id,
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage,
                      cacheManager: newsImageCacheManager,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (article.author.isNotEmpty)
                  Text(
                    'By ${article.author}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                Text(
                  article.publishedAt,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '${_estimateReadMinutes()} min read',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              article.content.isNotEmpty
                  ? article.content
                  : article.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
