import 'package:app_movies/core/entities/genre_movies_entities.dart';
import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';
import 'package:app_movies/core/model/genre_movies.dart';
import 'package:app_movies/core/model/movies_model.dart';
import 'package:app_movies/core/model/video_movies.dart';
import 'package:app_movies/features/search/data/datasources/remote/search_api_service.dart';
import 'package:app_movies/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  static final SearchRepositoryImpl _searchRepositoryImpl =
      SearchRepositoryImpl(SearchApiService.instance);
  static SearchRepositoryImpl get instance => _searchRepositoryImpl;

  final SearchApiService _searchApiService;

  SearchRepositoryImpl(this._searchApiService);

  // Lấy danh sách thể loại phim
  @override
  Future<List<GenreMoviesEntities>> getGenres() async {
    final genreData = await _searchApiService.fetchGenreMovies();
    return genreData
        .map<GenreMoviesModel>((genre) => GenreMoviesModel.fromJson(genre))
        .toList();
  }

  // Lấy danh sách phim theo thể loại
  @override
  Future<List<MoviesEntities>> getMoviesByGenre(int genreId) async {
    final moviesData = await _searchApiService.fetchListMovies(genreId);
    return moviesData
        .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
        .toList();
  }

  // Tìm kiếm phim theo từ khóa
  @override
  Future<List<MoviesEntities>> getMovieSearch(String query) async {
    final searchResults = await _searchApiService.fetchMoviesBySearch(query);
    return searchResults
        .map<MoviesModel>((movie) => MoviesModel.fromJson(movie))
        .toList();
  }

  @override
  Future<List<VideoMoviesEntities>> getVideoSearch(int movieId) async {
    final videos = await _searchApiService.fetchVideoSearch(movieId);
    return videos
        .map<VideoMovies>((video) => VideoMovies.fromJson(video))
        .toList();
  }

  // Lấy danh sách phim trending

  // lấy video youtube
}
