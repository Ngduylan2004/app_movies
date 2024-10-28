import 'package:app_movies/data/repostory/movies_repostory_impl.dart';
import 'package:app_movies/presentation/authen/splash.cree.dart';
import 'package:app_movies/presentation/home/bloc/home_bloc.dart';
import 'package:app_movies/presentation/search/bloc/search_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  // Load the .env file
  await dotenv.load(fileName: ".env");

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => HomeBloc()), // HomeBloc
      BlocProvider(
          create: (context) =>
              SearchBloc(MoviesRepositoryImpl.instance)), // SearchBloc
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  ));
}
