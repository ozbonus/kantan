import 'package:audio_service/audio_service.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';

extension TrackToMediaItem on Track {
  MediaItem get mediaItem => MediaItem(
        id: filename,
        album: album,
        title: title,
        displayDescription: displayDescription,
        artist: artist,
        duration: Duration(milliseconds: duration),
      );
}
