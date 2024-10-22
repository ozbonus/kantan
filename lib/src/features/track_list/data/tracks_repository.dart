import 'package:kantan/src/features/track_list/domain/track.dart';

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
