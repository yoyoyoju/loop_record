import 'package:flutter/material.dart';
import 'package:loop_record_app/models/audio_settings.dart';
import 'package:loop_record_app/models/theme_settings.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';
import 'package:loop_record_repository_core/loop_record_repository_core.dart';
import 'package:loop_record_app/models/app_state.dart';
import 'package:loop_record_app/screens/home_screen.dart';
import 'package:loop_record_app/screens/loop_screen.dart';
import 'package:loop_record_app/screens/settings_screen.dart';

class RecordApp extends StatefulWidget {
  final SettingsRepository repository;

  RecordApp({@required this.repository});

  @override
  _RecordAppState createState() => _RecordAppState();
}

class _RecordAppState extends State<RecordApp> {
  AppState appState;

  @override
  void initState() {
    super.initState();

    // Initialize appState
    // based on the saved settings from repository
    widget.repository.loadThemeSettings().then((loadedSettings) {
      setState(() {
        appState = AppState(
          audioSettings: null,
          themeSettings: ThemeSettings.fromEntity(loadedSettings),
        );
      });
    }).catchError((err) {
      appState = AppState.getDefault();
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    // Save appState into repository
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      theme: LoopRecordTheme.theme,
      darkTheme: LoopRecordTheme.dark,
      routes: {
        LoopRecordRoutes.home: (context) {
          return HomeScreen();
        },
        LoopRecordRoutes.loop: (context) {
          return LoopScreen();
        },
        LoopRecordRoutes.settings: (context) {
          return SettingsScreen();
        }
      },
    );
  }
}
