import 'dart:async';

import 'package:app_movies/core/api/api_service.dart';
import 'package:app_movies/core/constants/api_resource.dart';
import 'package:app_movies/core/language/data/repositories/language_repository_impl.dart';
import 'package:app_movies/core/local/base_service_local.dart';

class ApiMoviesService {
  static final ApiMoviesService _apiMoviesService =
      ApiMoviesService(ApiService.instance);
  static ApiMoviesService get instance => _apiMoviesService;

  final ApiService _apiService;
  final LanguageRepositoryIml _apiLanguage =
      LanguageRepositoryIml(LocalServiceImpl());

  ApiMoviesService(this._apiService);

  Future<List<dynamic>> fetchTrendingMovies() async {
    final language = await _apiLanguage.getSavedLanguage();
    final response = await _apiService.fetchData(ApiResource.trendingMovieUrl,
        queryParameters: {'language': language});
    return response.data['results'] ?? [];
  }

  Future<List<dynamic>> fetchVideoMovies(int movieId) async {
    final language = await _apiLanguage.getSavedLanguage();
    String baseUrlVideo = '/movie/$movieId/videos';
    final response = await _apiService.fetchData(baseUrlVideo,
        queryParameters: {'movie_id': movieId, 'language': language});
    return response.data['results'];
  }
}
