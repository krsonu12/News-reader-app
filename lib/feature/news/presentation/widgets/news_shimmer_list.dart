import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsTileShimmer extends StatelessWidget {
  const NewsTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ShimmerBox(height: 180, borderRadius: 8),
              const SizedBox(height: 10),

              _ShimmerBox(height: 16, widthFactor: 0.9),
              const SizedBox(height: 6),
              _ShimmerBox(height: 16, widthFactor: 0.6),
              const SizedBox(height: 12),

              _ShimmerBox(height: 13),
              const SizedBox(height: 5),
              _ShimmerBox(height: 13),
              const SizedBox(height: 5),
              _ShimmerBox(height: 13, widthFactor: 0.75),
              const SizedBox(height: 12),

              Row(
                children: [
                  _ShimmerBox(height: 13, width: 80),
                  const Spacer(),
                  _ShimmerBox(height: 13, width: 55),
                  const SizedBox(width: 8),
                  _ShimmerBox(height: 24, width: 24, borderRadius: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    this.height = 14,
    this.width,
    this.widthFactor,
    this.borderRadius = 6,
  });

  final double height;
  final double? width;
  final double? widthFactor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget box = Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );

    if (widthFactor != null) {
      return FractionallySizedBox(widthFactor: widthFactor, child: box);
    }
    if (width == null) {
      return SizedBox(width: double.infinity, child: box);
    }
    return box;
  }
}

class NewsShimmerList extends StatelessWidget {
  const NewsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (_, _) => const NewsTileShimmer(),
    );
  }
}
