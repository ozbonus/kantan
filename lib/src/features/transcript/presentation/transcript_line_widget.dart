import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_line_controller.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

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
    final style = Theme.of(context).extension<TranscriptLineWidgetStyle>();
    final showNames =
        controller.showSpeakerName || controller.showSpeakerNameTranslation;

    Widget? speakerName;
    if (controller.showSpeakerName) {
      speakerName = Text(
        transcriptLine.speaker!,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize! *
                  controller.scale,
              color: style?.transcriptTextColor,
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
              color: style?.translationTextColor,
            ),
      );
    }

    Widget transcriptText = Text(
      transcriptLine.text,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! *
                controller.scale,
            color: style?.transcriptTextColor,
          ),
    );

    Widget? translationText;
    if (controller.showTranslation) {
      translationText = Text(
        translationLine!.text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! *
                  controller.scale,
              color: style?.translationTextColor,
            ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(style?.borderRadius ?? 0),
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
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: controller.isActive ? style?.activeColor : null,
              borderRadius: BorderRadius.circular(style?.borderRadius ?? 0),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(style?.borderRadius ?? 0),
              border: controller.isActive
                  ? Border.all(
                      width: style?.borderWidth ?? 0,
                      color: style?.borderColor ?? Colors.transparent,
                    )
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
