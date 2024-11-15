import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/player/presentation/repeat_mode_button_controller.dart';

class RepeatModeButton extends ConsumerWidget {
  const RepeatModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repeatModeValue = ref.watch(repeatModeButtonControllerProvider);
    final controller = ref.read(repeatModeButtonControllerProvider.notifier);
    return IconButton.filledTonal(
      onPressed: controller.nextRepeatMode,
      icon: AsyncValueWidget(
        value: repeatModeValue,
        data: (repeatMode) {
          switch (repeatMode) {
            case RepeatMode.none:
              return const Icon(Icons.arrow_right_alt_rounded);
            case RepeatMode.one:
              return const Icon(Icons.repeat_one_rounded);
            case RepeatMode.all:
              return const Icon(Icons.repeat_rounded);
          }
        },
      ),
    );
  }
}
