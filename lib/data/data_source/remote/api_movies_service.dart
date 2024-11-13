import 'dart:async';

import 'package:app_movies/presentation/language/bloc/language_bloc.dart';

import 'api_service.dart';

class ApiMoviesService {
  static final ApiMoviesService _apiMoviesService =
      ApiMoviesService(ApiService.instance);
  static ApiMoviesService get instance => _apiMoviesService;

  final ApiService _apiService;
  late final LanguageBloc _languageBloc;

  ApiMoviesService(this._apiService);

  // Getter để lấy language code hiện tại
  String get _currentLanguage =>
      _languageBloc.state.locale.languageCode == 'vi' ? 'vi-VN' : 'en-US';

  // Lấy danh sách thể loại phim
  Future<List<dynamic>> fetchGenreMovies() async {
    const String baseUrlGenre = '/genre/movie/list';

    try {
      final response =
          await _apiService.dio.get(baseUrlGenre, queryParameters: {
        'language': _currentLanguage,
      });
      return response.data['genres'] ?? [];
    } catch (e) {
      print('Lỗi khi lấy danh sách thể loại: $e');
      return [];
    }
  }

  // Lấy danh sách phim theo thể loại
  Future<List<dynamic>> fetchListMovies(int idGenre) async {
    const String baseUrl = '/discover/movie';

    try {
      final response = await _apiService.dio.get(baseUrl, queryParameters: {
        'language': _currentLanguage,
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

  // Lấy danh sách phim theo từ khóa tìm kiếm
  Future<List<dynamic>> fetchMoviesBySearch(String query) async {
    const String baseUrlSearching = '/search/movie';

    final response =
        await _apiService.dio.get(baseUrlSearching, queryParameters: {
      'query': query,
      'language': _currentLanguage,
    });

    return response.data['results'] ?? [];
  }

  // Lấy danh sách phim xu hướng
  Future<List<dynamic>> fetchTrendingMovies() async {
    const String baseUrlTrending = '/trending/movie/week';

    try {
      final response =
          await _apiService.dio.get(baseUrlTrending, queryParameters: {
        'language': _currentLanguage,
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
      'language': _currentLanguage,
    });
    return response.data['results'];
  }

  // Method để set LanguageBloc sau khi khởi tạo ch hiểu
  void setLanguageBloc(LanguageBloc bloc) {
    _languageBloc = bloc;
  }
}
