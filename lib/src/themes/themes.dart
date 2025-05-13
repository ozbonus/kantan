import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

abstract final class AppTheme {
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.mandyRed,
    applyElevationOverlayColor: false,
    fontFamily: 'Atkinson Hyperlegible Next',
    subThemesData: FlexSubThemesData(
      interactionEffects: true,
      splashType: FlexSplashType.inkSparkle,
    ),
  );

  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.mandyRed,
    applyElevationOverlayColor: false,
    fontFamily: 'Atkinson Hyperlegible Next',
    variant: FlexSchemeVariant.fidelity,
    subThemesData: FlexSubThemesData(
      interactionEffects: true,
      splashType: FlexSplashType.inkSparkle,
    ),
  );
}
