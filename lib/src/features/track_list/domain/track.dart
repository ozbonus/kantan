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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Track &&
        other.filename == filename &&
        other.album == album &&
        other.title == title &&
        other.displayDescription == displayDescription &&
        other.artist == artist &&
        other.duration == duration &&
        other.bundleName == bundleName &&
        other.trackObject == trackObject &&
        other.bundleTrack == bundleTrack &&
        other.absoluteTrack == absoluteTrack &&
        _mapEquals(other.transcripts, transcripts);
  }

  @override
  int get hashCode {
    return filename.hashCode ^
        album.hashCode ^
        title.hashCode ^
        displayDescription.hashCode ^
        artist.hashCode ^
        duration.hashCode ^
        bundleName.hashCode ^
        trackObject.hashCode ^
        bundleTrack.hashCode ^
        absoluteTrack.hashCode ^
        (transcripts == null ? 0 : transcripts.hashCode);
  }

  bool _mapEquals(
      Map<String, List<String>>? map1, Map<String, List<String>>? map2) {
    if (map1 == null && map2 == null) return true;
    if (map1 == null || map2 == null) return false;
    if (map1.length != map2.length) return false;

    for (final key in map1.keys) {
      if (!map2.containsKey(key)) return false;
      final list1 = map1[key]!;
      final list2 = map2[key]!;
      if (list1.length != list2.length) return false;
      for (int i = 0; i < list1.length; i++) {
        if (list1[i] != list2[i]) return false;
      }
    }
    return true;
  }
}
