import 'dart:convert';

import 'package:key_value_store/key_value_store.dart';
import 'package:loop_record_repository_core/loop_record_repository_core.dart';

const AUDIO_SETTINGS_KEY = 'audio_settings';
const THEME_SETTINGS_KEY = 'theme_settings';

/// Loads and saves Settings using a provided KeyValueStore, which works
/// on mobile and web. On mobile, it uses the SharedPreferences package,
/// on web it uses window.localStorage.
class KeyValueStorage implements SettingsRepository {
  final String key;
  final KeyValueStore store;
  final JsonCodec codec;

  const KeyValueStorage(this.key, this.store, [this.codec = json]);

  @override
  Future<AudioSettingsEntity> loadAudioSettings() async {
    final map = codec.decode(store.getString(key))[AUDIO_SETTINGS_KEY];
    return AudioSettingsEntity.fromJson(map);
  }

  @override
  Future<bool> saveAudioSettings(AudioSettingsEntity settings) {
    return store.setString(
      key,
      codec.encode({
        AUDIO_SETTINGS_KEY: settings.toJson(),
      }),
    );
  }

  @override
  Future<ThemeSettingsEntity> loadThemeSettings() async {
    final map = codec.decode(store.getString(key))[THEME_SETTINGS_KEY];
    return ThemeSettingsEntity.fromJson(map);
  }

  @override
  Future<bool> saveThemeSettings(ThemeSettingsEntity settings) {
    return store.setString(
      key,
      codec.encode({
        THEME_SETTINGS_KEY: settings.toJson(),
      }),
    );
  }
}
