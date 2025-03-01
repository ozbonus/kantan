import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';

part 'transcript_index_controller.g.dart';

@riverpod
int? transcriptIndexController(Ref ref) {
  return ref.watch(transcriptControllerProvider).whenOrNull(
    data: (transcriptData) {
      final transcript = transcriptData.transcript;
      if (transcript == null || transcript.endTimes == null) {
        debugPrint('Transcript index: null');
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
