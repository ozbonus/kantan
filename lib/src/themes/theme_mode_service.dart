import 'package:flutter/material.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_service.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeService extends _$ThemeModeService {
  @override
  ThemeMode build() {
    final initialState =
        ref.read(settingsRepositoryProvider).requireValue.themeMode;
    return initialState;
  }

  void setThemeMode(ThemeMode themeMode) {
    ref.read(settingsRepositoryProvider).requireValue.setThemeMode(themeMode);
    state = themeMode;
  }
}
