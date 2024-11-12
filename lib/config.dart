class Config {
  static String get appTitle => 'Kantan Player';
  static String get tracksJson => 'packages/demo_assets/assets/tracks.json';
  static String get channelId => 'com.crayonfox.kantanplayer';
  static String get channelName => 'Kantan Player';
  static String get notificationIcon => 'drawable/text_to_speech';
  static Duration get rewindDuration => const Duration(seconds: 5);
  static Duration get fastForwardDuration => const Duration(seconds: 5);
}
