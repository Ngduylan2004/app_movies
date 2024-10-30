import 'package:app_movies/domain/entities/genre_movies_entities.dart';
import 'package:app_movies/domain/entities/movies_entities.dart';
import 'package:app_movies/domain/entities/video_moviesw_entities.dart';
import 'package:app_movies/domain/repostory/movies_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final MoviesRepository moviesRepository;
  DetailBloc(this.moviesRepository) : super(DetailState([], [], [])) {
    on<DetailEventRelateMovies>(
      (event, emit) async {
        final relateMovies =
            await moviesRepository.getMoviesByGenre(event.genreId[0]);
        final relateGenre = await moviesRepository.getGenres();

        emit(DetailState(relateMovies, relateGenre, state.videoDetail));
      },
    );
    // on<DetailEventGetVideo>(
    //   (event, emit) async {
    //     final videoList = await moviesRepository.getVideoMovies(event.movieId);
    //     // print('ds video:$videoList');
    //     emit(DetailState(state.relatedMovies, state.relatedGenre, videoList));
    //   },
    // );
  }
}
