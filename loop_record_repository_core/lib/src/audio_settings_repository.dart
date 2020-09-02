import 'dart:async';
import 'audio_settings_entity.dart';

/// A class that Loads and Persists settings data.
abstract class AudioSettingsRepository {
  Future<AudioSettingsEntity> loadSettings();

  Future<bool> saveSettings(AudioSettingsEntity settings);
}
