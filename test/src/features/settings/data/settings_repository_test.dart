import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Map<String, Object> nullValues = {};
const Map<String, Object> fullValues = {
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
    expect(repository.track, 1);
    expect(repository.time, 1);
    expect(repository.speed, 1.0);
  });

  test('Get null values.', () async {
    final repository = await makeRepository(nullValues);
    expect(repository.track, null);
    expect(repository.time, null);
    expect(repository.speed, null);
  });

  test('Write and read values.', () async {
    final repository = await makeRepository(nullValues);
    expectLater(repository.setTrack(2), completion(true));
    expectLater(repository.setTime(3), completion(true));
    expectLater(repository.setSpeed(2.5), completion(true));
    expect(repository.track, 2);
    expect(repository.time, 3);
    expect(repository.speed, 2.5);
  });
}
