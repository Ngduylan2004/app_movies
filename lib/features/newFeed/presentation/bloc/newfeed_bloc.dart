import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';
import 'package:app_movies/features/newFeed/domain/repositories/movies_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'newfeed_event.dart';
part 'newfeed_state.dart';

class NewfeedBloc extends Bloc<NewfeedEvent, NewfeedState> {
  final MoviesRepository movieRepository;

  NewfeedBloc(this.movieRepository) : super(NewfeedInitial()) {
    on<NewfeedEventTreding>((event, emit) async {
      {
        final trendingMovies = await movieRepository.getTrendingMovies();
        trendingMovies.fold(
          (l) => emit(NewfeedErrorState(
            errorMessage: l.message,
            trendingMovies: [],
            videoTrending: state.videoTrending,
          )),
          (r) => emit(NewfeedLoaded(r, state.videoTrending)),
        );
      }
    });

    on<NewfeedEventVideo>((event, emit) async {
      {
        final videoList = await movieRepository.getVideoMovies(event.movieId);
        videoList.fold(
          (l) => emit(NewfeedErrorState(
            errorMessage: l.message,
            trendingMovies: state.trendingMovies,
            videoTrending: [],
          )),
          (r) => emit(NewfeedLoaded(state.trendingMovies, r)),
        );
      }
    });
  }
}
