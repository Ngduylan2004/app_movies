import 'package:app_movies/domain/entities/genre_movies_entities.dart';
import 'package:app_movies/domain/entities/movies_entities.dart';
import 'package:app_movies/domain/repostory/movies_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MoviesRepository movieRepository;

  SearchBloc(this.movieRepository)
      : super(SearchState('', [], [], GenreMoviesEntities(id: 0, name: ''))) {
    on<SearchEventLoadMovies>(
      (event, emit) async {
        final categories = await movieRepository.getGenres();
        final genre = categories[0];
        emit(SearchState(state.query, categories, [], genre));
        add(SearchEventLoadMoviesByGenre());
      },
    );
    on<SearchEventLoadMoviesByGenre>((event, emit) async {
      final listMovies =
          await movieRepository.getMoviesByGenre(state.tabCategories.id);
      emit(SearchState(
          state.query, state.categories, listMovies, state.tabCategories));
    });

    on<SearchEventGenreMovies>(
      (event, emit) async {
        final genreMovies = await movieRepository.getGenres();
        emit(SearchState(
            state.query, genreMovies, state.movies, genreMovies[0]));
      },
    );

    on<SearchEventGenreMoviesTab>((event, emit) async {
      final genreMovies =
          await movieRepository.getMoviesByGenre(event.selectedGenre.id);

      emit(SearchState(
          state.query, state.categories, genreMovies, event.selectedGenre));
    });
    on<SearchKeyWord>(
      (event, emit) async {
        final searchMovies = await movieRepository.getMovieSearch(event.query);

        emit(SearchState(
            event.query, state.categories, searchMovies, state.tabCategories));
      },
    );
  }
}
