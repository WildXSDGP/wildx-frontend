import 'dart:async';
import 'package:torch_light/torch_light.dart';
import 'alarm_service.dart';
import '../models/emergency_contact.dart';
import '../models/location_info.dart';

class EmergencyService {
  static final EmergencyService _instance = EmergencyService._internal();
  factory EmergencyService() => _instance;
  EmergencyService._internal();

  final AlarmService _alarmService = AlarmService();

  bool _flashlightActive = false;

  bool get flashlightActive => _flashlightActive;
  bool get alarmActive => _alarmService.isPlaying;

  /// Toggle real device flashlight ON/OFF
  Future<bool?> toggleFlashlight() async {
    try {
      final available = await TorchLight.isTorchAvailable();
      if (!available) return null;

      if (_flashlightActive) {
        await TorchLight.disableTorch();
        _flashlightActive = false;
      } else {
        await TorchLight.enableTorch();
        _flashlightActive = true;
      }
      return _flashlightActive;
    } on Exception {
      return null;
    }
  }

  /// Toggle real alarm sound
  Future<bool> toggleAlarm() async {
    return await _alarmService.toggle();
  }

  /// Turn off everything on dispose
  Future<void> ensureAllOff() async {
    await ensureFlashlightOff();
    await _alarmService.ensureAlarmOff();
  }

  Future<void> ensureFlashlightOff() async {
    try {
      if (_flashlightActive) {
        await TorchLight.disableTorch();
        _flashlightActive = false;
      }
    } catch (_) {}
  }

  Future<bool> sendSOSAlert(LocationInfo location) async {
    await Future.delayed(const Duration(seconds: 1));
    print('[SOS] Alert sent from: ${location.coordinates}');
    return true;
  }

  Future<void> callEmergency(EmergencyContact contact) async {
    print('[CALL] ${contact.name} - ${contact.number}');
  }

  Future<void> shareLocation(LocationInfo location) async {
    print('[SHARE] ${location.coordinates}');
  }
}
