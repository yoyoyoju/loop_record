import 'package:flutter/material.dart';
import 'package:file/local.dart';
import 'package:loop_record_app_core/loop_record_app_core.dart';
import 'package:loop_record_app/models/audio_settings.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:loop_record_app/models/audio_unit.dart';
import 'package:loop_record_app/widgets/extra_actions_button.dart';
import 'package:loop_record_app/widgets/recording_tab.dart';
import 'package:loop_record_app/widgets/playing_tab.dart';
import 'package:loop_record_app/widgets/audio_error_tab.dart';
import 'package:loop_record_app/strings.dart';

class LoopScreen extends StatefulWidget {
  final LocalFileSystem localFileSystem;
  final AudioSettings audioSettings;

  LoopScreen({
    localFileSystem,
    @required this.audioSettings,
  })  : this.localFileSystem = localFileSystem ?? LocalFileSystem(),
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
        title: Text(Strings.TITLE),
//            '${widget.audioSettings.audioPlayMode.description}'), //TODO use localization
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
    if (!audioUnit.isPaused) {
      activeTab == LoopTab.recording ? audioUnit.record() : audioUnit.play();
    }

    return activeTab == LoopTab.recording
        ? RecordingTab(
            updateTab: updateTab,
            onStopBtn: onStopBtn,
          )
        : PlayingTab(
            updateTab: updateTab,
            onStopBtn: onStopBtn,
          );
  }

  void _goToSettings() {
    audioUnit.pause();
    Navigator.pushNamed(context, LoopRecordRoutes.settings)
        .whenComplete(onResume);
  }

  void onStopBtn() {
    audioUnit.stop();
    Navigator.pop(context);
  }

  void onResume() {
    audioUnit.resume();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initAudio();
  }

  _initAudio() async {
    // Pass callback whenComplete
    audioUnit = AudioUnitImpl(
      localFileSystem: widget.localFileSystem,
      audioSettings: widget.audioSettings,
      callbackOnPlayComplete: () => updateTab(LoopTab.playing),
    );
    final result = await audioUnit.init();
    setState(() {
      _audioUnitHealth = result;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    audioUnit.release();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      audioUnit.resume();
    } else if (state == AppLifecycleState.paused) {
      audioUnit.pause();
    }
  }
}
