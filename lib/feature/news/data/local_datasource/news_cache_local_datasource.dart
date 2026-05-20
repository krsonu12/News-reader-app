import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/hive_boxes.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';

class NewsCacheLocalDataSource {
  Future<void> saveFeed({
    required NewsFeedType feed,
    required List<NewsModel> articles,
  }) async {
    final box = _boxForFeed(feed);
    await box.put(
      _cacheKeyForFeed(feed),
      jsonEncode(articles.map((article) => article.toJson()).toList()),
    );
  }

  List<NewsModel> getFeed({required NewsFeedType feed}) {
    final box = _boxForFeed(feed);
    final encoded = box.get(_cacheKeyForFeed(feed));
    if (encoded == null || encoded.isEmpty) return [];

    final decoded = jsonDecode(encoded);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map>()
        .map((item) => NewsModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  List<NewsModel> getAnyFeed() {
    final topFeeds = [
      NewsFeedType.topHeadlines,
      NewsFeedType.business,
      NewsFeedType.sports,
      NewsFeedType.technology,
      NewsFeedType.health,
    ];
    for (final feed in topFeeds) {
      final items = getFeed(feed: feed);
      if (items.isNotEmpty) return items;
    }

    return getFeed(feed: NewsFeedType.everything);
  }

  Box<String> _boxForFeed(NewsFeedType feed) {
    final topHeadlinesFeeds = {
      NewsFeedType.topHeadlines,
      NewsFeedType.business,
      NewsFeedType.sports,
      NewsFeedType.technology,
      NewsFeedType.health,
    };
    return Hive.box<String>(
      topHeadlinesFeeds.contains(feed)
          ? HiveBoxes.cachedTopHeadlines
          : HiveBoxes.cachedEverything,
    );
  }

  String _cacheKeyForFeed(NewsFeedType feed) {
    return feed.name;
  }
}
