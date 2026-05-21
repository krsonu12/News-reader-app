import 'package:hive/hive.dart';

class HiveBoxes {
  static const String cachedTopHeadlines = 'cached_top_headlines';
  static const String cachedEverything = 'cached_everything';
  static const String bookmarks = 'bookmarks';

  static Future<void> openAll() async {
    await Hive.openBox<String>(cachedTopHeadlines);
    await Hive.openBox<String>(cachedEverything);
    await Hive.openBox<String>(bookmarks);
  }

  static Future<void> clearCache() async {
    await Hive.box<String>(cachedTopHeadlines).clear();
    await Hive.box<String>(cachedEverything).clear();
  }
}
