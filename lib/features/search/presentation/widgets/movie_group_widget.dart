import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/features/search/presentation/widgets/movie_item_large_widget%20.dart';
import 'package:flutter/material.dart';

class MovieGroupWidget extends StatelessWidget {
  final List<MoviesEntities> listMovie;

  const MovieGroupWidget({super.key, required this.listMovie});

  @override
  Widget build(BuildContext context) {
    // Xác định layout dựa trên số lượng phim trong danh sách
    switch (listMovie.length) {
      case 1:
        return Align(
          alignment: Alignment.centerLeft,
          child: MovieItemLargeWidget(
            isLarge: true,
            image: listMovie[0].backdropPath ?? '',
            name: listMovie[0].title ?? 'Untitled',
            movie: listMovie[0], // Truyền đối tượng phim
          ),
        );

      case 2:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MovieItemLargeWidget(
                isLarge: true,
                image: listMovie[0].backdropPath ?? '',
                name: listMovie[0].title ?? 'Untitled',
                movie: listMovie[0], // Truyền đối tượng phim
              ),
            ),
            const SizedBox(width: 16), // Khoảng cách giữa các ảnh
            Expanded(
              child: MovieItemLargeWidget(
                isLarge: true,
                image: listMovie[1].backdropPath ?? '',
                name: listMovie[1].title ?? 'Untitled',
                movie: listMovie[1], // Truyền đối tượng phim
              ),
            ),
          ],
        );

      case 3:
        return SizedBox(
          width: MediaQuery.of(context).size.width - 32,
          height: 545,
          child: Wrap(
            direction: Axis.vertical,
            spacing: 16,
            children: listMovie.map((movie) {
              return MovieItemLargeWidget(
                isLarge: true,
                image: movie.backdropPath ?? '',
                name: movie.title ?? 'Untitled',
                movie: movie, // Truyền đối tượng phim
              );
            }).toList(),
          ),
        );

      default:
        return SizedBox(
          width: MediaQuery.of(context).size.width - 32,
          height: 545,
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.vertical,
            spacing: 16,
            children: listMovie.map((movie) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 16.0), // Căn lề cho ảnh bên phải
                child: MovieItemLargeWidget(
                  isLarge: listMovie.indexOf(movie) == 0 ||
                      listMovie.indexOf(movie) == 3,
                  image: movie.backdropPath ?? '',
                  name: movie.title ?? 'Untitled',
                  movie: movie, // Truyền đối tượng phim
                ),
              );
            }).toList(),
          ),
        );
    }
  }
}
