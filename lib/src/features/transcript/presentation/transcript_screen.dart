import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:kantan/l10n/string_hardcoded.dart';
import 'package:kantan/src/features/transcript/application/transcript_index_service.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/domain/transcript_line.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_line_controller.dart';

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
        } else if (data.transcript!.lines[0].startTime == null) {
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
  late final AutoScrollController _scrollController;
  late final bool _enableAutoScroll;

  @override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController();
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
    // TODO: Make a service to provide whether autoscrolling is enabled or not.
    // Check the value of that service before actually scrolling.
    _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(transcriptIndexServiceProvider, (_, index) => _scroll(index));
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
  });

  final int index;
  final TranscriptLine transcriptLine;
  final TranscriptLine? translationLine;

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
      title: Text(transcriptLine.text),
      subtitle: translationLine != null ? Text(translationLine!.text) : null,
      selected: playbackPosition != null
          ? playbackPosition == PlaybackPosition.during
          : false,
      onTap: transcriptLine.startTime != null
          ? () => ref.read(seekToLineProvider(transcriptLine))
          : null,
    );
  }
}
