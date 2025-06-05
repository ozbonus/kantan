// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String aboutAndInfoTileLabel(String appName) {
    return 'אודות $appName';
  }

  @override
  String get appLanguageDescription =>
      'שנו את שפת הממשק של האפליקציה. פעולה זו לא תשנה את שפת התרגום של התמלולים.';

  @override
  String get appLanguageListTileLabel => 'שפת ממשק';

  @override
  String get cancelButtonLabel => 'ביטול';

  @override
  String get noTranscriptMessage => 'No transcript for this track.';

  @override
  String get canSeeTranscriptTileLabel => 'ניתן לראות תמליל';

  @override
  String get canSeeTranslationTileLabel => 'ניתן לראות תרגום';

  @override
  String get changeTextSizeTooltip => 'שינוי גודל טקסט';

  @override
  String get checkAnswerButtonText => 'בדיקת תשובה';

  @override
  String get closeSettingsAndInfoTileLabel => 'סגירה';

  @override
  String get darkTheme => 'ערכת נושא כהה';

  @override
  String get defaultLanguageOptionLabel => 'שפת ברירת-מחדל';

  @override
  String get deviceTheme => 'ערכת נושא של המכשיר';

  @override
  String get disableModeWindowTitle => 'מצב כבוי';

  @override
  String get disableParentTeacherModeConfirmationText =>
      'לכבות את מצב הורה מורה?';

  @override
  String get discObject => 'דיסק';

  @override
  String get exitFullscreenTooltip => 'יציאה ממסך מלא';

  @override
  String get fastForwardButtonTooltip => 'הרץ 5 שניות קדימה';

  @override
  String get lightTheme => 'ערכת נושא בהירה';

  @override
  String get loadingButtonTooltip => 'טוען';

  @override
  String get loadingLabel => 'טוען...';

  @override
  String get mathChallengeWarning =>
      'עליכם לפתור תרגיל במתמטיקה כדי להפעיל אותו שוב.';

  @override
  String get noTranslationLanguageOptionLabel => 'אף אחת';

  @override
  String get okButtonText => 'אוקיי';

  @override
  String get openPlayerControlsTooltip => 'פתיחת בקרי נגינה';

  @override
  String get parentAndTeacherModeTileLabel => 'מצב הורה מורה';

  @override
  String get parentTeacherModeActivatedPopup => 'מצב הורה מורה הופעל.';

  @override
  String get parentTeacherModeWindowTitle => 'להורים ומורים';

  @override
  String get pauseButtonTooltip => 'השהה';

  @override
  String get playButtonTooltip => 'נגן';

  @override
  String get progressSliderTooltip => 'דילוג לזמן';

  @override
  String get repeatModeButtonTooltip => 'שנה מצב חזרה';

  @override
  String get replayButtonTooltip => 'נגן הכל שוב';

  @override
  String get replayIntroduction => 'הפעלה מחדש של הפתיח';

  @override
  String get rewindButtonTooltip => 'חזור 5 שניות לאחור';

  @override
  String get settingsAndInfoMenuTitle => 'הגדרות';

  @override
  String get showTranslationTooltip => 'הצג או הסתר תרגום';

  @override
  String sizeMultiplierSymbol(String size) {
    return '${size}x';
  }

  @override
  String get skipNextButtonTooltip => 'דלג אל הבא';

  @override
  String get skipPreviousButtonTooltip => 'דלג אל הקודם';

  @override
  String get solveForX => 'מצאו את ערך x';

  @override
  String speedMultiplierSymbol(String speed) {
    return '${speed}x';
  }

  @override
  String get speedSliderTooltip => 'שינוי מהירות';

  @override
  String get themeMenuTitle => 'ערכת נושא';

  @override
  String get trackObject => 'רצועה';

  @override
  String get transcriptButtonLabel => 'תמליל';

  @override
  String get transcriptFullscreenTooltip => 'פתיחת מסך מלא';

  @override
  String get translationLanguageDescription =>
      'תרגומי תמלולים זמינים בשפות הבאות. בחרו שפה להצגה במסך התמלול. פעולה זו לא תשנה את שפת הממשק של האפליקציה.';

  @override
  String get translationLanguageListTileLabel => 'שפת תרגום';

  @override
  String get wakelockTileLabel => 'השארת מסך דולק';
}
