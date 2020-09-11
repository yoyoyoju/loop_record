import 'package:flutter/material.dart';
import 'package:loop_record_app/models/audio_settings.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';

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
        title: Text("Settings"), //TODO use localization
      ),
      body: ListView(
        children: <Widget>[
          DarkModeSwitch(
            value: widget?.isDarkMode,
            onChanged: (bool changed) {
              widget.updateDarkMode(changed);
            },
          ),
          PlayRateSlider(
            update: widget.updateAudioSettings,
            initialPlayRate: widget.audioSettings.playbackRate,
          ),
          AudioPlayModeRadio(
            update: widget.updateAudioSettings,
            currentMode: widget.audioSettings.audioPlayMode,
          ),
        ],
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

class PlayRateSlider extends StatefulWidget {
  final double initialPlayRate;
  final Function update;

  PlayRateSlider({
    @required this.initialPlayRate,
    @required this.update,
  });

  @override
  _PlayRateSliderState createState() => _PlayRateSliderState();
}

class _PlayRateSliderState extends State<PlayRateSlider> {
  double _playRate;

  @override
  initState() {
    super.initState();
    _playRate = widget.initialPlayRate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RowSettingItem(
          textLabel: "Audio Playback Rate",
          settingWidget: Slider(
            min: 0.1,
            max: 2.0,
            onChanged: (double value) {
              setState(() {
                _playRate = value;
                widget.update(playbackRate: value);
              });
            },
            value: _playRate,
          ),
        ),
        RaisedButton(
            child: Text("Set default playback rate"),
            onPressed: () => setState(() {
                  _playRate = 1.0;
                  widget.update(playbackRate: 1.0);
                })),
      ],
    );
  }
}

class VolumnSlider extends StatefulWidget {
  final double initialVolumn;
  final Function update;
  VolumnSlider({
    @required this.initialVolumn,
    @required this.update,
  });
  @override
  _VolumnSliderState createState() => _VolumnSliderState();
}

class _VolumnSliderState extends State<VolumnSlider> {
  double _volumn;

  @override
  initState() {
    super.initState();
    _volumn = widget.initialVolumn;
  }

  @override
  Widget build(BuildContext context) {
    return RowSettingItem(
      textLabel: "Volumn",
      settingWidget: Slider(
        min: 0.1,
        max: 2.0,
        onChanged: (double value) {
          setState(() {
            _volumn = value;
            widget.update(volumn: value);
          });
        },
        value: _volumn,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(textLabel),
        ),
        settingWidget,
      ],
    );
  }
}
