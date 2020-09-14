import 'package:flutter/material.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:loop_record_app/strings.dart';

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
        RecordPaint(),
        Text(Strings.RECORDING_TEXT),
        GestureDetector(
          onTap: () => widget.updateTab(_currentTab),
        ),
        RaisedButton(
          child: Text(Strings.STOP_BUTTON),
          onPressed: () => widget.onStopBtn(),
        )
      ],
    );
  }
}

class RecordPaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      child: CustomPaint(
        painter: CirclePainter(),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(200, 200), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
