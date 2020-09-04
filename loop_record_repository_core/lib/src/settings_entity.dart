import 'audio_settings_entity.dart';
import 'theme_settings_entity.dart';

class SettingsEntity {
  final AudioSettingsEntity audioSettingsEntity;
  final ThemeSettingsEntity themeSettingsEntity;

  SettingsEntity(this.audioSettingsEntity, this.themeSettingsEntity);

  @override
  int get hashCode =>
      audioSettingsEntity.hashCode ^ themeSettingsEntity.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsEntity &&
          runtimeType == other.runtimeType &&
          audioSettingsEntity == other.audioSettingsEntity &&
          themeSettingsEntity == other.themeSettingsEntity;

  Map<String, Object> toJson() {
    return {
      'audioSettingsEntity': audioSettingsEntity.toJson(),
      'themeSettingsEntity': themeSettingsEntity.toJson(),
    };
  }

  @override
  String toString() {
    return 'SettingsEntity{audioSettingsEntity: $audioSettingsEntity, themeSettingsEntity: $themeSettingsEntity}';
  }

  static SettingsEntity fromJson(Map<String, Object> json) {
    return SettingsEntity(
      json['audioSettingsEntity'] as AudioSettingsEntity,
      json['themeSettingsEntity'] as ThemeSettingsEntity,
    );
  }
}
