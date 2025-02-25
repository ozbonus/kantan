import 'dart:convert';
import 'dart:ui';
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
  },
  'lines': [
    {
      'text': expected.text1,
    },
    {
      'text': expected.text2,
    },
  ],
};

final expectedTranscript = Transcript(
  locale: Locale.fromSubtags(
    languageCode: expected.languageCode,
    scriptCode: expected.scriptCode,
    countryCode: expected.countryCode,
  ),
  lines: [
    (speaker: expected.speaker1, text: expected.text1),
    (speaker: expected.speaker2, text: expected.text2),
  ],
  endTimes: [
    Duration(milliseconds: expected.endTime1),
    Duration(milliseconds: expected.endTime2),
  ],
);

final expectedTranscriptWithNull = Transcript(
  locale: Locale.fromSubtags(
    languageCode: expected.languageCode,
  ),
  lines: [
    (speaker: null, text: expected.text1),
    (speaker: null, text: expected.text2),
  ],
);
final testJson = json.encode(testMap);
final testJsonWithNull = json.encode(testMapWithNull);

void main() {
  test('Transcript from JSON.', () {
    final transcript = Transcript.fromJson(testJson);
    expect(transcript, equals(expectedTranscript));
  });

  test('Transcript from JSON with null values.', () {
    final transcript = Transcript.fromJson(testJsonWithNull);
    expect(transcript, equals(expectedTranscriptWithNull));
  });

  test('Transcript with null end times.', () {
    final transcript = Transcript.fromJson(testJsonWithNull);
    expect(transcript.endTimes, isNull);
  });
}
