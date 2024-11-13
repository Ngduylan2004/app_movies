import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String LANGUAGE_CODE_KEY = 'language_code';

  LanguageBloc() : super(const LanguageInitial()) {
    // Khởi tạo với ngôn ngữ đã lưu
    _loadSavedLanguage();

    on<LanguageEventChangeLanguage>((event, emit) async {
      // Lưu ngôn ngữ mới

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(LANGUAGE_CODE_KEY, event.locale.languageCode);

      emit(LanguageChanged(locale: event.locale));
    });
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(LANGUAGE_CODE_KEY);
    if (savedLanguage != null) {
      add(LanguageEventChangeLanguage(locale: Locale(savedLanguage)));
    }
  }
}
