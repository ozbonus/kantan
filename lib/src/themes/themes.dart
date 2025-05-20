import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

final lightColors = FlexColorScheme.light(
  scheme: FlexScheme.mandyRed,
).toScheme;

abstract final class AppTheme {
  static final lightColorScheme = FlexColorScheme.light(
    blendLevel: 5,
    scheme: FlexScheme.mandyRed,
  ).toScheme;

  static final darkColorScheme = FlexColorScheme.dark(
    blendLevel: 5,
    scheme: FlexScheme.mandyRed,
  ).toScheme;

  static ThemeData light = FlexThemeData.light(
    colorScheme: lightColorScheme,
    applyElevationOverlayColor: false,
    fontFamily: 'Atkinson Hyperlegible Next',
    subThemesData: FlexSubThemesData(
      interactionEffects: true,
      splashType: FlexSplashType.inkSparkle,
    ),
    extensions: <ThemeExtension<dynamic>>[
      PlayerScreenContainerStyle(
        decoration: BoxDecoration(
          color: lightColorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(20.0),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border(
            top: BorderSide(
              width: 4,
              color: lightColorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            right: BorderSide(
              width: 4,
              color: lightColorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            bottom: BorderSide(
              width: 8,
              color: lightColorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            left: BorderSide(
              width: 4,
              color: lightColorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
        mainAxisSpacing: 24.0,
        crossAxisSpacing: 24.0,
        iconColor: lightColorScheme.primary,
      ),
      PlayerScreenSliderStyle(
        trackHeight: 8.0,
        activeTrackColor: lightColorScheme.primary,
        inactiveTrackColor: lightColorScheme.shadow,
        sliderTickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: lightColorScheme.primary,
        thumbRadius: 12.0,
        elevation: 0.0,
        overlayColor: lightColorScheme.primary.withAlpha(50),
        overlayRadius: 24.0,
      ),
      TranscriptProgressSliderStyle(
        trackHeight: 4.0,
        activeTrackColor: lightColorScheme.secondary,
        inactiveTrackColor: lightColorScheme.secondaryContainer,
        sliderTickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: lightColorScheme.secondary,
        thumbRadius: 8.0,
        elevation: 0.0,
        overlayColor: lightColorScheme.secondaryContainer.withAlpha(50),
        overlayRadius: 12.0,
      ),
    ],
  );

  static ThemeData dark = FlexThemeData.dark(
    colorScheme: darkColorScheme,
    applyElevationOverlayColor: false,
    fontFamily: 'Atkinson Hyperlegible Next',
    variant: FlexSchemeVariant.fidelity,
    subThemesData: FlexSubThemesData(
      interactionEffects: true,
      splashType: FlexSplashType.inkSparkle,
    ),
    extensions: <ThemeExtension<dynamic>>[
      PlayerScreenContainerStyle(
        decoration: BoxDecoration(
          color: darkColorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(24.0),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          border: Border(
            top: BorderSide(
              width: 4,
              color: darkColorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            right: BorderSide(
              width: 4,
              color: darkColorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            bottom: BorderSide(
              width: 8,
              color: darkColorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            left: BorderSide(
              width: 4,
              color: darkColorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
        mainAxisSpacing: 24.0,
        crossAxisSpacing: 24.0,
        iconColor: darkColorScheme.primary,
      ),
      PlayerScreenSliderStyle(
        trackHeight: 8.0,
        activeTrackColor: darkColorScheme.primary,
        inactiveTrackColor: darkColorScheme.surfaceContainerHighest,
        sliderTickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: darkColorScheme.primary,
        thumbRadius: 12.0,
        elevation: 0.0,
        overlayColor: darkColorScheme.primary.withAlpha(50),
        overlayRadius: 24.0,
      ),
      TranscriptProgressSliderStyle(
        trackHeight: 4.0,
        activeTrackColor: darkColorScheme.secondary,
        inactiveTrackColor: darkColorScheme.secondaryContainer,
        sliderTickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: darkColorScheme.secondary,
        thumbRadius: 8.0,
        elevation: 0.0,
        overlayColor: darkColorScheme.secondaryContainer.withAlpha(50),
        overlayRadius: 12.0,
      ),
    ],
  );
}
