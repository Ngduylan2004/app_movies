import 'package:app_movies/data/data_source/remote/api_movies_service.dart';
import 'package:app_movies/data/model/genre_movies.dart';
import 'package:app_movies/data/model/movies_model.dart';
import 'package:app_movies/domain/entities/genre_movies_entities.dart';
import 'package:app_movies/domain/entities/movies_entities.dart';
import 'package:app_movies/domain/repostory/movies_repostory.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  static final MoviesRepositoryImpl _moviesRepositoryImpl =
      MoviesRepositoryImpl(ApiMoviesService.instance);
  static MoviesRepositoryImpl get instance => _moviesRepositoryImpl;

  final ApiMoviesService _movieService;

  MoviesRepositoryImpl(this._movieService);

  // Lấy danh sách thể loại phim
  @override
  Future<List<GenreMoviesEntities>> getGenres() async {
    final genreData = await _movieService.fetchGenreMovies();
    return genreData
        .map<GenreMoviesModel>((genre) => GenreMoviesModel.fromJson(genre))
        .toList();
  }

  // Lấy danh sách phim theo thể loại
  @override
  Future<List<MoviesEntities>> getMoviesByGenre(int genreId) async {
    final moviesData = await _movieService.fetchListMovies(genreId);
    return moviesData
        .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
        .toList();
  }

  // Tìm kiếm phim theo từ khóa
  @override
  Future<List<MoviesEntities>> getMovieSearch(String query) async {
    final searchResults = await _movieService.fetchMoviesBySearch(query);
    return searchResults
        .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
        .toList();
  }

  // Lấy danh sách phim trending
  @override
  Future<List<MoviesEntities>> getTrendingMovies() async {
    final trendingData = await _movieService.fetchTrendingMovies();
    return trendingData
        .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
        .toList();
  }
}
