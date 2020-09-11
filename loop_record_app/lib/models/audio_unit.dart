import 'dart:async';
import 'dart:io' as io;
import 'package:meta/meta.dart';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:loop_record_app/models/audio_settings.dart';
import 'package:loop_record_app/models/enums.dart';
import 'package:path_provider/path_provider.dart';

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
  AudioUnitStatus _audioUnitStatus = AudioUnitStatus.IDLE;

  // AudioSettings
  AudioSettings audioSettings;
  StreamSubscription _playOnCompleteSubscription;
  final Function callbackOnPlayComplete;

  @override
  AudioUnitStatus get status => _audioUnitStatus;
  @override
  bool get isPaused =>
      _audioUnitStatus == AudioUnitStatus.RECORD_PAUSED ||
      _audioUnitStatus == AudioUnitStatus.PLAY_PAUSED;

  AudioUnitImpl({
    this.localFileSystem,
    @required this.audioSettings,
    @required this.callbackOnPlayComplete,
  });

  Future _updateStatus() async {
    // It mutate the statuses of audio Units
    // based on
    // _audioPlayer and _recorder
    _currentRecording = await _recorder?.current(channel: 0) ?? null;
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
        // should be "Initialized", if all working fine

        await _updateStatus();

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
    if (_audioPlayer != null && _playerState == AudioPlayerState.PLAYING) {
      await _stopAudio();
    }
    // Start Recording
    if (_recorderStatus == null ||
        _recorderStatus == RecordingStatus.Stopped ||
        _recorderStatus == RecordingStatus.Unset) {
      await init();
    }
    await _startRecording();
    return true;
  }

  @override
  Future<bool> play() async {
    assert(_audioUnitStatus == AudioUnitStatus.RECORDING ||
        _audioUnitStatus == AudioUnitStatus.IDLE);

    // If Recording Stop Recording
    if (_recorderStatus == RecordingStatus.Recording) {
      await _stopRecording();
    }
    // Start Playing audio
    // TODO Check whether file exist?
    await _playAudio();
    return true;
  }

  @override
  Future<bool> pause() async {
    switch (_audioUnitStatus) {
      case AudioUnitStatus.RECORDING:
        _pauseRecording();
        break;
      case AudioUnitStatus.PLAYING:
        _pauseAudio();
        break;
      case AudioUnitStatus.RECORD_PAUSED:
      case AudioUnitStatus.PLAY_PAUSED:
        break;
      case AudioUnitStatus.IDLE:
      case AudioUnitStatus.ERROR:
        throw 'shoul be playing or recording';
        break;
    }
    return true;
  }

  @override
  Future<bool> resume() async {
    switch (_audioUnitStatus) {
      case AudioUnitStatus.RECORDING:
      case AudioUnitStatus.PLAYING:
        throw 'Already playing or recording';
        break;
      case AudioUnitStatus.RECORD_PAUSED:
        _resumeRecording();
        break;
      case AudioUnitStatus.PLAY_PAUSED:
        _resumeAudio();
        break;
      case AudioUnitStatus.IDLE:
        throw 'Should be in pause status';
        break;
      case AudioUnitStatus.ERROR:
        throw 'errer';
        break;
    }
    return true;
  }

  @override
  void release() async {
    await stop();
    _delete(_currentRecording?.path);
    _audioPlayer?.release();
  }

  @override
  Future<bool> stop() async {
    try {
      if (_audioUnitStatus == AudioUnitStatus.PLAYING ||
          _audioUnitStatus == AudioUnitStatus.PLAY_PAUSED) {
        await _stopAudio();
      } else if (_audioUnitStatus == AudioUnitStatus.RECORDING ||
          _audioUnitStatus == AudioUnitStatus.RECORD_PAUSED) {
        await _stopRecording();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> _delete(String filepath) async {
    try {
      final file = io.File(filepath);
      if (file.existsSync()) {
        await file.delete();
      }
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<int> _startRecording() async {
    try {
      await _recorder.start();
      await _updateStatus();
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> _resumeRecording() async {
    await _recorder?.resume();
    await _updateStatus();
    return 1;
  }

  Future<int> _pauseRecording() async {
    await _recorder?.pause();
    await _updateStatus();
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
    await _updateStatus();
    return 1;
  }

  // AudioPlayer
  Future<int> _playAudio() async {
    _audioPlayer = AudioPlayer();
    await _updateReleaseMode();
    final result = _audioPlayer.play(
      _currentRecording.path,
      isLocal: true,
    );
    _updateAudioSettings();
    _playerState = _audioPlayer?.state;

    await _updateStatus();
    return await result;
  }

  Future<int> _stopAudio() async {
    final result = await _audioPlayer?.stop() ?? -1;
    _playerState = _audioPlayer?.state;
    await _updateStatus();
    await _audioPlayer?.release();
    return result;
  }

  Future<int> _pauseAudio() async {
    final result = await _audioPlayer?.pause() ?? -1;
    _playerState = _audioPlayer?.state;
    await _updateStatus();
    return result;
  }

  Future<int> _resumeAudio() async {
    await _updateReleaseMode();
    _updateAudioSettings();
    final result = await _audioPlayer?.resume() ?? -1;
    _playerState = _audioPlayer?.state;
    var updateStatue = _updateStatus();
    await updateStatue;
    return result;
  }

  void _updateAudioSettings() {
    // This should be called while playing
//    _audioPlayer?.setVolume(audioSettings.volumn); // Volume does not work...
    final rate = audioSettings.playbackRate;
    if (rate != 1.0) {
      _audioPlayer?.setPlaybackRate(playbackRate: rate);
    }
  }

  Future _updateReleaseMode() async {
    // This should be called before playing
    switch (audioSettings.audioPlayMode) {
      case AudioPlayMode.LOOP:
        await _audioPlayer.setReleaseMode(ReleaseMode.LOOP);
        _playOnCompleteSubscription?.cancel();
        break;
      case AudioPlayMode.STOP:
        await _audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
        _playOnCompleteSubscription?.cancel();
        break;
      case AudioPlayMode.RECORD_ON_COMPLETE:
        await _audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
        _playOnCompleteSubscription =
            _audioPlayer.onPlayerCompletion.listen((event) {
          callbackOnPlayComplete();
        });
        break;
    }
  }
}

abstract class AudioUnit {
  AudioUnitStatus get status;
  bool get isPaused;
  Future<AudioUnitHealth> init();
  Future<bool> record();
  Future<bool> play();
  Future<bool> pause();
  Future<bool> resume();
  Future<bool> stop();
  // Add Stop for both
  void release();
}

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
  if (recorderStatus == RecordingStatus.Recording &&
      (playerStatus == null || playerStatus != AudioPlayerState.PLAYING)) {
    return AudioUnitStatus.RECORDING;
  }
  if (playerStatus == AudioPlayerState.PLAYING &&
      (recorderStatus == null || recorderStatus != RecordingStatus.Recording)) {
    return AudioUnitStatus.PLAYING;
  }
  if (recorderStatus == RecordingStatus.Paused &&
      (playerStatus == null || playerStatus != AudioPlayerState.PLAYING)) {
    return AudioUnitStatus.RECORD_PAUSED;
  }
  if (playerStatus == AudioPlayerState.PAUSED &&
      (recorderStatus == null || recorderStatus != RecordingStatus.Recording)) {
    return AudioUnitStatus.PLAY_PAUSED;
  }
  if ((playerStatus == null ||
          playerStatus == AudioPlayerState.STOPPED ||
          playerStatus == AudioPlayerState.COMPLETED) &&
      (recorderStatus == null ||
          recorderStatus == RecordingStatus.Unset ||
          recorderStatus == RecordingStatus.Stopped ||
          recorderStatus == RecordingStatus.Initialized)) {
    return AudioUnitStatus.IDLE;
  }
  return AudioUnitStatus.ERROR;
}
