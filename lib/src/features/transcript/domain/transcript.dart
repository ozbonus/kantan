import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';

/// A record to hold essential information about a single line of a transcript.
typedef TranscriptLine = ({
  Duration? startTime,
  String? speaker,
  String text,
});

/// A data class that contains all of the essential information about a
/// transcript for a single track, for a single locale.
///
/// Transcript files must follow a specific naming pattern based on track name
/// and locale. If a track is named [001.m4a], then the English language
/// transcript must be named [001.en.json].
///
/// This JSON scheme follows this format:
///
/// * "locale": Map <------------- REQUIRED
///   * "languageCode": String <-- REQUIRED
///   * "scriptCode": String
///   * "countryCode": String
/// * "lines": Array[Map] <------- REQUIRED
///   * "text": String <---------- REQUIRED
///   * "speaker": String
///   * "startTime": int
///   * "endTime": int
///
/// Here's an example with all fields used:
///
/// ```json
/// {
///   "locale": {
///     "languageCode": "cn",
///     "scriptCode": "Hant",
///     "countryCode": "TW"
///   },
///   "lines": [
///     {
///       "startTime": 0,
///       "endTime": 4000,
///       "speaker": "Tom",
///       "text": "Hello. What's your name?"
///     },
///     {
///       "startTime": 4000,
///       "endTime": 9000,
///       "speaker": "Jane",
///       "text": "My name's Jane. Nice to mee you."
///     }
///   ]
/// }
/// ```
///
/// Here is the same, but minus optional fields:
///
/// ```json
/// {
///   "locale": {
///     "languageCode": "cn",
///   },
///   "lines": [
///     {
///       "text": "Hello. What's your name?"
///     },
///     {
///       "text": "My name's Jane. Nice to mee you."
///     }
///   ]
/// }
/// ```
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
