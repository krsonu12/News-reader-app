// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_reader_app/feature/news/presentation/widgets/news_tile.dart';

import '../helpers/widget_test_helpers.dart';

// ── Helpers ───────────────────────────────────────────────────────────────────

/// Pumps a bare [NewsTile] inside a minimal themed scaffold.
/// No Riverpod needed — NewsTile is a pure stateless widget.
Future<void> pumpTile(
  WidgetTester tester, {
  required String title,
  String description = '',
  String content = '',
  String urlToImage = '',
  String sourceName = 'BBC News',
  bool isBookmarked = false,
  VoidCallback? onBookmarkTap,
  VoidCallback? onTap,
}) async {
  final article = makeArticle(
    title: title,
    description: description,
    content: content,
    urlToImage: urlToImage,
    sourceName: sourceName,
  );

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: NewsTile(
          article: article,
          isBookmarked: isBookmarked,
          onBookmarkTap: onBookmarkTap ?? () {},
          onTap: onTap,
        ),
      ),
    ),
  );
}

void main() {
  setUpAll(registerWidgetFallbackValues);

  // ── Title rendering ───────────────────────────────────────────────────────

  group('NewsTile — title', () {
    testWidgets('renders the article title', (tester) async {
      await pumpTile(tester, title: 'Flutter 4.0 Released');
      expect(find.text('Flutter 4.0 Released'), findsOneWidget);
    });

    testWidgets('renders "Untitled" when title is empty', (tester) async {
      await pumpTile(tester, title: '');
      expect(find.text('Untitled'), findsOneWidget);
    });

    testWidgets('renders description when non-empty', (tester) async {
      await pumpTile(
        tester,
        title: 'Title',
        description: 'A great description',
      );
      expect(find.text('A great description'), findsOneWidget);
    });

    testWidgets('does not render description widget when empty', (
      tester,
    ) async {
      await pumpTile(tester, title: 'Title', description: '');
      expect(find.text(''), findsNothing);
    });
  });

  // ── Image placeholder ─────────────────────────────────────────────────────

  group('NewsTile — image placeholder', () {
    testWidgets('shows no image widget when urlToImage is empty', (
      tester,
    ) async {
      await pumpTile(tester, title: 'No Image', urlToImage: '');
      // CachedNetworkImage should not be in the tree at all
      expect(find.byType(ClipRRect), findsNothing);
    });

    testWidgets('shows ClipRRect image container when urlToImage is set', (
      tester,
    ) async {
      await pumpTile(
        tester,
        title: 'With Image',
        urlToImage: 'https://example.com/image.jpg',
      );
      // CachedNetworkImage wraps in ClipRRect
      expect(find.byType(ClipRRect), findsOneWidget);
    });
  });

  // ── Read-time ─────────────────────────────────────────────────────────────

  group('NewsTile — read-time', () {
    testWidgets('shows "1 min read" for an empty article', (tester) async {
      await pumpTile(tester, title: '');
      expect(find.text('1 min read'), findsOneWidget);
    });

    testWidgets('shows "1 min read" for a short article (< 200 words)', (
      tester,
    ) async {
      // 10 words in title
      await pumpTile(
        tester,
        title: 'one two three four five six seven eight nine ten',
      );
      expect(find.text('1 min read'), findsOneWidget);
    });

    testWidgets('shows "5 min read" for a 1000-word article', (tester) async {
      // 1000 words split across content + title
      final content = List.filled(990, 'word').join(' ');
      final title = List.filled(10, 'word').join(' ');
      await pumpTile(tester, title: title, content: content);
      expect(find.text('5 min read'), findsOneWidget);
    });

    testWidgets('shows "1 min read" for exactly 200 words', (tester) async {
      final content = List.filled(200, 'word').join(' ');
      await pumpTile(tester, title: '', content: content);
      expect(find.text('1 min read'), findsOneWidget);
    });

    testWidgets('shows "2 min read" for 201 words', (tester) async {
      final content = List.filled(201, 'word').join(' ');
      await pumpTile(tester, title: '', content: content);
      expect(find.text('2 min read'), findsOneWidget);
    });

    testWidgets(
      'shows "60 min read" for a very long article (> 12 000 words)',
      (tester) async {
        final content = List.filled(12001, 'word').join(' ');
        await pumpTile(tester, title: '', content: content);
        expect(find.text('60 min read'), findsOneWidget);
      },
    );
  });

  // ── Source name ───────────────────────────────────────────────────────────

  group('NewsTile — source name', () {
    testWidgets('renders source name', (tester) async {
      await pumpTile(tester, title: 'T', sourceName: 'Reuters');
      expect(find.text('Reuters'), findsOneWidget);
    });

    testWidgets('renders "Unknown source" when sourceName is empty', (
      tester,
    ) async {
      await pumpTile(tester, title: 'T', sourceName: '');
      expect(find.text('Unknown source'), findsOneWidget);
    });
  });

  // ── Bookmark icon ─────────────────────────────────────────────────────────

  group('NewsTile — bookmark icon', () {
    testWidgets('shows bookmark_border icon when not bookmarked', (
      tester,
    ) async {
      await pumpTile(tester, title: 'T', isBookmarked: false);
      expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
      expect(find.byIcon(Icons.bookmark), findsNothing);
    });

    testWidgets('shows filled bookmark icon when bookmarked', (tester) async {
      await pumpTile(tester, title: 'T', isBookmarked: true);
      expect(find.byIcon(Icons.bookmark), findsOneWidget);
      expect(find.byIcon(Icons.bookmark_border), findsNothing);
    });

    testWidgets('calls onBookmarkTap when bookmark icon is tapped', (
      tester,
    ) async {
      var tapped = false;
      await pumpTile(tester, title: 'T', onBookmarkTap: () => tapped = true);
      await tester.tap(find.byIcon(Icons.bookmark_border));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });

  // ── onTap ─────────────────────────────────────────────────────────────────

  group('NewsTile — onTap', () {
    testWidgets('calls onTap when card is tapped', (tester) async {
      var tapped = false;
      await pumpTile(
        tester,
        title: 'Tappable Article',
        onTap: () => tapped = true,
      );
      // Tap the Card widget itself (avoids ambiguity with the IconButton's InkWell)
      await tester.tap(find.byType(Card));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });
}
