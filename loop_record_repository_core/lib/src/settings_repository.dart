import 'audio_settings_repository.dart';
import 'theme_settings_repository.dart';
import 'settings_entity.dart';

abstract class SettingsRepository
    implements AudioSettingsRepository, ThemeSettingsRepository {
  Future<SettingsEntity> loadSettings();

  Future<bool> saveSettings(SettingsEntity settings);
}
