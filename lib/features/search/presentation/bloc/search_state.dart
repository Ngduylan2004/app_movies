// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchFailure extends SearchState {
  SearchFailure(super.errorMessage, super.query, super.categories, super.movies,
      super.tabCategories);
}

class SearchState {
  final String errorMessage;
  final String query;
  final List<GenreMoviesEntities> categories;
  final List<MoviesEntities> movies;
  final GenreMoviesEntities tabCategories;

  SearchState(
    this.errorMessage,
    this.query,
    this.categories,
    this.movies,
    this.tabCategories,
  );
}
