import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/presentation/rewind_forward_button_controller.dart';

class RewindButton extends ConsumerWidget {
  const RewindButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(rewindForwardButtonControllerProvider.notifier);
    return IconButton.filledTonal(
      onPressed: controller.rewind,
      icon: const Icon(Icons.replay_5_rounded),
    );
  }
}

class FastForwardButton extends ConsumerWidget {
  const FastForwardButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(rewindForwardButtonControllerProvider.notifier);
    return IconButton.filledTonal(
      onPressed: controller.fastForward,
      icon: const Icon(Icons.forward_5_rounded),
    );
  }
}
