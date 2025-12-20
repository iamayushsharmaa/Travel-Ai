import 'dart:ui';

class AppLanguage {
  final String label;
  final String flag;
  final Locale locale;

  const AppLanguage({
    required this.label,
    required this.flag,
    required this.locale,
  });
}

const supportedLanguages = [
  AppLanguage(label: 'English', flag: '🇺🇸', locale: Locale('en')),
  AppLanguage(label: 'Hindi', flag: '🇮🇳', locale: Locale('hi')),
];
