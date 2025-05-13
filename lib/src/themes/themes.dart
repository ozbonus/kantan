import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

final lightColors = FlexColorScheme.light(
  scheme: FlexScheme.mandyRed,
).toScheme;

abstract final class AppTheme {
  static final _light = FlexColorScheme.light(
    scheme: FlexScheme.mandyRed,
  ).toScheme;

  static ThemeData light = FlexThemeData.light(
    colorScheme: _light,
    applyElevationOverlayColor: false,
    fontFamily: 'Atkinson Hyperlegible Next',
    subThemesData: FlexSubThemesData(
      interactionEffects: true,
      splashType: FlexSplashType.inkSparkle,
    ),
    extensions: <ThemeExtension<dynamic>>[
      PlayerScreenContainerStyle(
        decoration: BoxDecoration(
          color: _light.surfaceContainer,
          borderRadius: BorderRadius.circular(24),
          border: Border(
            top: BorderSide(width: 4, color: _light.shadow),
            right: BorderSide(width: 4, color: _light.shadow),
            bottom: BorderSide(width: 8, color: _light.shadow),
            left: BorderSide(width: 4, color: _light.shadow),
          ),
          // border: Border.all(
          //   width: 4.0,
          //   color: _light.shadow,
          // ),
        ),
      ),
    ],
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
    extensions: <ThemeExtension<dynamic>>[],
  );
}
