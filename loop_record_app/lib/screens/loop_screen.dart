import 'package:flutter/material.dart';
import 'package:file/local.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:loop_record_app/models/audio_unit.dart';
import 'package:loop_record_app/widgets/extra_actions_button.dart';
import 'package:loop_record_app/widgets/recording_tab.dart';
import 'package:loop_record_app/widgets/playing_tab.dart';
import 'package:loop_record_app/widgets/audio_error_tab.dart';

class LoopScreen extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  LoopScreen({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem(),
        super(key: LoopRecordKeys.loopScreen);

  @override
  _LoopScreenState createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> with WidgetsBindingObserver {
  LoopTab activeTab = LoopTab.recording;
  AudioUnit audioUnit;
  AudioUnitHealth _audioUnitHealth;

  void updateTab(LoopTab currentTab) {
    final nextTab =
        currentTab == LoopTab.recording ? LoopTab.playing : LoopTab.recording;
    setState(() {
      activeTab = nextTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record and Play'), //TODO use localization
        actions: [
          ExtraActionsButton(
            onSelected: (action) {
              if (action == ExtraAction.settings) {
                _goToSettings();
              }
            },
          ),
        ],
      ),
      body: _currentBody(),
    );
  }

  Widget _currentBody() {
    print("Get current Body for loop_screen -------------------------");
    if (_audioUnitHealth != AudioUnitHealth.ok) {
      return AudioErrorTab();
    }
    // TODO:
    // activate only when it is visible
    // if not paused
    activeTab == LoopTab.recording ? audioUnit.record() : audioUnit.play();

    print("activeTab = $activeTab -------------------------");
    return activeTab == LoopTab.recording
        ? RecordingTab(updateTab: updateTab)
        : PlayingTab(updateTab: updateTab);
  }

  void _goToSettings() {
    //TODO pause playing and recording
    // For now stop
    print("-------------------------pause?");
    audioUnit.stop();
    Navigator.pushNamed(context, LoopRecordRoutes.settings)
        .whenComplete(onResume);
  }

  void onResume() {
    print("-------------------------resumed?");
  }

  @override
  void initState() {
    print("Init for loop_screen -------------------------");
    super.initState();
    // Temp Observer
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  _init() async {
    audioUnit = AudioUnitImpl(localFileSystem: widget.localFileSystem);
    final result = await audioUnit.init();
    print(result);
    setState(() {
      _audioUnitHealth = result;
    });
  }

  @override
  void dispose() {
    // Temp Observer
    print("Dispose for loop_screen -------------------------");
    WidgetsBinding.instance.removeObserver(this);
    audioUnit.release();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("-------------------------------------resumed");
    } else if (state == AppLifecycleState.paused) {
      print("-------------------------------------paused");
    }
  }
}
