import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_line_controller.dart';

class TranscriptLineWidget extends ConsumerWidget {
  const TranscriptLineWidget({
    super.key,
    required this.index,
    required this.transcriptLine,
    required this.transcriptLineLocale,
    this.translationLine,
    this.translationLineLocale,
  });

  final int index;
  final TranscriptLine transcriptLine;
  final Locale transcriptLineLocale;
  final TranscriptLine? translationLine;
  final Locale? translationLineLocale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(transcriptLineControllerProvider(
      index,
      transcriptLine,
      translationLine,
    ));
    final showNames =
        controller.showSpeakerName || controller.showSpeakerNameTranslation;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => ref
            .read(
              transcriptLineControllerProvider(
                index,
                transcriptLine,
                translationLine,
              ).notifier,
            )
            .seekToLine(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: controller.isActive ? Colors.purple[100] : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8.0,
              children: [
                if (showNames)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.0,
                    children: [
                      if (controller.showSpeakerName)
                        Text(transcriptLine.speaker!),
                      if (controller.showSpeakerNameTranslation)
                        Text(translationLine!.speaker!),
                    ],
                  ),
                Text(transcriptLine.text),
                if (controller.showTranslation) Text(translationLine!.text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
