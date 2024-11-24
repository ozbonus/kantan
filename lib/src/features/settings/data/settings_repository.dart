import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  const SettingsRepository(this.prefs);
  final SharedPreferences prefs;

  int? get queueIndex => prefs.getInt(SettingKey.queueIndex);

  Duration? get position {
    final milliseconds = prefs.getInt(SettingKey.position);
    return milliseconds != null ? Duration(milliseconds: milliseconds) : null;
  }

  double? get speed => prefs.getDouble(SettingKey.speed);

  RepeatMode? get repeatMode {
    final savedValue = prefs.getInt(SettingKey.repeatMode);
    return RepeatMode.values[savedValue ?? 0];
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
