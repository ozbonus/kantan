class Config {
  static String getConfig(String key) => String.fromEnvironment(key);

  static String get tracksJson => getConfig('TRACKS_JSON');
  static String get channelId => getConfig('androidNotificationChannelId');
  static String get channelName => getConfig('androidNotificationChannelName');
  static String get notificationIcon => getConfig('androidNotificationIcon');
  static String get rewindDuration => getConfig('rewindDuration');
  static String get fastForwardDuration => getConfig('fastForwardDuration');
}
