import 'package:flutter/material.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:loop_record_app/widgets/loop_widgets.dart';
import 'package:loop_record_app/strings.dart';

class PlayingTab extends StatefulWidget {
  final Function updateTab;
  final Function onStopBtn;

  PlayingTab({
    @required this.updateTab,
    @required this.onStopBtn,
  });

  @override
  _PlayingTabState createState() => _PlayingTabState();
}

class _PlayingTabState extends State<PlayingTab> {
  final _currentTab = LoopTab.playing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InstructionWidget(
          TriangleDecoratedText(Strings.PLAYING_TEXT),
          Strings.PLAYING_INSTRUCTION,
        ),
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
