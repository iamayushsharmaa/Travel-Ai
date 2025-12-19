import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    _loadSavedTheme();
    return ThemeMode.light;
  }

  void setTheme(ThemeMode mode) {
    state = mode;
    _saveTheme(mode);
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newMode;
    _saveTheme(newMode);
  }

  bool get isDarkMode => state == ThemeMode.dark;

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.toString());
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme_mode');
    state = _parseThemeMode(savedTheme);
  }

  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}

@Riverpod(keepAlive: true)
class LanguageNotifier extends _$LanguageNotifier {
  @override
  String build() {
    _loadSavedLanguage();
    return 'English';
  }

  void changeLanguage(String language) {
    state = language;
    _saveLanguage(language);
  }

  Future<void> _saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('language') ?? 'English';
  }

  Locale getLocaleFromLanguage(String language) {
    switch (language) {
      case 'Spanish':
        return const Locale('es');
      case 'Hindi':
        return const Locale('hi');
      default:
        return const Locale('en');
    }
  }
}

@riverpod
bool isDarkMode(IsDarkModeRef ref) {
  final themeMode = ref.watch(themeModeNotifierProvider);
  return themeMode == ThemeMode.dark;
}

@riverpod
Locale currentLocale(CurrentLocaleRef ref) {
  final language = ref.watch(languageNotifierProvider);
  return ref
      .read(languageNotifierProvider.notifier)
      .getLocaleFromLanguage(language);
}
