part of 'newfeed_bloc.dart';

class NewfeedErrorState extends NewfeedState {
  final String errorMessage;

  NewfeedErrorState({
    required this.errorMessage,
    required List<MoviesEntities> trendingMovies,
    required List<VideoMoviesEntities> videoTrending,
  }) : super(trendingMovies, videoTrending);
}

class NewfeedInitial extends NewfeedState {
  NewfeedInitial() : super([], []);
}

class NewfeedLoaded extends NewfeedState {
  NewfeedLoaded(super.trendingMovies, super.videoTrending);
}

abstract class NewfeedState {
  final List<MoviesEntities> trendingMovies;
  final List<VideoMoviesEntities> videoTrending;

  NewfeedState(this.trendingMovies, this.videoTrending);
}
