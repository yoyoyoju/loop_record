import 'dart:convert';

import 'package:key_value_store/key_value_store.dart';
import 'package:loop_record_repository_core/loop_record_repository_core.dart';

/// Loads and saves Settings using a provided KeyValueStore, which works
/// on mobile and web. On mobile, it uses the SharedPreferences package,
/// on web it uses window.localStorage.
class KeyValueStorage implements AudioSettingsRepository {
  final String key;
  final KeyValueStore store;
  final JsonCodec codec;

  const KeyValueStorage(this.key, this.store, [this.codec = json]);

  @override
  Future<AudioSettingsEntity> loadSettings() async {
    final map = codec.decode(store.getString(key))['settings'];
    return AudioSettingsEntity.fromJson(map);
  }

  @override
  Future<bool> saveSettings(AudioSettingsEntity settings) {
    return store.setString(
      key,
      codec.encode({
        'settings': settings.toJson(),
      }),
    );
  }
}
