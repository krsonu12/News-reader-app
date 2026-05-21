import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class NewsImageCacheManager extends CacheManager {
  static const key = 'news_image_cache';
  static NewsImageCacheManager? _instance;

  factory NewsImageCacheManager() {
    return _instance ??= NewsImageCacheManager._();
  }

  NewsImageCacheManager._()
    : super(
        Config(
          key,
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 200,
          repo: JsonCacheInfoRepository(databaseName: key),
          fileService: HttpFileService(),
        ),
      );

  static CacheManager get instance => NewsImageCacheManager();
}

final newsImageCacheManager = NewsImageCacheManager.instance;
