import 'package:app_movies/core/entities/genre_movies_entities.dart';
import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';
import 'package:app_movies/core/error/error.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<GenreMoviesEntities>>> getGenres();
  Future<Either<Failure, List<MoviesEntities>>> getMoviesByGenre(int genreId);
  Future<Either<Failure, List<MoviesEntities>>> getMovieSearch(String query);
  Future<Either<Failure, List<VideoMoviesEntities>>> getVideoSearch(
      int movieId);

  // Future<List<MoviesEntities>> searchMovies(String keyword);
}
