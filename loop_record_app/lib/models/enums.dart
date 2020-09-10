enum ExtraAction { settings }

enum LoopTab { recording, playing }

enum AudioUnitHealth { ok, needPermissions, error }

enum AudioPlayMode {
  LOOP,
  STOP, // STOP and RELEASE (set releaseMode to RELEASE)
  RECORD_ON_COMPLETE,
}

extension AudioPlayModeExtension on AudioPlayMode {
  String get description {
    switch (this) {
      case AudioPlayMode.LOOP:
        return "Play in loop";
      case AudioPlayMode.STOP:
        return "Stop after play";
      case AudioPlayMode.RECORD_ON_COMPLETE:
        return "Record after play";
    }
    return "error";
  }
}
