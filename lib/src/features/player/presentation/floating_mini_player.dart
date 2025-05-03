import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button_controller.dart';
import 'package:kantan/src/routing/app_router.dart';

class FloatingMiniPlayer extends ConsumerWidget {
  const FloatingMiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(playPauseButtonControllerProvider);

    IconData buttonIcon = switch (playbackState) {
      KantanPlaybackState.loading ||
      KantanPlaybackState.error ||
      KantanPlaybackState.playing =>
        Icons.pause_rounded,
      KantanPlaybackState.paused => Icons.play_arrow_rounded,
      KantanPlaybackState.completed => Icons.replay_rounded,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton.filled(
          onPressed: () =>
              ref.read(playPauseButtonControllerProvider.notifier).activate(),
          icon: Icon(buttonIcon),
        ),
        IconButton.filled(
          onPressed: () => context.goNamed(AppRoute.player),
          icon: const Icon(Icons.window_rounded),
        ),
      ],
    );
  }
}
