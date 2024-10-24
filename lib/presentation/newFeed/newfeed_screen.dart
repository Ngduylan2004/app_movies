import 'package:app_movies/data/repostory/movies_repostory_impl.dart';
import 'package:app_movies/presentation/newFeed/bloc/new_feed_bloc.dart';
import 'package:app_movies/presentation/newFeed/widget/newfeed_banner_widget.dart';
import 'package:app_movies/presentation/newFeed/widget/newfeed_widget.dart';
import 'package:app_movies/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewfeedScreen extends StatelessWidget {
  const NewfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewFeedBloc(MoviesRepositoryImpl.instance)
        ..add(NewFeedEventTreding()),
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        appBar: AppBar(
          titleSpacing: 28,
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          title: const Padding(
            padding: EdgeInsets.only(top: 53.0),
            child: Row(
              children: [
                Text(
                  'Stream ',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.accentColor,
                  ),
                ),
                Text(
                  'Everywhere',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(
              children: [
                NewfeedBannerWidget(),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Trending',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                NewfeedWidget(), // Thay đổi đây
              ],
            ),
          ),
        ),
      ),
    );
  }
}
