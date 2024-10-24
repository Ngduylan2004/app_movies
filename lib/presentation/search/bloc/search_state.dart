part of 'search_bloc.dart';

class SearchState {
  final String query;
  final List<GenreMoviesEntities> categories;
  final List<MoviesEntities> movies;
  final GenreMoviesEntities tabCategories;

  SearchState(this.query, this.categories, this.movies, this.tabCategories);
}
