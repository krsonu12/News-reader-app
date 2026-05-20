import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/hive_boxes.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';

class BookmarkLocalDataSource {
  final StreamController<List<NewsModel>> _bookmarksController =
      StreamController<List<NewsModel>>.broadcast();

  Box<String> get _box => Hive.box<String>(HiveBoxes.bookmarks);

  Future<void> toggleBookmark(NewsModel article) async {
    if (_box.containsKey(article.id)) {
      await _box.delete(article.id);
    } else {
      await _box.put(article.id, jsonEncode(article.toJson()));
    }
    _emitBookmarks();
  }

  Future<bool> isBookmarked(String articleId) async {
    return _box.containsKey(articleId);
  }

  List<NewsModel> getBookmarks() {
    return _box.values
        .map((encoded) => jsonDecode(encoded))
        .whereType()
        .map((item) => NewsModel.fromJson(item))
        .toList();
  }

  Stream<List<NewsModel>> watchBookmarks() {
    _emitBookmarks();
    return _bookmarksController.stream;
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
