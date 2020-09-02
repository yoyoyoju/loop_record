import 'dart:async';
import 'theme_settings_entity.dart';

/// A class that Loads and Persists settings data.
abstract class ThemeSettingsRepository {
  Future<ThemeSettingsEntity> loadSettings();

  Future<bool> saveSettings(ThemeSettingsEntity settings);
}
