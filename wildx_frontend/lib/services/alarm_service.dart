import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  factory AlarmService() => _instance;
  AlarmService._internal();

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  /// Start playing the alarm (system alarm sound, loops)
  Future<void> startAlarm() async {
    if (_isPlaying) return;
    _isPlaying = true;
    await FlutterRingtonePlayer().playAlarm(
      looping: true,   // Keep ringing until stopped
      volume: 1.0,     // Max volume
      asAlarm: true,   // Use alarm audio stream (overrides silent mode)
    );
  }

  /// Stop the alarm
  Future<void> stopAlarm() async {
    if (!_isPlaying) return;
    _isPlaying = false;
    await FlutterRingtonePlayer().stop();
  }

  /// Toggle alarm on/off
  Future<bool> toggle() async {
    if (_isPlaying) {
      await stopAlarm();
    } else {
      await startAlarm();
    }
    return _isPlaying;
  }

  /// Always call this when leaving screen
  Future<void> ensureAlarmOff() async {
    if (_isPlaying) await stopAlarm();
  }
}
