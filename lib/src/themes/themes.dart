import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

final lightColorScheme = FlexColorScheme.light(
  blendLevel: 24,
  scheme: FlexScheme.mandyRed,
).toScheme;

final darkColorScheme = FlexColorScheme.dark(
  blendLevel: 8,
  scheme: FlexScheme.mandyRed,
).toScheme;

abstract final class AppTheme {
  static ThemeData light = FlexThemeData.light(
    colorScheme: lightColorScheme,
    applyElevationOverlayColor: false,
    fontFamily: 'Atkinson Hyperlegible Next',
    scaffoldBackground: lightColorScheme.primary,
    subThemesData: FlexSubThemesData(
      interactionEffects: true,
      splashType: FlexSplashType.inkSparkle,
    ),
    extensions: <ThemeExtension<dynamic>>[
      LayoutStyle.light(lightColorScheme),
      TrackListPaneStyle.light(lightColorScheme),
      TrackListAppBarStyle.light(lightColorScheme),
      PlayerPaneStyle.light(lightColorScheme),
      TranscriptPaneStyle.light(lightColorScheme),
      FloatingMiniPlayerPlayPauseButtonStyle.light(lightColorScheme),
      FloatingMiniPlayerTrackInfoButton.light(lightColorScheme),
      PlayerScreenControlsStyle.light(lightColorScheme),
      OpenTranscriptButtonStyle.light(lightColorScheme),
      PlayerScreenSliderStyle.light(lightColorScheme),
      TranscriptProgressSliderStyle.light(lightColorScheme),
      TranscriptScreenStyle.light(lightColorScheme),
      TranscriptLineWidgetStyle.light(lightColorScheme),
      TranscriptScreenButtonStyle.light(lightColorScheme),
      TranscriptScreenToggleStyle.light(lightColorScheme),
    ],
  );

  static ThemeData dark = FlexThemeData.dark(
    colorScheme: darkColorScheme,
    applyElevationOverlayColor: false,
    fontFamily: 'Atkinson Hyperlegible Next',
    scaffoldBackground: Colors.black,
    variant: FlexSchemeVariant.fidelity,
    subThemesData: FlexSubThemesData(
      interactionEffects: true,
      splashType: FlexSplashType.inkSparkle,
    ),
    extensions: <ThemeExtension<dynamic>>[
      LayoutStyle.dark(darkColorScheme),
      TrackListPaneStyle.dark(darkColorScheme),
      TrackListAppBarStyle.dark(darkColorScheme),
      PlayerPaneStyle.dark(darkColorScheme),
      TranscriptPaneStyle.dark(darkColorScheme),
      FloatingMiniPlayerPlayPauseButtonStyle.dark(darkColorScheme),
      FloatingMiniPlayerTrackInfoButton.dark(darkColorScheme),
      PlayerScreenControlsStyle.dark(darkColorScheme),
      OpenTranscriptButtonStyle.dark(darkColorScheme),
      PlayerScreenSliderStyle.dark(darkColorScheme),
      TranscriptProgressSliderStyle.dark(darkColorScheme),
      TranscriptScreenStyle.dark(darkColorScheme),
      TranscriptLineWidgetStyle.dark(darkColorScheme),
      TranscriptScreenButtonStyle.dark(darkColorScheme),
      TranscriptScreenToggleStyle.dark(darkColorScheme),
    ],
  );
}
