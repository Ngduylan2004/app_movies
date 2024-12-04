import 'dart:async';

import 'package:app_movies/core/api/api_service.dart';
import 'package:app_movies/core/constants/api_resource.dart';
import 'package:app_movies/core/error/error.dart';
import 'package:app_movies/core/language/data/repositories/language_repository_impl.dart';
import 'package:app_movies/core/local/base_service_local.dart';
import 'package:app_movies/core/model/movies_model.dart';
import 'package:app_movies/core/model/video_movies.dart';
import 'package:dio/dio.dart';
// import 'package:dartz/dartz.dart';

class ApiMoviesService {
  static final ApiMoviesService _apiMoviesService =
      ApiMoviesService(ApiService.instance);
  static ApiMoviesService get instance => _apiMoviesService;

  final ApiService _apiService;
  final LanguageRepositoryIml _apiLanguage =
      LanguageRepositoryIml(LocalServiceImpl());

  ApiMoviesService(this._apiService);

  Future<List<MoviesModel>> fetchTrendingMovies() async {
    final language = await _apiLanguage.getSavedLanguage();
    final response = await _apiService.fetchData(ApiResource.trendingMovieUrl,
        queryParameters: {'language': language});
    return response.data['results']
        .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
        .toList();
  }

  //note: fetchVideoMovies trả về list VideoMoviesEntities
  Future<List<VideoMovies>> fetchVideoMovies(int movieId) async {
    try {
      final language = await _apiLanguage.getSavedLanguage();
      // replace {movieId} with movieId
      //replaceAll là thay thế tất cả các ký tự {movieId} trong chuỗi ApiResource.videoMovieUrl bằng movieId.toString()
      final baseUrlVideo =
          ApiResource.videoMovieUrl.replaceAll('{movieId}', movieId.toString());
      final response = await _apiService
          .fetchData(baseUrlVideo, queryParameters: {'language': language});

      final video = response.data['results']
          .map<VideoMovies>((video) => VideoMovies.fromJson(video))
          .toList();
      return video;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  // Future<Either<Failure, List<VideoModel>>> fetchVideoMovies(int movieId) async {
  //   final language = await _apiLanguage.getSavedLanguage();
  //   String baseUrlVideo = '/movie/$movieId/videos';
  //   final response = await _apiService.fetchData(baseUrlVideo,
  //       queryParameters: {'movie_id': movieId, 'language': language});
  //   return response.data['results'];
  // }
}
