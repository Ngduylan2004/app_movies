import 'package:app_movies/core/language/domain/repositories/language_repostory.dart';
import 'package:app_movies/core/local/base_service_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageRepositoryIml implements LanguageRepostory {
  final String _LANGUAGE_CODE_KEY = 'language_code';

  // final BaseServiceLocal _localService = LocalServiceImpl();
  final BaseServiceLocal _localService;

  LanguageRepositoryIml(this._localService);
  @override
  Future<String> getSavedLanguage() async {
    final language = await _localService.get(_LANGUAGE_CODE_KEY);
    return language ?? 'en';
  }

  @override
  Future<bool> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_LANGUAGE_CODE_KEY, languageCode);
  }
}

//xem lại logic hoạt động của contructor and language_repository_impl