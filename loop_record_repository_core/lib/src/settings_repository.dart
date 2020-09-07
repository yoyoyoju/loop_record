import 'settings_entity.dart';

abstract class SettingsRepository {
  Future<SettingsEntity> loadSettings();

  Future<bool> saveSettings(SettingsEntity settings);
}
