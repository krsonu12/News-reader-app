import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:news_reader_app/feature/news/data/local/hive_boxes.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';

class NewsCacheLocalDataSource {
  Future<void> saveFeed({
    required NewsFeedType feed,
    required List<NewsModel> articles,
  }) async {
    final box = _boxForFeed(feed);
    await box.put(
      'items',
      jsonEncode(articles.map((article) => article.toJson()).toList()),
    );
  }

  List<NewsModel> getFeed({required NewsFeedType feed}) {
    final box = _boxForFeed(feed);
    final encoded = box.get('items');
    if (encoded == null || encoded.isEmpty) return [];

    final decoded = jsonDecode(encoded);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map>()
        .map((item) => NewsModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  List<NewsModel> getAnyFeed() {
    final top = getFeed(feed: NewsFeedType.topHeadlines);
    if (top.isNotEmpty) return top;

    return getFeed(feed: NewsFeedType.everything);
  }

  Box<String> _boxForFeed(NewsFeedType feed) {
    return Hive.box<String>(
      feed == NewsFeedType.topHeadlines
          ? HiveBoxes.cachedTopHeadlines
          : HiveBoxes.cachedEverything,
    );
  }
}
