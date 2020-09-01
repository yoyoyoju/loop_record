import 'dart:async';
import 'settings_entity.dart';

/// A class that Loads and Persists settings data.
abstract class SettingsRepository {
  Future<SettingsEntity> loadSettings();

  Future<bool> saveSettings(SettingsEntity settings);
}
