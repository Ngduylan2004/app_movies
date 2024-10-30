import 'package:app_movies/domain/entities/movies_entities.dart';
import 'package:app_movies/domain/entities/video_moviesw_entities.dart';
import 'package:app_movies/domain/repostory/movies_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_feed_event.dart';
part 'new_feed_state.dart';

class NewFeedBloc extends Bloc<NewFeedEvent, NewFeedState> {
  final MoviesRepository movieRepository;
  NewFeedBloc(this.movieRepository) : super(NewFeedState([], [])) {
    on<NewFeedEventTreding>(
      (event, emit) async {
        final TrendingMoives = await movieRepository.getTrendingMovies();
        print('id_movie ${TrendingMoives[0]}');
        emit(
          NewFeedState(TrendingMoives, state.videoTrending),
        );
      },
    );
    on<NewFeedEventVideo>(
      (event, emit) async {
        final videoList = await movieRepository.getVideoMovies(889737);
        // print('ds video:$videoList');
        emit(NewFeedState(state.trendingMovies, videoList));
      },
    );
  }
}
