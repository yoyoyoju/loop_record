import 'package:loop_record_repository_core/loop_record_repository_core.dart';

/// Set and preserve settings
/// The settings for theme
/// isDarkMode (bool)
class ThemeSettings {
  final bool isDarkMode;

  ThemeSettings([this.isDarkMode = false]);

  @override
  int get hashCode => isDarkMode.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeSettingsEntity &&
          runtimeType == other.runtimeType &&
          isDarkMode == other.isDarkMode;

  @override
  String toString() {
    return 'ThemeSettings{isDarkMode: $isDarkMode}';
  }

  ThemeSettingsEntity toEntity() {
    return ThemeSettingsEntity(isDarkMode);
  }

  static ThemeSettings fromEntity(ThemeSettingsEntity entity) {
    return ThemeSettings(entity.isDarkMode);
  }
}
