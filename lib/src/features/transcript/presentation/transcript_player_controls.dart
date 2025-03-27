import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/config.dart';
import 'package:kantan/l10n/string_hardcoded.dart';
import 'package:kantan/src/features/player/presentation/progress_slider_controller.dart';
import 'package:kantan/src/features/transcript/application/enable_auto_scroll_service.dart';
import 'package:kantan/src/features/transcript/application/show_translation_service.dart';
import 'package:kantan/src/features/transcript/application/transcript_scale_service.dart';
import 'package:kantan/src/features/transcript/presentation/show_translation_switch_controller.dart';
import 'package:kantan/src/routing/app_router.dart';

class TranscriptPlayerControls extends StatelessWidget {
  const TranscriptPlayerControls({
    super.key,
    this.isFullscreen = false,
  });

  final bool isFullscreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TranscriptProgressSlider(),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (Config.useTranslationFeature) ShowTranslationSwitch(),
                  if (Config.useAutoScrollFeature) EnableAutoScrollSwitch(),
                  TranscriptScaleButton(),
                ],
              ),
              if (isFullscreen)
                const CloseTranscriptButton()
              else
                const ExpandTranscriptButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class TranscriptProgressSlider extends ConsumerWidget {
  const TranscriptProgressSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionData = ref.watch(progressSliderControllerProvider);
    return ProgressBar(
      progress: positionData.position,
      total: positionData.duration,
      onSeek: (position) => ref.read(onSeekProvider(position)),
    );
  }
}

class ShowTranslationSwitch extends ConsumerWidget {
  const ShowTranslationSwitch({super.key});

  static const thumbIcon =
      WidgetStatePropertyAll<Icon>(Icon(Icons.translate_rounded));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showTranslationSwitchControllerProvider);
    return Switch(
      thumbIcon: thumbIcon,
      value: state.value,
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
    final value = ref.watch(enableAutoScrollServiceProvider);
    return Switch(
      thumbIcon: thumbIcon,
      value: value,
      onChanged: (value) => ref
          .read(enableAutoScrollServiceProvider.notifier)
          .setEnableAutoScroll(value),
    );
  }
}

class TranscriptScaleButton extends StatelessWidget {
  const TranscriptScaleButton({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Slider(
                        label: 'hello',
                        value: scale,
                        min: Config.minTranscriptScale,
                        max: Config.maxTranscriptScale,
                        // divisions: Config.transcriptScaleDivisions,
                        onChanged: (value) {
                          ref
                              .read(transcriptScaleServiceProvider.notifier)
                              .setTranscriptScale(value);
                        },
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

class CloseTranscriptButton extends StatelessWidget {
  const CloseTranscriptButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close_rounded),
      onPressed: context.pop,
    );
  }
}
