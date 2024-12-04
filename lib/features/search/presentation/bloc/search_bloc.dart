import 'package:app_movies/core/entities/genre_movies_entities.dart';
import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc(this.searchRepository)
      : super(
            SearchState('', '', [], [], GenreMoviesEntities(id: 0, name: ''))) {
    on<SearchEventLoadMovies>(
      (event, emit) async {
        final categories = await searchRepository.getGenres();
        categories.fold(
          (l) => emit(SearchState(l.message, state.query, [], [],
              GenreMoviesEntities(id: 0, name: ''))),
          (r) {
            final genre = r[0];
            emit(SearchState('', state.query, r, [], genre));
            add(SearchEventLoadMoviesByGenre());
          },
        );
      },
    );
    on<SearchEventLoadMoviesByGenre>((event, emit) async {
      final listMovies =
          await searchRepository.getMoviesByGenre(state.tabCategories.id);
      listMovies.fold(
        (l) => emit(SearchState(
            l.message, state.query, state.categories, [], state.tabCategories)),
        (r) => emit(SearchState(
            '', state.query, state.categories, r, state.tabCategories)),
      );
    });

    on<SearchEventGenreMovies>((event, emit) async {
      final genreMovies = await searchRepository.getGenres();
      genreMovies.fold(
        (l) => emit(SearchState(
            l.message, state.query, [], state.movies, state.tabCategories)),
        (r) => emit(SearchState('', state.query, r, state.movies, r[0])),
      );
    });

    on<SearchEventGenreMoviesTab>((event, emit) async {
      final genreMovies =
          await searchRepository.getMoviesByGenre(event.selectedGenre.id);
      genreMovies.fold(
        (l) => emit(SearchState(
            l.message, state.query, state.categories, [], event.selectedGenre)),
        (r) => emit(SearchState(
            '', state.query, state.categories, r, event.selectedGenre)),
      );
    });

    on<SearchKeyWord>((event, emit) async {
      final searchMovies = await searchRepository.getMovieSearch(event.query);
      searchMovies.fold(
        (l) => emit(SearchState(
            l.message, event.query, state.categories, [], state.tabCategories)),
        (r) => emit(SearchState(
            '', event.query, state.categories, r, state.tabCategories)),
      );
    });
  }
}
