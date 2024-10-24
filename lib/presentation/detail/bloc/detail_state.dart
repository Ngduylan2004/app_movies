part of 'detail_bloc.dart';

class DetailState {
  final List<MoviesEntities> relatedMovies;
  final List<GenreMoviesEntities> relatedGenre;

  DetailState(this.relatedMovies, this.relatedGenre);
}
