import 'package:meta/meta.dart';
import 'package:loop_record_app/models/app_settings.dart';

/// Store the app state
class AppState {
  AppSettings appSettings;

  AppState({
    @required this.appSettings,
  });

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

  bool get isDarkMode => appSettings?.isDarkMode ?? false;

  void updateSettings({isDarkMode}) {
    appSettings.isDarkMode = isDarkMode ?? appSettings.isDarkMode;
  }
}
