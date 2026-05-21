import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:news_reader_app/core/storage/hive_boxes.dart';
import 'package:news_reader_app/feature/news/data/dtos/article_dto.dart';
import 'package:news_reader_app/feature/news/domain/entities/news_feed_type.dart';

/// Abstract contract for local news feed caching.
abstract class NewsCacheDataSource {
  Future<void> saveFeed({
    required NewsFeedType feed,
    required List<ArticleDto> articles,
  });

  List<ArticleDto> getFeed({required NewsFeedType feed});

  List<ArticleDto> getAnyFeed();

  Future<void> clearAll();
}

/// Hive-backed implementation of [NewsCacheDataSource].
class NewsCacheDataSourceImpl implements NewsCacheDataSource {
  static const _topHeadlinesFeeds = {
    NewsFeedType.topHeadlines,
    NewsFeedType.business,
    NewsFeedType.sports,
    NewsFeedType.technology,
    NewsFeedType.health,
  };

  @override
  Future<void> saveFeed({
    required NewsFeedType feed,
    required List<ArticleDto> articles,
  }) async {
    final box = _boxForFeed(feed);
    await box.put(
      feed.name,
      jsonEncode(articles.map((a) => a.toJson()).toList()),
    );
  }

  @override
  List<ArticleDto> getFeed({required NewsFeedType feed}) {
    final box = _boxForFeed(feed);
    final encoded = box.get(feed.name);
    if (encoded == null || encoded.isEmpty) return [];

    final decoded = jsonDecode(encoded);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map>()
        .map((item) => ArticleDto.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  @override
  List<ArticleDto> getAnyFeed() {
    const priority = [
      NewsFeedType.topHeadlines,
      NewsFeedType.business,
      NewsFeedType.sports,
      NewsFeedType.technology,
      NewsFeedType.health,
      NewsFeedType.everything,
    ];
    for (final feed in priority) {
      final items = getFeed(feed: feed);
      if (items.isNotEmpty) return items;
    }
    return [];
  }

  Box<String> _boxForFeed(NewsFeedType feed) {
    return Hive.box<String>(
      _topHeadlinesFeeds.contains(feed)
          ? HiveBoxes.cachedTopHeadlines
          : HiveBoxes.cachedEverything,
    );
  }

  @override
  Future<void> clearAll() async {
    await Hive.box<String>(HiveBoxes.cachedTopHeadlines).clear();
    await Hive.box<String>(HiveBoxes.cachedEverything).clear();
  }
}
