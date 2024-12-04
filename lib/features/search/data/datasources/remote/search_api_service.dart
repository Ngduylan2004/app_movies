import 'package:app_movies/core/language/data/repositories/language_repository_impl.dart';
import 'package:app_movies/core/local/base_service_local.dart';
import 'package:app_movies/core/model/genre_movies.dart';
import 'package:app_movies/core/model/movies_model.dart';
import 'package:app_movies/core/model/video_movies.dart';

import '../../../../../core/api/api_service.dart';
import '../../../../../core/constants/api_resource.dart';

class SearchApiService {
  static final SearchApiService _searchApiService =
      SearchApiService(ApiService.instance);
  static SearchApiService get instance => _searchApiService;

  final ApiService _apiService;
  final LanguageRepositoryIml _apiLanguage =
      LanguageRepositoryIml(LocalServiceImpl());

  SearchApiService(this._apiService);

  Future<List<GenreMoviesModel>> fetchGenreMovies() async {
    try {
      final language = await _apiLanguage.getSavedLanguage();
      final response = await _apiService.fetchData(ApiResource.genderUrl,
          queryParameters: {'language': language});
      return response.data['genres']
          .map<GenreMoviesModel>((genre) => GenreMoviesModel.fromJson(genre))
          .toList();
    } catch (e) {
      print('Lỗi khi lấy danh sách thể loại: $e');
      return [];
    }
  }

  Future<List<MoviesModel>> fetchListMovies(int idGenre) async {
    try {
      final language = await _apiLanguage.getSavedLanguage();
      final response = await _apiService
          .fetchData(ApiResource.listMovieUrl, queryParameters: {
        'language': language,
        'with_genres': idGenre,
      });

      if (response.statusCode == 200) {
        return response.data['results']
            .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
            .toList();
      } else {
        throw Exception('Không thể tải phim: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi lấy danh sách phim: $e');
      return [];
    }
  }

  Future<List<MoviesModel>> fetchMoviesBySearch(String query) async {
    try {
      final language = await _apiLanguage.getSavedLanguage();
      final response = await _apiService.fetchData(ApiResource.searchMovieUrl,
          queryParameters: {'query': query, 'language': language});
      return response.data['results']
          .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
          .toList();
    } catch (e) {
      print('Lỗi khi lấy danh sách phim theo từ khóa: $e');
      return [];
    }
  }

  Future<List<VideoMovies>> fetchVideoSearch(int movieId) async {
    final language = await _apiLanguage.getSavedLanguage();
    final response = await _apiService
        .fetchData(ApiResource.videoMovieUrl, queryParameters: {
      'movie_id': movieId,
      'language': language,
    });
    return List<VideoMovies>.from(
        response.data['results'].map((json) => VideoMovies.fromJson(json)));
  }
}
