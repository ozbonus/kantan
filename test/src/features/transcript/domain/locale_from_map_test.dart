import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/transcript/domain/locale_from_map.dart';

const expected = (
  languageCode: 'zh',
  scriptCode: 'Hant',
  countryCode: 'TW',
  fullLanguageTag: 'zh-Hant-TW',
  languageCountryTag: 'zh-TW',
  minimalLanguageTag: 'zh',
);

final fullTestMap = {
  'languageCode': expected.languageCode,
  'scriptCode': expected.scriptCode,
  'countryCode': expected.countryCode,
};

final languageCountryTestMap = {
  'languageCode': expected.languageCode,
  'countryCode': expected.countryCode,
};

final minimalTestMap = {
  'languageCode': expected.languageCode,
};

void main() {
  test('Locale from all subtags.', () {
    final locale = LocaleFromMap.fromMap(fullTestMap);
    expect(locale.toLanguageTag(), equals(expected.fullLanguageTag));
  });

  test('Locale from language and country subtags.', () {
    final locale = LocaleFromMap.fromMap(languageCountryTestMap);
    expect(locale.toLanguageTag(), equals(expected.languageCountryTag));
  });

  test('Locale from just language subtag.', () {
    final locale = LocaleFromMap.fromMap(minimalTestMap);
    expect(locale.toLanguageTag(), equals(expected.minimalLanguageTag));
  });
}
