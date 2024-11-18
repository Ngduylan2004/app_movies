import 'package:app_movies/core/entities/genre_movies_entities.dart';
import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/entities/video_movies_entities.dart';
import 'package:app_movies/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final SearchRepository searchRepository;
  DetailBloc(this.searchRepository) : super(DetailState([], [], [])) {
    on<DetailEventRelateMovies>(
      (event, emit) async {
        final relateMovies =
            await searchRepository.getMoviesByGenre(event.genreId[0]);
        final relateGenre = await searchRepository.getGenres();

        emit(DetailState(relateMovies, relateGenre, state.videoDetail));
      },
    );
    // on<DetailEventGetVideo>(
    //   (event, emit) async {
    //     final videoList = await searchRepository.getVideoSearch(event.movieId);
    //     // print('ds video:$videoList');
    //     emit(DetailState(state.relatedMovies, state.relatedGenre, videoList));
    //   },
    // );
  }
}
