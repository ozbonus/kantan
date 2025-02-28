import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';

typedef TranscriptLine = ({
  Duration? startTime,
  String? speaker,
  String text,
});

class Transcript {
  Transcript({
    required this.locale,
    required this.lines,
    this.endTimes,
  });

  final Locale locale;
  final List<TranscriptLine> lines;
  final List<Duration>? endTimes;

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
    List<Duration>? endTimes;
    if (json['lines'][0].containsKey('endTime')) {
      endTimes = (json['lines'] as List<dynamic>)
          .map((line) => Duration(milliseconds: line['endTime']))
          .toList(growable: false);
    }
    return Transcript(
      locale: Locale.fromSubtags(
        languageCode: json['locale']['languageCode'] as String,
        scriptCode: json['locale']['scriptCode'] as String?,
        countryCode: json['locale']['countryCode'] as String?,
      ),
      lines: (json['lines'] as List<dynamic>).map((line) {
        // If endTimes is not null, then lines are certain to have start times.
        Duration? startTime;
        if (endTimes != null) {
          startTime = Duration(milliseconds: line['startTime'] as int);
        }
        return (
          startTime: startTime,
          speaker: line['speaker'] as String?,
          text: line['text'] as String,
        );
      }).toList(),
      endTimes: endTimes,
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
