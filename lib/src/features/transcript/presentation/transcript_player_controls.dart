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
import 'package:kantan/src/features/transcript/application/enable_auto_scroll_service.dart';
import 'package:kantan/src/features/transcript/application/show_translation_service.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  if (isFullscreen)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: TranscriptProgressSlider(),
                    ),
                  IntrinsicHeight(
                    child: Flex(
                      direction: constraints.maxWidth > Config.mediumBreakpoint
                          ? Axis.horizontal
                          : Axis.vertical,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      children: [
                        if (isFullscreen)
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.ltr,
                            children: [
                              TranscriptSkipToPreviousButton(),
                              TranscriptPlayButton(),
                              TranscriptSkipToNextButton(),
                              VerticalDivider(),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.ltr,
                          children: [
                            if (Config.useTranslationFeature)
                              const ShowTranslationSwitch(),
                            if (Config.useAutoScrollFeature)
                              const EnableAutoScrollSwitch(),
                            const TranscriptScaleButton(),
                            if (isFullscreen)
                              const CloseTranscriptButton()
                            else
                              const ExpandTranscriptButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
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

class ShowTranslationSwitch extends ConsumerWidget {
  const ShowTranslationSwitch({super.key});

  static const thumbIcon = WidgetStatePropertyAll<Icon>(Icon(
    Icons.translate_rounded,
  ));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showTranslationSwitchControllerProvider);

    final WidgetStateProperty<Icon?> thumbIcon =
        WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return const Icon(
          Icons.coronavirus_rounded,
          color: Colors.black,
        );
      }
      return Icon(
        Icons.heart_broken_rounded,
      );
    });

    return Switch(
      thumbIcon: thumbIcon,
      value: state.isActive ? state.value : false,
      onChanged: state.isActive
          ? (value) => ref
              .read(showTranslationServiceProvider.notifier)
              .setShowTranslation(value)
          : null,
    );
  }
}

class EnableAutoScrollSwitch extends ConsumerWidget {
  const EnableAutoScrollSwitch({super.key});

  static const thumbIcon =
      WidgetStatePropertyAll<Icon>(Icon(Icons.format_line_spacing_rounded));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enableAutoScrollSwitchControllerProvider);
    return Switch(
      thumbIcon: thumbIcon,
      value: state.isActive ? state.value : false,
      onChanged: state.isActive
          ? (value) => ref
              .read(enableAutoScrollServiceProvider.notifier)
              .setEnableAutoScroll(value)
          : null,
    );
  }
}

class TranscriptScaleButton extends StatelessWidget {
  const TranscriptScaleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<PlayerScreenSliderStyle>();
    return IconButton(
      icon: const Icon(Icons.text_fields_rounded),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Adjust text scale'.hardcoded),
              content: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final scale = ref.watch(transcriptScaleServiceProvider);
                  return Column(
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
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: context.pop,
                  child: Text('Close'.hardcoded),
                ),
              ],
            );
          },
        );
      },
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

class TranscriptPlayButton extends ConsumerWidget {
  const TranscriptPlayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(playPauseButtonControllerProvider);
    final style = Theme.of(context).extension<TranscriptScreenButtonStyle>();

    IconData buttonIcon = switch (playbackState) {
      KantanPlaybackState.loading ||
      KantanPlaybackState.error ||
      KantanPlaybackState.playing =>
        Icons.pause_rounded,
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
