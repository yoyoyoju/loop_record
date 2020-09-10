import 'package:flutter/material.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';
import 'package:loop_record_repository_core/loop_record_repository_core.dart';
import 'package:loop_record_app/models/app_state.dart';
import 'package:loop_record_app/models/enums.dart';
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
    widget.repository.loadSettings().then((loadedSettings) {
      setState(() {
        appState = AppState.fromEntity(loadedSettings);
      });
    }).catchError((err) {
      setState(() {
        appState = AppState.getDefault();
        appState.updateSettings(isDarkMode: ThemeMode.system == ThemeMode.dark);
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    // Save appState into repository
    widget.repository.saveSettings(
      appState.appSettings.toEntity(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      theme: LoopRecordTheme.theme,
      darkTheme: LoopRecordTheme.dark,
      themeMode: getThemeMode(),
      routes: {
        LoopRecordRoutes.home: (context) {
          return HomeScreen();
        },
        LoopRecordRoutes.loop: (context) {
          return LoopScreen(
            audioSettings: appState.audioSettings,
          );
        },
        LoopRecordRoutes.settings: (context) {
          return SettingsScreen(
            isDarkMode: appState.isDarkMode,
            updateDarkMode: updateDarkMode,
            updateAudioSettings: updateAudioSettings,
          );
        }
      },
    );
  }

  void updateAudioSettings({
    double volumn,
    double playbackRate,
    AudioPlayMode audioPlayMode,
  }) {
    setState(() {
      // It saves the settings into repository
      appState.updateAudioSettings(
        volumn: volumn,
        playbackRate: playbackRate,
        audioPlayMode: audioPlayMode,
      );
    });
  }

  ThemeMode getThemeMode() {
    if (appState?.isDarkMode ?? false) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  void updateDarkMode(bool isDarkMode) {
    setState(() {
      appState.updateSettings(isDarkMode: isDarkMode);
    });
  }
}
