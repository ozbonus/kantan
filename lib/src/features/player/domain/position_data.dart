// ignore_for_file: public_member_api_docs, sort_constructors_first
class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData copyWith({
    Duration? position,
    Duration? bufferedPosition,
    Duration? duration,
  }) {
    return PositionData(
      position ?? this.position,
      bufferedPosition ?? this.bufferedPosition,
      duration ?? this.duration,
    );
  }

  @override
  String toString() =>
      'PositionData(position: $position, bufferedPosition: $bufferedPosition, duration: $duration)';

  @override
  bool operator ==(covariant PositionData other) {
    if (identical(this, other)) return true;

    return other.position == position &&
        other.bufferedPosition == bufferedPosition &&
        other.duration == duration;
  }

  @override
  int get hashCode =>
      position.hashCode ^ bufferedPosition.hashCode ^ duration.hashCode;
}
