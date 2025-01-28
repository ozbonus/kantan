import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/track_list/data/tracks_repository.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';

const Map<String, dynamic> trackMap1 = {
  'filename': 'audio.m4a',
  'album': 'Book Name',
  'artist': 'Artist',
  'title': 'Track Title',
  'displayDescription': 'Display Description',
  'duration': 599900,
  'disc': "1",
  'discTotal': "1",
  'track': "1",
  'trackTotal': "2"
};

// All nullable fields are left unpopulated.
const Map<String, dynamic> trackMap2 = {
  'filename': 'audio.m4a',
  'album': 'Book Name',
  'artist': 'Artist',
  'title': 'Track Title',
  'duration': 599900,
  'disc': "1",
  'discTotal': "1",
  'track': "2",
  'trackTotal': "2"
};

const tracksMap = {
  'TRACK1': trackMap1,
  'TRACK2': trackMap2,
};

final track1 = Track.fromMap(trackMap1);
final track2 = Track.fromMap(trackMap2);

final trackList = [track1, track2];

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

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

  // test('Make MediaItems', () {
  //   final container = createContainer();
  //   final mediaItemList = container.read(mediaItemListProvider(trackList));
  //   expect(mediaItemList, isA<List<MediaItem>>());
  // });

  // test('MediaItems are correct.', () {
  //   final container = createContainer();
  //   final mediaItemList = container.read(mediaItemListProvider(trackList));
  //   final expectedMediaitem = MediaItem(
  //     id: track1.filename,
  //     album: track1.album,
  //     title: track1.title,
  //     displayDescription: track1.displayDescription,
  //     artist: track1.artist,
  //     duration: Duration(milliseconds: track1.duration),
  //   );
  //   expect(mediaItemList[0], equals(expectedMediaitem));
  // });
}
