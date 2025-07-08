import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/config.dart';
import 'package:kantan/l10n/string_hardcoded.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button_controller.dart';
import 'package:kantan/src/features/player/presentation/prev_next_button_controller.dart';
import 'package:kantan/src/features/player/presentation/progress_slider_controller.dart';
import 'package:kantan/src/features/transcript/application/transcript_scale_service.dart';
import 'package:kantan/src/features/transcript/presentation/enable_auto_scroll_switch_controller.dart';
import 'package:kantan/src/features/transcript/presentation/show_translation_switch_controller.dart';
import 'package:kantan/src/routing/app_router.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class TranscriptPlayerControls extends StatelessWidget {
  const TranscriptPlayerControls({
    super.key,
    this.isFullscreen = false,
  });

  final bool isFullscreen;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<TranscriptScreenStyle>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: style?.backgroundColor,
      ),
      child: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                if (isFullscreen) TranscriptProgressSlider(),
                Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isFullscreen) ...[
                      TranscriptPlayButton(),
                      TranscriptSkipToPreviousButton(),
                      TranscriptSkipToNextButton(),
                    ],
                    TranscriptScaleButton(),
                    if (Config.useTranslationFeature)
                      ShowTranslationToggleButton(),
                    if (Config.useAutoScrollFeature)
                      EnableAutoScrollToggleButton(),
                    if (!isFullscreen) ExpandTranscriptButton(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TranscriptProgressSlider extends ConsumerWidget {
  const TranscriptProgressSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionData = ref.watch(progressSliderControllerProvider);
    final style = Theme.of(context).extension<TranscriptProgressSliderStyle>();
    return ProgressBar(
      progress: positionData.position,
      timeLabelLocation: TimeLabelLocation.none,
      total: positionData.duration,
      barHeight: style?.trackHeight ?? 2.0,
      baseBarColor: style?.inactiveTrackColor,
      progressBarColor: style?.activeTrackColor,
      thumbColor: style?.thumbColor,
      thumbRadius: style?.thumbRadius ?? 3.0,
      thumbGlowColor: style?.overlayColor,
      thumbGlowRadius: style?.overlayRadius ?? 4.0,
      onSeek: (position) => ref.read(onSeekProvider(position)),
    );
  }
}

class ShowTranslationToggleButton extends ConsumerWidget {
  const ShowTranslationToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showTranslationSwitchControllerProvider);
    final style = Theme.of(context).extension<TranscriptScreenToggleStyle>();

    final ButtonStyle? buttonStyle;
    if (!state.isActive) {
      buttonStyle = style?.disabled;
    } else if (state.value) {
      buttonStyle = style?.active;
    } else {
      buttonStyle = style?.inactive;
    }

    return IconButton(
      icon: Icon(Icons.translate_rounded),
      style: buttonStyle,
      onPressed: state.isActive
          ? () => ref
                .read(showTranslationSwitchControllerProvider.notifier)
                .setShowTranslation(!state.value)
          : null,
    );
  }
}

class EnableAutoScrollToggleButton extends ConsumerWidget {
  const EnableAutoScrollToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enableAutoScrollSwitchControllerProvider);
    final style = Theme.of(context).extension<TranscriptScreenToggleStyle>();

    final ButtonStyle? buttonStyle;
    if (!state.isActive) {
      buttonStyle = style?.disabled;
    } else if (state.value) {
      buttonStyle = style?.active;
    } else {
      buttonStyle = style?.inactive;
    }

    return IconButton(
      icon: Icon(Icons.format_line_spacing_rounded),
      style: buttonStyle,
      onPressed: state.isActive
          ? () => ref
                .read(enableAutoScrollSwitchControllerProvider.notifier)
                .setEnableAutoScroll(!state.value)
          : null,
    );
  }
}

class TranscriptScaleButton extends StatelessWidget {
  const TranscriptScaleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<TranscriptScreenButtonStyle>();
    return IconButton(
      style: style?.buttonStyle,
      icon: const Icon(Icons.text_fields_rounded),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ScaleSliderDialog(),
        );
      },
    );
  }
}

class ScaleSliderDialog extends ConsumerWidget {
  const ScaleSliderDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(transcriptScaleServiceProvider);
    final style = Theme.of(context).extension<PlayerScreenSliderStyle>();
    return AlertDialog(
      title: Text('Adjust text scale'.hardcoded),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Scale: ${scale.toStringAsFixed(2)}'),
          Directionality(
            textDirection: TextDirection.ltr,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: style?.trackHeight,
                tickMarkShape: style?.sliderTickMarkShape,
                activeTrackColor: style?.activeTrackColor,
                inactiveTrackColor: style?.inactiveTrackColor,
                thumbColor: style?.thumbColor,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: style?.thumbRadius ?? 8.0,
                  disabledThumbRadius: style?.thumbRadius ?? 8.0,
                  elevation: style?.elevation ?? 0.0,
                  pressedElevation: style?.elevation ?? 0.0,
                ),
                overlayColor: style?.overlayColor,
              ),
              child: Slider(
                value: scale,
                min: Config.minTranscriptScale,
                max: Config.maxTranscriptScale,
                onChanged: (value) {
                  ref
                      .read(transcriptScaleServiceProvider.notifier)
                      .setTranscriptScale(value);
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text('Close'.hardcoded),
        ),
      ],
    );
  }
}

class ExpandTranscriptButton extends StatelessWidget {
  const ExpandTranscriptButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.zoom_out_map_rounded),
      onPressed: () => context.goNamed(AppRoute.transcript),
    );
  }
}

/// In this version of Kantan Player all of the audio files are stored on device
/// which means that loading is nearly instantaneous. However, when skipping
/// tracks the app does very briefly pass through a loading state. Because this
/// loading state is so brief, it's not helpful to communicate to the user. The
/// design of this `StatefulWidget` prevents the icon from ever showing the
/// loading state. In a future version of Kantan Player which can load audio
/// over the web, showing the loading state can be re-enabled.
class TranscriptPlayButton extends ConsumerStatefulWidget {
  const TranscriptPlayButton({super.key});

  @override
  ConsumerState<TranscriptPlayButton> createState() =>
      _TranscriptPlayButtonState();
}

class _TranscriptPlayButtonState extends ConsumerState<TranscriptPlayButton> {
  late KantanPlaybackState playbackState;

  @override
  void initState() {
    super.initState();
    final initState = ref.read(playPauseButtonControllerProvider);
    setState(() => playbackState = initState);
  }

  @override
  void dispose() => super.dispose();

  void resolveState(KantanPlaybackState state) {
    if (state == KantanPlaybackState.loading) {
      return;
    } else {
      setState(() => playbackState = state);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<KantanPlaybackState>(
      playPauseButtonControllerProvider,
      (_, state) => resolveState(state),
    );

    final style = Theme.of(context).extension<TranscriptScreenButtonStyle>();

    IconData buttonIcon = switch (playbackState) {
      KantanPlaybackState.loading ||
      KantanPlaybackState.error ||
      KantanPlaybackState.playing => Icons.pause_rounded,
      KantanPlaybackState.paused => Icons.play_arrow_rounded,
      KantanPlaybackState.completed => Icons.replay_rounded,
    };

    return IconButton(
      style: style?.buttonStyle,
      onPressed: () =>
          ref.read(playPauseButtonControllerProvider.notifier).activate(),
      icon: Icon(buttonIcon),
    );
  }
}

class TranscriptSkipToPreviousButton extends ConsumerWidget {
  const TranscriptSkipToPreviousButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).extension<TranscriptScreenButtonStyle>();
    return IconButton(
      style: style?.buttonStyle,
      onPressed: () => ref.read(skipToPreviousButtonControllerProvider),
      icon: const Icon(Icons.skip_previous_rounded),
    );
  }
}

class TranscriptSkipToNextButton extends ConsumerWidget {
  const TranscriptSkipToNextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).extension<TranscriptScreenButtonStyle>();
    return IconButton(
      style: style?.buttonStyle,
      onPressed: () => ref.read(skipToNextButtonControllerProvider),
      icon: const Icon(Icons.skip_next_rounded),
    );
  }
}

class CloseTranscriptButton extends StatelessWidget {
  const CloseTranscriptButton({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<TranscriptScreenButtonStyle>();
    return IconButton(
      style: style?.buttonStyle,
      icon: const Icon(Icons.close_rounded),
      onPressed: () => context.goNamed(AppRoute.player),
    );
  }
}
