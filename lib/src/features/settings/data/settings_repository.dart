import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  const SettingsRepository(this.prefs);
  final SharedPreferences prefs;

  bool? get debugBool => prefs.getBool(SettingKey.debugBool);
  int? get debugInt => prefs.getInt(SettingKey.debugInt);
  String? get debugString => prefs.getString(SettingKey.debugString);
  int? get track => prefs.getInt(SettingKey.track);
  int? get time => prefs.getInt(SettingKey.time);
  double? get speed => prefs.getDouble(SettingKey.speed);

  Future<bool> setDebugBool(bool value) async {
    return await prefs.setBool(SettingKey.debugBool, value);
  }

  Future<bool> setDebugInt(int value) async {
    return await prefs.setInt(SettingKey.debugInt, value);
  }

  Future<bool> setDebugString(String value) async {
    return await prefs.setString(SettingKey.debugString, value);
  }

  Future<bool> setTrack(int value) async {
    return await prefs.setInt(SettingKey.track, value);
  }

  Future<bool> setTime(int value) async {
    return await prefs.setInt(SettingKey.time, value);
  }

  Future<bool> setSpeed(double value) async {
    return await prefs.setDouble(SettingKey.speed, value);
  }
}

@Riverpod(keepAlive: true)
FutureOr<SettingsRepository> settingsRepository(
    SettingsRepositoryRef ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return SettingsRepository(sharedPreferences);
}
