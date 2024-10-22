import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  const SettingsRepository(this.prefs);
  final SharedPreferences prefs;

  bool? get debugSetting => prefs.getBool(SettingKey.debugKey);

  Future<bool> setDebug(bool value) async {
    return await prefs.setBool(SettingKey.debugKey, value);
  }
}

@Riverpod(keepAlive: true)
FutureOr<SettingsRepository> settingsRepository(
    SettingsRepositoryRef ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return SettingsRepository(sharedPreferences);
}
