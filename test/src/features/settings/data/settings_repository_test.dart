import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/config.dart';
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

  group('No pre-existing values:', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(nullValues);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      repository = SettingsRepository(prefs);
    });

    test('Repository returns default queue index when null.', () {
      expect(repository.queueIndex, equals(Config.defaultQueueIndex));
    });

    test('Repository returns default position when null.', () {
      expect(repository.position, equals(Config.defaultPosition));
    });

    test('Repository returns default speed when null.', () {
      expect(repository.speed, equals(Config.defaultSpeed));
    });

    test('Repository returns default repeat mode when null.', () {
      expect(repository.repeatMode, equals(Config.defaultRepeatMode));
    });

    test('Write and read queue index.', () async {
      expectLater(repository.setQueueIndex(2), completion(true));
      expect(repository.queueIndex, equals(2));
    });

    test('Write and read position.', () async {
      expectLater(repository.setPosition(3000), completion(true));
      expect(repository.position, equals(const Duration(milliseconds: 3000)));
    });

    test('Write and read speed.', () async {
      expectLater(repository.setSpeed(2.5), completion(true));
      expect(repository.speed, equals(2.5));
    });
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

  test('Get default values.', () async {
    final repository = await makeRepository(nullValues);
    expect(repository.queueIndex, null);
    expect(repository.position, null);
    expect(repository.speed, null);
  });
}
