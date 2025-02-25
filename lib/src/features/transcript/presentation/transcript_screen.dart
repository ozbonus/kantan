import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:kantan/l10n/string_hardcoded.dart';
import 'package:kantan/src/features/transcript/application/enable_auto_scroll_service.dart';
import 'package:kantan/src/features/transcript/application/transcript_index_service.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';

/// A wrapper widget for small displays that show the transcript as a single
/// screen.
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
          return StaticTranscript(
            transcript: data.transcript!,
            translation: data.translation,
          );
        } else {
          return DynamicScrollingTranscript(
            transcript: data.transcript!,
            translation: data.translation,
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
    return Center(
      child: Text(
        'No transcript.'.hardcoded,
      ),
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
    return Container();
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
    // Recall the last known index and scroll to that.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final index = ref.read(transcriptIndexServiceProvider);
      _scroll(index);
    });
  }

  @override
  void didUpdateWidget(covariant DynamicScrollingTranscript oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scroll(int index) {
    final enableAutoScroll = ref.read(enableAutoScrollServiceProvider);
    if (enableAutoScroll) {
      _scrollController.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.middle,
      );
    }
  }

  void enabler(bool enable) {
    /// If the option to enable auto scroll is switching from off to on,
    /// immediately scroll to the active index.
    if (enable) {
      final index = ref.read(transcriptIndexServiceProvider);
      _scroll(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(transcriptIndexServiceProvider, (_, index) => _scroll(index));
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
    this.translationLine,
    required this.transcriptLineLocale,
    this.translationLineLocale,
  });

  final int index;
  final TranscriptLine transcriptLine;
  final TranscriptLine? translationLine;
  final Locale transcriptLineLocale;
  final Locale? translationLineLocale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final PlaybackPosition? playbackPosition;
    if (transcriptLine.startTime != null) {
      playbackPosition =
          ref.watch(transcriptLineControllerProvider(transcriptLine, index));
      ref.listen(transcriptLineControllerProvider(transcriptLine, index),
          (prev, next) {
        if (next == PlaybackPosition.during) {
          ref.read(transcriptIndexServiceProvider.notifier).setIndex(index);
        }
      });
    }

    return ListTile(
      title: Localizations.override(
        context: context,
        locale: transcriptLineLocale,
        child: Text(transcriptLine.text),
      ),
      leading:
          transcriptLine.speaker != null ? Text(transcriptLine.speaker!) : null,
      subtitle: translationLine != null
          ? Localizations.override(
              context: context,
              locale: translationLineLocale,
              child: Text(translationLine!.text),
            )
          : null,
      selected: playbackPosition != null
          ? playbackPosition == PlaybackPosition.during
          : false,
      onTap: transcriptLine.startTime != null
          ? () => ref.read(seekToLineProvider(transcriptLine))
          : null,
    );
  }
}
