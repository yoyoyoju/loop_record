import 'package:loop_record_repository_core/loop_record_repository_core.dart';

enum AudioPlayingMode {
  LOOP,
  STOP, // STOP and RELEASE (set releaseMode to RELEASE)
  RECORD_ON_COMPLETE,
}

class AppSettings {
  bool toLoop;
  double volumn;
  double playbackRate;
  bool isDarkMode;

  AppSettings(this.toLoop, this.volumn, this.playbackRate, this.isDarkMode);

  factory AppSettings.getDefault() => AppSettings(true, 1.0, 1.0, false);

  @override
  int get hashCode =>
      toLoop.hashCode ^
      volumn.hashCode ^
      playbackRate.hashCode ^
      isDarkMode.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsEntity &&
          runtimeType == other.runtimeType &&
          toLoop == other.toLoop &&
          volumn == other.volumn &&
          playbackRate == other.playbackRate &&
          isDarkMode == other.isDarkMode;

  @override
  String toString() {
    return 'AppSettings{toLoop: $toLoop, volumn: $volumn, playbackRate: $playbackRate, isDarkMode: $isDarkMode}';
  }

  SettingsEntity toEntity() {
    return SettingsEntity(toLoop, volumn, playbackRate, isDarkMode);
  }

  static AppSettings fromEntity(SettingsEntity entity) {
    return AppSettings(
        entity.toLoop, entity.volumn, entity.playbackRate, entity.isDarkMode);
  }
}
