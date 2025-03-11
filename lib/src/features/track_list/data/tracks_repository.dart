import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracks_repository.g.dart';

class TracksRepository {
  const TracksRepository(this.tracksMap);

  // A JSON-formatted map that contains essential track data.
  final Map<String, dynamic> tracksMap;

  List<Track> tracksList() {
    final tracksList = tracksMap.entries.map((trackMap) {
      return Track.fromMap(trackMap.value as Map<String, dynamic>);
    }).toList();
    return tracksList;
  }
}

@Riverpod(keepAlive: true)
FutureOr<List<Track>> tracksRepository(Ref ref) async {
  final tracksJsonUri = 'packages/${Config.assetsPackage}/assets/tracks.json';
  final tracksJson = await rootBundle.loadString(tracksJsonUri);
  final tracksMap = jsonDecode(tracksJson) as Map<String, dynamic>;
  final tracksRepository = TracksRepository(tracksMap);
  return tracksRepository.tracksList();
}
