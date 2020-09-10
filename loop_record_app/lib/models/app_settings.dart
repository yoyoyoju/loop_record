import 'package:loop_record_repository_core/loop_record_repository_core.dart';
import 'package:loop_record_app/models/audio_settings.dart';

class AppSettings {
  AudioSettings audioSettings;
  bool isDarkMode;

  AppSettings(this.audioSettings, this.isDarkMode);

  factory AppSettings.getDefault() =>
      AppSettings(AudioSettings.getDefault(), false);

  @override
  int get hashCode => audioSettings.hashCode ^ isDarkMode.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          audioSettings == other.audioSettings &&
          isDarkMode == other.isDarkMode;

  @override
  String toString() {
    return 'AppSettings{audioSettings: $audioSettings, isDarkMode: $isDarkMode}';
  }

  SettingsEntity toEntity() {
    // TODO Update Entity accordingly
    // Deprecate toLoop in audioSettings
    return SettingsEntity(audioSettings.toLoop, audioSettings.volumn,
        audioSettings.playbackRate, isDarkMode);
  }

  static AppSettings fromEntity(SettingsEntity entity) {
    // TODO Update Entity accordingly
    AudioSettings audioSettings = AudioSettings.fromArgs(
      entity.toLoop,
      entity.volumn,
      entity.playbackRate,
    );
    return AppSettings(audioSettings, entity.isDarkMode);
  }
}

/*
main() {
  AppSettings settings = AppSettings.getDefault();
  print(settings);

  settings.volumn = 0.0;
  print(settings);
}
*/
