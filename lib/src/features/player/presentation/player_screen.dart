import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
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
          const TrackInfo(),
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

class TrackInfo extends ConsumerWidget {
  const TrackInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackValue = ref.watch(currentTrackStreamProvider);
    return AsyncValueWidget(
      value: trackValue,
      data: (track) {
        if (track != null) {
          return Column(
            children: [
              Text('${track.track} ${track.title}'),
              if (track.displayDescription != null)
                Text('${track.displayDescription}')
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
