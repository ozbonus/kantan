import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      TrackListPaneStyle(
        decoration: BoxDecoration(
          color: darkColorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      TrackListAppBarStyle(
        systemUiOverlayStyle: SystemUiOverlayStyle.light,
        fullscreenAppBarCollapsedColor: lightColorScheme.primary,
        backgroundContainerDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              darkColorScheme.surface.blend(darkColorScheme.primary, 50),
              darkColorScheme.surface,
            ],
            stops: [0.8, 0.8],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        imageContainerDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        imageContainerForegroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignInside,
            width: 2.0,
            color: darkColorScheme.outline,
          ),
        ),
      ),
      PlayerPaneStyle(
        containerDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              darkColorScheme.primaryContainer.blend(Colors.black, 70),
              Colors.black,
            ],
            stops: [0.0, 0.6],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        appBarForegroundColor: darkColorScheme.onPrimary,
        trackNumberTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: darkColorScheme.onPrimary,
          shadows: [
            Shadow(
              color: lightColorScheme.shadow,
              offset: Offset(0.0, 1.5),
              blurRadius: 4.0,
            ),
          ],
        ),
        trackTitleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: darkColorScheme.onPrimary,
          shadows: [
            Shadow(
              color: lightColorScheme.shadow,
              offset: Offset(0.0, 1.5),
              blurRadius: 4.0,
            ),
          ],
        ),
        trackDescriptionTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: darkColorScheme.onPrimary,
          shadows: [
            Shadow(
              color: lightColorScheme.shadow,
              offset: Offset(0.0, 1.5),
              blurRadius: 4.0,
            ),
          ],
        ),
      ),
      TranscriptPaneStyle(
        decoration: BoxDecoration(
          color: darkColorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      FloatingMiniPlayerPlayPauseButtonStyle(
        decoration: BoxDecoration(
          color: darkColorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: darkColorScheme.secondary,
          ),
        ),
        iconColor: darkColorScheme.onSecondaryContainer,
      ),
      FloatingMiniPlayerTrackInfoButton(
        decoration: BoxDecoration(
          color: darkColorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: darkColorScheme.secondary,
          ),
        ),
      ),
      PlayerScreenControlsStyle(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: darkColorScheme.primary.blend(darkColorScheme.onSurface, 50),
          ),
        ),
        mainAxisSpacing: 24.0,
        crossAxisSpacing: 24.0,
        iconColor: darkColorScheme.primary,
      ),
      OpenTranscriptButtonStyle(
        decoration: BoxDecoration(
          color: darkColorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16.0),
        ),
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
        borderRadius: 16.0,
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
      TranscriptScreenToggleStyle.dark(darkColorScheme),
    ],
  );
}
