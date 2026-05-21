import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kThemeModeKey = 'theme_mode';
const String _kFontSizeKey = 'font_size';

class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final storedMode = prefs.getString(_kThemeModeKey);

    switch (storedMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> _setMode(ThemeMode mode) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeModeKey, mode.name);
    state = AsyncValue.data(mode);
  }

  Future<void> setLight() => _setMode(ThemeMode.light);
  Future<void> setDark() => _setMode(ThemeMode.dark);
  Future<void> setSystem() => _setMode(ThemeMode.system);
}

final themeNotifierProvider = AsyncNotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

class FontSizeNotifier extends AsyncNotifier<double> {
  @override
  Future<double> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_kFontSizeKey) ?? 16.0;
  }

  Future<void> setFontSize(double fontSize) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kFontSizeKey, fontSize);
    state = AsyncValue.data(fontSize);
  }
}

final fontSizeNotifierProvider =
    AsyncNotifierProvider<FontSizeNotifier, double>(FontSizeNotifier.new);
