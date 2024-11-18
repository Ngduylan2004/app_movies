import 'package:app_movies/core/api/api_service.dart';
import 'package:app_movies/core/language/bloc/language_bloc.dart';

abstract class BaseApiLanguage {
  static LanguageBloc? _languageBloc; // Static field
  final ApiService apiService;

  BaseApiLanguage(this.apiService);

  String get currentLanguage {
    if (_languageBloc == null) {
      throw StateError('LanguageBloc chưa được khởi tạo');
    }
    return _languageBloc!.state.locale.languageCode == 'en' ? 'en-US' : 'vi-VN';
  }

  // Static method để set language bloc
  static void setLanguageBloc(LanguageBloc bloc) {
    _languageBloc = bloc;
  }
}
