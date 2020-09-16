import 'package:flutter/material.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:loop_record_app/widgets/loop_widgets.dart';

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
        TriangleDecoratedText("playing"),
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

class TriangleDecoratedText extends StatelessWidget {
  final String text;

  TriangleDecoratedText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).accentTextTheme.headline4.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).colorScheme.secondary,
      ),
      margin: EdgeInsets.all(30.0),
      padding: EdgeInsets.all(40.0),
    );
  }
}
