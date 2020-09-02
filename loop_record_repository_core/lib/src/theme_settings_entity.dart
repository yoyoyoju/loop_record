/// Set and preserve settings
/// The settings for theme
/// isDarkMode (bool)
class ThemeSettingsEntity {
  final bool isDarkMode;

  ThemeSettingsEntity(this.isDarkMode);

  @override
  int get hashCode => isDarkMode.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeSettingsEntity &&
          runtimeType == other.runtimeType &&
          isDarkMode == other.isDarkMode;

  Map<String, Object> toJson() {
    return {
      'isDarkMode': isDarkMode,
    };
  }

  @override
  String toString() {
    return 'ThemeSettingsEntity{isDarkMode: $isDarkMode}';
  }

  static ThemeSettingsEntity fromJson(Map<String, Object> json) {
    return ThemeSettingsEntity(
      json['isDarkMode'] as bool,
    );
  }
}
