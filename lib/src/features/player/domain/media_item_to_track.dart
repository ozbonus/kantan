import 'package:audio_service/audio_service.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';

extension MediaItemToTrack on MediaItem {
  Track get track => Track(
        filename: id,
        album: album!,
        artist: artist!,
        title: title,
        displayDescription: displayDescription,
        duration: duration!.inMilliseconds,
        disc: extras!['disc'],
        discTotal: extras!['discTotal'],
        track: extras!['track'],
        trackTotal: extras!['trackTotal'],
      );
}
