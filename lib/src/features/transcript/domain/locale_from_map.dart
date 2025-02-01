import 'dart:ui';

extension LocaleFromMap on Locale {
  static Locale fromMap(Map<String, String?> map) {
    final languageCode = map['languageCode']!;
    final countryCode = map['countryCode'];
    final scriptCode = map['scriptCode'];
    return Locale.fromSubtags(
      languageCode: languageCode,
      countryCode: countryCode,
      scriptCode: scriptCode,
    );
  }
}
