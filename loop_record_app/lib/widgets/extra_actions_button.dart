import 'package:flutter/material.dart';
import 'package:loop_record_app/models.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';

class ExtraActionsButton extends StatelessWidget {
  final PopupMenuItemSelected<ExtraAction> onSelected;

  ExtraActionsButton({
    this.onSelected,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      key: LoopRecordKeys.extraActionsButton,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          key: LoopRecordKeys.goToSettings,
          value: ExtraAction.settings,
          child: Text('Go to Settings'), //TODO: localization
        ),
      ],
    );
  }
}
