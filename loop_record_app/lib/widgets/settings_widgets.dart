import 'package:flutter/material.dart';
import 'package:loop_record_app/strings.dart';
import 'package:loop_record_app/models/enums.dart';

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
      textLabel: Strings.SETTINGS_DARKMODE,
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
          textLabel: Strings.SETTINGS_PLAYRATE,
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
        Text(Strings.SETTINGS_PLAYRATE_COMMENT),
        RaisedButton(
            child: Text(Strings.SETTINGS_PLAYRATE_DEFAULT),
            onPressed: () => setState(() {
                  _playRate = 1.0;
                  widget.update(playbackRate: 1.0);
                })),
      ],
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

// Volume Slider not in use
class VolumeSlider extends StatefulWidget {
  final double initialVolume;
  final Function update;
  VolumeSlider({
    @required this.initialVolume,
    @required this.update,
  });
  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _volume;
  @override
  initState() {
    super.initState();
    _volume = widget.initialVolume;
  }

  @override
  Widget build(BuildContext context) {
    return RowSettingItem(
      textLabel: "Volume",
      settingWidget: Slider(
        min: 0.1,
        max: 2.0,
        onChanged: (double value) {
          setState(() {
            _volume = value;
            widget.update(volumn: value);
          });
        },
        value: _volume,
      ),
    );
  }
}

class PlayModeItem extends StatelessWidget {
  final AudioPlayMode value;
  final AudioPlayMode groupValue;
  final Function onChanged;

  PlayModeItem({
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

Widget getPlayModeItem(
  AudioPlayMode playMode,
  AudioPlayMode groupValue,
  Function onChanged,
) {
  return PlayModeItem(
    value: playMode,
    groupValue: groupValue,
    onChanged: onChanged,
  );
}

List<Widget> getPlayModeItems(
  AudioPlayMode groupValue,
  Function onChanged,
) {
  return AudioPlayMode.values.map((playMode) {
    return getPlayModeItem(
      playMode,
      groupValue,
      onChanged,
    );
  }).toList();
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
        ),
      ),
    );
  }
}
