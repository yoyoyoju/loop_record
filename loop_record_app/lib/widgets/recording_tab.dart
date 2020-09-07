import 'package:flutter/material.dart';
import 'package:loop_record_app/models/enums.dart';

class RecordingTab extends StatefulWidget {
  final updateTab;

  RecordingTab({@required this.updateTab});

  @override
  _RecordingTabState createState() => _RecordingTabState();
}

class _RecordingTabState extends State<RecordingTab> {
  final _currentTab = LoopTab.recording;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text("Recording"),
        GestureDetector(
          onTap: () => widget.updateTab(_currentTab),
        ),
      ],
    );
  }
}
