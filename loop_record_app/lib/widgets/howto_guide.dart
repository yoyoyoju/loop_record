import 'package:flutter/material.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';

class HowtoGuide extends StatelessWidget {
  final Function onTap;

  HowtoGuide({
    @required this.onTap,
  }) : super(key: LoopRecordKeys.howtoGuide);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Text('hi'), // TODO Add the body
      GestureDetector(
        onTap: this.onTap,
      ),
    ]);
  }
}
