import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/parental_mode/application/parental_mode_service.dart';
import 'package:kantan/src/features/settings/application/interface_locale_service.dart';
import 'package:kantan/src/features/transcript/application/can_see_transcript_service.dart';
import 'package:kantan/src/features/transcript/application/can_see_translation_service.dart';
import 'package:kantan/src/features/transcript/application/translation_locale_service.dart';
import 'package:kantan/src/features/wakelock/application/wakelock_service.dart';
import 'package:kantan/src/themes/theme_mode_service.dart';

part 'settings_menu_controllers.g.dart';

@riverpod
class WakelockSwitchController extends _$WakelockSwitchController {
  @override
  bool build() {
    return ref.watch(wakelockServiceProvider);
  }

  void setIsWakelockOn(bool value) {
    ref.read(wakelockServiceProvider.notifier).setIsWakelockOn(value);
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
  }
}

@riverpod
class CanSeeTranscriptSwitchController
    extends _$CanSeeTranscriptSwitchController {
  @override
  bool build() {
    return ref.watch(canSeeTranscriptServiceProvider);
  }

  void setCanSeeTranscript(bool value) {
    ref
        .read(canSeeTranscriptServiceProvider.notifier)
        .setCanSeeTranscript(value);
  }
}

@riverpod
class CanSeeTranslationSwitchController
    extends _$CanSeeTranslationSwitchController {
  @override
  bool build() {
    return ref.watch(canSeeTranslationServiceProvider);
  }

  void setCanSeeTranslation(bool value) {
    ref
        .read(canSeeTranslationServiceProvider.notifier)
        .setCanSeeTranslation(value);
  }
}

@riverpod
class InterfaceLocaleOptionController
    extends _$InterfaceLocaleOptionController {
  @override
  build() {
    return ref.watch(interfaceLocaleServiceProvider);
  }

  void setInterfaceLocale(Locale? locale) {
    ref
        .read(interfaceLocaleServiceProvider.notifier)
        .setInterfaceLocale(locale);
  }
}

@riverpod
class TranslationLocaleOptionController
    extends _$TranslationLocaleOptionController {
  @override
  Locale? build() {
    return ref.watch(translationLocaleServiceProvider);
  }

  void setTranslationLocale(Locale? locale) {
    ref
        .read(translationLocaleServiceProvider.notifier)
        .setTranslationLocale(locale);
  }
}
