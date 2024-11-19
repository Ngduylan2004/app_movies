abstract class LanguageRepostory {
  Future<String> getSavedLanguage();
  Future<bool> saveLanguage(String languageCode);
}
