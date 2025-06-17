import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_he.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('he'),
    Locale('ja'),
    Locale('th'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// The label of a button that reveals essential information about the app, such as the version number and copyright information.
  ///
  /// In en, this message translates to:
  /// **'About {appName}'**
  String aboutAndInfoTileLabel(String appName);

  /// No description provided for @appLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Change the language of the app\'s interface. This does not change the translation language of transcripts.'**
  String get appLanguageDescription;

  /// The label of a menu that allows the user to pick what language the interface of the app will be.
  ///
  /// In en, this message translates to:
  /// **'Interface language'**
  String get appLanguageListTileLabel;

  /// The label of a button that closes a dialog that otherwise would have asked the user to decide to do something. There are no side effects from choosing this action.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// A message that informs the user that the current audio track does not a text transcript.
  ///
  /// In en, this message translates to:
  /// **'No transcript for this track.'**
  String get noTranscriptMessage;

  /// The label of a switch that controls whether the user is allowed to see transcripts of audio tracks.
  ///
  /// In en, this message translates to:
  /// **'Can see transcript'**
  String get canSeeTranscriptTileLabel;

  /// The label of a switch that controls whether the user is allowed to see translations of transcripts.
  ///
  /// In en, this message translates to:
  /// **'Can see translation'**
  String get canSeeTranslationTileLabel;

  /// The tooltip of a button that changes the size of text on the screen. Usually it will increase the size of the text, but once the text is at a predefined maximum size, clicking the button will return to its original, smaller size.
  ///
  /// In en, this message translates to:
  /// **'Change text size'**
  String get changeTextSizeTooltip;

  /// The label of a button that causes the app to check whether the user's answer to a math problem is correct or incorrect.
  ///
  /// In en, this message translates to:
  /// **'Check answer'**
  String get checkAnswerButtonText;

  /// The label of a button that closes the settings and info screen.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeSettingsAndInfoTileLabel;

  /// Tooltip of the theme switcher option that sets the app theme to dark.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// The label of a button that refers to the default language of the phone or computer that is running the app.
  ///
  /// In en, this message translates to:
  /// **'Default language'**
  String get defaultLanguageOptionLabel;

  /// Tooltip of the theme switcher option that sets the app theme to match the device theme.
  ///
  /// In en, this message translates to:
  /// **'Device theme'**
  String get deviceTheme;

  /// The title of a window that asks the user if they would like to disable a mode that the app is operating in.
  ///
  /// In en, this message translates to:
  /// **'Disable Mode'**
  String get disableModeWindowTitle;

  /// A text description that asks the user if they would like to disable a mode that is meant for parents and teachers.
  ///
  /// In en, this message translates to:
  /// **'Would you like to turn off Parent and Teacher Mode?'**
  String get disableParentTeacherModeConfirmationText;

  /// The short name that refers to compact discs (CDs) that audio content is distributed on. Sometimes multiples of them are packed together and therefore need to be numbered.
  ///
  /// Examples: CD 1, Disc 2
  ///
  /// In en, this message translates to:
  /// **'CD'**
  String get discObject;

  /// The tooltip of a button that closes a fullscreen window and returns it to its normal, smaller size.
  ///
  /// In en, this message translates to:
  /// **'Exit fullscreen'**
  String get exitFullscreenTooltip;

  /// The tooltip of the button that fast forwards the current audio track five seconds.
  ///
  /// In en, this message translates to:
  /// **'Forward five seconds'**
  String get fastForwardButtonTooltip;

  /// Tooltip of the theme switcher option that sets the app theme to light.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get lightTheme;

  /// The tooltip of a button that is deactivated while data is being loaded.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingButtonTooltip;

  /// A label the tells the user data is currently being loaded and will be available in this same space soon.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingLabel;

  /// A message to the user before they disable a mode meant for parents and teachers. It informs them that will have to solve a math problem in the future if they wish to enable the mode again.
  ///
  /// In en, this message translates to:
  /// **'You must solve a math challenge to enable it again.'**
  String get mathChallengeWarning;

  /// The label of a button that specifies no language has been chosen to translate audio transcripts.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get noTranslationLanguageOptionLabel;

  /// The text on a button that confirms that the user has decided to perform an action.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButtonText;

  /// The tooltip of a button that navigates to a screen with many ways to control playback of the current audio stream. Play, pause, seek, speed, etc.
  ///
  /// In en, this message translates to:
  /// **'Open player controls'**
  String get openPlayerControlsTooltip;

  /// The label of the button that toggles a special mode meant only for parents and teachers of young children.
  ///
  /// In en, this message translates to:
  /// **'Parent and teacher mode'**
  String get parentAndTeacherModeTileLabel;

  /// A notification message that briefly appears after the user has enabled a mode meant for parents and teachers.
  ///
  /// In en, this message translates to:
  /// **'Parent and teacher mode enabled.'**
  String get parentTeacherModeActivatedPopup;

  /// The title of a window that states this part of app is only meant to be used by parents and teachers.
  ///
  /// In en, this message translates to:
  /// **'For parents and teachers'**
  String get parentTeacherModeWindowTitle;

  /// The aooltip of a button that pauses a piece of audio that is currently being played.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseButtonTooltip;

  /// The tooltip of a button that plays audio.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get playButtonTooltip;

  /// The tooltip of a slider that allows the user to move to a position within an audio track that is currently playing.
  ///
  /// In en, this message translates to:
  /// **'Seek to time'**
  String get progressSliderTooltip;

  /// The tooltip of a button that cycles through audio repeat modes: repeat none, repeat one, and repeat all.
  ///
  /// In en, this message translates to:
  /// **'Change repeat mode'**
  String get repeatModeButtonTooltip;

  /// The tooltip of a button that appears after a playlist of audio tracks has played completely and automatically stopped at the end. Pushing this button will play every track again from the beginning.
  ///
  /// In en, this message translates to:
  /// **'Replay all'**
  String get replayButtonTooltip;

  /// The label of a button that replays the onboarding process of an app which teaches users its essential functions.
  ///
  /// In en, this message translates to:
  /// **'Replay introduction'**
  String get replayIntroduction;

  /// The tooltip of the button that rewinds the current audio track five seconds.
  ///
  /// In en, this message translates to:
  /// **'Rewind five seconds'**
  String get rewindButtonTooltip;

  /// The title of a slide out menu that contains settings and links to app information.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsAndInfoMenuTitle;

  /// The tooltip for a button that toggles the visibility of the translation of the transcript of the currently-playing audio.
  ///
  /// In en, this message translates to:
  /// **'Show or hide translation'**
  String get showTranslationTooltip;

  /// The symbol that appears next to a number that displays the relative size of text on the screen compared to its default size.
  ///
  /// Examples: 1.0x, 1.5x, 2.0x, etc.
  ///
  /// In en, this message translates to:
  /// **'{size}x'**
  String sizeMultiplierSymbol(String size);

  /// The tooltip of a button that skips to the next audio track in a playlist.
  ///
  /// In en, this message translates to:
  /// **'Skip to next'**
  String get skipNextButtonTooltip;

  /// The tooltip of a button that skips to the previous audio track in a playlist.
  ///
  /// In en, this message translates to:
  /// **'Skip to previous'**
  String get skipPreviousButtonTooltip;

  /// A prompt for a math problem wherein the user must find the correct value for a variable named x.
  ///
  /// In en, this message translates to:
  /// **'Solve for x'**
  String get solveForX;

  /// The symbol that appears next to a number that displays the relative speed of audio playback.
  ///
  /// Examples: 1.0x, 0.5x, 2.0x, etc.
  ///
  /// In en, this message translates to:
  /// **'{speed}x'**
  String speedMultiplierSymbol(String speed);

  /// The tooltip of a slider that controls audio playback speed.
  ///
  /// In en, this message translates to:
  /// **'Change speed'**
  String get speedSliderTooltip;

  /// The title of a menu that allows the user the change the app's visual theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeMenuTitle;

  /// The name of a discrete, numbered, piece of audio content, often distributed on a CD or as a digital file.
  ///
  /// Examples: Track 1, Track 5, #10, etc.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get trackObject;

  /// The label for a button that opens the written transcript for the currently-playing audio.
  ///
  /// In en, this message translates to:
  /// **'Transcript'**
  String get transcriptButtonLabel;

  /// The tooltip for a button that enlarges a portion of the app to fill the entire window.
  ///
  /// In en, this message translates to:
  /// **'Open fullscreen'**
  String get transcriptFullscreenTooltip;

  /// No description provided for @translationLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Translations of transcripts are available in these languages. Choose one to show in the transcript screen. This does not change the app\'s interface language.'**
  String get translationLanguageDescription;

  /// The label of a menu that allows the user to specify a second language into which audio transcripts can be translated into. Similar to subtitles.
  ///
  /// For example, if the app has an text transcript of an English school book audio track and the user selects French as the translation language, then the text transcript may appear like this:
  ///
  /// Dominique: Hello
  /// Dominique: Bonjour.
  ///
  /// Pat: Hello
  /// Pat: Bonjour.
  ///
  /// Dominique: How's it going?
  /// Dominique: Comment ça va ?
  ///
  /// Pat: It's going very well, thank you. And you?
  /// Pat: Ça va très bien, merci. Et vous ?
  ///
  /// In en, this message translates to:
  /// **'Translation language'**
  String get translationLanguageListTileLabel;

  /// The label of a button that toggles on or off a feature that prevents the device's screen from turning off automatically.
  ///
  /// In en, this message translates to:
  /// **'Keep screen on'**
  String get wakelockTileLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'he',
    'ja',
    'th',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'he':
      return AppLocalizationsHe();
    case 'ja':
      return AppLocalizationsJa();
    case 'th':
      return AppLocalizationsTh();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
