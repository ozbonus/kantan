import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/routing/app_router.dart';

class TrackListScreen extends ConsumerWidget {
  const TrackListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioHandler = ref.watch(audioHandlerProvider).requireValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track List Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  onPressed: audioHandler.play,
                  icon: const Icon(Icons.play_arrow_rounded),
                ),
                IconButton.filledTonal(
                  onPressed: audioHandler.pause,
                  icon: const Icon(Icons.pause_rounded),
                ),
                IconButton.filledTonal(
                  onPressed: audioHandler.skipToPrevious,
                  icon: const Icon(Icons.skip_previous_rounded),
                ),
                IconButton.filledTonal(
                  onPressed: audioHandler.skipToNext,
                  icon: const Icon(Icons.skip_next_rounded),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () => context.goNamed(AppRoute.player),
                child: const Text('Go to Player Screen'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () => context.goNamed(AppRoute.transcript),
                child: const Text('Go to Transcript Screen'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
