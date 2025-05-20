import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_screen_title_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/transcript/application/enable_auto_scroll_service.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_index_controller.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_line_widget.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_player_controls.dart';

/// A wrapper widget for small displays, such as smart phones, that show the
/// transcript as a single screen.
class TranscriptScreen extends StatelessWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TranscriptScreenTitle(),
      ),
      body: const Center(
        child: TranscriptScreenContents(
          isFullscreen: true,
        ),
      ),
    );
  }
}

class _TranscriptScreenTitle extends ConsumerWidget {
  const _TranscriptScreenTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackTitle = ref.watch(transcriptScreenTitleControllerProvider);
    return Text(trackTitle ?? '');
  }
}

/// The core contents of the transcript screen that can be shown on displays of
/// any size. Depending on what `transcriptValue` resolves to, one three types
/// of content can be shown:
/// * a notification that no transcript is available
/// * a simple transcript akin to a text document
/// * a self-scrolling transcript with tappable lines that seek to a position
class TranscriptScreenContents extends ConsumerWidget {
  const TranscriptScreenContents({
    super.key,
    this.isFullscreen = false,
  });

  final bool isFullscreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transcriptValue = ref.watch(transcriptControllerProvider);
    return transcriptValue.when(
      skipLoadingOnReload: true,
      loading: () => const CircularProgressIndicator.adaptive(),
      error: (e, st) => throw Exception('$e $st'),
      data: (data) {
        if (data.transcript == null) {
          // return const NoTranscript();
          return Column(
            children: [
              const Expanded(
                child: NoTranscript(),
              ),
              TranscriptPlayerControls(isFullscreen: isFullscreen),
            ],
          );
        } else if (data.transcript!.endTimes == null) {
          return Column(
            children: [
              Expanded(
                child: StaticTranscript(
                  transcript: data.transcript!,
                  translation: data.translation,
                ),
              ),
              TranscriptPlayerControls(isFullscreen: isFullscreen)
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
              TranscriptPlayerControls(isFullscreen: isFullscreen),
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
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();
    final index = ref.read(transcriptIndexControllerProvider);
    _scrollToIndex(index);
    _scrollController.addListener(_maybeDisableAutoScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_maybeDisableAutoScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// Scroll to the given index of the transcript.
  ///
  /// Sets [_isAutoScrolling] to [true] just before scrolling and then back to
  /// [false] when complete, so as not to accidentally disable auto scrolling
  /// when [_onScroll] is called.
  void _scrollToIndex(int? index) {
    final enableAutoScroll = ref.read(enableAutoScrollServiceProvider);
    if (enableAutoScroll && index != null) {
      _isAutoScrolling = true;
      _scrollController
          .scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.middle,
        duration: Config.scrollDuration,
      )
          .then((_) {
        _isAutoScrolling = false;
      });
    }
  }

  /// Disables auto scroll upon manual scroll.
  ///
  /// When a user scrolls the transcript manually disable auto scrolling if it
  /// is enabled, audio is currently playing, and this feature is enabled by the
  /// customer.
  void _maybeDisableAutoScroll() async {
    if (!_isAutoScrolling) {
      final autoScrollEnabled = ref.read(enableAutoScrollServiceProvider);
      final currentlyPlaying =
          await ref.read(kantanPlaybackStateStreamProvider.future);
      if (autoScrollEnabled &&
          currentlyPlaying == KantanPlaybackState.playing &&
          Config.disableAutoScrollOnUserScroll) {
        ref
            .read(enableAutoScrollServiceProvider.notifier)
            .setEnableAutoScroll(false);
      }
    }
  }

  /// Immediate auto scrolls when auto scrolling is toggled on.
  ///
  /// If enable auto scroll changes from [false] to [true], immediately scrolls
  /// to the portion of the transcript associated with position of the current
  /// track.
  void _enabler(bool enable) {
    if (enable) {
      final index = ref.read(transcriptIndexControllerProvider);
      _scrollToIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int?>(
        transcriptIndexControllerProvider, (_, index) => _scrollToIndex(index));
    ref.listen(
        enableAutoScrollServiceProvider, (_, enable) => _enabler(enable));
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
