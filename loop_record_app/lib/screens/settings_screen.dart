import 'package:flutter/material.dart';
import 'package:loop_record_app/strings.dart';
import 'package:loop_record_app/models/audio_settings.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';
import 'package:loop_record_app/widgets/settings_widgets.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function updateDarkMode;
  final Function updateAudioSettings;
  final AudioSettings audioSettings;

  SettingsScreen({
    this.isDarkMode,
    @required this.updateDarkMode,
    @required this.updateAudioSettings, //TODO use it
    @required this.audioSettings,
  }) : super(key: LoopRecordKeys.settingsScreen);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.SETTINGS_TITLE),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          DarkModeSwitch(
            value: widget?.isDarkMode,
            onChanged: (bool changed) {
              widget.updateDarkMode(changed);
            },
          ),
          SizedBox(height: 50.0),
          PlayRateSlider(
            update: widget.updateAudioSettings,
            initialPlayRate: widget.audioSettings.playbackRate,
          ),
          SizedBox(height: 50.0),
          AudioPlayModeRadio(
            update: widget.updateAudioSettings,
            currentMode: widget.audioSettings.audioPlayMode,
          ),
        ],
      ),
    );
  }
}
