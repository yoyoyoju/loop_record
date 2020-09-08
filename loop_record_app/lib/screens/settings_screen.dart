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
  var args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"), //TODO use localization
      ),
      body: Column(children: <Widget>[
        Switch(
          value: widget?.isDarkMode,
          onChanged: (bool changed) {
            widget.updateDarkMode(changed);
          },
        ),
        Text(ModalRoute.of(context).settings.arguments?.toString() ?? "hi"),
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
//    args['callbackForPop']();
    super.dispose();
  }
}
