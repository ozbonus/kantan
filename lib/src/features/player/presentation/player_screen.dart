import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button.dart';
import 'package:kantan/src/features/player/presentation/prev_next_buttons.dart';
import 'package:kantan/src/features/player/presentation/progress_slider.dart';
import 'package:kantan/src/features/player/presentation/repeat_mode_button.dart';
import 'package:kantan/src/features/player/presentation/rewind_forward_buttons.dart';
import 'package:kantan/src/features/player/presentation/speed_slider.dart';
import 'package:kantan/src/routing/app_router.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Screen'),
      ),
      body: const PlayerScreenContents(),
    );
  }
}

class PlayerScreenContents extends StatelessWidget {
  const PlayerScreenContents({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Center(
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
              child: Text(localizations!.transcriptButtonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
