import 'package:flutter/material.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';
import 'package:loop_record_app/widgets/extra_actions_button.dart';
import 'package:loop_record_app/widgets/howto_guide.dart';
import 'package:loop_record_app/models/enums.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super(key: LoopRecordKeys.homeScreen);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xff191637),
      appBar: AppBar(
//        backgroundColor: Color(0xff2c2a44),
        title: Text('Change the title'),
        actions: [
          ExtraActionsButton(onSelected: (action) {
            if (action == ExtraAction.settings) {
              Navigator.pushNamed(context, LoopRecordRoutes.settings);
            }
          }),
        ],
      ),
      body: HowtoGuide(
        onTap: () => {Navigator.pushNamed(context, LoopRecordRoutes.loop)},
      ),
    );
  }
}
