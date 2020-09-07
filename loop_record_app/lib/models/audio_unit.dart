import 'package:loop_record_app/models/enums.dart';

class AudioUnit {
  Future<bool> init() async {
    return false;
  }

  Future<bool> record() async {
    return false;
  }

  Future<bool> play() async {
    return false;
  }

  Future<bool> pause(AudioStatus status) async {
    return false;
  }

  Future<bool> resume(AudioStatus status) async {
    return false;
  }
}
