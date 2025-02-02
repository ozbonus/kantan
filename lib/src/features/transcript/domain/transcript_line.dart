import 'dart:convert';

class TranscriptLine {
  TranscriptLine({
    required this.startTime,
    required this.endTime,
    this.speaker,
    required this.text,
  });

  final int startTime;
  final int endTime;
  final String? speaker;
  final String text;

  TranscriptLine copyWith({
    int? startTime,
    int? endTime,
    String? speaker,
    String? text,
  }) {
    return TranscriptLine(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      speaker: speaker ?? this.speaker,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime,
      'endTime': endTime,
      'speaker': speaker,
      'text': text,
    };
  }

  factory TranscriptLine.fromMap(Map<String, dynamic> map) {
    return TranscriptLine(
      startTime: map['startTime'] as int,
      endTime: map['endTime'] as int,
      speaker: map['speaker'] != null ? map['speaker'] as String : null,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TranscriptLine.fromJson(String source) =>
      TranscriptLine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TranscriptLine(startTime: $startTime, endTime: $endTime, speaker: $speaker, text: $text)';
  }

  @override
  bool operator ==(covariant TranscriptLine other) {
    if (identical(this, other)) return true;

    return other.startTime == startTime &&
        other.endTime == endTime &&
        other.speaker == speaker &&
        other.text == text;
  }

  @override
  int get hashCode {
    return startTime.hashCode ^
        endTime.hashCode ^
        speaker.hashCode ^
        text.hashCode;
  }
}
