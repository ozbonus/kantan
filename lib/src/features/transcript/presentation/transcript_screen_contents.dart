import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/presentation/no_transcript.dart';
import 'package:kantan/src/features/transcript/presentation/static_transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_player_controls.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_screen.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

/// The core contents of the transcript screen that can be shown on displays of
/// any size. Depending on what `transcriptValue` resolves to, one three types
/// of content can be shown:
/// * a notification that no transcript is available
/// * a simple transcript akin to a text document
/// * a self-scrolling transcript with tappable lines that seek to a position
class TranscriptScreenContents extends ConsumerWidget {
  const TranscriptScreenContents({super.key, this.isFullscreen = false});

  final bool isFullscreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transcriptValue = ref.watch(transcriptControllerProvider);
    final style = Theme.of(context).extension<TranscriptScreenStyle>();

    Widget transcriptContainer({required Widget child}) {
      return Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 8.0),
              child: child,
            ),
          ),
          TranscriptPlayerControls(isFullscreen: isFullscreen),
        ],
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: style?.backgroundColor),
      child: transcriptValue.when(
        skipLoadingOnReload: true,
        loading: () => transcriptContainer(
          child: const CircularProgressIndicator.adaptive(),
        ),
        error: (e, st) => throw Exception('$e $st'),
        data: (data) {
          if (data.transcript?.endTimes != null) {
            return transcriptContainer(
              child: DynamicScrollingTranscript(
                transcript: data.transcript!,
                translation: data.translation,
              ),
            );
          }

          if (data.transcript != null) {
            return transcriptContainer(
              child: StaticTranscript(
                transcript: data.transcript!,
                translation: data.translation,
              ),
            );
          }

          return transcriptContainer(
            child: const NoTranscript(),
          );
        },
      ),
    );
  }
}
