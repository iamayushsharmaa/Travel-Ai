import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('theme_mode');

    return _parseThemeMode(saved);
  }

  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.name);
    state = AsyncData(mode);
  }

  Future<void> toggleTheme() async {
    final current = state.value ?? ThemeMode.light;
    final next = current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    await setTheme(next);
  }

  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      case 'light':
      default:
        return ThemeMode.light;
    }
  }
}

@Riverpod(keepAlive: true)
class LanguageNotifier extends _$LanguageNotifier {
  @override
  Future<Locale> build() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language') ?? 'en';
    return Locale(code);
  }

  Future<void> changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
    state = AsyncData(locale);
  }
}
