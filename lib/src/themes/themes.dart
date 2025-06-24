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
      TrackListAppBarStyle(
        systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        fullscreenAppBarCollapsedColor: lightColorScheme.primaryContainer,
        backgroundContainerDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lightColorScheme.surface.blend(lightColorScheme.primary, 20),
              lightColorScheme.surface,
            ],
            stops: [0.8, 0.8],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        imageContainerDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: lightColorScheme.shadow.withAlpha(64),
              blurRadius: 4.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
        ),
        imageContainerForegroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignInside,
            width: 2.0,
            color: lightColorScheme.outline,
          ),
        ),
      ),
      PlayerPaneStyle(
        containerDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lightColorScheme.primaryContainer,
              lightColorScheme.primary,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        appBarForegroundColor: lightColorScheme.surface,
        trackNumberTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: lightColorScheme.surface,
          shadows: [
            Shadow(
              color: lightColorScheme.shadow,
              offset: Offset(0.0, 1.5),
              blurRadius: 4.0,
            ),
          ],
        ),
        trackTitleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: lightColorScheme.surface,
          shadows: [
            Shadow(
              color: lightColorScheme.shadow,
              offset: Offset(0.0, 1.5),
              blurRadius: 4.0,
            ),
          ],
        ),
        trackDescriptionTextStyle: TextStyle(
          color: lightColorScheme.surface,
          fontWeight: FontWeight.bold,
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
      FloatingMiniPlayerPlayPauseButtonStyle(
        decoration: BoxDecoration(
          color: lightColorScheme.secondaryContainer,
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
        iconColor: lightColorScheme.onSecondaryContainer,
      ),
      FloatingMiniPlayerTrackInfoButton(
        decoration: BoxDecoration(
          color: lightColorScheme.secondaryContainer,
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
      OpenTranscriptButtonStyle(
        decoration: BoxDecoration(
          color: lightColorScheme.secondary,
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
        foregroundColor: lightColorScheme.onSecondary,
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
        borderRadius: 16.0,
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
