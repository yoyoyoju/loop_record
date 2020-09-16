import 'package:flutter/material.dart';
import 'package:loop_record_app/strings.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';

class HowtoGuide extends StatelessWidget {
  final Function onTap;

  HowtoGuide({
    @required this.onTap,
  }) : super(key: LoopRecordKeys.howtoGuide);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      HowtoDiv(),
      GestureDetector(
        onTap: this.onTap,
      ),
    ]);
  }
}

class HowtoDiv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          HowtoCard(),
          SizedBox(height: 8.0),
          Text(
            Strings.HOW_START,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}

class HowtoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: HowtoText(Strings.HOW_TEXT),
        ),
      ),
    );
  }
}

class HowtoText extends StatelessWidget {
  final List<String> texts;
  final double padding;

  HowtoText(this.texts, [this.padding = 20.0]);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: texts
          .map(
            (text) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: padding,
              ),
              child: Text(
                "•  " + text,
                style: Theme.of(context).accentTextTheme.headline6,
              ),
            ),
          )
          .toList(),
    );
  }
}
