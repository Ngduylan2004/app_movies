import 'package:app_movies/domain/entities/genre_movies_entities.dart';
import 'package:app_movies/domain/entities/movies_entities.dart';

abstract class MoviesRepository {
  Future<List<GenreMoviesEntities>> getGenres();
  Future<List<MoviesEntities>> getMoviesByGenre(int genreId);
  Future<List<MoviesEntities>> getMovieSearch(String query); // Thêm dòng này
  Future<List<MoviesEntities>> getTrendingMovies();

  // Future<List<MoviesEntities>> searchMovies(String keyword);
}
