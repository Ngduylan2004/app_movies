import 'package:app_movies/data/repostory/movies_repostory_impl.dart';
import 'package:app_movies/domain/entities/movies_entities.dart';
import 'package:app_movies/presentation/detail/bloc/detail_bloc.dart';
import 'package:app_movies/presentation/detail/widget/detail_widget.dart';
import 'package:app_movies/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final MoviesEntities movie;

  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailBloc(MoviesRepositoryImpl.instance)
        ..add(DetailEventRelateMovies(movie.genreIds ?? [])),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xff15141F),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                    width: MediaQuery.of(context).size.width,
                    height: 345,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/home/icon/Icon.png',
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            movie.title ?? 'Untitled',
                            style: const TextStyle(
                                color: AppTheme.textColor, fontSize: 24),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '4K',
                          style: TextStyle(
                              color: AppTheme.textColor, fontSize: 16),
                        ),
                        const SizedBox(width: 20)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'VoteCount:',
                              style: TextStyle(
                                  color: AppTheme.textColor, fontSize: 15),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${movie.voteCount ?? 0}',
                              style: const TextStyle(
                                  color: AppTheme.textColor, fontSize: 15),
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 20,
                              color: AppTheme.textColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${movie.voteAverage ?? 0} (IMDb)',
                              style: const TextStyle(
                                  color: AppTheme.textColor, fontSize: 15),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 0.2),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cột chứa ngày phát hành
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Release Date',
                                  style: TextStyle(
                                    color: AppTheme.textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  movie.releaseDate != null
                                      ? DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(movie.releaseDate!))
                                      : 'No release date available',
                                  style: const TextStyle(
                                    color: AppTheme.textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 28),
                            // Cột chứa thể loại phim
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Genres',
                                    style: TextStyle(
                                      color: AppTheme.textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  BlocBuilder<DetailBloc, DetailState>(
                                    builder: (context, state) {
                                      // Lọc các thể loại theo ID từ movie.genreIds
                                      final filteredGenres = state.relatedGenre
                                          .where((genre) => movie.genreIds!
                                              .contains(genre.id))
                                          .toList();

                                      // Kết hợp các thể loại đã lọc thành một chuỗi
                                      final genres = filteredGenres
                                          .map((genre) => genre.name)
                                          .toList()
                                          .join(', ');

                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff15141F),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppTheme
                                                  .hintColor), // Viền cho box
                                        ),
                                        child: Text(
                                          genres.isNotEmpty
                                              ? genres
                                              : 'No genres available',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.hintColor,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(thickness: 0.2),
                    const Text(
                      'Synopsis',
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    Text(
                      movie.overview ?? 'No synopsis available.',
                      style: const TextStyle(color: AppTheme.hintColor),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Related Movies',
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    const SizedBox(height: 16),
                    const DetailWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
