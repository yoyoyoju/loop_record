import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:path_provider/path_provider.dart';

class AudioUnitImpl implements AudioUnit {
  AudioPlayer _audioPlayer;
  FlutterAudioRecorder _recorder;
  Recording _currentRecording;
  RecordingStatus _currentStatus;
//  PlayerState _playerState;

  @override
  Future<AudioUnitHealth> init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/loop_record_app';
        io.Directory appDocDirectory;
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        customPath = appDocDirectory.path + customPath + ".wav";
        await _delete(customPath);

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine

        _currentRecording = current;
        _currentStatus = current.status;

        return AudioUnitHealth.ok;
      } else {
        return AudioUnitHealth.needPermissions;
      }
    } catch (e) {
      print(e);
      return AudioUnitHealth.error;
    }
  }

  @override
  Future<bool> record() async {
    return false;
  }

  @override
  Future<bool> play() async {
    return false;
  }

  @override
  Future<bool> pause(AudioStatus status) async {
    if (status == AudioStatus.recording) {
      // pause recording
    } else {
      // pause playing
    }
    return false;
  }

  @override
  Future<bool> resume(AudioStatus status) async {
    if (status == AudioStatus.recording) {
      // resume recording
    } else {
      // resume playing
    }
    return false;
  }

  void _delete(String customPath) async {}
}

abstract class AudioUnit {
  Future<AudioUnitHealth> init();

  Future<bool> record();

  Future<bool> play();

  Future<bool> pause(AudioStatus status);

  Future<bool> resume(AudioStatus status);
}
