part of 'detail_bloc.dart';

class DetailState {
  final List<MoviesEntities> relatedMovies;
  final List<GenreMoviesEntities> relatedGenre;
  final List<VideoMoviesEntities> videoDetail;

  DetailState(this.relatedMovies, this.relatedGenre, this.videoDetail);
}
