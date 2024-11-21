import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button.dart';
import 'package:kantan/src/routing/app_router.dart';

class FloatingMiniPlayer extends ConsumerWidget {
  const FloatingMiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const PlayPauseButton(),
        IconButton.filledTonal(
          onPressed: () => context.goNamed(AppRoute.player),
          icon: const Icon(Icons.window_rounded),
        ),
      ],
    );
  }
}
