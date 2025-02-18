import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/application/transcript_index_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/domain/transcript_line.dart';

part 'transcript_line_controller.g.dart';

enum PlaybackPosition { before, during, after }

@riverpod
PlaybackPosition? transcriptLineController(
  Ref ref,
  TranscriptLine line,
  int index,
) {
  final positionValue = ref.watch(positionDataStreamProvider);
  return positionValue.when(
    loading: () {
      debugPrint('Loading');
      return null;
    },
    error: (e, st) {
      debugPrint('$e $st');
      return null;
    },
    data: (positionData) {
      final currentTime = positionData.position.inMilliseconds;
      if (currentTime < line.startTime!) {
        return PlaybackPosition.before;
      } else if (currentTime >= line.endTime!) {
        return PlaybackPosition.after;
      } else {
        return PlaybackPosition.during;
      }
    },
  );
}

@riverpod
seekToLine(Ref ref, TranscriptLine line) {
  final lineStart = Duration(milliseconds: line.startTime!);
  return ref.read(audioHandlerProvider).requireValue.seek(lineStart);
}

// @riverpod
// class TranscriptLineController extends _$TranscriptLineController {
//   @override
//   PlaybackPosition build(TranscriptLine line) {
//     final positionValue = ref.watch(positionDataStreamProvider);
//     return positionValue.when(
//       loading: () {
//         debugPrint('Loading');
//         return PlaybackPosition.during;
//       },
//       error: (e, st) {
//         debugPrint('$e $st');
//         return PlaybackPosition.during;
//       },
//       data: (positionData) {
//         final currentTime = positionData.position.inMilliseconds;
//         if (currentTime < line.startTime!) {
//           return PlaybackPosition.before;
//         } else if (currentTime > line.endTime!) {
//           return PlaybackPosition.after;
//         } else {
//           return PlaybackPosition.during;
//         }
//       },
//     );
//   }

//   void seekToLine() {
//     if (line.startTime != null) {
//       final startPosition = Duration(milliseconds: line.startTime!);
//       ref.read(audioHandlerProvider).requireValue.seek(startPosition);
//     }
//   }
// }
