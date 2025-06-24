import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button_controller.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class MiniPlayerPlayPauseButton extends ConsumerWidget {
  const MiniPlayerPlayPauseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(playPauseButtonControllerProvider);

    IconData buttonIcon = switch (playbackState) {
      KantanPlaybackState.loading ||
      KantanPlaybackState.error ||
      KantanPlaybackState.playing => Icons.pause_rounded,
      KantanPlaybackState.paused => Icons.play_arrow_rounded,
      KantanPlaybackState.completed => Icons.replay_rounded,
    };

    final style = Theme.of(
      context,
    ).extension<FloatingMiniPlayerPlayPauseButtonStyle>();

    return Container(
      decoration: style?.decoration ?? BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          child: InkWell(
            onTap: ref
                .read(playPauseButtonControllerProvider.notifier)
                .activate,
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  buttonIcon,
                  color: style?.iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
