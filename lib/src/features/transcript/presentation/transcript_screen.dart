import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/domain/transcript_line.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';

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
    final controller = ref.watch(transcriptControllerProvider);
    return controller.when(
      loading: () => const CircularProgressIndicator.adaptive(),
      error: (e, st) => const CircularProgressIndicator.adaptive(),
      data: (data) {
        final transcript = data.transcript;
        final translation = data.translation;
        return ListView.builder(
          itemCount: transcript?.lines.length ?? 0,
          itemBuilder: (context, index) {
            final transcriptLine = transcript?.lines[index];
            final translationLine = translation?.lines[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8.0,
                children: [
                  if (transcriptLine != null)
                    TranscriptLineRow(
                      locale: transcript!.locale,
                      transcriptLine: transcriptLine,
                    ),
                  if (translationLine != null)
                    TranscriptLineRow(
                      locale: translation!.locale,
                      transcriptLine: translationLine,
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class TranscriptLineRow extends ConsumerWidget {
  const TranscriptLineRow({
    super.key,
    required this.locale,
    required this.transcriptLine,
  });

  final Locale locale;
  final TranscriptLine transcriptLine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      locale: locale,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          if (transcriptLine.speaker != null) Text(transcriptLine.speaker!),
          Expanded(
            child: Text(transcriptLine.text),
          ),
        ],
      ),
    );
  }
}
