import 'package:flutter/material.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function updateDarkMode;
  final Function updateAudioSettings;

  SettingsScreen({
    this.isDarkMode,
    @required this.updateDarkMode,
    @required this.updateAudioSettings, //TODO use it
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DarkModeSwitch(
              value: widget?.isDarkMode,
              onChanged: (bool changed) {
                widget.updateDarkMode(changed);
              },
            ),
            ExampleSlider(),
            AudioPlayModeRadio(widget.updateAudioSettings),
          ],
        ),
      ),
    );
  }
}

class DarkModeSwitch extends StatelessWidget {
  final bool value;
  final Function onChanged;

  DarkModeSwitch({
    @required this.value,
    @required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return RowSettingItem(
      textLabel: "Dark Mode!",
      settingWidget: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class ExampleSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RowSettingItem(
      textLabel: "Slider Example",
      settingWidget: Slider(
        min: 0.1,
        max: 2.0,
        onChanged: (double value) {},
        value: 1.0,
      ),
    );
  }
}

class AudioPlayModeRadio extends StatefulWidget {
  final Function update;

  AudioPlayModeRadio(this.update);

  @override
  _AudioPlayModeRadioState createState() => _AudioPlayModeRadioState();
}

class _AudioPlayModeRadioState extends State<AudioPlayModeRadio> {
  // TODO: get value from repo
  AudioPlayMode _audioPlayMode = AudioPlayMode.LOOP;

  @override
  Widget build(BuildContext context) {
    return RowSettingItem(
      textLabel: "Radio buttons",
      settingWidget: Flexible(
        child: Column(
          children: <Widget>[
            PlayingModeOption(
                value: AudioPlayMode.LOOP,
                groupValue: _audioPlayMode,
                onChanged: (AudioPlayMode value) {
                  setState(() {
                    _audioPlayMode = value;
                    widget.update(audioPlayMode: value);
                  });
                }),
            PlayingModeOption(
                value: AudioPlayMode.STOP,
                groupValue: _audioPlayMode,
                onChanged: (AudioPlayMode value) {
                  setState(() {
                    _audioPlayMode = value;
                    widget.update(audioPlayMode: value);
                  });
                }),
            PlayingModeOption(
                value: AudioPlayMode.RECORD_ON_COMPLETE,
                groupValue: _audioPlayMode,
                onChanged: (AudioPlayMode value) {
                  setState(() {
                    _audioPlayMode = value;
                    widget.update(audioPlayMode: value);
                  });
                }),
          ],
        ),
      ),
    );
  }
}

class PlayingModeOption extends StatelessWidget {
  final AudioPlayMode value;
  final AudioPlayMode groupValue;
  final Function onChanged;

  PlayingModeOption({
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<AudioPlayMode>(
      title: Text(value.description),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}

class RowSettingItem extends StatelessWidget {
  final String textLabel;
  final Widget settingWidget;

  RowSettingItem({
    @required this.textLabel,
    @required this.settingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(textLabel),
        ),
        settingWidget,
      ],
    );
  }
}
