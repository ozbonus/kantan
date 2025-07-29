import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/application/translation_locale_service.dart';
import 'package:kantan/src/features/transcript/data/transcript_repository.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';

part 'transcript_controller.g.dart';

typedef TranscriptBundle = ({Transcript? transcript, Transcript? translation});

/// Provides a transcript and translation for the current track, if either are
/// available.
///
/// Watches the current track stream provider and when a track is provided,
/// attempts to load transcript data from two files: one for the verbatim
/// transcript, and another for the translation.
///
/// Returns a Riverpod [AsyncValue]. If that value is [AsyncData], the data is a
/// record of two nullable [Transcript?] objects, as mentioned above. If either
/// is not available, then its associated member will be [null].
@riverpod
class TranscriptController extends _$TranscriptController {
  @override
  FutureOr<TranscriptBundle> build() {
    final trackValue = ref.watch(currentTrackStreamProvider);
    final translationLocale = ref.watch(translationLocaleServiceProvider);

    return trackValue.when(
      loading: () => (transcript: null, translation: null),
      error: (e, st) => (transcript: null, translation: null),
      data: (track) async {
        if (track == null) {
          return (transcript: null, translation: null);
        }

        final results = await Future.wait([
          ref
              .read(transcriptRepositoryProvider)
              .getTranscript(track, Config.transcriptLocale),
          ref
              .read(transcriptRepositoryProvider)
              .getTranscript(track, translationLocale),
        ]);

        return (transcript: results[0], translation: results[1]);
      },
    );
  }
}
