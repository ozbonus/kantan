class Config {
  static String getConfig(String key) => String.fromEnvironment(key);

  static String get tracksJson => getConfig('TRACKS_JSON');
  static String get rewindDuration => getConfig('rewindDuration');
  static String get fastForwardDuration => getConfig('fastForwardDuration');
}
