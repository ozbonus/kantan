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
    final controller = ref.watch(
      transcriptLineControllerProvider(
        index,
        transcriptLine,
        translationLine,
      ),
    );
    final style = Theme.of(context).extension<TranscriptLineWidgetStyle>();
    final baseTextStyle = Theme.of(context).textTheme.bodyLarge;
    final showNames =
        controller.showSpeakerName || controller.showSpeakerNameTranslation;

    TextScaler? textScaler = TextScaler.linear(controller.scale).clamp(
      maxScaleFactor: 3.0,
    );

    Widget? speakerName;
    if (controller.showSpeakerName) {
      speakerName = Text(
        transcriptLine.speaker!,
        style: baseTextStyle?.merge(style?.speakerNameTextStyle).apply(),
        textScaler: textScaler,
      );
    }

    Widget? speakerNameTranslation;
    if (controller.showSpeakerNameTranslation) {
      speakerNameTranslation = Text(
        translationLine!.speaker!,
        style: baseTextStyle?.merge(style?.speakerNameTranslationTextStyle),
        textScaler: textScaler,
      );
    }

    Widget transcriptText = Text(
      transcriptLine.text,
      style: baseTextStyle?.merge(style?.transcriptTextStyle),
      textScaler: textScaler,
    );

    Widget? translationText;
    if (controller.showTranslation) {
      translationText = Text(
        translationLine!.text,
        style: baseTextStyle?.merge(style?.translationTextStyle),
        textScaler: textScaler,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        child: Material(
          type: MaterialType.transparency,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: style?.splashColor,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
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
