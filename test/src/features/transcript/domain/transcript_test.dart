import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';

const expected = (
  languageCode: 'zh',
  scriptCode: 'Hant',
  countryCode: 'TW',
  fullLanguageTag: 'zh-Hant-TW',
  minimalLanguageTag: 'zh',
  startTime1: 0,
  endTime1: 99,
  speaker1: 'Dash',
  text1: 'I am Dash.',
  startTime2: 100,
  endTime2: 199,
  speaker2: 'Fnord',
  text2: 'I am Fnord.',
);

final testMap = {
  'locale': {
    'languageCode': expected.languageCode,
    'scriptCode': expected.scriptCode,
    'countryCode': expected.countryCode,
  },
  'lines': [
    {
      'startTime': expected.startTime1,
      'endTime': expected.endTime1,
      'speaker': expected.speaker1,
      'text': expected.text1,
    },
    {
      'startTime': expected.startTime2,
      'endTime': expected.endTime2,
      'speaker': expected.speaker2,
      'text': expected.text2,
    },
  ],
};

final testMapWithNull = {
  'locale': {
    'languageCode': expected.languageCode,
    // 'scriptCode' is null.
    // 'countryCode' is null.
  },
  'lines': [
    {
      'startTime': expected.startTime1,
      'endTime': expected.endTime1,
      // 'speaker' is null.
      'text': expected.text1,
    },
    {
      'startTime': expected.startTime2,
      'endTime': expected.endTime2,
      // 'speaker' is null.
      'text': expected.text2,
    },
  ],
};

void main() {
  group('All values are non-null.', () {
    late Transcript transcript;

    setUp(() {
      transcript = Transcript.fromMap(testMap);
    });

    test('Locale is zh-Hant-TW.', () {
      final languageTag = transcript.locale.toLanguageTag();
      expect(languageTag, equals(expected.fullLanguageTag));
    });

    test('There are two lines.', () {
      expect(transcript.lines.length, equals(2));
    });

    test('First line matches expectation.', () {
      final line = transcript.lines[0];
      expect(line.startTime, equals(expected.startTime1));
      expect(line.endTime, equals(expected.endTime1));
      expect(line.speaker, equals(expected.speaker1));
      expect(line.text, equals(expected.text1));
    });

    test('Second line matches expectation.', () {
      final line = transcript.lines[1];
      expect(line.startTime, equals(expected.startTime2));
      expect(line.endTime, equals(expected.endTime2));
      expect(line.speaker, equals(expected.speaker2));
      expect(line.text, equals(expected.text2));
    });
  });

  group('Nullable values are null.', () {
    late Transcript transcript;

    setUp(() {
      transcript = Transcript.fromMap(testMapWithNull);
    });

    test('Locale is zh', () {
      final languageTag = transcript.locale.toLanguageTag();
      expect(languageTag, equals(expected.minimalLanguageTag));
    });

    test('First line matches expectation.', () {
      final line = transcript.lines[0];
      expect(line.startTime, equals(expected.startTime1));
      expect(line.endTime, equals(expected.endTime1));
      expect(line.speaker, isNull);
      expect(line.text, equals(expected.text1));
    });

    test('Second line matches expectation.', () {
      final line = transcript.lines[1];
      expect(line.startTime, equals(expected.startTime2));
      expect(line.endTime, equals(expected.endTime2));
      expect(line.speaker, isNull);
      expect(line.text, equals(expected.text2));
    });
  });
}
