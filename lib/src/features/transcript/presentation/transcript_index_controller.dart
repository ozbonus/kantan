import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/transcript/presentation/debounced_position_data_stream.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';

part 'transcript_index_controller.g.dart';

/// Provides the index of the transcript line presently being spoken.
///
/// Returns an [int] index when a transcript and position data stream are
/// available.
///
/// Returns [null] under the following conditions:
/// * during [AsyncLoading] and [AsyncError]
/// * [Transcript.transcript] is null
/// * [Transcript.transcript.endTimes] is null
/// * the index is out of bounds of the transcript (possible when seeking)
@riverpod
int? transcriptIndexController(Ref ref) {
  final transcriptValue = ref.watch(transcriptControllerProvider);
  final positionDataValue = ref.watch(debouncedPositionStreamProvider);

  return transcriptValue.whenOrNull(
    data: (transcriptData) {
      final transcript = transcriptData.transcript;
      if (transcript?.endTimes == null) return null;

      return positionDataValue.whenOrNull(
        data: (positionData) {
          final currentPosition = positionData.position;
          final endTimes = transcript!.endTimes!;

          final index = endTimes.indexWhere(
            (endTime) => currentPosition < endTime,
          );

          return index >= 0 ? index : null;
        },
      );
    },
  );
}
