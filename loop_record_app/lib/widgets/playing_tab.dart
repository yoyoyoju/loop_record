import 'package:flutter/material.dart';
import 'package:loop_record_app/models/enums.dart';

class PlayingTab extends StatefulWidget {
  final updateTab;

  PlayingTab({@required this.updateTab});

  @override
  _PlayingTabState createState() => _PlayingTabState();
}

class _PlayingTabState extends State<PlayingTab> {
  final _currentTab = LoopTab.playing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text("Playing"),
        GestureDetector(
          onTap: () => widget.updateTab(_currentTab),
        ),
      ],
    );
  }
}
