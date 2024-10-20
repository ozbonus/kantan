class Track {
  Track({
    required this.filename,
    required this.album,
    this.title,
    this.displayDescription,
    required this.artist,
    required this.duration,
    this.bundleName,
    required this.trackObject,
    required this.bundleTrack,
    required this.absoluteTrack,
    this.transcripts,
  }) {
    if (transcripts != null) {
      final lengths = transcripts!.values.map((e) => e.length).toList();
      final allEqual = lengths.every((len) => len == lengths[0]);
      if (!allEqual) {
        throw ArgumentError('Transcripts must have an equal number of lines.');
      }
    }
  }

  final String filename;
  final String album;
  final String? title;
  final String? displayDescription;
  final String artist;
  final double duration;
  final String? bundleName;
  final String trackObject;
  final String bundleTrack;
  final String absoluteTrack;
  final Map<String, List<String>>? transcripts;

  Track copyWith({
    String? filename,
    String? album,
    String? title,
    String? displayDescription,
    String? artist,
    double? duration,
    String? bundleName,
    String? trackObject,
    String? bundleTrack,
    String? absoluteTrack,
    Map<String, List<String>>? transcripts,
  }) {
    return Track(
      filename: filename ?? this.filename,
      album: album ?? this.album,
      title: title ?? this.title,
      displayDescription: displayDescription ?? this.displayDescription,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      bundleName: bundleName ?? this.bundleName,
      trackObject: trackObject ?? this.trackObject,
      bundleTrack: bundleTrack ?? this.bundleTrack,
      absoluteTrack: absoluteTrack ?? this.absoluteTrack,
      transcripts: transcripts ?? this.transcripts,
    );
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      filename: map['filename'] as String,
      album: map['album'] as String,
      title: map['title'] as String?,
      displayDescription: map['displayDescription'] as String?,
      artist: map['artist'] as String,
      duration: map['duration'] as double,
      bundleName: map['bundleName'] as String?,
      trackObject: map['trackObject'] as String,
      bundleTrack: map['bundleTrack'] as String,
      absoluteTrack: map['absoluteTrack'] as String,
      transcripts: (map['transcripts'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          List<String>.from(value),
        ),
      ),
    );
  }
}
