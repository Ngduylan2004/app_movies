import 'dart:ui';

import 'package:app_movies/core/language/data/repositories/language_repository_impl.dart';
import 'package:app_movies/core/local/base_service_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageInitial()) {
    on<LanguageEventSwitchLanguage>((event, emit) async {
      final currentLanguage = state.locale.languageCode;
      final newLanguage = currentLanguage == 'en' ? 'vi' : 'en';
      await LanguageRepositoryIml(LocalServiceImpl()).saveLanguage(newLanguage);

      emit(LanguageChanged(locale: Locale(newLanguage)));
    });

    on<LanguageEventStarted>((event, emit) async {
      // Lưu ngôn ngữ mới

      final savedLanguage =
          await LanguageRepositoryIml(LocalServiceImpl()).getSavedLanguage();
      emit(LanguageChanged(locale: Locale(savedLanguage)));
    });
  }
}
//xem lại constructor
