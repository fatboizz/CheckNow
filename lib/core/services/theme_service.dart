import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/app_constants.dart';

/// Service managing persistent application light/dark theme preference.
class ThemeService {
  final GetStorage _box = GetStorage();
  final String _key = AppConstants.isDarkModeKey;

  void _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read<bool>(_key) ?? false;

  /// Returns current ThemeMode based on stored preference.
  ThemeMode get theme =>
      _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Toggles theme between Light and Dark mode.
  void switchTheme() {
    final bool nextIsDark = !_loadThemeFromBox();
    Get.changeThemeMode(nextIsDark ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox(nextIsDark);
  }
}
