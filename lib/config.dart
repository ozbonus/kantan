import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:kantan/src/features/player/domain/repeat_mode.dart';

class Config {
  static String get appTitle => 'Kantan Player';
  static String get assetsPackage => 'demo_assets';
  static String get assetsDir => p.join('packages', assetsPackage, 'assets');
  static String get channelId => 'com.crayonfox.kantanplayer';
  static String get channelName => 'Kantan Player';
  static String get notificationIcon => 'drawable/text_to_speech';
  static double get buttonGridMaxWidth => 360;
  static int get mediumBreakpoint => 590;
  static int get largeBreakpoint => 1000;
  static int get fullButtonGridBreakpoint => 500;
  static int get smallButtonGridBreakpoint => 400;

  static Duration get saveStateUpdateDuration => const Duration(seconds: 2);

  static Duration get rewindDuration => const Duration(seconds: 5);
  static Duration get fastForwardDuration => const Duration(seconds: 5);

  // Feature flags
  static bool get useTranscriptFeature => true;
  static bool get useTranscriptLineSeekFeature => true;
  static bool get useTranslationFeature => true;
  static bool get useAutoScrollFeature => true;
  static bool get disableAutoScrollOnUserScroll => true;

  // Default values for player state.
  static int get defaultQueueIndex => 0;
  static Duration get defaultPosition => Duration.zero;
  static double get defaultSpeed => 1.0;
  static RepeatMode get defaultRepeatMode => RepeatMode.none;

  // Floating Mini Player
  static double get miniPlayerWidthProportion => 0.75;
  static double get miniPlayerMaxWidth => 250;
  static double get miniPlayerButtonSize => 72;
  static double get trackListScrollBottomPadding => 120;

  // Default values for user-accessible settings.
  static ThemeMode get defaultThemeMode => ThemeMode.system;
  static bool get defaultIsWakelockOn => false;
  static bool get defaultIsParentalModeOn => true;
  static bool get defaultEnableAutoScroll => true;
  static Locale? get defaultInterfaceLocale => const Locale('en');
  static Locale? get defaultTranslationLocale => const Locale.fromSubtags(
    languageCode: 'zh',
    countryCode: 'TW',
  );
  static bool get defaultCanSeeTranscript => true;
  static bool get defaultCanSeeTranslation => true;
  static bool get defaultShowTranslation => true;
  static double get defaultTranscriptScale => 1.0;

  static Locale get transcriptLocale =>
      const Locale.fromSubtags(languageCode: 'en');
  static List<Locale> get translationLocales => const [
    Locale.fromSubtags(languageCode: 'es'),
    // Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    Locale.fromSubtags(languageCode: 'ar'),
    Locale.fromSubtags(languageCode: 'he'),
    Locale.fromSubtags(languageCode: 'ja'),
  ];
  static double minTranscriptScale = 1.0;
  static double maxTranscriptScale = 2.5;
  static bool showSpeakerName = true;
  static bool showSpeakerNameTranslation = true;

  // Theming
  static Color get primary => Color(0xFFBE3137);
  static double get layoutOuterPadding => 16.0;
  static double get layoutSpacing => 24.0;
  static double get bookCoverPadding => 24.0;
  static Duration get scrollDuration => const Duration(milliseconds: 200);
}
