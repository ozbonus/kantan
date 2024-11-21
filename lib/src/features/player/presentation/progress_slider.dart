import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/presentation/progress_slider_controller.dart';

class ProgressSlider extends ConsumerWidget {
  const ProgressSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionData = ref.watch(progressSliderControllerProvider);
    return ProgressBar(
      progress: positionData.position,
      total: positionData.duration,
      // Calling this onSeekProvider is a workaround for an issue described in
      // detail in progress_slider_controller.dart.
      onSeek: (position) => ref.read(onSeekProvider(position)),
    );
  }
}
