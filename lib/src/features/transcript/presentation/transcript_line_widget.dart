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

    Widget? speakerName;
    if (controller.showSpeakerName) {
      speakerName = Text(
        transcriptLine.speaker!,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize! *
                  controller.scale,
            ),
      );
    }

    Widget? speakerNameTranslation;
    if (controller.showSpeakerNameTranslation) {
      speakerNameTranslation = Text(
        translationLine!.speaker!,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize! *
                  controller.scale,
              color:
                  Theme.of(context).textTheme.bodyMedium?.color?.withAlpha(96),
            ),
      );
    }

    Widget transcriptText = Text(
      transcriptLine.text,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! *
                controller.scale,
          ),
    );

    Widget? translationText;
    if (controller.showTranslation) {
      translationText = Text(
        translationLine!.text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! *
                  controller.scale,
              color:
                  Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(96),
            ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        type: MaterialType.transparency,
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
                    Localizations.override(
                      context: context,
                      locale: transcriptLineLocale,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8.0,
                        children: [
                          if (speakerName != null) speakerName,
                          if (speakerNameTranslation != null)
                            Localizations.override(
                              context: context,
                              locale: translationLineLocale,
                              child: speakerNameTranslation,
                            ),
                        ],
                      ),
                    ),
                  Localizations.override(
                    context: context,
                    locale: transcriptLineLocale,
                    child: transcriptText,
                  ),
                  if (controller.showTranslation)
                    Localizations.override(
                      context: context,
                      locale: translationLineLocale,
                      child: translationText,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
