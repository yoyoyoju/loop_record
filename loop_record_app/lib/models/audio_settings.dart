import 'package:loop_record_repository_core/loop_record_repository_core.dart';

class AudioSettings {
  final bool toLoop;
  final double volumn;
  final double playbackRate;

  AudioSettings(this.toLoop, this.volumn, this.playbackRate);

  @override
  int get hashCode => toLoop.hashCode ^ volumn.hashCode ^ playbackRate.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioSettingsEntity &&
          runtimeType == other.runtimeType &&
          toLoop == other.toLoop &&
          volumn == other.volumn &&
          playbackRate == other.playbackRate;

  @override
  String toString() {
    return 'AudioSettingsEntity{toLoop: $toLoop, volumn: $volumn, playbackRate: $playbackRate}';
  }

  AudioSettingsEntity toEntity() {
    return AudioSettingsEntity(toLoop, volumn, playbackRate);
  }

  static AudioSettings fromEntity(AudioSettingsEntity entity) {
    return AudioSettings(entity.toLoop, entity.volumn, entity.playbackRate);
  }
}
