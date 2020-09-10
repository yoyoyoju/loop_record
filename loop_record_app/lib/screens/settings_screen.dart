import 'package:flutter/material.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function updateDarkMode;

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
            ExampleRadio(),
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

enum Example { one, two, three }

class ExampleRadio extends StatefulWidget {
  @override
  _ExampleRadioState createState() => _ExampleRadioState();
}

class _ExampleRadioState extends State<ExampleRadio> {
  Example _example = Example.one;

  @override
  Widget build(BuildContext context) {
    return RowSettingItem(
      textLabel: "Radio buttons",
      settingWidget: Flexible(
        child: Column(
          children: <Widget>[
            PlayingModeOption(
                value: Example.one,
                groupValue: _example,
                onChanged: (Example value) {
                  setState(() {
                    _example = value;
                  });
                }),
            PlayingModeOption(
                value: Example.three,
                groupValue: _example,
                onChanged: (Example value) {
                  setState(() {
                    _example = value;
                  });
                }),
            PlayingModeOption(
                value: Example.two,
                groupValue: _example,
                onChanged: (Example value) {
                  setState(() {
                    _example = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}

class PlayingModeOption extends StatelessWidget {
  final Example value;
  final Example groupValue;
  final Function onChanged;

  PlayingModeOption({
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<Example>(
      title: Text(value.toString().split('.')[1]),
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
