import 'package:flutter/material.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';

class Config {
  static String get appTitle => 'Kantan Player';
  static String get assetsPackage => 'demo_assets';
  static String get channelId => 'com.crayonfox.kantanplayer';
  static String get channelName => 'Kantan Player';
  static String get notificationIcon => 'drawable/text_to_speech';

  static Duration get saveStateUpdateDuration => const Duration(seconds: 2);

  static Duration get rewindDuration => const Duration(seconds: 5);
  static Duration get fastForwardDuration => const Duration(seconds: 5);

  // Default values for player state.
  static int get defaultQueueIndex => 0;
  static Duration get defaultPosition => Duration.zero;
  static double get defaultSpeed => 1.0;
  static RepeatMode get defaultRepeatMode => RepeatMode.none;

  static ThemeMode get defaultThemeMode => ThemeMode.system;
}
