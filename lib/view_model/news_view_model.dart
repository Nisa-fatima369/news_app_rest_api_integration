
import 'package:news_app_rest_api_integration/models/news_categories_model.dart';
import 'package:news_app_rest_api_integration/models/news_channels_headlines_model.dart';
import 'package:news_app_rest_api_integration/repository/news_repository.dart';

class NewsViewModdel{
  final _repo = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async{
    final response = await _repo.fetchNewsChannelHeadlinesApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    final response = await _repo.fetchCategoriesNewsApi(category);
    return response;
  }
}