import 'package:key_value_store/key_value_store.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:loop_record_repository_core/loop_record_repository_core.dart';
import 'package:loop_record_repository_impl/loop_record_repository_impl.dart';

import 'dart:convert';

class MockKeyValueStore extends Mock implements KeyValueStore {}

void main() {
  group('KeyValueStorage for Audio', () {
    final store = MockKeyValueStore();
    final settings = SettingsEntity(true, 1.0, 1.0, false);
    final settingsJson =
        '{"$SETTINGS_KEY":{"toLoop":true,"volumn":1.0,"playbackRate":1.0,"isDarkMode":false}}';
    final storage = KeyValueStorage('T', store);

    test('Should persist SettingsEntities to the store', () async {
      // Check the settingsJson is okay
      expect(
          json.encode({
            SETTINGS_KEY: settings.toJson(),
          }),
          settingsJson);
      await storage.saveSettings(settings);
      verify(store.setString('T', settingsJson));
    });

    test('Should load SettingsEntity from disk', () async {
      when(store.getString('T')).thenReturn(settingsJson);
      expect(await storage.loadSettings(), settings);
    });
  });
}
