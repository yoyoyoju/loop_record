// import 'package:loop_record_repository_core/loop_record_repository_core.dart';
import 'package:loop_record_app/models/enums.dart';

class AudioSettings {
  AudioPlayMode audioPlayMode;
  double _volumn;
  double _playbackRate;

  double get volumn => _volumn;
  set volumn(double volumn) {
    _volumn = _checkInput(volumn);
  }

  bool get toLoop => audioPlayMode == AudioPlayMode.LOOP;

  double get playbackRate => _playbackRate;
  set playbackRate(double playbackRate) {
    _playbackRate = _checkInput(playbackRate);
  }

  AudioSettings(
    this.audioPlayMode,
    this._volumn,
    this._playbackRate,
  );

  factory AudioSettings.getDefault() =>
      AudioSettings(AudioPlayMode.LOOP, 1.0, 1.0);

  @override
  int get hashCode =>
      audioPlayMode.hashCode ^ _volumn.hashCode ^ _playbackRate.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioSettings &&
          runtimeType == other.runtimeType &&
          audioPlayMode == other.audioPlayMode &&
          _volumn == other._volumn &&
          _playbackRate == other._playbackRate;

  @override
  String toString() {
    return 'AudioSettings{audioPlayMode: $audioPlayMode, volumn: $_volumn, playbackRate: $_playbackRate}';
  }

  /*
  SettingsEntity toEntity() {
    // TODO Update Entity accordingly
    return SettingsEntity(audioPlayMode == AudioPlayMode.LOOP ? true : false,
        _volumn, _playbackRate, isDarkMode);
  }

  // TODO Update Entity accordingly
  static AudioSettings fromEntity(SettingsEntity entity) {
    return AudioSettings(entity.toLoop ? AudioPlayMode.LOOP : AudioPlayMode.STOP,
        entity.volumn, entity.playbackRate, entity.isDarkMode);
  }
  */

  static AudioSettings fromArgs(
      bool toLoop, double volumn, double playbackRate) {
    return AudioSettings(
        toLoop ? AudioPlayMode.LOOP : AudioPlayMode.STOP, volumn, playbackRate);
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

main() {
  AudioSettings settings = AudioSettings.getDefault();
  print(settings);

  settings.volumn = null;
  print(settings);
}
