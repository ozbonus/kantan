import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Map<String, Object> nullValues = {};
Map<String, Object> fullValues = {
  SettingKey.queueIndex: 1,
  SettingKey.position: 1000,
  SettingKey.speed: 1.5,
  SettingKey.repeatMode: 1,
  SettingKey.themeMode: 1,
  SettingKey.useWakelock: true,
  SettingKey.isParentalModeOn: !Config.defaultIsParentalModeOn,
};

late SettingsRepository repo;

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
      repo = SettingsRepository(prefs);
    });

    test('Repository returns default queue index when null.', () {
      expect(repo.queueIndex, equals(Config.defaultQueueIndex));
    });

    test('Repository returns default position when null.', () {
      expect(repo.position, equals(Config.defaultPosition));
    });

    test('Repository returns default speed when null.', () {
      expect(repo.speed, equals(Config.defaultSpeed));
    });

    test('Repository returns default repeat mode when null.', () {
      expect(repo.repeatMode, equals(Config.defaultRepeatMode));
    });

    test('Repository returns default theme mode when null.', () {
      expect(repo.themeMode, equals(Config.defaultThemeMode));
    });

    test('Repository returns default wakelock value when null.', () {
      expect(repo.useWakelock, equals(Config.defaultUseWakelock));
    });

    test('Repository returns default parental mode value when null.', () {
      expect(repo.isParentalModeOn, equals(Config.defaultIsParentalModeOn));
    });

    test('Write and read queue index.', () async {
      expectLater(repo.setQueueIndex(2), completion(true));
      expect(repo.queueIndex, equals(2));
    });

    test('Write and read position.', () async {
      const position = Duration(milliseconds: 3000);
      expectLater(repo.setPosition(position), completion(true));
      expect(repo.position, equals(const Duration(milliseconds: 3000)));
    });

    test('Write and read speed.', () async {
      expectLater(repo.setSpeed(2.5), completion(true));
      expect(repo.speed, equals(2.5));
    });

    test('Write and read repeat mode.', () async {
      expectLater(repo.setRepeatMode(RepeatMode.all), completion(true));
      expect(repo.repeatMode, equals(RepeatMode.all));
    });

    test('Write and read theme mode.', () async {
      expectLater(repo.setThemeMode(ThemeMode.dark), completion(true));
      expect(repo.themeMode, equals(ThemeMode.dark));
    });

    test('Write and read use wakelock.', () async {
      expectLater(repo.setUseWakelock(true), completion(true));
      expect(repo.useWakelock, equals(true));
    });

    test('Write and read parental mode.', () async {
      final value = !Config.defaultIsParentalModeOn;
      expectLater(repo.setIsParentalModeOn(value), completion(true));
      expect(repo.isParentalModeOn, equals(value));
    });
  });

  group('Pre-existing values:', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(fullValues);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      repo = SettingsRepository(prefs);
    });

    test('Queue index is 1.', () {
      expect(repo.queueIndex, equals(1));
    });

    test('Position is 1,000 milliseconds.', () {
      expect(repo.position, equals(const Duration(milliseconds: 1000)));
    });

    test('Speed is 1.5x.', () {
      expect(repo.speed, equals(1.5));
    });

    test('Repeat mode is repeat one.', () {
      expect(repo.repeatMode, equals(RepeatMode.one));
    });

    test('Theme mode is ThemeMode.light.', () {
      expect(repo.themeMode, equals(ThemeMode.light));
    });

    test('Use wakelock is true.', () {
      expect(repo.useWakelock, equals(true));
    });

    test('Parental mode is not default value.', () {
      final value = !Config.defaultIsParentalModeOn;
      expect(repo.isParentalModeOn, equals(value));
    });

    test('Write and read queue index.', () async {
      expectLater(repo.setQueueIndex(2), completion(true));
      expect(repo.queueIndex, equals(2));
    });

    test('Write and read position.', () async {
      const position = Duration(milliseconds: 3000);
      expectLater(repo.setPosition(position), completion(true));
      expect(repo.position, equals(const Duration(milliseconds: 3000)));
    });

    test('Write and read speed.', () async {
      expectLater(repo.setSpeed(2.5), completion(true));
      expect(repo.speed, equals(2.5));
    });

    test('Write and read repeat mode.', () async {
      expectLater(repo.setRepeatMode(RepeatMode.all), completion(true));
      expect(repo.repeatMode, equals(RepeatMode.all));
    });

    test('Write and read theme mode.', () async {
      expectLater(repo.setThemeMode(ThemeMode.dark), completion(true));
      expect(repo.themeMode, equals(ThemeMode.dark));
    });

    test('Write and read use wakelock.', () async {
      expectLater(repo.setUseWakelock(false), completion(true));
      expect(repo.useWakelock, equals(false));
    });

    test('Write and read parental mode.', () async {
      final value = !repo.isParentalModeOn;
      expectLater(repo.setIsParentalModeOn(value), completion(true));
      expect(repo.isParentalModeOn, equals(value));
    });
  });
}
