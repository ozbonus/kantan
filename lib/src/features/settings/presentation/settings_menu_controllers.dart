import 'package:flutter/material.dart';
import 'package:kantan/src/features/parental_mode/application/parental_mode_service.dart';
import 'package:kantan/src/features/wakelock/application/wakelock_service.dart';
import 'package:kantan/src/themes/theme_mode_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_menu_controllers.g.dart';

@riverpod
class WakelockSwitchController extends _$WakelockSwitchController {
  @override
  bool build() {
    return ref.watch(wakelockServiceProvider);
  }

  void setIsWakelockOn(bool value) {
    ref.read(wakelockServiceProvider.notifier).setIsWakelockOn(value);
    state = value;
  }
}

@riverpod
class ThemeModeSwitchController extends _$ThemeModeSwitchController {
  @override
  ThemeMode build() {
    return ref.watch(themeModeServiceProvider);
  }

  void setThemeMode(ThemeMode themeMode) {
    ref.read(themeModeServiceProvider.notifier).setThemeMode(themeMode);
    state = themeMode;
  }
}

@riverpod
class ParentalModeSwitchController extends _$ParentalModeSwitchController {
  @override
  bool build() {
    return ref.watch(parentalModeServiceProvider);
  }

  void setIsParentalModeOn(bool value) {
    ref.read(parentalModeServiceProvider.notifier).setIsParentalModeOn(value);
    state = value;
  }
}
