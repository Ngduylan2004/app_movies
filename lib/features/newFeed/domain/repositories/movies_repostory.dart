import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';

abstract class MoviesRepository {
  Future<List<MoviesEntities>> getTrendingMovies();
  Future<List<VideoMoviesEntities>> getVideoMovies(int moiveId);
}
