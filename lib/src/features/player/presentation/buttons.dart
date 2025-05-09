import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/l10n/string_hardcoded.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button_controller.dart';
import 'package:kantan/src/features/player/presentation/prev_next_button_controller.dart';
import 'package:kantan/src/features/player/presentation/repeat_mode_button_controller.dart';
import 'package:kantan/src/features/player/presentation/rewind_forward_button_controller.dart';
import 'package:kantan/src/routing/app_router.dart';

class _ButtonContainer extends StatelessWidget {
  const _ButtonContainer({
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}

class _TappableButton extends StatelessWidget {
  const _TappableButton({
    required this.onTap,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ButtonContainer(
      child: Material(
        child: Ink(
          child: InkWell(
            onTap: onTap,
            child: SizedBox.expand(
                child: FittedBox(
              fit: BoxFit.contain,
              child: child,
            )),
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(playPauseButtonControllerProvider);
    return _TappableButton(
      onTap: () =>
          ref.read(playPauseButtonControllerProvider.notifier).activate(),
      child: switch (playbackState) {
        KantanPlaybackState.loading ||
        KantanPlaybackState.error ||
        KantanPlaybackState.paused =>
          Icon(Icons.play_arrow_rounded),
        KantanPlaybackState.playing => Icon(Icons.pause_rounded),
        KantanPlaybackState.completed => Icon(Icons.replay_rounded),
      },
    );
  }
}

class SkipToPreviousButton extends ConsumerWidget {
  const SkipToPreviousButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _TappableButton(
      onTap: () => ref.read(skipToPreviousButtonControllerProvider),
      child: const Icon(Icons.skip_previous_rounded),
    );
  }
}

class SkipToNextButton extends ConsumerWidget {
  const SkipToNextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _TappableButton(
      onTap: () => ref.read(skipToNextButtonControllerProvider),
      child: const Icon(Icons.skip_next_rounded),
    );
  }
}

class RewindButton extends ConsumerWidget {
  const RewindButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _TappableButton(
      onTap: () => ref.read(rewindButtonControllerProvider),
      child: const Icon(Icons.replay_5_rounded),
    );
  }
}

class FastForwardButton extends ConsumerWidget {
  const FastForwardButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _TappableButton(
      onTap: () => ref.read(fastForwardButtonControllerProvider),
      child: const Icon(Icons.forward_5_rounded),
    );
  }
}

class RepeatModeButton extends ConsumerWidget {
  const RepeatModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repeatMode = ref.watch(repeatModeButtonControllerProvider);
    return _TappableButton(
      onTap: () => ref
          .read(repeatModeButtonControllerProvider.notifier)
          .nextRepeatMode(),
      child: switch (repeatMode) {
        RepeatMode.one => const Icon(Icons.repeat_one_rounded),
        RepeatMode.all => const Icon(Icons.repeat_rounded),
        RepeatMode.none => const Icon(Icons.arrow_right_alt_rounded),
      },
    );
  }
}

class OpenTranscriptButton extends StatelessWidget {
  const OpenTranscriptButton({
    super.key,
    this.iconOnly = false,
  });

  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        // type: MaterialType.button,
        borderRadius: BorderRadius.circular(32),
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: () => context.pushNamed(AppRoute.transcript),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: iconOnly
                    ? const Icon(Icons.message_rounded)
                    : Text('Transcript'.hardcoded),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
