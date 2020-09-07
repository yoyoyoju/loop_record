import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:loop_record_app/models/enums.dart';

class AudioUnitImpl implements AudioUnit {
  AudioPlayer _audioPlayer;
  FlutterAudioRecorder _recorder;

  @override
  Future<AudioUnitHealth> init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
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
}

abstract class AudioUnit {
  Future<AudioUnitHealth> init();

  Future<bool> record();

  Future<bool> play();

  Future<bool> pause(AudioStatus status);

  Future<bool> resume(AudioStatus status);
}
