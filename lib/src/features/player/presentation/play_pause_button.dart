import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button_controller.dart';

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackStateValue = ref.watch(playPauseButtonControllerProvider);
    return IconButton.filledTonal(
      onPressed: ref.read(playPauseButtonControllerProvider.notifier).activate,
      icon: AsyncValueWidget(
        value: playbackStateValue,
        data: (playbackState) {
          switch (playbackState) {
            case KantanPlaybackState.loading:
              return const Icon(Icons.play_arrow_rounded);
            case KantanPlaybackState.playing:
              return const Icon(Icons.pause_rounded);
            case KantanPlaybackState.paused:
              return const Icon(Icons.play_arrow_rounded);
            case KantanPlaybackState.completed:
              return const Icon(Icons.replay_rounded);
            case KantanPlaybackState.error:
              return const Icon(Icons.error_rounded);
          }
        },
      ),
    );
  }
}
