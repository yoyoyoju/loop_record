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

class TriangleDecoratedText extends StatelessWidget {
  final String text;

  TriangleDecoratedText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: ClipPath(
        clipper: CustomTriangleClipper(),
        child: Container(
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
        ),
      ),
    );
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double x1, x2, x3, y1, y2, y3;
    final double w = size.width;
    final double h = size.height;
    if (size.width > size.height) {
      const ratio = 0.866; // sin(2*pi/3)
      x1 = (w - h * ratio) / 2.0;
      x2 = (w + h * ratio) / 2.0;
      x3 = x1; // (w - h) / 2.0;
      y1 = 0;
      y2 = h / 2.0;
      y3 = h;
    } else {
      const ratio = 1.73;
      x1 = 0;
      x2 = w;
      x3 = 0;
      y1 = h / 2.0 - w * ratio;
      y2 = h / 2.0;
      y3 = h / 2.0 + w * ratio;
    }

    final path = Path();
    path.moveTo(x1, y1);
    path.lineTo(x2, y2);
    path.lineTo(x3, y3);
    path.lineTo(x1, y1);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
