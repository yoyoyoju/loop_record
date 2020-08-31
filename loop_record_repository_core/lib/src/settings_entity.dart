/// Set and preserve settings
/// The settings for audio play such as
/// Volumne (double)
/// PlaybackRate (double)
/// Loop the play or not
class SettingsEntity {
  final bool toLoop;
  final double volumn;
  final double playbackRate;

  SettingsEntity(this.toLoop, this.volumn, this.playbackRate);

  @override
  int get hashCode => toLoop.hashCode ^ volumn.hashCode ^ playbackRate.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsEntity &&
          runtimeType == other.runtimeType &&
          toLoop == other.toLoop &&
          volumn == other.volumn &&
          playbackRate == other.playbackRate;

  Map<String, Object> toJson() {
    return {
      'toLoop': toLoop,
      'volumn': volumn,
      'playbackRate': playbackRate,
    };
  }

  @override
  String toString() {
    return 'SettingsEntity{toLoop: $toLoop, volumn: $volumn, playbackRate: $playbackRate}';
  }

  static SettingsEntity fromJson(Map<String, Object> json) {
    return SettingsEntity(
      json['toLoop'] as bool,
      json['volumn'] as double,
      json['playbackRate'] as double,
    );
  }
}
