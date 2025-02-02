import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/track_list/data/track_to_media_item.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';

const expected = (
  filename: 'filename',
  album: 'album',
  artist: 'artist',
  title: 'title',
  displayDescription: 'displayDescription',
  duration: Duration(milliseconds: 1000),
  durationMilliseconds: 1000,
  disc: '1',
  discTotal: '2',
  track: '3',
  trackTotal: '4',
);

final testTrack = Track(
  filename: expected.filename,
  album: expected.album,
  artist: expected.artist,
  title: expected.title,
  displayDescription: expected.displayDescription,
  duration: expected.durationMilliseconds,
  disc: expected.disc,
  discTotal: expected.discTotal,
  track: expected.track,
  trackTotal: expected.trackTotal,
);

final testTrackWithNull = Track(
  filename: expected.filename,
  album: expected.album,
  artist: expected.artist,
  title: expected.title,
  displayDescription: null,
  duration: expected.durationMilliseconds,
  disc: expected.disc,
  discTotal: expected.discTotal,
  track: expected.track,
  trackTotal: expected.trackTotal,
);

final testMediaItem = MediaItem(
  id: expected.filename,
  album: expected.album,
  title: expected.title,
  displayDescription: expected.displayDescription,
  artist: expected.artist,
  duration: expected.duration,
  extras: {
    'disc': expected.disc,
    'discTotal': expected.discTotal,
    'track': expected.track,
    'trackTotal': expected.trackTotal,
  },
);

final testMediaItemWithNull = MediaItem(
  id: expected.filename,
  album: expected.album,
  title: expected.title,
  displayDescription: null,
  artist: expected.artist,
  duration: expected.duration,
  extras: {
    'disc': expected.disc,
    'discTotal': expected.discTotal,
    'track': expected.track,
    'trackTotal': expected.trackTotal,
  },
);

void main() {
  test('Track to MediaItem.', () {
    final mediaItem = testTrack.mediaItem;
    expect(mediaItem, equals(testMediaItem));
  });

  test('Display description is null.', () {
    final mediaItem = testTrackWithNull.mediaItem;
    expect(mediaItem, testMediaItemWithNull);
  });
}
