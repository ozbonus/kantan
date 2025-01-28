import 'dart:convert';

class Track {
  Track({
    required this.filename,
    required this.album,
    required this.artist,
    required this.title,
    this.displayDescription,
    required this.duration,
    required this.disc,
    required this.discTotal,
    required this.track,
    required this.trackTotal,
  });

  final String filename;
  final String album;
  final String artist;
  final String title;
  final String? displayDescription;
  final int duration;
  final String disc;
  final String discTotal;
  final String track;
  final String trackTotal;

  Track copyWith({
    String? filename,
    String? album,
    String? artist,
    String? title,
    String? displayDescription,
    int? duration,
    String? disc,
    String? discTotal,
    String? track,
    String? trackTotal,
  }) {
    return Track(
      filename: filename ?? this.filename,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      title: title ?? this.title,
      displayDescription: displayDescription ?? this.displayDescription,
      duration: duration ?? this.duration,
      disc: disc ?? this.disc,
      discTotal: discTotal ?? this.discTotal,
      track: track ?? this.track,
      trackTotal: trackTotal ?? this.trackTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filename': filename,
      'album': album,
      'artist': artist,
      'title': title,
      'displayDescription': displayDescription,
      'duration': duration,
      'disc': disc,
      'discTotal': discTotal,
      'track': track,
      'trackTotal': trackTotal,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      filename: map['filename'] as String,
      album: map['album'] as String,
      artist: map['artist'] as String,
      title: map['title'] as String,
      displayDescription: map['displayDescription'] != null
          ? map['displayDescription'] as String
          : null,
      duration: map['duration'] as int,
      disc: map['disc'] as String,
      discTotal: map['discTotal'] as String,
      track: map['track'] as String,
      trackTotal: map['trackTotal'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Track.fromJson(String source) =>
      Track.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Track(filename: $filename, album: $album, artist: $artist, title: $title, displayDescription: $displayDescription, duration: $duration, disc: $disc, discTotal: $discTotal, track: $track, trackTotal: $trackTotal)';
  }

  @override
  bool operator ==(covariant Track other) {
    if (identical(this, other)) return true;

    return other.filename == filename &&
        other.album == album &&
        other.artist == artist &&
        other.title == title &&
        other.displayDescription == displayDescription &&
        other.duration == duration &&
        other.disc == disc &&
        other.discTotal == discTotal &&
        other.track == track &&
        other.trackTotal == trackTotal;
  }

  @override
  int get hashCode {
    return filename.hashCode ^
        album.hashCode ^
        artist.hashCode ^
        title.hashCode ^
        displayDescription.hashCode ^
        duration.hashCode ^
        disc.hashCode ^
        discTotal.hashCode ^
        track.hashCode ^
        trackTotal.hashCode;
  }
}
