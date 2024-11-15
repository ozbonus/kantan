import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button.dart';
import 'package:kantan/src/features/player/presentation/prev_next_buttons.dart';
import 'package:kantan/src/features/player/presentation/progress_slider.dart';
import 'package:kantan/src/features/player/presentation/repeat_mode_button.dart';
import 'package:kantan/src/features/player/presentation/rewind_forward_buttons.dart';
import 'package:kantan/src/features/player/presentation/speed_slider.dart';
import 'package:kantan/src/routing/app_router.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlayPauseButton(),
                RewindButton(),
                FastForwardButton(),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SkipToPreviousButton(),
                SkipToNextButton(),
                RepeatModeButton(),
              ],
            ),
            const SpeedSlider(),
            const ProgressSlider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () => context.goNamed(AppRoute.transcript),
                child: const Text('Go to Transcript Screen'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
