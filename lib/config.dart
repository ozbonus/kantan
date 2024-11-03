class Config {
  static String get tracksJson {
    return const String.fromEnvironment('TRACKS_JSON');
  }

  static String get channelId {
    return const String.fromEnvironment('androidNotificationChannelId');
  }

  static String get channelName {
    return const String.fromEnvironment('androidNotificationChannelName');
  }

  static String get notificationIcon {
    return const String.fromEnvironment('androidNotificationIcon');
  }

  static int get rewindDuration {
    return const int.fromEnvironment('rewindDuration');
  }

  static int get fastForwardDuration {
    return const int.fromEnvironment('fastForwardDuration');
  }
}
