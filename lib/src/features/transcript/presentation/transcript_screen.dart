import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
            final transcriptLine = transcript?.lines[index].text;
            final translationLine = translation?.lines[index].text;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (transcriptLine != null)
                  Text(
                    transcriptLine,
                    textAlign: TextAlign.start,
                    locale: transcript!.locale,
                  ),
                if (translationLine != null)
                  Localizations.override(
                    context: context,
                    locale: translation!.locale,
                    child: Text(
                      translationLine,
                      // textAlign: TextAlign.start,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
