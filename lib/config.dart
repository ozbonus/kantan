class Config {
  static String get test => const String.fromEnvironment('TEST');
  static String get tracksJson => const String.fromEnvironment('TRACKS_JSON');
}
