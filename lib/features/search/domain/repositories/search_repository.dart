import 'package:app_movies/core/entities/genre_movies_entities.dart';
import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';

abstract class SearchRepository {
  Future<List<GenreMoviesEntities>> getGenres();
  Future<List<MoviesEntities>> getMoviesByGenre(int genreId);
  Future<List<MoviesEntities>> getMovieSearch(String query);
  Future<List<VideoMoviesEntities>> getVideoSearch(int movieId);

  // Future<List<MoviesEntities>> searchMovies(String keyword);
}
