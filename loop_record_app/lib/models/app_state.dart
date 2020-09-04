import 'package:meta/meta.dart';
import 'package:loop_record_app/models/theme_settings.dart';
import 'package:loop_record_app/models/audio_settings.dart';

/// Store the app state
class AppState {
  AudioSettings audioSettings;
  ThemeSettings themeSettings;

  AppState({
    @required this.audioSettings,
    @required this.themeSettings,
  });

  factory AppState.getDefault() => AppState(
        audioSettings: AudioSettings(true, 1.0, 1.0),
        themeSettings: ThemeSettings(false),
      );

  @override
  int get hashCode => audioSettings.hashCode ^ themeSettings.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          audioSettings == other.audioSettings &&
          themeSettings == other.themeSettings;

  @override
  String toString() {
    return 'AppState{audioSettings: $audioSettings, themeSettings: $themeSettings}';
  }
}

main() {
  AppState state = AppState.getDefault();
  print(state);
}
