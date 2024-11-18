part of 'newfeed_bloc.dart';

class NewfeedState {
  final List<MoviesEntities> trendingMovies;
  final List<VideoMoviesEntities> videoTrending;

  NewfeedState(this.trendingMovies, this.videoTrending);
}
