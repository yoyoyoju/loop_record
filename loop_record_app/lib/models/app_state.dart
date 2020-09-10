import 'package:meta/meta.dart';
import 'package:loop_record_app/models/app_settings.dart';
import 'package:loop_record_app/models/enums.dart';

/// Store the app state
class AppState {
  AppSettings appSettings;

  AppState({
    @required appSettings,
  }) : this.appSettings = appSettings ?? AppSettings.getDefault();

  factory AppState.getDefault() => AppState(
        appSettings: AppSettings.getDefault(),
      );

  factory AppState.fromEntity(settingsEntity) => AppState(
        appSettings: AppSettings.fromEntity(settingsEntity),
      );

  @override
  int get hashCode => appSettings.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          appSettings == other.appSettings;

  @override
  String toString() {
    return 'AppState{appSettings: $appSettings}';
  }

  bool get isDarkMode => appSettings.isDarkMode ?? false;
  double get volumn => appSettings.volumn ?? 1.0;
  double get playbackRate => appSettings.playbackRate ?? 1.0;
  AudioPlayMode get audioPlayMode => appSettings.audioPlayMode;

  void updateSettings({
    bool isDarkMode,
  }) {
    appSettings.isDarkMode = isDarkMode ?? appSettings.isDarkMode;
  }

  void updateAudioSettings({
    double volumn,
    double playbackRate,
    AudioPlayMode audioPlayMode,
  }) {
    print("appSettings: $appSettings");
    print("volumn: ${appSettings.volumn}");
    appSettings.volumn = volumn ?? appSettings.volumn;
    appSettings.playbackRate = playbackRate ?? appSettings.playbackRate;
    appSettings.audioPlayMode = audioPlayMode ?? appSettings.audioPlayMode;
  }
}

/*
main() {
  AppState state = AppState.getDefault();
  print(state);

  state.updateAudioSettings(volumn: 3.0);
  print(state);
}
*/
