import 'dart:async';

import 'package:app_movies/core/api/api_service.dart';
import 'package:app_movies/core/language/base_api_language.dart';

class ApiMoviesService extends BaseApiLanguage {
  static final ApiMoviesService _apiMoviesService =
      ApiMoviesService(ApiService.instance);
  static ApiMoviesService get instance => _apiMoviesService;

  final ApiService _apiService;

  ApiMoviesService(this._apiService) : super(ApiService.instance);

  // Lấy danh sách thể loại phim

  // Lấy danh sách phim xu hướng
  Future<List<dynamic>> fetchTrendingMovies() async {
    const String baseUrlTrending = '/trending/movie/week';

    try {
      final response =
          await _apiService.dio.get(baseUrlTrending, queryParameters: {
        'language': currentLanguage,
      });

      if (response.statusCode == 200) {
        return response.data['results'] ?? [];
      } else {
        throw Exception('Không thể tải phim xu hướng: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi lấy danh sách phim xu hướng: $e');
      return [];
    }
  }

  // lấy video movie
  Future<List<dynamic>> fetchVideoMovies(int movieId) async {
    String baseUrlVideo = '/movie/$movieId/videos';
    final response = await _apiService.dio.get(baseUrlVideo, queryParameters: {
      'movie_id': movieId,
      'language': currentLanguage,
    });
    return response.data['results'];
  }

  // Method để set LanguageBloc sau khi khởi tạo ch hiểu
}
