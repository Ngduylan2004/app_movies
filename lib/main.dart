import 'package:app_movies/data/data_source/remote/api_movies_service.dart';
import 'package:app_movies/data/repostory/movies_repostory_impl.dart';
import 'package:app_movies/presentation/authen/splash_screen.dart';
import 'package:app_movies/presentation/detail/bloc/detail_bloc.dart'; // Import DetailBloc
import 'package:app_movies/presentation/home/bloc/home_bloc.dart';
import 'package:app_movies/presentation/language/bloc/language_bloc.dart';
import 'package:app_movies/presentation/newFeed/bloc/new_feed_bloc.dart';
import 'package:app_movies/presentation/search/bloc/search_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  // Khởi tạo LanguageBloc trước
  final languageBloc = LanguageBloc();

  // Set LanguageBloc cho ApiMoviesService
  ApiMoviesService.instance.setLanguageBloc(languageBloc);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider.value(value: languageBloc),
      BlocProvider(create: (context) => HomeBloc()),
      BlocProvider(
        create: (context) => SearchBloc(MoviesRepositoryImpl.instance),
      ),
      BlocProvider(
        create: (context) => NewFeedBloc(MoviesRepositoryImpl.instance),
      ),
      BlocProvider(
        create: (context) => DetailBloc(MoviesRepositoryImpl.instance),
      ),
    ],
    child: BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color.fromARGB(255, 254, 123, 0),
              surface: Colors.grey,
            ),
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
          home: const SplashScreen(),
        );
      },
    ),
  ));
}
