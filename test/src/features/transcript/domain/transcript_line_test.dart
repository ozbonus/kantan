import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/transcript/domain/transcript_line.dart';

const expected = (
  startTime: 0,
  endTime: 100,
  speaker: 'Dash',
  text: 'fnord',
);

final Map<String, dynamic> lineMap = {
  'startTime': expected.startTime,
  'endTime': expected.endTime,
  'speaker': expected.speaker,
  'text': expected.text,
};

final Map<String, dynamic> lineMapWithNull = {
  'text': expected.text,
};

final expectedTranscriptLine = TranscriptLine(
  startTime: expected.startTime,
  endTime: expected.endTime,
  speaker: expected.speaker,
  text: expected.text,
);

final expectedTranscriptLineWithNull = TranscriptLine(
  text: expected.text,
);

void main() {
  test('Create a Transcript Line from a map with all values.', () {
    final line = TranscriptLine.fromMap(lineMap);
    expect(line, equals(expectedTranscriptLine));
  });

  test('Create a Transcript Line from a map with null values.', () {
    final line = TranscriptLine.fromMap(lineMapWithNull);
    expect(line, equals(expectedTranscriptLineWithNull));
  });
}
