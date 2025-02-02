import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/transcript/domain/transcript_line.dart';

const expectedStartTime = 0;
const expectedEndTime = 100;
const expectedSpeaker = 'Dash';
const expectedText = 'fnord';

const Map<String, dynamic> lineMap = {
  'startTime': expectedStartTime,
  'endTime': expectedEndTime,
  'speaker': expectedSpeaker,
  'text': expectedText,
};

const Map<String, dynamic> lineMapNullSpeaker = {
  'startTime': expectedStartTime,
  'endTime': expectedEndTime,
  'text': expectedText,
};

void main() {
  test('Create a Transcript Line from a map with all values.', () {
    final line = TranscriptLine.fromMap(lineMap);
    expect(line.startTime, equals(expectedStartTime));
    expect(line.endTime, equals(expectedEndTime));
    expect(line.speaker, equals(expectedSpeaker));
    expect(line.text, equals(expectedText));
  });

  test('Create a Transcript Line from a map with null speaker.', () {
    final line = TranscriptLine.fromMap(lineMapNullSpeaker);
    expect(line.speaker, isNull);
  });
}
