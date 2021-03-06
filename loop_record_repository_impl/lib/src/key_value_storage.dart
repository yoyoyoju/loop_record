import 'dart:convert';

import 'package:key_value_store/key_value_store.dart';
import 'package:loop_record_repository_core/loop_record_repository_core.dart';

const SETTINGS_KEY = 'settings';

/// Loads and saves Settings using a provided KeyValueStore, which works
/// on mobile and web. On mobile, it uses the SharedPreferences package,
/// on web it uses window.localStorage.
class KeyValueStorage implements SettingsRepository {
  final String key;
  final KeyValueStore store;
  final JsonCodec codec;

  const KeyValueStorage(this.key, this.store, [this.codec = json]);

  @override
  Future<SettingsEntity> loadSettings() async {
    final map = codec.decode(store.getString(key))[SETTINGS_KEY];
    return SettingsEntity.fromJson(map);
  }

  @override
  Future<bool> saveSettings(SettingsEntity settings) async {
    return store.setString(
      key,
      codec.encode({
        SETTINGS_KEY: settings.toJson(),
      }),
    );
  }
}
