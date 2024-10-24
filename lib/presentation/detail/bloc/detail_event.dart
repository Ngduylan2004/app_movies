part of 'detail_bloc.dart';

abstract class DetailEvent {}

class DetailEventRelateMovies extends DetailEvent {
  final List<int> genreId; // Sửa lại để sử dụng genreId

  DetailEventRelateMovies(this.genreId);
}
