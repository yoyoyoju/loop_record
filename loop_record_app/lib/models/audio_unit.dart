import 'dart:async';
import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:path_provider/path_provider.dart';

// Move the enum to models

enum AudioUnitStatus {
  RECORDING, // Recording, !playing or null
  PLAYING, // playing, ! recording or null
  RECORD_PAUSED, // one of them paused
  PLAY_PAUSED,
  IDLE, // not recording, not playing or null
  ERROR
}

AudioUnitStatus getAudioUnitStatus(
    RecordingStatus recorderStatus, AudioPlayerState playerStatus) {
  // The args are set to null before init
  //TODO
  return null;
}

class AudioUnitImpl implements AudioUnit {
  // Player/Recorder
  AudioPlayer _audioPlayer; // has state AudioPlayerState
  FlutterAudioRecorder _recorder;

  // Recording File Info
  Recording _currentRecording;
  LocalFileSystem localFileSystem;
  // Status
  RecordingStatus
      _recorderStatus; // Unset, Initialized, Recording, Paused, Stopped
  AudioPlayerState _playerState; // STOPPED, PLAYING, PAUSED, COMPLETED
  AudioUnitStatus _audioUnitStatus;

  @override
  AudioUnitStatus get status => _audioUnitStatus;

  AudioUnitImpl({this.localFileSystem});

  void _updateStatus() {
    // It mutate the statuses of audio Units
    // based on
    // _audioPlayer and _recorder
    _recorderStatus = _currentRecording?.status ?? null;
    _playerState = _audioPlayer?.state ?? null;
    _audioUnitStatus = getAudioUnitStatus(_recorderStatus, _playerState);
  }

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
        _updateStatus();

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
    assert(_audioUnitStatus == AudioUnitStatus.PLAYING ||
        _audioUnitStatus == AudioUnitStatus.IDLE);

    // Stop Playing Audio
    if (_playerState_D == PlayerState.Playing) {
      await _stopAudio();
    }
    // Start Recording
    if (_recorderStatus == RecordingStatus.Stopped) {
      await init();
    } // else RecordingStatus.Paused
    await _startRecording();
    return false;
  }

  @override
  Future<bool> play() async {
    // If Recording Stop Recording
    if (_recorderStatus == RecordingStatus.Recording) {
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
    // TODO delete the file
    stop();
    _delete(_currentRecording?.path);
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
      _updateStatus();
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> _resumeRecording() async {
    await _recorder?.resume();
    // TODO should I update the status manually??
    _updateStatus();
    return 1;
  }

  Future<int> _pauseRecording() async {
    await _recorder?.pause();
    _updateStatus();
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
    _updateStatus();
    return 1;
  }

  // AudioPlayer
  Future<int> _playAudio() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    final result =
        await _audioPlayer.play(_currentRecording.path, isLocal: true);
    _playerState = _audioPlayer?.state;
    _updateStatus();
    return result;
  }

  Future<int> _stopAudio() async {
    final result = await _audioPlayer?.stop() ?? -1;
    _playerState = _audioPlayer?.state;
    _updateStatus();
    await _audioPlayer?.release();
    return result;
  }

  Future<int> _pauseAudio() async {
    final result = await _audioPlayer?.pause() ?? -1;
    _playerState = _audioPlayer?.state;
    _updateStatus();
    return result;
  }

  Future<int> _resumeAudio() async {
    final result = await _audioPlayer?.resume() ?? -1;
    _playerState = _audioPlayer?.state;
    _updateStatus();
    return result;
  }
}

abstract class AudioUnit {
  AudioUnitStatus get status;

  Future<AudioUnitHealth> init();

  Future<bool> record();

  Future<bool> play();

  Future<bool> pause();

  Future<bool> resume();

  Future<bool> stop();

  // Add Stop for both
  void release();
}
