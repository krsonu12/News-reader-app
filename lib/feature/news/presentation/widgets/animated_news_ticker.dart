import 'package:flutter/material.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';

class AnimatedNewsTicker extends StatefulWidget {
  const AnimatedNewsTicker({super.key, required this.headlines});

  final List<NewsModel> headlines;

  @override
  State<AnimatedNewsTicker> createState() => _AnimatedNewsTickerState();
}

class _AnimatedNewsTickerState extends State<AnimatedNewsTicker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _minDuration = Duration(seconds: 36);
  static const _separator = ' |   •   | ';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _minDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headlines = widget.headlines
        .where((item) => item.title.trim().isNotEmpty)
        .map((item) => item.title.trim())
        .toList();
    final tickerText = headlines.isEmpty
        ? 'No headlines available yet.'
        : headlines.join(_separator);

    return Container(
      height: 55,
      width: double.infinity,
      color: theme.colorScheme.secondaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final textStyle = theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            );

            final textPainter = TextPainter(
              text: TextSpan(text: tickerText, style: textStyle),
              textDirection: TextDirection.ltr,
            )..layout();

            final contentWidth = textPainter.width;
            final visibleWidth = constraints.maxWidth;

            if (contentWidth <= visibleWidth || headlines.isEmpty) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tickerText,
                  style: textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }

            final scrollWidth = contentWidth + 64;
            final duration = Duration(
              seconds: (scrollWidth / 11).ceil().clamp(36, 180),
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
              child: SizedBox(
                width: scrollWidth * 2,
                child: Row(
                  children: [
                    Text(tickerText, style: textStyle),
                    const SizedBox(width: 64),
                    Text(tickerText, style: textStyle),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
