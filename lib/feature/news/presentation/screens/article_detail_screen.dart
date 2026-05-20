import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/presentation/news_notifier/news_notifier.dart';

class ArticleDetailScreen extends ConsumerWidget {
  const ArticleDetailScreen({super.key, required this.article});

  final NewsModel article;

  int _estimateReadMinutes() {
    final text = '${article.content} ${article.description} ${article.title}'.trim();
    if (text.isEmpty) return 1;
    final words = text.split(RegExp(r"\s+")).length;
    final wpm = 200;
    return (words / wpm).ceil().clamp(1, 60);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(newsNotifierProvider.notifier);
    final isBookmarked = ref.watch(newsNotifierProvider).bookmarks
        .any((item) => item.id == article.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.sourceName.isNotEmpty ? article.sourceName : 'Article'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              final shareText = '${article.title}\n\n${article.url.isNotEmpty ? article.url : article.description}';
              SharePlus.instance.share(ShareParams(text: shareText));
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
                height: 200,
                child: Image.network(article.urlToImage, fit: BoxFit.cover),
              ),
            const SizedBox(height: 12),
            Text(article.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                if (article.author.isNotEmpty)
                  Text('By ${article.author}', style: Theme.of(context).textTheme.bodySmall),
                if (article.author.isNotEmpty) const SizedBox(width: 12),
                Text(article.publishedAt, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(width: 12),
                Text('${_estimateReadMinutes()} min read', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 16),
            Text(article.content.isNotEmpty ? article.content : article.description,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            if (article.url.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () {
                  SharePlus.instance.share(ShareParams(text: '${article.title}\n${article.url}'));
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open full article'),
              ),
          ],
        ),
      ),
    );
  }
}
