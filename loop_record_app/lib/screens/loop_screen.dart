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

class _LoopScreenState extends State<LoopScreen> {
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
    if (_audioUnitHealth != AudioUnitHealth.ok) {
      return AudioErrorTab();
    }
    return activeTab == LoopTab.recording
        ? RecordingTab(updateTab: updateTab)
        : PlayingTab(updateTab: updateTab);
  }

  void _goToSettings() {
    //TODO pause playing and recording
    Navigator.pushNamed(context, LoopRecordRoutes.settings);
  }

  @override
  void initState() {
    super.initState();
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
    audioUnit.release();
    super.dispose();
  }
}
