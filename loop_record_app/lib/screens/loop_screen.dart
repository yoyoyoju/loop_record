import 'package:flutter/material.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';
import 'package:loop_record_app/models.dart';
import 'package:loop_record_app/widgets/extra_actions_button.dart';

class LoopScreen extends StatefulWidget {
  LoopScreen() : super(key: LoopRecordKeys.loopScreen);

  @override
  _LoopScreenState createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> {
  LoopTab activeTab = LoopTab.recording;

  void _updateTab(LoopTab tab) {
    setState(() {
      activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loop Screen'), //TODO use localization
        actions: [
          ExtraActionsButton(
            onSelected: (action) {
              if (action == ExtraAction.settings) {
                _goToSettings();
              }
            },
          ),
        ],
      ),
      body:
          activeTab == LoopTab.recording ? Text("recording") : Text("playing"),
    );
  }

  void _goToSettings() {
    //TODO pause playing and recording
    Navigator.pushNamed(context, LoopRecordRoutes.settings);
  }
}
