// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String aboutAndInfoTileLabel(String appName) {
    return 'About $appName';
  }

  @override
  String get appLanguageDescription =>
      'Change the language of the app\'s interface. This does not change the translation language of transcripts.';

  @override
  String get appLanguageListTileLabel => 'Interface language';

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get noTranscriptMessage => 'No transcript for this track.';

  @override
  String get canSeeTranscriptTileLabel => 'Can see transcript';

  @override
  String get canSeeTranslationTileLabel => 'Can see translation';

  @override
  String get changeTextSizeTooltip => 'Change text size';

  @override
  String get checkAnswerButtonText => 'Check answer';

  @override
  String get closeSettingsAndInfoTileLabel => 'Close';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get defaultLanguageOptionLabel => 'Default language';

  @override
  String get deviceTheme => 'Device theme';

  @override
  String get disableModeWindowTitle => 'Disable Mode';

  @override
  String get disableParentTeacherModeConfirmationText =>
      'Would you like to turn off Parent and Teacher Mode?';

  @override
  String get discObject => 'CD';

  @override
  String get exitFullscreenTooltip => 'Exit fullscreen';

  @override
  String get fastForwardButtonTooltip => 'Forward five seconds';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get loadingButtonTooltip => 'Loading';

  @override
  String get loadingLabel => 'Loading...';

  @override
  String get mathChallengeWarning =>
      'You must solve a math challenge to enable it again.';

  @override
  String get noTranslationLanguageOptionLabel => 'None';

  @override
  String get okButtonText => 'OK';

  @override
  String get openPlayerControlsTooltip => 'Open player controls';

  @override
  String get parentAndTeacherModeTileLabel => 'Parent and teacher mode';

  @override
  String get parentTeacherModeActivatedPopup =>
      'Parent and teacher mode enabled.';

  @override
  String get parentTeacherModeWindowTitle => 'For parents and teachers';

  @override
  String get pauseButtonTooltip => 'Pause';

  @override
  String get playButtonTooltip => 'Play';

  @override
  String get progressSliderTooltip => 'Seek to time';

  @override
  String get repeatModeButtonTooltip => 'Change repeat mode';

  @override
  String get replayButtonTooltip => 'Replay all';

  @override
  String get replayIntroduction => 'Replay introduction';

  @override
  String get rewindButtonTooltip => 'Rewind five seconds';

  @override
  String get settingsAndInfoMenuTitle => 'Settings';

  @override
  String get showTranslationTooltip => 'Show or hide translation';

  @override
  String sizeMultiplierSymbol(String size) {
    return '${size}x';
  }

  @override
  String get skipNextButtonTooltip => 'Skip to next';

  @override
  String get skipPreviousButtonTooltip => 'Skip to previous';

  @override
  String get solveForX => 'Solve for x';

  @override
  String speedMultiplierSymbol(String speed) {
    return '${speed}x';
  }

  @override
  String get speedSliderTooltip => 'Change speed';

  @override
  String get themeMenuTitle => 'Theme';

  @override
  String get trackObject => 'Track';

  @override
  String get transcriptButtonLabel => 'Transcript';

  @override
  String get transcriptFullscreenTooltip => 'Open fullscreen';

  @override
  String get translationLanguageDescription =>
      'Translations of transcripts are available in these languages. Choose one to show in the transcript screen. This does not change the app\'s interface language.';

  @override
  String get translationLanguageListTileLabel => 'Translation language';

  @override
  String get wakelockTileLabel => 'Keep screen on';
}
