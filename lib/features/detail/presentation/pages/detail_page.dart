import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/core/utils/base_screen.dart';
import 'package:app_movies/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:app_movies/features/detail/presentation/widgets/detailSkeleton.dart';
import 'package:app_movies/features/detail/presentation/widgets/detail_widget.dart';
import 'package:app_movies/features/newFeed/presentation/bloc/newfeed_bloc.dart';
import 'package:app_movies/features/search/data/repositories/search_repository_impl.dart';
import 'package:app_movies/theme.dart';
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
  late final NewfeedBloc _newFeedBloc;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: BlocProvider(
        create: (context) => DetailBloc(SearchRepositoryImpl.instance)
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
                BlocBuilder<NewfeedBloc, NewfeedState>(
                  builder: (context, state) {
                    if (state.videoTrending.isEmpty) {
                      return const DetailSkeleton();
                    }
                    final videoKey = state.videoTrending.first.key ?? '';
                    return GestureDetector(
                      onTap: () => _showDialog(videoKey),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          widget.movie.backdropPath != null
                              ? Image.network(
                                  'https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}',
                                  width: MediaQuery.of(context).size.width,
                                  height: 345,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 345,
                                      color: Colors.grey,
                                      child: const Center(
                                        child: Icon(Icons.error),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 345,
                                  color: Colors.grey,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported),
                                  ),
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .detailGenres,
                                      style: const TextStyle(
                                        color: AppTheme.textColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    BlocBuilder<DetailBloc, DetailState>(
                                      builder: (context, state) {
                                        final filteredGenres = state
                                            .relatedGenre
                                            .where((genre) => widget
                                                .movie.genreIds!
                                                .contains(genre.id))
                                            .toList();

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
                                                color: AppTheme.hintColor),
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 19),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.movie.overview ??
                            AppLocalizations.of(context)!.detailNoSynopsis,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 142, 140, 140)),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.detailRelatedMovies,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 19),
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _newFeedBloc = BlocProvider.of<NewfeedBloc>(context);
    _newFeedBloc.add(NewfeedEventVideo(movieId: widget.movie.id ?? 0));
  }

  void _showDialog(String keyMovie) {
    if (keyMovie.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video available')),
      );
      return;
    }

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
