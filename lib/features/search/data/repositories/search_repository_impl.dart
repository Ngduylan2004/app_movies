import 'package:app_movies/core/entities/genre_movies_entities.dart';
import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';
import 'package:app_movies/core/error/error.dart';
import 'package:app_movies/features/search/data/datasources/remote/search_api_service.dart';
import 'package:app_movies/features/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  static final SearchRepositoryImpl _searchRepositoryImpl =
      SearchRepositoryImpl(SearchApiService.instance);
  static SearchRepositoryImpl get instance => _searchRepositoryImpl;

  final SearchApiService _searchApiService;

  SearchRepositoryImpl(this._searchApiService);

  // Lấy danh sách thể loại phim
  @override
  Future<Either<Failure, List<GenreMoviesEntities>>> getGenres() async {
    try {
      final genreData = await _searchApiService.fetchGenreMovies();
      return Right(genreData);
    } catch (e) {
      return Left(ServerFailure(
        message: 'Failed to fetch genres: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  // Lấy danh sách phim theo thể loại
  @override
  Future<Either<Failure, List<MoviesEntities>>> getMoviesByGenre(
      int genreId) async {
    try {
      final moviesData = await _searchApiService.fetchListMovies(genreId);
      return Right(moviesData);
    } catch (e) {
      return Left(e as ServerFailure);
    }
  }

  // Tìm kiếm phim theo từ khóa
  @override
  Future<Either<Failure, List<MoviesEntities>>> getMovieSearch(
      String query) async {
    try {
      final searchResults = await _searchApiService.fetchMoviesBySearch(query);
      return Right(searchResults);
    } catch (e) {
      return Left(e as ServerFailure);
    }
  }

  @override
  Future<Either<Failure, List<VideoMoviesEntities>>> getVideoSearch(
      int movieId) async {
    try {
      final videos = await _searchApiService.fetchVideoSearch(movieId);
      return Right(videos);
    } catch (e) {
      return Left(e as ServerFailure);
    }
  }

  // Lấy danh sách phim trending

  // lấy video youtube
}
