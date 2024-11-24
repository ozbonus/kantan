import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  const SettingsRepository(this.prefs);
  final SharedPreferences prefs;

  int? get queueIndex => prefs.getInt(SettingKey.queueIndex);
  int? get position => prefs.getInt(SettingKey.position);
  double? get speed => prefs.getDouble(SettingKey.speed);

  Future<bool> setTrack(int value) async {
    return await prefs.setInt(SettingKey.queueIndex, value);
  }

  Future<bool> setTime(int value) async {
    return await prefs.setInt(SettingKey.position, value);
  }

  Future<bool> setSpeed(double value) async {
    return await prefs.setDouble(SettingKey.speed, value);
  }
}

@Riverpod(keepAlive: true)
FutureOr<SettingsRepository> settingsRepository(Ref ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return SettingsRepository(sharedPreferences);
}
