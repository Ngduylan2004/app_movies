import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';
import 'package:app_movies/core/error/error.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<MoviesEntities>>> getTrendingMovies();
  Future<Either<Failure, List<VideoMoviesEntities>>> getVideoMovies(
      int moiveId);
}
