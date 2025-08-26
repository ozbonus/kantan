import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class TranscriptLineWidget extends ConsumerWidget {
  const TranscriptLineWidget({
    super.key,
    required this.index,
    required this.transcript,
    this.translation,
    this.scale,
    this.selected = false,
    this.onTap,
  });

  final int index;
  final Transcript transcript;
  final Transcript? translation;
  final double? scale;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).extension<TranscriptLineWidgetStyle>();
    final baseTextStyle = Theme.of(context).textTheme.bodyLarge;

    final TextScaler? textScaler = scale != null
        ? TextScaler.linear(scale!).clamp(maxScaleFactor: 3.0)
        : null;

    final String? speakerName = index < transcript.lines.length
        ? transcript.lines[index].speaker
        : null;

    final Widget? speakerNameWidget = speakerName != null
        ? Text(
            speakerName,
            style: baseTextStyle?.merge(style?.speakerNameTextStyle),
            textScaler: textScaler,
          )
        : null;

    final String? speakerNameTranslation =
        translation != null && index < translation!.lines.length
        ? translation?.lines[index].speaker
        : null;

    final Widget? speakerNameTranslationWidget = speakerNameTranslation != null
        ? Text(
            speakerNameTranslation,
            style: baseTextStyle?.merge(style?.speakerNameTranslationTextStyle),
            textScaler: textScaler,
          )
        : null;

    final Widget transcriptTextWidget = Text(
      transcript.lines[index].text,
      style: baseTextStyle?.merge(style?.transcriptTextStyle),
      textScaler: textScaler,
    );

    final String? translationText = translation?.lines[index].text;
    final translationTextWidget = translationText != null
        ? Text(
            translationText,
            style: baseTextStyle?.merge(style?.translationTextStyle),
            textScaler: textScaler,
          )
        : null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? style?.activeColor : null,
        borderRadius: BorderRadius.circular(style?.borderRadius ?? 0),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(style?.borderRadius ?? 0),
        border: selected
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
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4.0,
              children: [
                if (speakerName != null || speakerNameTranslation != null)
                  Localizations.override(
                    context: context,
                    locale: transcript.locale,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8.0,
                      children: [
                        if (speakerNameWidget != null) speakerNameWidget,
                        if (speakerNameTranslationWidget != null)
                          Localizations.override(
                            context: context,
                            locale: translation?.locale,
                            child: speakerNameTranslationWidget,
                          ),
                      ],
                    ),
                  ),
                Localizations.override(
                  context: context,
                  locale: transcript.locale,
                  child: transcriptTextWidget,
                ),
                if (translationTextWidget != null)
                  Localizations.override(
                    context: context,
                    locale: translation?.locale,
                    child: translationTextWidget,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
