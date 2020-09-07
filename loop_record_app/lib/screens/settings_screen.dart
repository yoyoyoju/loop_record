import 'package:flutter/material.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';

class SettingsScreen extends StatefulWidget {
  final isDarkMode;
  final updateDarkMode;

  SettingsScreen({
    this.isDarkMode,
    this.updateDarkMode,
  }) : super(key: LoopRecordKeys.settingsScreen);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"), //TODO use localization
      ),
      body: Switch(
        value: widget?.isDarkMode,
        onChanged: (bool changed) {
          widget.updateDarkMode(changed);
        },
      ),
    );
  }
}
