import 'package:loop_record_repository_core/loop_record_repository_core.dart';
import 'package:loop_record_app/models/enums.dart';

class AppSettings {
  AudioPlayMode audioPlayMode;
  double volumn;
  double playbackRate;
  bool isDarkMode;

  AppSettings(
      this.audioPlayMode, this.volumn, this.playbackRate, this.isDarkMode);

  factory AppSettings.getDefault() =>
      AppSettings(AudioPlayMode.LOOP, 1.0, 1.0, false);

  @override
  int get hashCode =>
      audioPlayMode.hashCode ^
      volumn.hashCode ^
      playbackRate.hashCode ^
      isDarkMode.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          audioPlayMode == other.audioPlayMode &&
          volumn == other.volumn &&
          playbackRate == other.playbackRate &&
          isDarkMode == other.isDarkMode;

  @override
  String toString() {
    return 'AppSettings{audioPlayMode: $audioPlayMode, volumn: $volumn, playbackRate: $playbackRate, isDarkMode: $isDarkMode}';
  }

  SettingsEntity toEntity() {
    // TODO Update Entity accordingly
    return SettingsEntity(audioPlayMode == AudioPlayMode.LOOP ? true : false,
        volumn, playbackRate, isDarkMode);
  }

  // TODO Update Entity accordingly
  static AppSettings fromEntity(SettingsEntity entity) {
    return AppSettings(entity.toLoop ? AudioPlayMode.LOOP : AudioPlayMode.STOP,
        entity.volumn, entity.playbackRate, entity.isDarkMode);
  }
}
