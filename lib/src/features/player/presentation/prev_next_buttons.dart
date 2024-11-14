import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/presentation/prev_next_button_controller.dart';

class SkipToPreviousButton extends ConsumerWidget {
  const SkipToPreviousButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(prevNextButtonControllerProvider.notifier);
    return IconButton.filledTonal(
      onPressed: controller.skipToPrevious,
      icon: const Icon(Icons.skip_previous_rounded),
    );
  }
}

class SkipToNextButton extends ConsumerWidget {
  const SkipToNextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(prevNextButtonControllerProvider.notifier);
    return IconButton.filledTonal(
      onPressed: controller.skipToNext,
      icon: const Icon(Icons.skip_next_rounded),
    );
  }
}
