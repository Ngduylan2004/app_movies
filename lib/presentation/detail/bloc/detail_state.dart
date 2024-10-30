part of 'detail_bloc.dart';

class DetailState {
  final List<MoviesEntities> relatedMovies;
  final List<GenreMoviesEntities> relatedGenre;
  final List<VideoMovieswEntities> videoDetail;

  DetailState(this.relatedMovies, this.relatedGenre, this.videoDetail);
}
