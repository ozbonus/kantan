import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/application/can_see_translation_service.dart';
import 'package:kantan/src/features/transcript/application/show_translation_service.dart';
import 'package:kantan/src/features/transcript/application/transcript_scale_service.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_index_controller.dart';

part 'transcript_line_controller.g.dart';

typedef TranscriptLineState = ({
  bool isActive,
  bool showSpeakerName,
  bool showTranslation,
  bool showSpeakerNameTranslation,
  double scale,
});

@riverpod
class TranscriptLineController extends _$TranscriptLineController {
  @override
  TranscriptLineState build(
    int index,
    TranscriptLine transcriptLine,
    TranscriptLine? translationLine,
  ) {
    // Determine whether this transcript line is currently being spoken.
    final currentActiveIndex = ref.watch(transcriptIndexControllerProvider);
    final isActive = index == currentActiveIndex;

    // Determine whether to show the name of the speaker.
    final speakerNameExists = transcriptLine.speaker != null;
    final showSpeakerName = Config.showSpeakerName && speakerNameExists;

    // Determine whether to show the translation.
    final translationExists = translationLine != null;
    final canSeeTranslation = ref.watch(canSeeTranslationServiceProvider);
    final userShowTranslation = ref.watch(showTranslationServiceProvider);
    final showTranslation = Config.useTranslationFeature &&
        translationExists &&
        canSeeTranslation &&
        userShowTranslation;

    // Determine whether to show the translated name of the speaker.
    final nameTranslationExists = translationLine?.speaker != null;
    final showSpeakNameTranslation =
        Config.showSpeakerNameTranslation && nameTranslationExists;

    final scale = ref.watch(transcriptScaleServiceProvider);

    return (
      isActive: isActive,
      showSpeakerName: showSpeakerName,
      showTranslation: showTranslation,
      showSpeakerNameTranslation: showSpeakNameTranslation,
      scale: scale,
    );
  }

  void seekToLine() {
    if (transcriptLine.startTime != null) {
      ref
          .read(audioHandlerProvider)
          .requireValue
          .seek(transcriptLine.startTime!);
    }
    return;
  }
}
