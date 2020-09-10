import 'package:loop_record_repository_core/loop_record_repository_core.dart';
import 'package:loop_record_app/models/enums.dart';

class AppSettings {
  AudioPlayMode audioPlayMode;
  double _volumn;
  double _playbackRate;
  bool isDarkMode;

  double get volumn => _volumn;
  set volumn(double volumn) {
    _volumn = _checkInput(volumn);
  }

  double get playbackRate => _playbackRate;
  set playbackRate(double playbackRate) {
    _playbackRate = _checkInput(playbackRate);
  }

  AppSettings(
      this.audioPlayMode, this._volumn, this._playbackRate, this.isDarkMode);

  factory AppSettings.getDefault() =>
      AppSettings(AudioPlayMode.LOOP, 1.0, 1.0, false);

  @override
  int get hashCode =>
      audioPlayMode.hashCode ^
      _volumn.hashCode ^
      _playbackRate.hashCode ^
      isDarkMode.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          audioPlayMode == other.audioPlayMode &&
          _volumn == other._volumn &&
          _playbackRate == other._playbackRate &&
          isDarkMode == other.isDarkMode;

  @override
  String toString() {
    return 'AppSettings{audioPlayMode: $audioPlayMode, volumn: $_volumn, playbackRate: $_playbackRate, isDarkMode: $isDarkMode}';
  }

  SettingsEntity toEntity() {
    // TODO Update Entity accordingly
    return SettingsEntity(audioPlayMode == AudioPlayMode.LOOP ? true : false,
        _volumn, _playbackRate, isDarkMode);
  }

  // TODO Update Entity accordingly
  static AppSettings fromEntity(SettingsEntity entity) {
    return AppSettings(entity.toLoop ? AudioPlayMode.LOOP : AudioPlayMode.STOP,
        entity.volumn, entity.playbackRate, entity.isDarkMode);
  }

  double _checkInput(double input,
      {double max = 2.0, double min = 0.1, double defaultValue = 1.0}) {
    if (input == null) return defaultValue;
    var checked;
    if (input > max) {
      checked = max;
    } else if (input < min) {
      checked = min;
    } else {
      checked = input;
    }
    return checked;
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
