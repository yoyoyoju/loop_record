import 'dart:async';
import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:path_provider/path_provider.dart';

enum PlayerState {
  Stopped,
  Playing,
  Paused,
}

class AudioUnitImpl implements AudioUnit {
  AudioPlayer _audioPlayer;
  FlutterAudioRecorder _recorder;
  Recording _currentRecording;
  RecordingStatus _currentStatus;
  LocalFileSystem localFileSystem;
  PlayerState _playerState;

  AudioUnitImpl({this.localFileSystem});

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
        _currentStatus = _currentRecording.status;

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
    // Stop Playing Audio
    if (_playerState == PlayerState.Playing) {
      await _stopAudio();
    }
    // Start Recording
    if (_currentStatus == RecordingStatus.Stopped) {
      await init();
    } // else RecordingStatus.Paused
    await _startRecording();
    return false;
  }

  @override
  Future<bool> play() async {
    // If Recording Stop Recording
    if (_currentStatus == RecordingStatus.Recording) {
      await _stopRecording();
    }
    // Start Playing audio
    // TODO Check whether file exist?
    await _playAudio();
    return false;
  }

  @override
  Future<bool> pause(AudioStatus status) async {
    if (status == AudioStatus.recording) {
      // pause recording
      await _pauseRecording();
    } else {
      // pause playing
      await _pauseAudio();
    }
    return false;
  }

  @override
  Future<bool> resume(AudioStatus status) async {
    if (status == AudioStatus.recording) {
      // resume recording
      await _resumeRecording();
    } else {
      // resume playing
      await _resumeAudio();
    }
    return false;
  }

  @override
  void release() async {
    stop();
    _audioPlayer?.release();
  }

  @override
  Future<bool> stop() async {
    try {
      _stopAudio();
      _stopRecording();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> _delete(String filepath) async {
    try {
      final file = io.File(filepath);
      await file.delete();
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<int> _startRecording() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      _currentRecording = recording;
      _currentStatus = _currentRecording.status;

      /*
      const tick = const Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);
        _currentRecording = current;
        _currentStatus = _currentRecording.status;
      });
      */
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> _resumeRecording() async {
    await _recorder?.resume();
    return 1;
  }

  Future<int> _pauseRecording() async {
    await _recorder?.pause();
    return 1;
  }

  Future<int> _stopRecording() async {
    var result = await _recorder?.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    try {
      File file = localFileSystem.file(result.path);
      print("File length: ${await file.length()}");
    } catch (e) {
      print("File doesn't exist");
    }
    _currentRecording = result;
    _currentStatus = _currentRecording.status;
    return 1;
  }

  Future<int> _playAudio() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    final result =
        await _audioPlayer.play(_currentRecording.path, isLocal: true);
    if (result == 1) {
      _playerState = PlayerState.Playing;
    }
    return result;
  }

  Future<int> _stopAudio() async {
    final result = await _audioPlayer?.stop() ?? -1;
    if (result == 1) {
      _playerState = PlayerState.Stopped;
    }
    await _audioPlayer?.release();
    return result;
  }

  Future<int> _pauseAudio() async {
    final result = await _audioPlayer?.pause() ?? -1;
    if (result == 1) {
      _playerState = PlayerState.Paused;
    }
    return result;
  }

  Future<int> _resumeAudio() async {
    final result = await _audioPlayer?.resume() ?? -1;
    if (result == 1) {
      _playerState = PlayerState.Playing;
    }
    return result;
  }
}

abstract class AudioUnit {
  Future<AudioUnitHealth> init();

  Future<bool> record();

  Future<bool> play();

  Future<bool> pause(AudioStatus status);

  Future<bool> resume(AudioStatus status);

  // Add Stop for both
  void release();

  Future<bool> stop();
}
