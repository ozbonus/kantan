import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:kantan/src/features/transcript/domain/transcript_line.dart';
import 'package:kantan/src/features/transcript/domain/locale_from_map.dart';

class Transcript {
  Transcript({
    required this.locale,
    required this.lines,
  });

  final Locale locale;
  final List<TranscriptLine> lines;

  Transcript copyWith({
    Locale? locale,
    List<TranscriptLine>? lines,
  }) {
    return Transcript(
      locale: locale ?? this.locale,
      lines: lines ?? this.lines,
    );
  }

  factory Transcript.fromMap(Map<String, dynamic> map) {
    return Transcript(
      locale: LocaleFromMap.fromMap(map['locale'] as Map<String, String?>),
      lines: List<TranscriptLine>.from(
        (map['lines'] as List<Map<String, dynamic>>).map<TranscriptLine>(
          (x) => TranscriptLine.fromMap(x),
        ),
      ),
    );
  }

  factory Transcript.fromJson(String source) =>
      Transcript.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Transcript(locale: $locale, lines: $lines)';

  @override
  bool operator ==(covariant Transcript other) {
    if (identical(this, other)) return true;

    return other.locale == locale && listEquals(other.lines, lines);
  }

  @override
  int get hashCode => locale.hashCode ^ lines.hashCode;
}
