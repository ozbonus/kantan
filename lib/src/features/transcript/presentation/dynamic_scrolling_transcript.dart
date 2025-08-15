import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/application/can_see_translation_service.dart';
import 'package:kantan/src/features/transcript/application/show_translation_service.dart';
import 'package:kantan/src/features/transcript/application/transcript_scale_service.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/transcript/application/enable_auto_scroll_service.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_index_controller.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_line_widget.dart';

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
  GlobalKey<_ScrollingTranscriptScreenContentsState> _key = GlobalKey();
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
      final currentlyPlaying = await ref.read(
        kantanPlaybackStateStreamProvider.future,
      );
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

  void _reset() {
    setState(() {
      _key = GlobalKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int?>(
      transcriptIndexControllerProvider,
      (_, index) => _scrollToIndex(index),
    );
    ref.listen(
      enableAutoScrollServiceProvider,
      (_, enable) => _enabler(enable),
    );
    final currentIndex = ref.watch(transcriptIndexControllerProvider);
    // ref.listen(showTranslationServiceProvider, (_, show) {
    //   _reset();
    // });
    final scale = ref.watch(transcriptScaleServiceProvider);
    final showTranslation = ref.watch(showTranslationServiceProvider);
    final canSeeTranslation = ref.watch(canSeeTranslationServiceProvider);
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.transcript.lines.length,
      itemBuilder: (context, index) {
        return AutoScrollTag(
          key: ValueKey(index),
          controller: _scrollController,
          index: index,
          child: TranscriptLineWidget(
            index: index,
            transcript: widget.transcript,
            translation: showTranslation && canSeeTranslation
                ? widget.translation
                : null,
            selected: index == currentIndex,
            scale: scale,
            onTap: () => ref
                .read(audioHandlerProvider)
                .requireValue
                .seek(widget.transcript.lines[index].startTime!),
          ),
        );
      },
    );
  }
}
