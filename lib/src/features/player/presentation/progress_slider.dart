import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/presentation/buttons.dart';
import 'package:kantan/src/features/player/presentation/progress_slider_controller.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class ProgressSlider extends ConsumerWidget {
  const ProgressSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionData = ref.watch(progressSliderControllerProvider);
    final style = Theme.of(context).extension<PlayerScreenSliderStyle>();
    return ButtonContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProgressBar(
          progress: positionData.position,
          total: positionData.duration,
          timeLabelLocation: TimeLabelLocation.sides,
          timeLabelTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontFeatures: [
              FontFeature.tabularFigures(),
            ],
          ),
          // The track drawn by the audio_video_progress_bar package appears
          // slightly small than the "equally" sized slider built into Flutter.
          // The +1 gets them both looking similar enough.
          barHeight: (style?.trackHeight ?? 2.0) + 1,
          baseBarColor: style?.inactiveTrackColor,
          progressBarColor: style?.activeTrackColor,
          thumbColor: style?.thumbColor,
          thumbRadius: style?.thumbRadius ?? 3.0,
          thumbGlowColor: style?.overlayColor,
          thumbGlowRadius: style?.overlayRadius ?? 4.0,
          // Calling this onSeekProvider is a workaround for an issue described
          // in detail in progress_slider_controller.dart.
          onSeek: (position) => ref.read(onSeekProvider(position)),
        ),
      ),
    );
  }
}
