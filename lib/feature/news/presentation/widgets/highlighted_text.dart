import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  const HighlightedText({
    super.key,
    required this.text,
    required this.highlight,
    this.style,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final String highlight;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    if (highlight.trim().isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium;
    final highlightStyle = baseStyle?.copyWith(
      backgroundColor: Colors.amber.withValues(alpha: 0.45),
      fontWeight: FontWeight.w600,
    );

    final pattern = RegExp(RegExp.escape(highlight.trim()), caseSensitive: false);
    final spans = <TextSpan>[];
    var start = 0;

    for (final match in pattern.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: highlightStyle,
        ),
      );
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(style: baseStyle, children: spans),
    );
  }
}
