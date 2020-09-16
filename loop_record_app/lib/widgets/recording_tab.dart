import 'package:flutter/material.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:loop_record_app/strings.dart';
import 'package:loop_record_app/widgets/loop_widgets.dart';

class RecordingTab extends StatefulWidget {
  final Function updateTab;
  final Function onStopBtn;

  RecordingTab({
    @required this.updateTab,
    @required this.onStopBtn,
  });

  @override
  _RecordingTabState createState() => _RecordingTabState();
}

class _RecordingTabState extends State<RecordingTab> {
  final _currentTab = LoopTab.recording;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TwoWidgets(),
        GestureDetector(
          onTap: () => widget.updateTab(_currentTab),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: StopButton(
            () => widget.onStopBtn(),
          ),
        ),
      ],
    );
  }
}
