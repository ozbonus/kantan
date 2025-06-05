import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/l10n/app_localizations.dart';
import 'package:kantan/src/features/player/presentation/buttons.dart';
import 'package:kantan/src/features/player/presentation/speed_slider_controller.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class SpeedSlider extends ConsumerWidget {
  const SpeedSlider({super.key});

  String _speedValueString(BuildContext context, double speed) {
    final localizations = AppLocalizations.of(context)!;
    return localizations.speedMultiplierSymbol(speed.toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedValue = ref.watch(speedProvider);
    final style = Theme.of(context).extension<PlayerScreenSliderStyle>();
    return ButtonContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
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
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: style?.trackHeight,
                    tickMarkShape: style?.sliderTickMarkShape,
                    activeTrackColor: style?.activeTrackColor,
                    inactiveTrackColor: style?.inactiveTrackColor,
                    thumbColor: style?.thumbColor,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: style?.thumbRadius ?? 8.0,
                      disabledThumbRadius: style?.thumbRadius ?? 8.0,
                      elevation: style?.elevation ?? 0.0,
                      pressedElevation: style?.elevation ?? 0.0,
                    ),
                    overlayColor: style?.overlayColor,
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
