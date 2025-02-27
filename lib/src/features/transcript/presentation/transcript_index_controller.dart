import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';

part 'transcript_index_controller.g.dart';

@riverpod
int? transcriptIndexProvider(Ref ref) {
  return ref.watch(transcriptControllerProvider).whenOrNull(
    data: (transcriptData) {
      final transcript = transcriptData.transcript;
      if (transcript == null || transcript.endTimes == null) {
        return null;
      }
      return ref.watch(positionDataStreamProvider).whenOrNull(
        data: (positionData) {
          final currentDuration = positionData.duration;
          final endTimes = transcript.endTimes!;
          final index =
              endTimes.indexWhere((endTime) => currentDuration < endTime);
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
