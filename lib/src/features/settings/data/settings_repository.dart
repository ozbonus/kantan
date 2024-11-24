import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  const SettingsRepository(this.prefs);
  final SharedPreferences prefs;

  int get queueIndex {
    final value = prefs.getInt(SettingKey.queueIndex);
    return value ?? Config.defaultQueueIndex;
  }

  Duration get position {
    final value = prefs.getInt(SettingKey.position);
    if (value != null) {
      return Duration(milliseconds: value);
    } else {
      return Config.defaultPosition;
    }
  }

  double get speed {
    final value = prefs.getDouble(SettingKey.speed);
    return value ?? Config.defaultSpeed;
  }

  RepeatMode get repeatMode {
    final value = prefs.getInt(SettingKey.repeatMode);
    if (value != null) {
      return RepeatMode.values[value];
    } else {
      return Config.defaultRepeatMode;
    }
  }

  Future<bool> setTrack(int value) async {
    return await prefs.setInt(SettingKey.queueIndex, value);
  }

  Future<bool> setTime(int value) async {
    return await prefs.setInt(SettingKey.position, value);
  }

  Future<bool> setSpeed(double value) async {
    return await prefs.setDouble(SettingKey.speed, value);
  }

  Future<bool> setRepeatMode(RepeatMode value) async {
    return await prefs.setInt(SettingKey.repeatMode, value.index);
  }
}

@Riverpod(keepAlive: true)
FutureOr<SettingsRepository> settingsRepository(Ref ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return SettingsRepository(sharedPreferences);
}
