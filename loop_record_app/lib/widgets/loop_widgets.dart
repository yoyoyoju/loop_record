import 'package:flutter/material.dart';
import 'package:loop_record_app/strings.dart';

class InstructionWidget extends StatelessWidget {
  final Widget one;
  final String instructionText;

  InstructionWidget(this.one, this.instructionText);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var direction =
        orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal;
    var textAlignment = orientation == Orientation.portrait
        ? Alignment.topCenter
        : Alignment.center;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Flex(
        direction: direction,
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: one,
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: textAlignment,
              child: Text(
                instructionText,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleDecoratedText extends StatelessWidget {
  final String text;

  CircleDecoratedText([this.text = Strings.RECORDING_TEXT]);

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
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondary,
      ),
      margin: EdgeInsets.all(30.0),
      padding: EdgeInsets.all(40.0),
    );
  }
}

class StopButton extends StatelessWidget {
  final Function onStopBtn;

  StopButton(this.onStopBtn);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: OutlineButton(
        onPressed: () => onStopBtn(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            Strings.STOP_BUTTON,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
      ),
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
    const adjustment = 10.0;
    if (size.width > size.height) {
      const ratio = 0.866; // sin(2*pi/3)
      x1 = (w - h * ratio) / 2.0 + adjustment;
      x2 = (w + h * ratio) / 2.0 + adjustment;
      x3 = x1; // (w - h) / 2.0;
      y1 = 0;
      y2 = h / 2.0;
      y3 = h;
    } else {
      const ratio = 1.73;
      x1 = 0 + adjustment;
      x2 = w + adjustment;
      x3 = 0 + adjustment;
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
