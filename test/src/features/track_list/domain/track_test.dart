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
  "disc": 1,
  "discTotal": 2,
  "track": 1,
  "trackTotal": 99,
};

// displayDescription is null.
const Map<String, dynamic> trackMap2 = {
  "filename": "audio.m4a",
  "album": "Book Name",
  "title": "Track Title",
  "artist": "Artist",
  "duration": 1000,
  "disc": 1,
  "discTotal": 2,
  "track": 1,
  "trackTotal": 99,
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
    expect(track.disc, equals(1));
    expect(track.discTotal, equals(2));
    expect(track.track, equals(1));
    expect(track.trackTotal, equals(99));
  });

  test('Create a Track with null display description.', () {
    final track = Track.fromMap(trackMap2);
    expect(track.displayDescription, isNull);
  });
}
