// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String aboutAndInfoTileLabel(String appName) {
    return 'ข้อมูลเกี่ยวกับแอป';
  }

  @override
  String get appLanguageDescription =>
      'การเปลี่ยนภาษาที่ใช้ในอินเทอร์เฟซของแอป จะไม่ได้เปลี่ยนภาษาที่ใช้แปลคําบรรยาย\n';

  @override
  String get appLanguageListTileLabel => 'ภาษาที่ใช้ในอินเทอร์เฟซ';

  @override
  String get cancelButtonLabel => 'ยกเลิก';

  @override
  String get noTranscriptMessage => 'No transcript for this track.';

  @override
  String get canSeeTranscriptTileLabel => 'สามารถดูคําบรรยายได้';

  @override
  String get canSeeTranslationTileLabel => 'สามารถดูคำแปลได้';

  @override
  String get changeTextSizeTooltip => 'ปรับขนาดข้อความ';

  @override
  String get checkAnswerButtonText => 'ตรวจคําตอบ';

  @override
  String get closeSettingsAndInfoTileLabel => 'ปิด';

  @override
  String get darkTheme => 'ธีมมืด';

  @override
  String get defaultLanguageOptionLabel => 'ภาษาเริ่มต้นของอุปกรณ์';

  @override
  String get deviceTheme => 'ธีมของอุปกรณ์';

  @override
  String get disableModeWindowTitle => 'ปิดโหมด';

  @override
  String get disableParentTeacherModeConfirmationText =>
      'คุณต้องการปิดโหมดผู้ปกครองและครูหรือไม่';

  @override
  String get discObject => 'ซีดี';

  @override
  String get exitFullscreenTooltip => 'ออกจากโหมดเต็มหน้าจอ';

  @override
  String get fastForwardButtonTooltip => 'ไปข้างหน้าห้าวินาที';

  @override
  String get lightTheme => 'ธีมสว่าง';

  @override
  String get loadingButtonTooltip => 'กำลังโหลด';

  @override
  String get loadingLabel => 'กำลังโหลด...';

  @override
  String get mathChallengeWarning =>
      'คุณต้องแก้โจทย์คณิตศาสตร์เพื่อเปิดใช้งานอีกครั้ง';

  @override
  String get noTranslationLanguageOptionLabel => 'ไม่มี';

  @override
  String get okButtonText => 'ตกลง';

  @override
  String get openPlayerControlsTooltip => 'เปิดตัวควบคุมการเล่น';

  @override
  String get parentAndTeacherModeTileLabel => 'โหมดผู้ปกครองและครู';

  @override
  String get parentTeacherModeActivatedPopup =>
      'เปิดใช้งานโหมดผู้ปกครองและครูแล้ว';

  @override
  String get parentTeacherModeWindowTitle => 'สำหรับผู้ปกครองและครู';

  @override
  String get pauseButtonTooltip => 'หยุดชั่วคราว';

  @override
  String get playButtonTooltip => 'เล่น';

  @override
  String get progressSliderTooltip => 'เลื่อนไปยังเวลาที่ต้องการ';

  @override
  String get repeatModeButtonTooltip => 'เปลี่ยนโหมดการเล่นซ้ำ';

  @override
  String get replayButtonTooltip => 'เล่นซ้ำทั้งหมด';

  @override
  String get replayIntroduction => 'เล่นซ้ำบทแนะนำ';

  @override
  String get rewindButtonTooltip => 'ย้อนกลับห้าวินาที';

  @override
  String get settingsAndInfoMenuTitle => 'การตั้งค่า';

  @override
  String get showTranslationTooltip => 'แสดงหรือซ่อนคำแปล';

  @override
  String sizeMultiplierSymbol(String size) {
    return '${size}x';
  }

  @override
  String get skipNextButtonTooltip => 'ข้ามไปยังรายการถัดไป';

  @override
  String get skipPreviousButtonTooltip => 'ข้ามไปยังรายการก่อนหน้า';

  @override
  String get solveForX => 'หาค่า x';

  @override
  String speedMultiplierSymbol(String speed) {
    return '${speed}x';
  }

  @override
  String get speedSliderTooltip => 'ปรับความเร็ว';

  @override
  String get themeMenuTitle => 'ธีม';

  @override
  String get trackObject => 'แทร็ก';

  @override
  String get transcriptButtonLabel => 'คําบรรยาย';

  @override
  String get transcriptFullscreenTooltip => 'เปิดแบบเต็มหน้าจอ';

  @override
  String get translationLanguageDescription =>
      'มีการแปลคําบรรยายเป็นภาษาต่างๆ เหล่านี้ โปรดเลือกหนึ่งภาษาเพื่อแสดงในหน้าจอคําบรรยาย ซึ่งจะไม่ได้เปลี่ยนภาษาที่ใช้ในอินเทอร์เฟซของแอป';

  @override
  String get translationLanguageListTileLabel => 'ภาษาของคำแปล';

  @override
  String get wakelockTileLabel => 'ให้หน้าจอเปิดค้างไว้';
}
