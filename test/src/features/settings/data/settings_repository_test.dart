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
  SettingKey.isWakelockOn: !Config.defaultIsWakelockOn,
  SettingKey.isParentalModeOn: !Config.defaultIsParentalModeOn,
  SettingKey.interfaceLocale: 'en',
  SettingKey.translationLocale: 'fr_CA',
  SettingKey.canSeeTranscript: !Config.defaultCanSeeTranscript,
  SettingKey.canSeeTranslation: !Config.defaultCanSeeTranslation,
  SettingKey.enableAutoScroll: !Config.defaultEnableAutoScroll,
  SettingKey.transcriptScale: Config.defaultTranscriptScale + 0.1,
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
      final value = Config.defaultIsWakelockOn;
      expect(repo.isWakelockOn, equals(value));
    });

    test('Parental mode value', () {
      final value = Config.defaultIsParentalModeOn;
      expect(repo.isParentalModeOn, equals(value));
    });

    test('Interface locale', () {
      final value = Config.defaultInterfaceLocale;
      expect(repo.interfaceLocale, equals(value));
    });

    test('Translation locale', () {
      final value = Config.defaultTranslationLocale;
      expect(repo.translationLocale, equals(value));
    });

    test('Can see transcript', () {
      final value = Config.defaultCanSeeTranscript;
      expect(repo.canSeeTranscript, equals(value));
    });

    test('Can see translation', () {
      final value = Config.defaultCanSeeTranslation;
      expect(repo.canSeeTranslation, equals(value));
    });

    test('Enable auto scroll', () {
      final value = Config.defaultEnableAutoScroll;
      expect(repo.enableAutoScroll, equals(value));
    });

    test('Transcript scale', () {
      final value = Config.defaultTranscriptScale;
      expect(repo.transcriptScale, equals(value));
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
      final value = fullValues[SettingKey.isWakelockOn] as bool;
      expect(repo.isWakelockOn, equals(value));
    });

    test('Parental mode value', () {
      final value = fullValues[SettingKey.isParentalModeOn] as bool;
      expect(repo.isParentalModeOn, equals(value));
    });

    test('Interface locale', () {
      final value = fullValues[SettingKey.interfaceLocale] as String;
      final subtags = value.split('-');
      final locale = Locale.fromSubtags(
        languageCode: subtags[0],
        countryCode: subtags.elementAtOrNull(1),
      );
      expect(repo.interfaceLocale, equals(locale));
    });

    test('Translation locale', () {
      final value = fullValues[SettingKey.translationLocale] as String;
      final subtags = value.split('-');
      final locale = Locale.fromSubtags(
        languageCode: subtags[0],
        countryCode: subtags.elementAtOrNull(1),
      );
      expect(repo.translationLocale, equals(locale));
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
      final value = fullValues[SettingKey.isWakelockOn] as bool;
      await expectLater(repo.setIsWakelockOn(value), completes);
      expect(repo.isWakelockOn, equals(value));
    });

    test('Parental mode value', () async {
      final value = fullValues[SettingKey.isParentalModeOn] as bool;
      await expectLater(repo.setIsParentalModeOn(value), completes);
      expect(repo.isParentalModeOn, equals(value));
    });

    test('Interface locale', () async {
      final value = fullValues[SettingKey.interfaceLocale] as String;
      final subtags = value.split('-');
      final locale = Locale.fromSubtags(
        languageCode: subtags[0],
        countryCode: subtags.elementAtOrNull(1),
      );
      await expectLater(repo.setInterfaceLocale(locale), completes);
      expect(repo.interfaceLocale, equals(locale));
    });

    test('Translation locale', () async {
      final value = fullValues[SettingKey.translationLocale] as String;
      final subtags = value.split('-');
      final locale = Locale.fromSubtags(
        languageCode: subtags[0],
        countryCode: subtags.elementAtOrNull(1),
      );
      await expectLater(repo.setTranslationLocale(locale), completes);
      expect(repo.translationLocale, equals(locale));
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

    test('Enable auto scroll', () async {
      final value = fullValues[SettingKey.enableAutoScroll] as bool;
      await expectLater(repo.setEnableAutoScroll(value), completes);
      expect(repo.enableAutoScroll, equals(value));
    });

    test('Transcript scale', () async {
      final value = fullValues[SettingKey.transcriptScale] as double;
      await expectLater(repo.setTranscriptScale(value), completes);
      expect(repo.transcriptScale, equals(value));
    });
  });
}
