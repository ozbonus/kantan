import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/features/transcript/domain/transcript_line.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';
import 'package:kantan/src/routing/app_router.dart';

class TranscriptScreen extends ConsumerWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(transcriptControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transcript Screen'),
      ),
      body: Center(
        child: TranscriptScreenContents(),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: FilledButton(
      //           onPressed: () => context.goNamed(AppRoute.home),
      //           child: const Text('Go to Home Screen'),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: FilledButton(
      //           onPressed: () => context.goNamed(AppRoute.player),
      //           child: const Text('Go to Player Screen'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
