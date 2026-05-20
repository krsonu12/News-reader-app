import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_reader_app/core/theme/brand_theme_extension.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/presentation/widgets/highlighted_text.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.article,
    required this.isBookmarked,
    required this.onBookmarkTap,
    this.highlightQuery = '',
  });

  final NewsModel article;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final String highlightQuery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandTheme>();

    return Card(
      elevation: brand?.cardElevation ?? 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(brand?.cardRadius ?? 16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                ),
              ),
            const SizedBox(height: 8),
            HighlightedText(
              text: article.title.isEmpty ? 'Untitled' : article.title,
              highlight: highlightQuery,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (article.description.isNotEmpty) ...[
              const SizedBox(height: 6),
              HighlightedText(
                text: article.description,
                highlight: highlightQuery,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    article.sourceName.isEmpty ? 'Unknown source' : article.sourceName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                IconButton(
                  onPressed: onBookmarkTap,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
