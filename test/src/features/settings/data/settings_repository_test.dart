import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Map<String, Object> nullValues = {};
const Map<String, Object> fullValues = {
  SettingKey.queueIndex: 1,
  SettingKey.position: 1000,
  SettingKey.speed: 1.5,
  SettingKey.repeatMode: 1
};

late SettingsRepository repository;

Future<SettingsRepository> makeRepository(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final repository = SettingsRepository(prefs);
  return repository;
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDownAll(() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  group('Retrieve pre-existing values:', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(fullValues);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      repository = SettingsRepository(prefs);
    });

    test('Queue index is 1.', () {
      expect(repository.queueIndex, equals(1));
    });

    test('Position is 1,000 milliseconds.', () {
      expect(repository.position, equals(const Duration(milliseconds: 1000)));
    });

    test('Speed is 1.5x.', () {
      expect(repository.speed, equals(1.5));
    });

    test('Repeat mode is repeat one.', () {
      expect(repository.repeatMode, equals(RepeatMode.one));
    });
  });

  test('Get null values.', () async {
    final repository = await makeRepository(nullValues);
    expect(repository.queueIndex, null);
    expect(repository.position, null);
    expect(repository.speed, null);
  });

  test('Write and read values.', () async {
    final repository = await makeRepository(nullValues);
    expectLater(repository.setTrack(2), completion(true));
    expectLater(repository.setTime(3), completion(true));
    expectLater(repository.setSpeed(2.5), completion(true));
    expect(repository.queueIndex, 2);
    expect(repository.position, 3);
    expect(repository.speed, 2.5);
  });
}
