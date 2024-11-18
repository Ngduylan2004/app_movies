part of 'language_bloc.dart';

class LanguageChanged extends LanguageState {
  const LanguageChanged({required super.locale});
}

final class LanguageInitial extends LanguageState {
  const LanguageInitial() : super(locale: const Locale('en'));
}

class LanguageState {
  final Locale locale;
  const LanguageState({required this.locale});
}
