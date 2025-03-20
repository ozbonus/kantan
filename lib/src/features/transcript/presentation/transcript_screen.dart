import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/features/player/presentation/progress_slider_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/transcript/application/can_see_translation_service.dart';
import 'package:kantan/src/features/transcript/application/enable_auto_scroll_service.dart';
import 'package:kantan/src/features/transcript/application/show_translation_service.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_index_controller.dart';
import 'package:kantan/src/routing/app_router.dart';

/// A wrapper widget for small displays, such as smart phones, that show the
/// transcript as a single screen.
class TranscriptScreen extends StatelessWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transcript Screen'),
      ),
      body: const Center(
        child: TranscriptScreenContents(),
      ),
    );
  }
}

/// The core contents of the transcript screen that can be shown on displays of
/// any size. Depending on what `transcriptValue` resolves to, one three types
/// of content can be shown:
/// * a notification that no transcript is available
/// * a simple transcript akin to a text document
/// * a self-scrolling transcript with tappable lines that seek to a position
class TranscriptScreenContents extends ConsumerWidget {
  const TranscriptScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transcriptValue = ref.watch(transcriptControllerProvider);
    return transcriptValue.when(
      loading: () => const CircularProgressIndicator.adaptive(),
      error: (e, st) => throw Exception('$e $st'),
      data: (data) {
        if (data.transcript == null) {
          return const NoTranscript();
        } else if (data.transcript!.endTimes == null) {
          return Column(
            children: [
              Expanded(
                child: StaticTranscript(
                  transcript: data.transcript!,
                  translation: data.translation,
                ),
              ),
              const TranscriptPlayerControls()
            ],
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: DynamicScrollingTranscript(
                  transcript: data.transcript!,
                  translation: data.translation,
                ),
              ),
              const TranscriptPlayerControls(),
            ],
          );
        }
      },
    );
  }
}

class NoTranscript extends StatelessWidget {
  const NoTranscript({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Center(
      child: Text(localizations!.noTranscriptMessage),
    );
  }
}

class StaticTranscript extends ConsumerWidget {
  const StaticTranscript({
    super.key,
    required this.transcript,
    this.translation,
  });
  final Transcript transcript;
  final Transcript? translation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: transcript.lines.length,
      itemBuilder: (context, index) => TranscriptLineWidget(
        index: index,
        transcriptLine: transcript.lines[index],
        transcriptLineLocale: transcript.locale,
        translationLine: translation?.lines[index],
        translationLineLocale: translation?.locale,
      ),
    );
  }
}

class DynamicScrollingTranscript extends ConsumerStatefulWidget {
  const DynamicScrollingTranscript({
    super.key,
    required this.transcript,
    this.translation,
  });
  final Transcript transcript;
  final Transcript? translation;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScrollingTranscriptScreenContentsState();
}

class _ScrollingTranscriptScreenContentsState
    extends ConsumerState<DynamicScrollingTranscript> {
  final _scrollController = AutoScrollController();

  @override
  void initState() {
    super.initState();
    final index = ref.read(transcriptIndexControllerProvider);
    _scroll(index);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scroll(int? index) {
    final enableAutoScroll = ref.read(enableAutoScrollServiceProvider);
    if (enableAutoScroll && index != null) {
      _scrollController.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.middle,
        duration: Config.scrollDuration,
      );
    }
  }

  void enabler(bool enable) {
    /// If the option to enable auto scroll is switching from off to on,
    /// immediately scroll to the active index.
    if (enable) {
      final index = ref.read(transcriptIndexControllerProvider);
      _scroll(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int?>(
        transcriptIndexControllerProvider, (_, index) => _scroll(index));
    ref.listen(enableAutoScrollServiceProvider, (_, enable) => enabler(enable));
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.transcript.lines.length,
      itemBuilder: (context, index) => AutoScrollTag(
        key: ValueKey(index),
        controller: _scrollController,
        index: index,
        child: TranscriptLineWidget(
          index: index,
          transcriptLine: widget.transcript.lines[index],
          translationLine: widget.translation?.lines[index],
          transcriptLineLocale: widget.transcript.locale,
          translationLineLocale: widget.translation?.locale,
        ),
      ),
    );
  }
}

class TranscriptLineWidget extends ConsumerWidget {
  const TranscriptLineWidget({
    super.key,
    required this.index,
    required this.transcriptLine,
    required this.transcriptLineLocale,
    this.translationLine,
    this.translationLineLocale,
  });

  final int index;
  final TranscriptLine transcriptLine;
  final Locale transcriptLineLocale;
  final TranscriptLine? translationLine;
  final Locale? translationLineLocale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(transcriptIndexControllerProvider);
    final canSeeTranslation = ref.watch(canSeeTranslationServiceProvider);
    final userShowTranslation = ref.watch(showTranslationServiceProvider);
    final showTranslation = canSeeTranslation && userShowTranslation;
    return ListTile(
      title: Localizations.override(
        context: context,
        locale: transcriptLineLocale,
        child: Text(transcriptLine.text),
      ),
      leading:
          transcriptLine.speaker != null ? Text(transcriptLine.speaker!) : null,
      subtitle: translationLine != null && showTranslation
          ? Localizations.override(
              context: context,
              locale: translationLineLocale,
              child: Text(translationLine!.text),
            )
          : null,
      selected: index == activeIndex,
      onTap: transcriptLine.startTime != null
          ? () => ref
              .read(audioHandlerProvider)
              .requireValue
              .seek(transcriptLine.startTime!)
          : null,
    );
  }
}

class TranscriptPlayerControls extends ConsumerWidget {
  const TranscriptPlayerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TranscriptProgressSlider(),
        ),
        Row(
          children: [
            ShowTranslationSwitch(),
            EnableAutoScrollSwitch(),
            ExpandTranscriptButton(),
          ],
        ),
      ],
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
    final value = ref.watch(showTranslationServiceProvider);
    return Switch(
      thumbIcon: thumbIcon,
      value: value,
      onChanged: (value) => ref
          .read(showTranslationServiceProvider.notifier)
          .setShowTranslation(value),
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
