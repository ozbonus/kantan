import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/data/transcript_repository.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transcript_controller.g.dart';

@riverpod
class TranscriptController extends _$TranscriptController {
  @override
  FutureOr<Transcript?> build() {
    final trackValue = ref.watch(currentTrackStreamProvider);
    return trackValue.when(
      loading: () => null,
      error: (e, st) => null,
      data: (track) async {
        if (track == null) {
          return null;
        } else {
          final transcript = await ref
              .read(transcriptRepositoryProvider)
              .getTranscript(track, Config.transcriptLocale);
          return transcript;
        }
      },
    );
  }
}
