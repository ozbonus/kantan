import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';

// All fields are populated with good values.
const Map<String, dynamic> trackMap1 = {
  "filename": "audio.m4a",
  "album": "Book Name",
  "title": "Track Title",
  "displayDescription": "Display Description",
  "artist": "Artist",
  "duration": 1000,
  "bundleName": "Bundle Name",
  "trackObject": "Track",
  "bundleTrack": "1",
  "absoluteTrack": "1",
  "transcripts": {
    "en": ["Hello", "What's your name?"],
    "ja": ["今日は", "お名前は？"],
    "zh-TW": ["你好", "你叫什麼名字？"],
  },
};

// All nullable fields are left unpopulated.
const Map<String, dynamic> trackMap2 = {
  "filename": "audio.m4a",
  "album": "Book Name",
  "title": "Track Title",
  "artist": "Artist",
  "duration": 1000,
  "trackObject": "Track",
  "bundleTrack": "1",
  "absoluteTrack": "1",
};

// The Chinese transcript is too short.
const Map<String, dynamic> trackMap3 = {
  "filename": "audio.m4a",
  "album": "Book Name",
  "title": "Track Title",
  "displayDescription": "Display Description",
  "artist": "Artist",
  "duration": 1000,
  "bundleName": "Bundle Name",
  "trackObject": "Track",
  "bundleTrack": "1",
  "absoluteTrack": "1",
  "transcripts": {
    "en": ["Hello", "What's your name?"],
    "ja": ["今日は", "お名前は？"],
    "zh-TW": ["你好"],
  },
};

void main() {
  test('Create a complete Track from a Map', () {
    final track = Track.fromMap(trackMap1);

    expect(track.filename, equals("audio.m4a"));
    expect(track.album, equals("Book Name"));
    expect(track.title, equals("Track Title"));
    expect(track.displayDescription, equals("Display Description"));
    expect(track.artist, equals("Artist"));
    expect(track.duration, equals(1000));
    expect(track.bundleName, equals("Bundle Name"));
    expect(track.trackObject, equals("Track"));
    expect(track.bundleTrack, equals("1"));
    expect(track.absoluteTrack, equals("1"));
    expect(track.transcripts, isNotNull);
    expect(track.transcripts!.length, equals(3));
    expect(track.transcripts!['en'], equals(["Hello", "What's your name?"]));
    expect(track.transcripts!['ja'], equals(["今日は", "お名前は？"]));
    expect(track.transcripts!['zh-TW'], equals(["你好", "你叫什麼名字？"]));
  });

  test('Create a Track with null values.', () {
    final track = Track.fromMap(trackMap2);

    expect(track.displayDescription, isNull);
    expect(track.bundleName, isNull);
    expect(track.transcripts, isNull);
  });

  test('Create a Track with unequal transcript lengths.', () {
    expect(() => Track.fromMap(trackMap3), throwsArgumentError);
  });
}
