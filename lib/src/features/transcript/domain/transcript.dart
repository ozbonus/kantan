import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:kantan/src/features/transcript/domain/transcript_line.dart';

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

  factory Transcript.fromJson(String source) {
    final json = jsonDecode(source);
    return Transcript(
      locale: Locale.fromSubtags(
        languageCode: json['locale']['languageCode'] as String,
        scriptCode: json['locale']['scriptCode'] as String?,
        countryCode: json['locale']['countryCode'] as String?,
      ),
      lines: (json['lines'] as List<dynamic>).map((line) {
        return TranscriptLine(
          startTime: line['startTime'] as int?,
          endTime: line['endTime'] as int?,
          speaker: line['speaker'] as String?,
          text: line['text'] as String,
        );
      }).toList(),
    );
  }

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
