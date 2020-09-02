import 'package:flutter/material.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super(key: LoopRecordKeys.homeScreen);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change the title'),
      ),
      body: Text('hi'),
    );
  }
}
