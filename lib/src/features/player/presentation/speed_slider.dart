import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/presentation/speed_slider_controller.dart';
import 'package:kantan/src/localization/string_hardcoded.dart';

class SpeedSlider extends ConsumerWidget {
  const SpeedSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedValue = ref.watch(speedProvider);
    return Row(
      children: [
        Text(
          speedValue.when(
            loading: () => 1.0.toString(),
            error: (_, __) => 1.0.toString(),
            data: (speed) => '${speed.toStringAsFixed(1)}x'.hardcoded,
          ),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Expanded(
          child: Slider(
            min: 0.5,
            max: 2.0,
            divisions: 16,
            value: speedValue.when(
              loading: () => 1.0,
              error: (_, __) => 1.0,
              data: (speed) => speed,
            ),
            onChanged: (speed) => ref.read(setSpeedProvider(speed)),
          ),
        ),
      ],
    );
  }
}
