import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:news_reader_app/core/storage/hive_boxes.dart';
import 'package:news_reader_app/feature/news/data/dtos/article_dto.dart';

/// Abstract contract for local bookmark persistence.
abstract class BookmarkDataSource {
  Future<void> toggleBookmark(ArticleDto article);
  Future<void> addBookmark(ArticleDto article);
  Future<void> removeBookmark(String articleId);
  Future<bool> isBookmarked(String articleId);
  List<ArticleDto> getBookmarks();
  Stream<List<ArticleDto>> watchBookmarks();
  void dispose();
}

/// Hive-backed implementation of [BookmarkDataSource].
class BookmarkDataSourceImpl implements BookmarkDataSource {
  BookmarkDataSourceImpl() {
    _controller.onListen = _emit;
  }

  final StreamController<List<ArticleDto>> _controller =
      StreamController<List<ArticleDto>>.broadcast();

  Box<String> get _box => Hive.box<String>(HiveBoxes.bookmarks);

  @override
  Future<void> toggleBookmark(ArticleDto article) async {
    final id = _idOf(article);
    if (_box.containsKey(id)) {
      await _box.delete(id);
    } else {
      await _box.put(id, jsonEncode(article.toJson()));
    }
    _emit();
  }

  @override
  Future<void> addBookmark(ArticleDto article) async {
    await _box.put(_idOf(article), jsonEncode(article.toJson()));
    _emit();
  }

  @override
  Future<void> removeBookmark(String articleId) async {
    await _box.delete(articleId);
    _emit();
  }

  @override
  Future<bool> isBookmarked(String articleId) async {
    return _box.containsKey(articleId);
  }

  @override
  List<ArticleDto> getBookmarks() {
    return _box.values.map(_decode).whereType<ArticleDto>().toList();
  }

  @override
  Stream<List<ArticleDto>> watchBookmarks() => _controller.stream;

  @override
  void dispose() => _controller.close();

  // ── helpers ──────────────────────────────────────────────────────────────

  String _idOf(ArticleDto dto) {
    if (dto.url.isNotEmpty) return dto.url;
    final fallback = [
      dto.title,
      dto.description,
      dto.content,
      dto.urlToImage,
      dto.publishedAt,
      dto.sourceName,
      dto.author,
    ].map((v) => v.trim()).where((v) => v.isNotEmpty).join('|');
    return fallback.isNotEmpty ? fallback : 'unknown_article';
  }

  ArticleDto? _decode(String encoded) {
    try {
      final value = jsonDecode(encoded);
      if (value is Map<String, dynamic>) return ArticleDto.fromJson(value);
      if (value is Map) {
        return ArticleDto.fromJson(Map<String, dynamic>.from(value));
      }
    } catch (_) {
      // Ignore corrupt entries.
    }
    return null;
  }

  void _emit() {
    if (!_controller.isClosed) _controller.add(getBookmarks());
  }
}
