import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/hive_boxes.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';

class BookmarkLocalDataSource {
  final StreamController<List<NewsModel>> _bookmarksController =
      StreamController<List<NewsModel>>.broadcast();

  Box<String> get _box => Hive.box<String>(HiveBoxes.bookmarks);

  BookmarkLocalDataSource() {
    _bookmarksController.onListen = _emitBookmarks;
  }

  Future<void> toggleBookmark(NewsModel article) async {
    final id = article.id;
    if (_box.containsKey(id)) {
      await _box.delete(id);
    } else {
      await _box.put(id, jsonEncode(article.toJson()));
    }
    _emitBookmarks();
  }

  Future<void> addBookmark(NewsModel article) async {
    await _box.put(article.id, jsonEncode(article.toJson()));
    _emitBookmarks();
  }

  Future<void> removeBookmark(String articleId) async {
    await _box.delete(articleId);
    _emitBookmarks();
  }

  Future<bool> isBookmarked(String articleId) async {
    return _box.containsKey(articleId);
  }

  List<NewsModel> getBookmarks() {
    return _box.values.map(_decodeBookmark).whereType<NewsModel>().toList();
  }

  Stream<List<NewsModel>> watchBookmarks() {
    return _bookmarksController.stream;
  }

  NewsModel? _decodeBookmark(String encoded) {
    try {
      final value = jsonDecode(encoded);
      if (value is Map<String, dynamic>) {
        return NewsModel.fromJson(value);
      }
      if (value is Map) {
        return NewsModel.fromJson(Map<String, dynamic>.from(value));
      }
    } catch (_) {
      // Ignore invalid bookmark entries and keep other bookmarks intact.
    }
    return null;
  }

  void _emitBookmarks() {
    if (!_bookmarksController.isClosed) {
      _bookmarksController.add(getBookmarks());
    }
  }

  void dispose() {
    _bookmarksController.close();
  }
}
