import 'package:flutter/material.dart';
import 'package:loop_record_app/strings.dart';

class TwoWidgets extends StatelessWidget {
  TwoWidgets();

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var direction =
        orientation == Orientation.landscape ? Axis.vertical : Axis.horizontal;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Wrap(
        direction: direction,
        runAlignment: WrapAlignment.spaceAround,
        children: <Widget>[
          CircleDecoratedText(Strings.RECORDING_TEXT),
          Align(
            alignment: Alignment.center,
            child: Text("Tab to Play"),
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
