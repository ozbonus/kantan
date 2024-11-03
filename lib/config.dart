class Config {
  static String getConfigStr(String key) => String.fromEnvironment(key);
  static int getConfigInt(String key) => int.fromEnvironment(key);

  static get tracksJson => getConfigStr('TRACKS_JSON');
  static get channelId => getConfigStr('androidNotificationChannelId');
  static get channelName => getConfigStr('androidNotificationChannelName');
  static get notificationIcon => getConfigStr('androidNotificationIcon');
  static get rewindDuration => getConfigInt('rewindDuration');
  static get fastForwardDuration => getConfigInt('fastForwardDuration');
}
