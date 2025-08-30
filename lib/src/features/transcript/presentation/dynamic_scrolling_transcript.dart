import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/application/transcript_scale_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/transcript/application/can_see_transcript_service.dart';
import 'package:kantan/src/features/transcript/application/enable_auto_scroll_service.dart';
import 'package:kantan/src/features/transcript/application/show_translation_service.dart';
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
      _DynamicScrollingTranscriptState();
}

class _DynamicScrollingTranscriptState
    extends ConsumerState<DynamicScrollingTranscript> {
  final _scrollController = ItemScrollController();
  final _itemsPositionsListener = ItemPositionsListener.create();
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();
    _itemsPositionsListener.itemPositions.addListener(_maybeDisableAutoScroll);
  }

  @override
  void dispose() {
    _itemsPositionsListener.itemPositions.removeListener(
      _maybeDisableAutoScroll,
    );
    super.dispose();
  }

  Future<void> _scrollToItem(int? index) async {
    final enableAutoScroll = ref.read(enableAutoScrollServiceProvider);
    if (enableAutoScroll && index != null && !_isAutoScrolling && mounted) {
      _isAutoScrolling = true;

      try {
        await _scrollController.scrollTo(
          index: index,
          duration: Config.scrollDuration,
          alignment: Config.autoScrollTranscriptAlignment,
        );
        // In the rare occurrence that the transcript moves to a new line before
        // the scrolling animation completes, this delay prevents
        // `_maybeDisableAutoScroll` from doing its job erroneously.
        await Future.delayed(Config.transcriptDebounce);
      } finally {
        if (mounted) {
          _isAutoScrolling = false;
        }
      }
    }
  }

  /// If the user manually scrolls while audio is playing, then disable auto
  /// scrolling. This feature is toggleable according to client preferences.
  void _maybeDisableAutoScroll() {
    if (_isAutoScrolling || !mounted) return;

    scheduleMicrotask(() async {
      final isPlaying =
          await ref.read(
            kantanPlaybackStateStreamProvider.future,
          ) ==
          KantanPlaybackState.playing;

      if (mounted && isPlaying && Config.disableAutoScrollOnUserScroll) {
        ref
            .read(enableAutoScrollServiceProvider.notifier)
            .setEnableAutoScroll(false);
      }
    });
  }

  /// Seek to the position in the audio file that corresponds to the beginning
  /// of the text in the line at the given index.
  void _onTap(int index) {
    // Although you can be highly confident that the provided index will always
    // be within the range of the list of lines, in the very unlikely case that,
    // for example, the transcript has incorrect timestamps that messes with the
    // index logic, then this function won't accidentally cause an out of range
    // error.
    if (index >= 0 && index < widget.transcript.lines.length) {
      final position = widget.transcript.lines[index].startTime;
      if (position != null) {
        ref.read(audioHandlerProvider).requireValue.seek(position);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(transcriptIndexControllerProvider);
    final scale = ref.watch(transcriptScaleServiceProvider);
    final showTranslation = ref.watch(showTranslationServiceProvider);
    final canSeeTranslation = ref.watch(canSeeTranscriptServiceProvider);
    final shouldShowTranslation = showTranslation && canSeeTranslation;

    ref.listen<int?>(
      transcriptIndexControllerProvider,
      (_, index) => _scrollToItem(index),
    );

    ref.listen<bool>(
      enableAutoScrollServiceProvider,
      (_, enabled) {
        if (enabled) _scrollToItem(currentIndex);
      },
    );

    return ScrollablePositionedList.builder(
      itemCount: widget.transcript.lines.length,
      physics: const ClampingScrollPhysics(),
      itemScrollController: _scrollController,
      itemPositionsListener: _itemsPositionsListener,
      itemBuilder: (context, index) {
        return TranscriptLineWidget(
          index: index,
          transcript: widget.transcript,
          translation: shouldShowTranslation ? widget.translation : null,
          selected: index == currentIndex,
          scale: scale,
          onTap: () => _onTap(index),
        );
      },
    );
  }
}
