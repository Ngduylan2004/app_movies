import 'package:app_movies/data/repostory/movies_repostory_impl.dart';
import 'package:app_movies/presentation/authen/sign_in/bloc/sign_in_bloc.dart';
import 'package:app_movies/presentation/authen/sign_in/login_screen.dart';
import 'package:app_movies/presentation/language/bloc/language_bloc.dart';
import 'package:app_movies/presentation/newFeed/bloc/new_feed_bloc.dart';
import 'package:app_movies/presentation/newFeed/widget/newfeed_banner_widget.dart';
import 'package:app_movies/presentation/newFeed/widget/newfeed_widget.dart';
import 'package:app_movies/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewfeedScreen extends StatelessWidget {
  const NewfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewFeedBloc(MoviesRepositoryImpl.instance)
        ..add(NewFeedEventTreding())
        ..add(NewFeedEventVideo(movieId: 889737)),
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          titleSpacing: 28,
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.newFeed,
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.accentColor,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.newFeedSubtitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  BlocProvider(
                    create: (context) => SignInBloc(),
                    child: BlocConsumer<SignInBloc, SignInState>(
                      listener: (context, state) {
                        if (state is SignoutSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        } else if (state is SignInFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 40.0, right: 5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              context.read<SignInBloc>().add(SignOutEvent());
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.language,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        context.read<LanguageBloc>().add(
                            LanguageEventChangeLanguage(
                                locale: context
                                            .read<LanguageBloc>()
                                            .state
                                            .locale
                                            .languageCode ==
                                        'en'
                                    ? const Locale('vi')
                                    : const Locale('en')));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: BlocBuilder<NewFeedBloc, NewFeedState>(builder: (context, state) {
          if (state.trendingMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const NewfeedBannerWidget(),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.newFeed,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 29,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const NewfeedWidget(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
