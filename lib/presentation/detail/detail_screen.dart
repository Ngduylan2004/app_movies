import 'package:app_movies/data/repostory/movies_repostory_impl.dart';
import 'package:app_movies/domain/entities/movies_entities.dart';
import 'package:app_movies/presentation/detail/bloc/detail_bloc.dart';
import 'package:app_movies/presentation/detail/widget/detailSkeleton.dart';
import 'package:app_movies/presentation/detail/widget/detail_widget.dart';
import 'package:app_movies/presentation/newFeed/bloc/new_feed_bloc.dart'; // Import NewFeedBloc
import 'package:app_movies/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulWidget {
  final MoviesEntities movie;

  const DetailPage({super.key, required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final NewFeedBloc _newFeedBloc; // Declare NewFeedBloc

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailBloc(MoviesRepositoryImpl.instance)
        ..add(DetailEventRelateMovies(widget.movie.genreIds ?? [])),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xff15141F),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.amber),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<NewFeedBloc, NewFeedState>(
                builder: (context, state) {
                  if (state.videoTrending.isEmpty) {
                    return DetailSkeleton();
                  }
                  final videoKey = state.videoTrending.first.key ?? '';
                  print('key video {$videoKey}');
                  return GestureDetector(
                    onTap: () => _showDialog(videoKey), // Show dialog on tap
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}',
                          width: MediaQuery.of(context).size.width,
                          height: 345,
                          fit: BoxFit.cover,
                        ),
                        const Icon(
                          Icons.play_circle_fill,
                          size: 50,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  );
                },
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
                            widget.movie.title ??
                                AppLocalizations.of(context)!.detailUntitled,
                            style: const TextStyle(
                                color: AppTheme.textColor, fontSize: 24),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          AppLocalizations.of(context)!.detail4K,
                          style: const TextStyle(
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
                            Text(
                              AppLocalizations.of(context)!.detailVoteCount,
                              style: const TextStyle(
                                  color: AppTheme.textColor, fontSize: 15),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${widget.movie.voteCount ?? 0}',
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
                              '${widget.movie.voteAverage ?? 0} (IMDb)',
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
                                Text(
                                  AppLocalizations.of(context)!
                                      .detailReleaseDate,
                                  style: const TextStyle(
                                    color: AppTheme.textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.movie.releaseDate != null
                                      ? DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(
                                              widget.movie.releaseDate!))
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
                                  Text(
                                    AppLocalizations.of(context)!.detailGenres,
                                    style: const TextStyle(
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
                                          .where((genre) => widget
                                              .movie.genreIds!
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
                                              : AppLocalizations.of(context)!
                                                  .detailNoGenres,
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
                    Text(
                      AppLocalizations.of(context)!.detailSynopsis,
                      style: const TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    Text(
                      widget.movie.overview ??
                          AppLocalizations.of(context)!.detailNoSynopsis,
                      style: const TextStyle(color: AppTheme.hintColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.detailRelatedMovies,
                      style: const TextStyle(color: Colors.white, fontSize: 19),
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

  @override
  void initState() {
    super.initState();
    _newFeedBloc = BlocProvider.of<NewFeedBloc>(context);
    _newFeedBloc.add(NewFeedEventVideo(movieId: widget.movie.id ?? 0));
  }

  void _showDialog(String keyMovie) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                child: YoutubePlayer(
                  aspectRatio: 16 / 20,
                  showVideoProgressIndicator: true,
                  controller: YoutubePlayerController(
                      initialVideoId: keyMovie,
                      flags: const YoutubePlayerFlags(
                        mute: true,
                        autoPlay: false,
                        controlsVisibleAtStart: true,
                      )),
                ),
              ),
            ),
          );
        });
  }
}
