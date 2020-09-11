import 'package:flutter/material.dart';
import 'package:loop_record_app/strings.dart';
import 'package:loop_record_app/models/audio_settings.dart';
import 'package:loop_record_app/models/enums.dart';
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

class AudioPlayModeRadio extends StatefulWidget {
  final Function update;
  final AudioPlayMode currentMode;

  AudioPlayModeRadio({@required this.update, this.currentMode});

  @override
  _AudioPlayModeRadioState createState() => _AudioPlayModeRadioState();
}

class _AudioPlayModeRadioState extends State<AudioPlayModeRadio> {
  AudioPlayMode _audioPlayMode;

  @override
  void initState() {
    super.initState();
    _audioPlayMode = widget.currentMode ?? AudioPlayMode.LOOP;
  }

  @override
  Widget build(BuildContext context) {
    return RowSettingItem(
      textLabel: "Radio buttons",
      settingWidget: Flexible(
        child: Column(
          children: getPlayModeItems(_audioPlayMode, (AudioPlayMode value) {
            setState(() {
              _audioPlayMode = value;
              widget.update(audioPlayMode: value);
            });
          }),
          /*
          <Widget>[
            PlayModeItem(
                value: AudioPlayMode.LOOP,
                groupValue: _audioPlayMode,
                onChanged: (AudioPlayMode value) {
                  setState(() {
                    _audioPlayMode = value;
                    widget.update(audioPlayMode: value);
                  });
                }),
            PlayModeItem(
                value: AudioPlayMode.STOP,
                groupValue: _audioPlayMode,
                onChanged: (AudioPlayMode value) {
                  setState(() {
                    _audioPlayMode = value;
                    widget.update(audioPlayMode: value);
                  });
                }),
            PlayModeItem(
                value: AudioPlayMode.RECORD_ON_COMPLETE,
                groupValue: _audioPlayMode,
                onChanged: (AudioPlayMode value) {
                  setState(() {
                    _audioPlayMode = value;
                    widget.update(audioPlayMode: value);
                  });
                }),
          ],
          */
        ),
      ),
    );
  }
}
