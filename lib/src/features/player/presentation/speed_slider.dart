import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/presentation/speed_slider_controller.dart';

class SpeedSlider extends ConsumerWidget {
  const SpeedSlider({super.key});

  String _speedValueString(BuildContext context, double speed) {
    final localizations = AppLocalizations.of(context)!;
    return localizations.speedMultiplierSymbol(speed.toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedValue = ref.watch(speedProvider);
    return Row(
      children: [
        Text(
          speedValue.when(
            loading: () => _speedValueString(context, 1.0),
            error: (_, __) => _speedValueString(context, 1.0),
            data: (speed) => _speedValueString(context, speed),
          ),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontFeatures: [
              FontFeature.tabularFigures(),
            ],
          ),
        ),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.ltr,
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
        ),
      ],
    );
  }
}
