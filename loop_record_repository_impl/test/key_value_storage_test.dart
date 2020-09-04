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
    final audioSettings = AudioSettingsEntity(true, 1.0, 1.0);
    final audioSettingsJson =
        '{"$AUDIO_SETTINGS_KEY":{"toLoop":true,"volumn":1.0,"playbackRate":1.0}}';
    final storage = KeyValueStorage('T', store);

    test('Should persist SettingsEntities to the store', () async {
      // Check the settingsJson is okay
      expect(
          json.encode({
            AUDIO_SETTINGS_KEY: audioSettings.toJson(),
          }),
          audioSettingsJson);
      await storage.saveAudioSettings(audioSettings);
      verify(store.setString('T', audioSettingsJson));
    });

    test('Should load SettingsEntity from disk', () async {
      when(store.getString('T')).thenReturn(audioSettingsJson);
      expect(await storage.loadAudioSettings(), audioSettings);
    });
  });

  group('KeyValueStorage for Theme', () {
    final store = MockKeyValueStore();
    final themeSettings = ThemeSettingsEntity(false);
    final themeSettingsJson = '{"$THEME_SETTINGS_KEY":{"isDarkMode":false}}';
    final storage = KeyValueStorage('T', store);

    test('Should persist SettingsEntities to the store', () async {
      // Check the settingsJson is okay
      expect(
          json.encode({
            THEME_SETTINGS_KEY: themeSettings.toJson(),
          }),
          themeSettingsJson);
      await storage.saveThemeSettings(themeSettings);
      verify(store.setString('T', themeSettingsJson));
    });

    test('Should load SettingsEntity from disk', () async {
      when(store.getString('T')).thenReturn(themeSettingsJson);
      expect(await storage.loadThemeSettings(), themeSettings);
    });
  });

  group('KeyValueStorage', () {
    final store = MockKeyValueStore();
    final themeSettings = ThemeSettingsEntity(false);
    final themeSettingsJson = '{"$THEME_SETTINGS_KEY":{"isDarkMode":false}}';
    final audioSettings = AudioSettingsEntity(true, 1.0, 1.0);
    final audioSettingsJson =
        '{"$AUDIO_SETTINGS_KEY":{"toLoop":true,"volumn":1.0,"playbackRate":1.0}}';
    final settings = SettingsEntity(audioSettings, themeSettings);
    final settingsJson =
        '{"$AUDIO_SETTINGS_KEY":{"toLoop":true,"volumn":1.0,"playbackRate":1.0},"$THEME_SETTINGS_KEY":{"isDarkMode":false}}';
    final storage = KeyValueStorage('T', store);

    test('Should persist SettingsEntities to the store', () async {
      // Check the settingsJson is okay
      expect(
          json.encode({
            THEME_SETTINGS_KEY: themeSettings.toJson(),
          }),
          themeSettingsJson);
      await storage.saveSettings(settings);
      verify(store.setString('T', themeSettingsJson));
      verify(store.setString('T', audioSettingsJson));
    });

    test('Should load SettingsEntity from disk', () async {
      when(store.getString('T')).thenReturn(themeSettingsJson);
      expect(await storage.loadSettings(), settings);
    });
  });
}
