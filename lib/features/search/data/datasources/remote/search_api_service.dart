import 'package:app_movies/core/language/base_api_language.dart';

import '../../../../../core/api/api_service.dart';
import '../../../../../core/constants/api_resource.dart';

class SearchApiService extends BaseApiLanguage {
  static final SearchApiService _searchApiService =
      SearchApiService(ApiService.instance);
  static SearchApiService get instance => _searchApiService;

  final ApiService _apiService;

  SearchApiService(this._apiService) : super(ApiService.instance);

  Future<List<dynamic>> fetchGenreMovies() async {
    try {
      final response =
          await _apiService.dio.get(ApiResource.genderUrl, queryParameters: {
        'language': currentLanguage,
      });
      return response.data['genres'] ?? [];
    } catch (e) {
      print('Lỗi khi lấy danh sách thể loại: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchListMovies(int idGenre) async {
    try {
      final response =
          await _apiService.dio.get(ApiResource.listMovieUrl, queryParameters: {
        'language': currentLanguage,
        'with_genres': idGenre,
      });

      if (response.statusCode == 200) {
        return response.data['results'] ?? [];
      } else {
        throw Exception('Không thể tải phim: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi lấy danh sách phim: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchMoviesBySearch(String query) async {
    try {
      final response = await _apiService.dio
          .get(ApiResource.searchMovieUrl, queryParameters: {
        'query': query,
        'language': currentLanguage,
      });
      return response.data['results'] ?? [];
    } catch (e) {
      print('Lỗi khi lấy danh sách phim theo từ khóa: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchVideoSearch(int movieId) async {
    String baseUrlVideo = '/movie/$movieId/videos';
    final response = await _apiService.dio.get(baseUrlVideo, queryParameters: {
      'movie_id': movieId,
      'language': currentLanguage,
    });
    return response.data['results'];
  }
}
