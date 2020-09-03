import 'dart:async';
import 'theme_settings_entity.dart';

/// A class that Loads and Persists settings data.
abstract class ThemeSettingsRepository {
  Future<ThemeSettingsEntity> loadThemeSettings();

  Future<bool> saveThemeSettings(ThemeSettingsEntity settings);
}
