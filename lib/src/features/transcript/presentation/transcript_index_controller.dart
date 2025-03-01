import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
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
  return ref.watch(transcriptControllerProvider).whenOrNull(
        error: (e, st) => throw Exception('$e $st'),
        data: (transcriptData) {
          final transcript = transcriptData.transcript;
          if (transcript == null || transcript.endTimes == null) {
            return null;
          }
          return ref.watch(positionDataStreamProvider).whenOrNull(
            data: (positionData) {
              final currentPosition = positionData.position;
              final endTimes = transcript.endTimes!;
              final index =
                  endTimes.indexWhere((endTime) => currentPosition < endTime);
              if (index >= 0) {
                return index;
              } else {
                return null;
              }
            },
          );
        },
      );
}
