import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/application/translation_locale_service.dart';
import 'package:kantan/src/features/transcript/data/transcript_repository.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';

part 'transcript_controller.g.dart';

/// Provides a transcript and translation for the current track, if either are
/// available.
///
/// Watches the current track stream provider and when a track is provided,
/// attempts to load transcript data from two files: one for the verbatim
/// transcript, and another for the translation.
///
/// Transcript files must follow a specific naming pattern based on track name
/// and locale. If a track is named [001.m4a], then the English language
/// transcript must be named [001.en.json]. See the documentation of the
/// [Transcript] class for information about formatting the internal structure
/// of the files.
///
/// Returns a Riverpod [AsyncValue]. If that value is [AsyncData], the data is a
/// record of two nullable [Transcript?] objects, as mentioned above. If either
/// is not available, then its associated member will be [null].
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
