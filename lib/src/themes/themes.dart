import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

final lightColors = FlexColorScheme.light(
  scheme: FlexScheme.mandyRed,
).toScheme;

abstract final class AppTheme {
  static final lightColorScheme = FlexColorScheme.light(
    scheme: FlexScheme.mandyRed,
  ).toScheme;

  static final darkColorScheme = FlexColorScheme.dark(
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
          borderRadius: BorderRadius.circular(24.0),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          border: Border(
            top: BorderSide(width: 4, color: lightColorScheme.shadow),
            right: BorderSide(width: 4, color: lightColorScheme.shadow),
            bottom: BorderSide(width: 8, color: lightColorScheme.shadow),
            left: BorderSide(width: 4, color: lightColorScheme.shadow),
          ),
        ),
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
          color: darkColorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
          border: Border(
            top: BorderSide(width: 4, color: lightColorScheme.onSurface),
            right: BorderSide(width: 4, color: lightColorScheme.onSurface),
            bottom: BorderSide(width: 8, color: lightColorScheme.onSurface),
            left: BorderSide(width: 4, color: lightColorScheme.onSurface),
          ),
        ),
      ),
    ],
  );
}
