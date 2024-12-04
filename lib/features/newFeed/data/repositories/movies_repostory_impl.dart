import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';
import 'package:app_movies/core/error/error.dart';
import 'package:app_movies/features/newFeed/data/datasources/remote/api_movie_service.dart';
import 'package:app_movies/features/newFeed/domain/repositories/movies_repostory.dart';
import 'package:dartz/dartz.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  static final MoviesRepositoryImpl _moviesRepositoryImpl =
      MoviesRepositoryImpl(ApiMoviesService.instance);
  static MoviesRepositoryImpl get instance => _moviesRepositoryImpl;

  final ApiMoviesService _movieService;

  MoviesRepositoryImpl(this._movieService);

  @override
  Future<Either<Failure, List<MoviesEntities>>> getTrendingMovies() async {
    try {
      final trendingData = await _movieService.fetchTrendingMovies();
      return Right(trendingData);
    } catch (e) {
      return Left(e as ServerFailure); // Đơn giản chỉ đóng gói lỗi vào Left
    }
  }

  @override
  Future<Either<Failure, List<VideoMoviesEntities>>> getVideoMovies(
      int movieId) async {
    try {
      final videos = await _movieService.fetchVideoMovies(movieId);
      return Right(videos);
    } catch (e) {
      return Left(e as ServerFailure); // Đơn giản chỉ đóng gói lỗi vào Left
    }
  }
}
