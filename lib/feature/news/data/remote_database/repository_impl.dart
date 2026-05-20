import 'package:dio/dio.dart';
import 'package:news_reader_app/core/constants/app_urls.dart';
import 'package:news_reader_app/feature/news/data/models/news_model.dart';
import 'package:news_reader_app/feature/news/domain/repository/news_repository.dart';

class RepositoryImpl implements NewsRepository {
  late final Dio dio;
  RepositoryImpl({required this.dio});
  @override
  Future<List<NewsModel>> getTopHeadlines() async {
    final response = await dio.get(AppUrls.topHeadlines);
    return response.data.map((e) => NewsModel.fromJson(e)).toList();
  }

  @override
  Future<List<NewsModel>> getEverything() async {
    final response = await dio.get(AppUrls.everything);
    return response.data.map((e) => NewsModel.fromJson(e)).toList();
  }
}
