import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/parental_mode/application/parental_mode_service.dart';

part 'settings_menu_controller.g.dart';

typedef VisibleSettings = ({
  bool showThemeModeSwitch,
  bool showWakelockSwitch,
  bool showParentalModeSwitch,
  bool showCanSeeTranscriptSwitch,
  bool showCanSeeTranslationSwitch,
  bool showInterfaceLanguageSelector,
  bool showTranslationLanguageSelector,
});

/// Provides visibility settings for the various switches and selectors in the
/// settings menu. A widget's visibility is determined by whether its respective
/// feature is enabled and if the ability to control that feature is under the
/// domain of the parental mode feature if the parental mode feature is enabled.
@riverpod
VisibleSettings settingsMenuController(Ref ref) {
  if (!Config.useParentalModeFeature) {
    return (
      showThemeModeSwitch: Config.useThemeModeFeature,
      showWakelockSwitch: Config.useWakelockFeature,
      showParentalModeSwitch: false,
      showCanSeeTranscriptSwitch: Config.useTranscriptFeature,
      showCanSeeTranslationSwitch: Config.useTranslationFeature,
      showInterfaceLanguageSelector: Config.useInterfaceLanguageSelectorFeature,
      showTranslationLanguageSelector:
          Config.useTranslationLanguageSelectorFeature,
    );
  }

  final parentalModeActive = ref.watch(parentalModeServiceProvider);

  return (
    showThemeModeSwitch: Config.themeModeIsParentalMode
        ? parentalModeActive
        : Config.useThemeModeFeature,
    showWakelockSwitch: Config.wakelockIsParentalMode
        ? parentalModeActive
        : Config.useWakelockFeature,
    showParentalModeSwitch: Config.useParentalModeFeature,
    showCanSeeTranscriptSwitch: Config.canSeeTranscriptIsParentalMode
        ? parentalModeActive
        : Config.useTranscriptFeature,
    showCanSeeTranslationSwitch: Config.canSeeTranslationIsParentalMode
        ? parentalModeActive
        : Config.useTranslationFeature,
    showInterfaceLanguageSelector: Config.interfaceLanguageIsParentalMode
        ? parentalModeActive
        : Config.useInterfaceLanguageSelectorFeature,
    showTranslationLanguageSelector: Config.translationLanguageIsParentalMode
        ? parentalModeActive
        : Config.useTranslationLanguageSelectorFeature,
  );
}
