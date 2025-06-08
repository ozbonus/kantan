import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

final lightColorScheme = FlexColorScheme.light(
  blendLevel: 24,
  scheme: FlexScheme.mandyRed,
).toScheme;

final darkColorScheme = FlexColorScheme.dark(
  blendLevel: 32,
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
      TrackListPaneStyle(
        decoration: BoxDecoration(
          color: lightColorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
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
              width: 12,
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
      ),
      PlayerPaneStyle(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lightColorScheme.primaryContainer,
              lightColorScheme.primary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      TranscriptPaneStyle(
        decoration: BoxDecoration(
          color: lightColorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
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
              width: 12,
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
      ),
      PlayerScreenControlsStyle(
        decoration: BoxDecoration(
          color: lightColorScheme.surface,
          borderRadius: BorderRadius.circular(16.0),
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
      TranscriptScreenStyle(
        backgroundColor: lightColorScheme.secondaryContainer,
        appBarElevation: 0.0,
        appBarScrolledUnderElevation: 0.0,
      ),
      TranscriptLineWidgetStyle(
        inactiveColor: lightColorScheme.secondaryContainer,
        activeColor: lightColorScheme.secondaryContainer.darken(5),
        borderRadius: 24.0,
        borderColor: lightColorScheme.secondaryContainer.darken(50),
        borderWidth: 2.0,
        splashColor: lightColorScheme.secondary.withAlpha(128),
        speakerNameTextStyle: TextStyle(
          color: lightColorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        speakerNameTranslationTextStyle: TextStyle(
          color: lightColorScheme.onSecondaryContainer.blend(
            lightColorScheme.secondaryContainer,
            50,
          ),
          fontWeight: FontWeight.bold,
        ),
        transcriptTextStyle: TextStyle(
          color: lightColorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        translationTextStyle: TextStyle(
          color: lightColorScheme.onSecondaryContainer.blend(
            lightColorScheme.secondaryContainer,
            50,
          ),
          fontWeight: FontWeight.bold,
        ),
      ),
      TranscriptScreenButtonStyle(
        buttonStyle: IconButton.styleFrom(
          foregroundColor: lightColorScheme.onSecondaryContainer,
          backgroundColor: lightColorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      TranscriptScreenToggleStyle(
        active: IconButton.styleFrom(
          foregroundColor: lightColorScheme.onSecondary,
          backgroundColor: lightColorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inactive: IconButton.styleFrom(
          foregroundColor: lightColorScheme.onSecondaryContainer,
          backgroundColor: lightColorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            width: 2.0,
            color: lightColorScheme.secondary,
          ),
        ),
        disabled: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
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
      TrackListPaneStyle(
        decoration: BoxDecoration(
          color: darkColorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      PlayerPaneStyle(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              darkColorScheme.surface,
              Colors.black,
            ],
            stops: [0.0, 0.5],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      TranscriptPaneStyle(
        decoration: BoxDecoration(
          color: darkColorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      PlayerScreenControlsStyle(
        decoration: BoxDecoration(
          color: darkColorScheme.surface,
          borderRadius: BorderRadius.circular(16.0),
          border: Border(
            top: BorderSide(
              width: 4,
              color: darkColorScheme.surfaceBright,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            right: BorderSide(
              width: 4,
              color: darkColorScheme.surfaceBright,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            bottom: BorderSide(
              width: 8,
              color: darkColorScheme.surfaceBright,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            left: BorderSide(
              width: 4,
              color: darkColorScheme.surfaceBright,
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
        inactiveTrackColor: darkColorScheme.surfaceBright,
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
      TranscriptScreenStyle(
        backgroundColor: darkColorScheme.secondaryContainer,
        appBarElevation: 0.0,
        appBarScrolledUnderElevation: 0.0,
      ),
      TranscriptLineWidgetStyle(
        inactiveColor: darkColorScheme.secondaryContainer,
        activeColor: darkColorScheme.secondaryContainer.darken(4),
        borderRadius: 24.0,
        borderColor: darkColorScheme.secondaryContainer.darken(8),
        borderWidth: 2.0,
        splashColor: darkColorScheme.secondary.withAlpha(128),
        speakerNameTextStyle: TextStyle(
          color: darkColorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        speakerNameTranslationTextStyle: TextStyle(
          color: darkColorScheme.onSecondaryContainer.blend(
            darkColorScheme.secondaryContainer,
            50,
          ),
          fontWeight: FontWeight.bold,
        ),
        transcriptTextStyle: TextStyle(
          color: darkColorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        translationTextStyle: TextStyle(
          color: darkColorScheme.onSecondaryContainer.blend(
            darkColorScheme.secondaryContainer,
            50,
          ),
          fontWeight: FontWeight.bold,
        ),
      ),
      TranscriptScreenButtonStyle(
        buttonStyle: IconButton.styleFrom(
          foregroundColor: darkColorScheme.onSecondaryContainer,
          backgroundColor: darkColorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      TranscriptScreenToggleStyle(
        active: IconButton.styleFrom(
          foregroundColor: darkColorScheme.onSecondary,
          backgroundColor: darkColorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inactive: IconButton.styleFrom(
          foregroundColor: darkColorScheme.onSecondaryContainer,
          backgroundColor: darkColorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            width: 2.0,
            color: darkColorScheme.secondary,
          ),
        ),
        disabled: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ],
  );
}
