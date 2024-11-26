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
  SettingKey.interfaceLanguage: 'Klingon',
  SettingKey.translationLanguage: 'Elvish',
  SettingKey.canSeeTranscript: !Config.defaultCanSeeTranscript,
  SettingKey.canSeeTranslation: !Config.defaultCanSeeTranslation,
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

  group('Return default when null:', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(nullValues);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      repo = SettingsRepository(prefs);
    });

    test('Queue index', () {
      final value = Config.defaultQueueIndex;
      expect(repo.queueIndex, equals(value));
    });

    test('Position', () {
      final value = Config.defaultPosition;
      expect(repo.position, equals(value));
    });

    test('Speed', () {
      final value = Config.defaultSpeed;
      expect(repo.speed, equals(value));
    });

    test('Repeat mode', () {
      final value = Config.defaultRepeatMode;
      expect(repo.repeatMode, equals(value));
    });

    test('Theme mode', () {
      final value = Config.defaultThemeMode;
      expect(repo.themeMode, equals(value));
    });

    test('Wakelock value', () {
      final value = Config.defaultUseWakelock;
      expect(repo.useWakelock, equals(value));
    });

    test('Parental mode value', () {
      final value = Config.defaultIsParentalModeOn;
      expect(repo.isParentalModeOn, equals(value));
    });

    test('Interface language', () {
      final value = Config.defaultInterfaceLanguage;
      expect(repo.interfaceLanguage, equals(value));
    });

    test('Translation language', () {
      final value = Config.defaultTranslationLanguage;
      expect(repo.translationLanguage, equals(value));
    });

    test('Can see transcript', () {
      final value = Config.defaultCanSeeTranscript;
      expect(repo.canSeeTranscript, equals(value));
    });

    test('Can see translation', () {
      final value = Config.defaultCanSeeTranslation;
      expect(repo.canSeeTranslation, equals(value));
    });
  });

  group('Return saved values:', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(fullValues);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      repo = SettingsRepository(prefs);
    });

    test('Queue index', () {
      final value = fullValues[SettingKey.queueIndex] as int;
      expect(repo.queueIndex, equals(value));
    });

    test('Position', () {
      final milli = fullValues[SettingKey.position] as int;
      final value = Duration(milliseconds: milli);
      expect(repo.position, equals(value));
    });

    test('Speed', () {
      final value = fullValues[SettingKey.speed] as double;
      expect(repo.speed, equals(value));
    });

    test('Repeat mode', () {
      final index = fullValues[SettingKey.repeatMode] as int;
      final value = RepeatMode.values[index];
      expect(repo.repeatMode, equals(value));
    });

    test('Theme mode', () {
      final index = fullValues[SettingKey.themeMode] as int;
      final value = ThemeMode.values[index];
      expect(repo.themeMode, equals(value));
    });

    test('Wakelock value', () {
      final value = fullValues[SettingKey.useWakelock] as bool;
      expect(repo.useWakelock, equals(value));
    });

    test('Parental mode value', () {
      final value = fullValues[SettingKey.isParentalModeOn] as bool;
      expect(repo.isParentalModeOn, equals(value));
    });

    test('Interface language', () {
      final value = fullValues[SettingKey.interfaceLanguage] as String;
      expect(repo.interfaceLanguage, equals(value));
    });

    test('Translation language', () {
      final value = fullValues[SettingKey.translationLanguage] as String;
      expect(repo.translationLanguage, equals(value));
    });

    test('Can see transcript', () {
      final value = fullValues[SettingKey.canSeeTranscript] as bool;
      expect(repo.canSeeTranscript, equals(value));
    });

    test('Can see translation', () {
      final value = fullValues[SettingKey.canSeeTranscript] as bool;
      expect(repo.canSeeTranslation, equals(value));
    });
  });

  group('Write and read:', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(nullValues);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      repo = SettingsRepository(prefs);
    });

    test('Queue index', () async {
      final value = fullValues[SettingKey.queueIndex] as int;
      await expectLater(repo.setQueueIndex(value), completes);
      expect(repo.queueIndex, equals(value));
    });

    test('Position', () async {
      final milli = fullValues[SettingKey.position] as int;
      final value = Duration(milliseconds: milli);
      await expectLater(repo.setPosition(value), completes);
      expect(repo.position, equals(value));
    });

    test('Speed', () async {
      final value = fullValues[SettingKey.speed] as double;
      await expectLater(repo.setSpeed(value), completes);
      expect(repo.speed, equals(value));
    });

    test('Repeat mode', () async {
      final index = fullValues[SettingKey.repeatMode] as int;
      final value = RepeatMode.values[index];
      await expectLater(repo.setRepeatMode(value), completes);
      expect(repo.repeatMode, equals(value));
    });

    test('Theme mode', () async {
      final index = fullValues[SettingKey.themeMode] as int;
      final value = ThemeMode.values[index];
      await expectLater(repo.setThemeMode(value), completes);
      expect(repo.themeMode, equals(value));
    });

    test('Wakelock value', () async {
      final value = fullValues[SettingKey.useWakelock] as bool;
      await expectLater(repo.setUseWakelock(value), completes);
      expect(repo.useWakelock, equals(value));
    });

    test('Parental mode value', () async {
      final value = fullValues[SettingKey.isParentalModeOn] as bool;
      await expectLater(repo.setIsParentalModeOn(value), completes);
      expect(repo.isParentalModeOn, equals(value));
    });

    test('Interface language', () async {
      final value = fullValues[SettingKey.interfaceLanguage] as String;
      await expectLater(repo.setInterfaceLanguage(value), completes);
      expect(repo.interfaceLanguage, equals(value));
    });

    test('Translation language', () async {
      final value = fullValues[SettingKey.translationLanguage] as String;
      await expectLater(repo.setTranslationLanguage(value), completes);
      expect(repo.translationLanguage, equals(value));
    });

    test('Can see transcript', () async {
      final value = fullValues[SettingKey.canSeeTranscript] as bool;
      await expectLater(repo.setCanSeeTranscript(value), completes);
      expect(repo.canSeeTranscript, equals(value));
    });

    test('Can see translation', () async {
      final value = fullValues[SettingKey.canSeeTranscript] as bool;
      await expectLater(repo.setCanSeeTranslation(value), completes);
      expect(repo.canSeeTranslation, equals(value));
    });
  });
}
