part of 'detail_bloc.dart';

abstract class DetailEvent {}

class DetailEventGetVideo extends DetailEvent {
  final int movieId; // ID của bộ phim

  DetailEventGetVideo(this.movieId);
}

class DetailEventRelateMovies extends DetailEvent {
  final List<int> genreId; // Sửa lại để sử dụng genreId

  DetailEventRelateMovies(this.genreId);
}
