import 'package:flutter/material.dart';
import 'package:loop_record_repository_core/loop_record_repository_core.dart';

class RecordApp extends StatefulWidget {
  final SettingsRepository repository;

  RecordApp({@required this.repository});

  @override
  _RecordAppState createState() => _RecordAppState();
}

class _RecordAppState extends State<RecordApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      home: Scaffold(
        body: Text('hi again and again'),
      ),
    );
  }
}
