import 'package:news_reader_app/feature/news/data/models/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getTopHeadlines();
  Future<List<NewsModel>> getEverything();
}