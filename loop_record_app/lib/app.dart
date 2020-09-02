import 'package:flutter/material.dart';

class RecordApp extends StatefulWidget {
  @override
  _RecordAppState createState() => _RecordAppState();
}

class _RecordAppState extends State<RecordApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      home: Scaffold(
        body: Text('hi'),
      ),
    );
  }
}
