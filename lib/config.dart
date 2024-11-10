class Config {
  static String get appTitle {
    return const String.fromEnvironment('appTitle');
  }

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

  static Duration get rewindDuration {
    return const Duration(seconds: int.fromEnvironment('rewindDuration'));
  }

  static Duration get fastForwardDuration {
    return const Duration(seconds: int.fromEnvironment('fastForwardDuration'));
  }
}
