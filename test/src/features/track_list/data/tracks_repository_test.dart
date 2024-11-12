import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/track_list/data/tracks_repository.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';

const Map<String, dynamic> trackMap1 = {
  'filename': 'audio.m4a',
  'album': 'Book Name',
  'title': 'Track Title',
  'displayDescription': 'Display Description',
  'artist': 'Artist',
  'duration': 599900,
  'bundleName': 'Bundle Name',
  'trackObject': 'Track',
  'bundleTrack': '1',
  'absoluteTrack': '1',
  'transcripts': {
    'en': ['Hello', 'What\'s your name?'],
    'ja': ['今日は', 'お名前は？'],
    'zh-TW': ['你好', '你叫什麼名字？'],
  },
};

// All nullable fields are left unpopulated.
const Map<String, dynamic> trackMap2 = {
  'filename': 'audio.m4a',
  'album': 'Book Name',
  'artist': 'Artist',
  'duration': 599900,
  'trackObject': 'Track',
  'bundleTrack': '1',
  'absoluteTrack': '1',
};

const tracksMap = {
  'TRACK1': trackMap1,
  'TRACK2': trackMap2,
};

final track1 = Track.fromMap(trackMap1);
final track2 = Track.fromMap(trackMap2);

// All nullable fields are left unpopulated.

void main() {
  test('Create a normal list of tracks', () {
    const repository = TracksRepository(tracksMap);
    final tracksList = repository.tracksList();
    expect(tracksList, isA<List<Track>>());
  });

  test('Verify tracks are properly formed.', () {
    const repository = TracksRepository(tracksMap);
    final tracksList = repository.tracksList();
    expect(tracksList[0], equals(track1));
    expect(tracksList[1], equals(track2));
  });
}
