// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String aboutAndInfoTileLabel(String appName) {
    return 'نبذة عن $appName';
  }

  @override
  String get appLanguageDescription =>
      'يمكنك تغيير لغة واجهة التطبيق. لا يغيّر هذا من لغة ترجمة النسخ المكتوبة.';

  @override
  String get appLanguageListTileLabel => 'لغة الواجهة';

  @override
  String get cancelButtonLabel => 'إلغاء';

  @override
  String get noTranscriptMessage => 'No transcript for this track.';

  @override
  String get canSeeTranscriptTileLabel => 'يستطيع رؤية النسخة المكتوبة';

  @override
  String get canSeeTranslationTileLabel => 'يستطيع رؤية الترجمة';

  @override
  String get changeTextSizeTooltip => 'تغيير حجم النص';

  @override
  String get checkAnswerButtonText => 'تحقق من الحل';

  @override
  String get closeSettingsAndInfoTileLabel => 'إغلاق';

  @override
  String get darkTheme => 'نسق داكن';

  @override
  String get defaultLanguageOptionLabel => 'اللغة الافتراضية';

  @override
  String get deviceTheme => 'نسق الجهاز';

  @override
  String get disableModeWindowTitle => 'تعطيل الوضع';

  @override
  String get disableParentTeacherModeConfirmationText =>
      'هل تود إيقاف تشغيل وضع ولي الأمر والمعلم؟';

  @override
  String get discObject => 'قرص مدمج';

  @override
  String get exitFullscreenTooltip => 'الخروج من وضع ملء الشاشة';

  @override
  String get fastForwardButtonTooltip => 'تقدم خمس ثوانٍ';

  @override
  String get lightTheme => 'نسق فاتح';

  @override
  String get loadingButtonTooltip => 'جارٍ التحميل';

  @override
  String get loadingLabel => 'جارٍ التحميل...';

  @override
  String get mathChallengeWarning =>
      'يجب عليك حل مسألة حسابية لتمكينه مرة أخرى.';

  @override
  String get noTranslationLanguageOptionLabel => 'لا شيء';

  @override
  String get okButtonText => 'موافق';

  @override
  String get openPlayerControlsTooltip => 'فتح عناصر التحكم في المشغل';

  @override
  String get parentAndTeacherModeTileLabel => 'وضع ولي الأمر والمعلم';

  @override
  String get parentTeacherModeActivatedPopup =>
      'تم تمكين وضع ولي الأمر والمعلم.';

  @override
  String get parentTeacherModeWindowTitle => 'لأولياء الأمور والمعلمين';

  @override
  String get pauseButtonTooltip => 'توقف مؤقت';

  @override
  String get playButtonTooltip => 'تشغيل';

  @override
  String get progressSliderTooltip => 'الوصول إلى وقت معين';

  @override
  String get repeatModeButtonTooltip => 'تغيير وضع التكرار';

  @override
  String get replayButtonTooltip => 'إعادة تشغيل الكل';

  @override
  String get replayIntroduction => 'إعادة تشغيل المقدمة';

  @override
  String get rewindButtonTooltip => 'إرجاع خمس ثوانٍ';

  @override
  String get settingsAndInfoMenuTitle => 'الإعدادات';

  @override
  String get showTranslationTooltip => 'عرض أو إخفاء الترجمة';

  @override
  String sizeMultiplierSymbol(String size) {
    return '${size}x';
  }

  @override
  String get skipNextButtonTooltip => 'تخطٍ إلى التالي';

  @override
  String get skipPreviousButtonTooltip => 'تخطٍ إلى السابق';

  @override
  String get solveForX => 'أوجد x';

  @override
  String speedMultiplierSymbol(String speed) {
    return '${speed}x';
  }

  @override
  String get speedSliderTooltip => 'تغيير السرعة';

  @override
  String get themeMenuTitle => 'النسق';

  @override
  String get trackObject => 'مقطع صوتي';

  @override
  String get transcriptButtonLabel => 'النسخة المكتوبة';

  @override
  String get transcriptFullscreenTooltip => 'فتح وضع ملء الشاشة';

  @override
  String get translationLanguageDescription =>
      'تتوفر الترجمات أو النسخ المكتوبة بهذه اللغات. اختر واحدة لعرضها في شاشة النسخة المكتوبة. لا يغيّر هذا من لغة واجهة التطبيق.';

  @override
  String get translationLanguageListTileLabel => 'لغة الترجمة';

  @override
  String get wakelockTileLabel => 'إبقاء الشاشة مفتوحة';
}
