import 'package:flutter_test/flutter_test.dart';
import 'package:news_reader_app/feature/news/domain/entities/article.dart';


Article articleWith({
  String title = '',
  String description = '',
  String content = '',
}) => Article(
  title: title,
  description: description,
  content: content,
  url: 'https://example.com',
  urlToImage: '',
  publishedAt: '',
  sourceName: '',
  author: '',
);

// Generates a string of exactly [n] space-separated words.
String nWords(int n) => List.filled(n, 'word').join(' ');

void main() {
  group('Article.estimatedReadMinutes — edge cases', () {
    // ── Empty / zero-word inputs ──────────────────────────────────────────

    test('all fields empty → returns minimum of 1 minute', () {
      final article = articleWith();
      expect(article.estimatedReadMinutes, equals(1));
    });

    test('title is whitespace only → treated as empty → 1 minute', () {
      final article = articleWith(title: '   ');
      // trim() collapses to empty string
      expect(article.estimatedReadMinutes, equals(1));
    });

    test('0 words (empty string after trim) → 1 minute (minimum clamp)', () {
      final article = articleWith(title: '', description: '', content: '');
      expect(article.estimatedReadMinutes, equals(1));
    });

    // ── Single word ───────────────────────────────────────────────────────

    test('1 word → ceil(1/200) = 1 minute', () {
      final article = articleWith(title: 'Hello');
      expect(article.estimatedReadMinutes, equals(1));
    });

    // ── Exact boundary at 200 words ───────────────────────────────────────

    test('200 words → exactly 1 minute', () {
      final article = articleWith(content: nWords(200));
      expect(article.estimatedReadMinutes, equals(1));
    });

    test('201 words → ceil(201/200) = 2 minutes', () {
      final article = articleWith(content: nWords(201));
      expect(article.estimatedReadMinutes, equals(2));
    });

    // ── 1000 words ────────────────────────────────────────────────────────

    test('1000 words → ceil(1000/200) = 5 minutes', () {
      final article = articleWith(content: nWords(1000));
      expect(article.estimatedReadMinutes, equals(5));
    });

    test(
      '1000 words split across title + description + content → 5 minutes',
      () {
        // 300 + 300 + 400 = 1000 words total
        final article = articleWith(
          title: nWords(300),
          description: nWords(300),
          content: nWords(400),
        );
        expect(article.estimatedReadMinutes, equals(5));
      },
    );

    // ── Upper clamp at 60 minutes ─────────────────────────────────────────

    test('12 000 words → ceil(12000/200) = 60 minutes (max clamp)', () {
      final article = articleWith(content: nWords(12000));
      expect(article.estimatedReadMinutes, equals(60));
    });

    test('50 000 words → clamped to 60 minutes', () {
      final article = articleWith(content: nWords(50000));
      expect(article.estimatedReadMinutes, equals(60));
    });

    // ── Rounding (ceil) ───────────────────────────────────────────────────

    test('100 words → ceil(100/200) = 1 minute (not 0)', () {
      final article = articleWith(content: nWords(100));
      expect(article.estimatedReadMinutes, equals(1));
    });

    test('399 words → ceil(399/200) = 2 minutes', () {
      final article = articleWith(content: nWords(399));
      expect(article.estimatedReadMinutes, equals(2));
    });

    test('400 words → ceil(400/200) = 2 minutes', () {
      final article = articleWith(content: nWords(400));
      expect(article.estimatedReadMinutes, equals(2));
    });

    test('401 words → ceil(401/200) = 3 minutes', () {
      final article = articleWith(content: nWords(401));
      expect(article.estimatedReadMinutes, equals(3));
    });

    // ── Multi-space / newline separators ──────────────────────────────────

    test('words separated by multiple spaces are counted correctly', () {
      // 5 words with extra spaces — regex \s+ handles this
      final article = articleWith(content: 'one  two   three    four     five');
      expect(article.estimatedReadMinutes, equals(1));
    });

    test('words separated by newlines are counted correctly', () {
      final article = articleWith(content: 'word\nword\nword');
      expect(article.estimatedReadMinutes, equals(1));
    });

    // ── Field combination ─────────────────────────────────────────────────

    test('only title has words → counted correctly', () {
      final article = articleWith(title: nWords(400));
      expect(article.estimatedReadMinutes, equals(2));
    });

    test('only description has words → counted correctly', () {
      final article = articleWith(description: nWords(600));
      expect(article.estimatedReadMinutes, equals(3));
    });

    test('content dominates when all three fields have words', () {
      // 50 + 50 + 900 = 1000 words → 5 minutes
      final article = articleWith(
        title: nWords(50),
        description: nWords(50),
        content: nWords(900),
      );
      expect(article.estimatedReadMinutes, equals(5));
    });
  });
}
