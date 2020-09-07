class SettingsEntity {
  final bool toLoop;
  final double volumn;
  final double playbackRate;
  final bool isDarkMode;

  SettingsEntity(this.toLoop, this.volumn, this.playbackRate, this.isDarkMode);

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

  Map<String, Object> toJson() {
    return {
      'toLoop': toLoop,
      'volumn': volumn,
      'playbackRate': playbackRate,
      'isDarkMode': isDarkMode,
    };
  }

  @override
  String toString() {
    return 'SettingsEntity{toLoop: $toLoop, volumn: $volumn, playbackRate: $playbackRate, isDarkMode: $isDarkMode}';
  }

  static SettingsEntity fromJson(Map<String, Object> json) {
    return SettingsEntity(
      json['toLoop'] as bool,
      json['volumn'] as double,
      json['playbackRate'] as double,
      json['isDarkMode'] as bool,
    );
  }
}
