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
