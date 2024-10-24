import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Map<String, Object> nullValues = {};
const Map<String, Object> fullValues = {
  SettingKey.debugBool: true,
  SettingKey.debugInt: 0,
  SettingKey.debugString: 'fnord',
  SettingKey.track: 1,
  SettingKey.time: 1,
  SettingKey.speed: 1.0,
};

Future<SettingsRepository> makeRepository(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final repository = SettingsRepository(prefs);
  return repository;
}

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  test('Get full values.', () async {
    final repository = await makeRepository(fullValues);
    expect(repository.debugBool, true);
    expect(repository.debugInt, 0);
    expect(repository.debugString, 'fnord');
    expect(repository.track, 1);
    expect(repository.time, 1);
    expect(repository.speed, 1.0);
  });

  test('Get null values.', () async {
    final repository = await makeRepository(nullValues);
    expect(repository.debugBool, null);
    expect(repository.debugInt, null);
    expect(repository.debugString, null);
    expect(repository.track, null);
    expect(repository.time, null);
    expect(repository.speed, null);
  });

  test('Write and read values.', () async {
    final repository = await makeRepository(nullValues);
    expectLater(repository.setDebugBool(true), completion(true));
    expectLater(repository.setDebugInt(1), completion(true));
    expectLater(repository.setDebugString('fnord'), completion(true));
    expectLater(repository.setTrack(2), completion(true));
    expectLater(repository.setTime(3), completion(true));
    expectLater(repository.setSpeed(2.5), completion(true));
    expect(repository.debugBool, true);
    expect(repository.debugInt, 1);
    expect(repository.debugString, 'fnord');
    expect(repository.track, 2);
    expect(repository.time, 3);
    expect(repository.speed, 2.5);
  });
}
