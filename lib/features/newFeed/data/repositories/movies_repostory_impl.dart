import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';
import 'package:app_movies/core/model/movies_model.dart';
import 'package:app_movies/core/model/video_movies.dart';
import 'package:app_movies/features/newFeed/data/datasources/remote/api_movie_service.dart';
import 'package:app_movies/features/newFeed/domain/repositories/movies_repostory.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  static final MoviesRepositoryImpl _moviesRepositoryImpl =
      MoviesRepositoryImpl(ApiMoviesService.instance);
  static MoviesRepositoryImpl get instance => _moviesRepositoryImpl;

  final ApiMoviesService _movieService;

  MoviesRepositoryImpl(this._movieService);

  @override
  Future<List<MoviesEntities>> getTrendingMovies() async {
    final trendingData = await _movieService.fetchTrendingMovies();
    return trendingData
        .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
        .toList();
  }

  @override
  Future<List<VideoMoviesEntities>> getVideoMovies(int movieId) async {
    final videos = await _movieService.fetchVideoMovies(movieId);
    return videos
        .map<VideoMovies>((video) => VideoMovies.fromJson(video))
        .toList();
  }
}
