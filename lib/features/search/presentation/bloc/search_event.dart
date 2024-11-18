part of 'search_bloc.dart';

sealed class SearchEvent {}

class SearchEventGenreMovies extends SearchEvent {}

class SearchEventGenreMoviesTab extends SearchEvent {
  final GenreMoviesEntities selectedGenre; // ghi chú

  SearchEventGenreMoviesTab(this.selectedGenre);
}

class SearchEventLoadMovies extends SearchEvent {}

class SearchEventLoadMoviesByGenre extends SearchEvent {}

class SearchKeyWord extends SearchEvent {
  final String query;

  SearchKeyWord({required this.query});
}
