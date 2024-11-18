import 'package:app_movies/core/entities/genre_movies_entities.dart';
import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc(this.searchRepository)
      : super(SearchState('', [], [], GenreMoviesEntities(id: 0, name: ''))) {
    on<SearchEventLoadMovies>(
      (event, emit) async {
        final categories = await searchRepository.getGenres();
        final genre = categories[0];
        emit(SearchState(state.query, categories, [], genre));
        add(SearchEventLoadMoviesByGenre());
      },
    );
    on<SearchEventLoadMoviesByGenre>((event, emit) async {
      final listMovies =
          await searchRepository.getMoviesByGenre(state.tabCategories.id);
      emit(SearchState(
          state.query, state.categories, listMovies, state.tabCategories));
    });

    on<SearchEventGenreMovies>(
      (event, emit) async {
        final genreMovies = await searchRepository.getGenres();
        emit(SearchState(
            state.query, genreMovies, state.movies, genreMovies[0]));
      },
    );

    on<SearchEventGenreMoviesTab>((event, emit) async {
      final genreMovies =
          await searchRepository.getMoviesByGenre(event.selectedGenre.id);

      emit(SearchState(
          state.query, state.categories, genreMovies, event.selectedGenre));
    });
    on<SearchKeyWord>(
      (event, emit) async {
        final searchMovies = await searchRepository.getMovieSearch(event.query);

        emit(SearchState(
            event.query, state.categories, searchMovies, state.tabCategories));
      },
    );
  }
}
