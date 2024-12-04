import 'package:app_movies/core/language/presentation/bloc/language_bloc.dart';
import 'package:app_movies/core/utils/bloc/base_screen_internet_bloc.dart';
import 'package:app_movies/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:app_movies/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_movies/features/newFeed/data/repositories/movies_repostory_impl.dart';
import 'package:app_movies/features/newFeed/presentation/bloc/newfeed_bloc.dart';
import 'package:app_movies/features/search/data/repositories/search_repository_impl.dart';
import 'package:app_movies/features/search/presentation/bloc/search_bloc.dart';
import 'package:app_movies/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => HomeBloc()),
      BlocProvider(
        create: (context) => SearchBloc(SearchRepositoryImpl.instance),
      ),
      BlocProvider(
        create: (context) => NewfeedBloc(MoviesRepositoryImpl.instance),
      ),
      BlocProvider(
        create: (context) => DetailBloc(SearchRepositoryImpl.instance),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => LanguageBloc()..add(LanguageEventStarted()),
      ),
      BlocProvider<BaseScreenInternetBloc>(
        create: (context) =>
            BaseScreenInternetBloc(InternetConnectionChecker()),
      ),
    ],
    child: BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
              // colorScheme: ColorScheme.fromSwatch().copyWith(
              //   primary: const Color.fromARGB(255, 254, 123, 0),
              //   surface: Colors.grey,
              // ),
              ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
          debugShowCheckedModeBanner: false,
          locale: state.locale,
          home: const SplashPage(),
        );
      },
    ),
  ));
}
