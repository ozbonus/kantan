import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/application/translation_locale_service.dart';
import 'package:kantan/src/features/transcript/data/transcript_repository.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transcript_controller.g.dart';

@riverpod
class TranscriptController extends _$TranscriptController {
  @override
  FutureOr<({Transcript? transcript, Transcript? translation})> build() {
    ref.watch(translationLocaleServiceProvider); // Trigger rebuild on change.
    final trackValue = ref.watch(currentTrackStreamProvider);
    return trackValue.when(
      loading: () => (transcript: null, translation: null),
      error: (e, st) => (transcript: null, translation: null),
      data: (track) async {
        if (track == null) {
          return (transcript: null, translation: null);
        }
        final transcript = await ref
            .read(transcriptRepositoryProvider)
            .getTranscript(track, Config.transcriptLocale);
        final translationLocale = ref.watch(translationLocaleServiceProvider);
        final translation = await ref
            .read(transcriptRepositoryProvider)
            .getTranscript(track, translationLocale);
        return (transcript: transcript, translation: translation);
      },
    );
  }
}
