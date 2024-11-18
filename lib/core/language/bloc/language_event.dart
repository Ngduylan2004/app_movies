part of 'language_bloc.dart';

class LanguageEvent {}

class LanguageEventChangeLanguage extends LanguageEvent {
  final Locale locale;
  LanguageEventChangeLanguage({required this.locale});
}
