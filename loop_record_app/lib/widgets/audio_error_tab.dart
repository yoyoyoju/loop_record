import 'package:flutter/material.dart';

class AudioErrorTab extends StatefulWidget {
  @override
  _AudioErrorTabState createState() => _AudioErrorTabState();
}

class _AudioErrorTabState extends State<AudioErrorTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
            "Something went wrong. Could you check the microphone permission for this app?")
      ],
    );
  }
}
