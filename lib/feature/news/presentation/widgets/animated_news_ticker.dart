import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:news_reader_app/core/storage/news_image_cache_manager.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';

class AnimatedNewsTicker extends StatefulWidget {
  const AnimatedNewsTicker({
    super.key,
    required this.headlines,
    this.onHeadlineTap,
    this.isLoading = false,
    this.height = 220,
  });

  final List<NewsModel> headlines;
  final ValueChanged<NewsModel>? onHeadlineTap;
  final bool isLoading;
  final double height;

  @override
  State<AnimatedNewsTicker> createState() => _AnimatedNewsTickerState();
}

class _AnimatedNewsTickerState extends State<AnimatedNewsTicker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _minDuration = Duration(seconds: 24);
  static const _cardWidth = 260.0;
  static const _cardSpacing = 14.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _minDuration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headlines = widget.headlines;

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (headlines.isEmpty) {
              if (widget.isLoading) {
                return _buildLoadingPlaceholder(theme);
              }
              return Center(
                child: Text(
                  'No headlines available yet.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              );
            }

            final cards = widget.headlines.map((article) {
              return Padding(
                padding: const EdgeInsets.only(right: _cardSpacing),
                child: SizedBox(
                  width: _cardWidth,
                  child: GestureDetector(
                    onTap: () => widget.onHeadlineTap?.call(article),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 6,
                      clipBehavior: Clip.hardEdge,
                      child: SizedBox(
                        height: 220,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (article.urlToImage.isNotEmpty)
                              Hero(
                                tag: article.id,
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage,
                                  cacheManager: newsImageCacheManager,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        color: theme
                                            .colorScheme
                                            .surfaceContainerHighest,
                                      ),
                                ),
                              )
                            else
                              Container(
                                color: theme.colorScheme.surface,
                                child: Center(
                                  child: Icon(
                                    Icons.newspaper,
                                    size: 40,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.10),
                                    Colors.black.withValues(alpha: 0.65),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  article.title,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList();

            final duplicatedCards = cards
                .map((card) => HeroMode(enabled: false, child: card))
                .toList();

            final itemWidth = _cardWidth + _cardSpacing;
            final scrollWidth = itemWidth * cards.length;
            final duration = Duration(
              seconds: (scrollWidth / 22).ceil().clamp(18, 60),
            );
            if (_controller.duration != duration) {
              _controller.duration = duration;
              _controller.repeat();
            }

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final offset = _controller.value * scrollWidth;
                return Transform.translate(
                  offset: Offset(-offset, 0),
                  child: child,
                );
              },
              child: OverflowBox(
                maxWidth: double.infinity,
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: scrollWidth * 2,
                  child: Row(children: [...cards, ...duplicatedCards]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingPlaceholder(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(4, (index) {
              return Container(
                margin: EdgeInsets.only(right: index == 3 ? 0 : _cardSpacing),
                width: _cardWidth,
                height: 220,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: _cardWidth * 0.7,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
