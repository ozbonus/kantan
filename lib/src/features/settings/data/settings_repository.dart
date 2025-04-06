import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  const SettingsRepository(this.prefs);
  final SharedPreferences prefs;

  int get queueIndex {
    final value = prefs.getInt(SettingKey.queueIndex);
    return value ?? Config.defaultQueueIndex;
  }

  Duration get position {
    final value = prefs.getInt(SettingKey.position);
    if (value != null) {
      return Duration(milliseconds: value);
    } else {
      return Config.defaultPosition;
    }
  }

  double get speed {
    final value = prefs.getDouble(SettingKey.speed);
    return value ?? Config.defaultSpeed;
  }

  RepeatMode get repeatMode {
    final value = prefs.getInt(SettingKey.repeatMode);
    if (value != null) {
      return RepeatMode.values[value];
    } else {
      return Config.defaultRepeatMode;
    }
  }

  ThemeMode get themeMode {
    final value = prefs.getInt(SettingKey.themeMode);
    if (value != null) {
      return ThemeMode.values[value];
    } else {
      return Config.defaultThemeMode;
    }
  }

  bool get isWakelockOn {
    final value = prefs.getBool(SettingKey.isWakelockOn);
    return value ?? Config.defaultIsWakelockOn;
  }

  bool get isParentalModeOn {
    final value = prefs.getBool(SettingKey.isParentalModeOn);
    return value ?? Config.defaultIsParentalModeOn;
  }

  Locale? get interfaceLocale {
    final value = prefs.getString(SettingKey.interfaceLocale);
    if (value != null) {
      final subtags = value.split('-');
      return Locale.fromSubtags(
        languageCode: subtags[0],
        countryCode: subtags.elementAtOrNull(1),
      );
    } else {
      return Config.defaultInterfaceLocale;
    }
  }

  Locale? get translationLocale {
    final value = prefs.getString(SettingKey.translationLocale);
    if (value != null) {
      final subtags = value.split('-');
      return Locale.fromSubtags(
        languageCode: subtags[0], // Definitley not null.
        countryCode: subtags.elementAtOrNull(1), // Nullable, ie. 'zh-TW'.
      );
    } else {
      return Config.defaultTranslationLocale;
    }
  }

  bool get canSeeTranscript {
    final value = prefs.getBool(SettingKey.canSeeTranscript);
    return value ?? Config.defaultCanSeeTranscript;
  }

  bool get canSeeTranslation {
    final value = prefs.getBool(SettingKey.canSeeTranslation);
    return value ?? Config.defaultCanSeeTranslation;
  }

  bool get showTranslation {
    final value = prefs.getBool(SettingKey.showTranslation);
    return value ?? Config.defaultShowTranslation;
  }

  bool get enableAutoScroll {
    final value = prefs.getBool(SettingKey.enableAutoScroll);
    return value ?? Config.defaultEnableAutoScroll;
  }

  double get transcriptScale {
    final value = prefs.getDouble(SettingKey.transcriptScale);
    return value ?? Config.defaultTranscriptScale;
  }

  Future<bool> setQueueIndex(int value) async {
    return await prefs.setInt(SettingKey.queueIndex, value);
  }

  Future<bool> setPosition(Duration position) async {
    return await prefs.setInt(SettingKey.position, position.inMilliseconds);
  }

  Future<bool> setSpeed(double value) async {
    return await prefs.setDouble(SettingKey.speed, value);
  }

  Future<bool> setRepeatMode(RepeatMode value) async {
    return await prefs.setInt(SettingKey.repeatMode, value.index);
  }

  Future<bool> setThemeMode(ThemeMode themeMode) async {
    return await prefs.setInt(SettingKey.themeMode, themeMode.index);
  }

  Future<bool> setIsWakelockOn(bool value) async {
    return await prefs.setBool(SettingKey.isWakelockOn, value);
  }

  Future<bool> setIsParentalModeOn(bool value) async {
    return await prefs.setBool(SettingKey.isParentalModeOn, value);
  }

  Future<bool> setInterfaceLocale(Locale? locale) async {
    if (locale != null) {
      return await prefs.setString(
        SettingKey.interfaceLocale,
        locale.toLanguageTag(),
      );
    } else {
      return await prefs.remove(SettingKey.interfaceLocale);
    }
  }

  Future<bool> setTranslationLocale(Locale? locale) async {
    if (locale != null) {
      return await prefs.setString(
        SettingKey.translationLocale,
        locale.toLanguageTag(),
      );
    } else {
      return await prefs.remove(SettingKey.translationLocale);
    }
  }

  Future<bool> setCanSeeTranscript(bool value) async {
    return await prefs.setBool(SettingKey.canSeeTranscript, value);
  }

  Future<bool> setCanSeeTranslation(bool value) async {
    return await prefs.setBool(SettingKey.canSeeTranslation, value);
  }

  Future<bool> setShowTranslation(bool value) async {
    return await prefs.setBool(SettingKey.showTranslation, value);
  }

  Future<bool> setEnableAutoScroll(bool value) async {
    return await prefs.setBool(SettingKey.enableAutoScroll, value);
  }

  Future<bool> setTranscriptScale(double value) async {
    return await prefs.setDouble(SettingKey.transcriptScale, value);
  }
}

@Riverpod(keepAlive: true)
FutureOr<SettingsRepository> settingsRepository(Ref ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return SettingsRepository(sharedPreferences);
}
