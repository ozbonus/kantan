import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

/// This theme extension is also used to set the scaffold color on the track
/// list screen.
@immutable
class TrackListPaneStyle extends ThemeExtension<TrackListPaneStyle> {
  const TrackListPaneStyle({
    this.decoration,
  });

  final BoxDecoration? decoration;

  factory TrackListPaneStyle.light(ColorScheme colorScheme) =>
      TrackListPaneStyle(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
          border: Border(
            top: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            right: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            bottom: BorderSide(
              width: 12,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            left: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
      );

  factory TrackListPaneStyle.dark(ColorScheme colorScheme) =>
      TrackListPaneStyle(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
        ),
      );

  @override
  TrackListPaneStyle copyWith({
    BoxDecoration? decoration,
  }) {
    return TrackListPaneStyle(
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  ThemeExtension<TrackListPaneStyle> lerp(
    ThemeExtension<TrackListPaneStyle>? other,
    double t,
  ) {
    if (other is! TrackListPaneStyle) {
      return this;
    }

    return TrackListPaneStyle(
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
    );
  }
}

@immutable
class TrackListAppBarStyle extends ThemeExtension<TrackListAppBarStyle> {
  const TrackListAppBarStyle({
    this.systemUiOverlayStyle,
    this.fullscreenAppBarCollapsedColor,
    this.contentsOnlyAppBarCollapsedColor,
    this.backgroundContainerDecoration,
    this.imageContainerDecoration,
    this.imageContainerForegroundDecoration,
  });

  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final Color? fullscreenAppBarCollapsedColor;
  final Color? contentsOnlyAppBarCollapsedColor;
  final BoxDecoration? backgroundContainerDecoration;
  final BoxDecoration? imageContainerDecoration;
  final BoxDecoration? imageContainerForegroundDecoration;

  factory TrackListAppBarStyle.light(ColorScheme colorScheme) =>
      TrackListAppBarStyle(
        systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        fullscreenAppBarCollapsedColor: colorScheme.primaryContainer,
        backgroundContainerDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.surface.blend(colorScheme.primary, 20),
              colorScheme.surface,
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
              color: colorScheme.shadow.withAlpha(64),
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
            color: colorScheme.outline,
          ),
        ),
      );

  factory TrackListAppBarStyle.dark(ColorScheme colorScheme) =>
      TrackListAppBarStyle(
        systemUiOverlayStyle: SystemUiOverlayStyle.light,
        fullscreenAppBarCollapsedColor: colorScheme.primary,
        backgroundContainerDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.surface.blend(colorScheme.primary, 50),
              colorScheme.surface,
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
            color: colorScheme.outline,
          ),
        ),
      );

  @override
  TrackListAppBarStyle copyWith({
    SystemUiOverlayStyle? systemUiOverlayStyle,
    Color? fullscreenAppBarCollapsedColor,
    Color? contentsOnlyAppBarCollapsedColor,
    BoxDecoration? backgroundContainerDecoration,
    BoxDecoration? imageContainerDecoration,
    BoxDecoration? imageContainerForegroundDecoration,
  }) {
    return TrackListAppBarStyle(
      systemUiOverlayStyle: systemUiOverlayStyle ?? this.systemUiOverlayStyle,
      fullscreenAppBarCollapsedColor:
          fullscreenAppBarCollapsedColor ?? this.fullscreenAppBarCollapsedColor,
      contentsOnlyAppBarCollapsedColor:
          contentsOnlyAppBarCollapsedColor ??
          this.contentsOnlyAppBarCollapsedColor,
      backgroundContainerDecoration:
          backgroundContainerDecoration ?? this.backgroundContainerDecoration,
      imageContainerDecoration:
          imageContainerDecoration ?? this.imageContainerDecoration,
      imageContainerForegroundDecoration:
          imageContainerForegroundDecoration ??
          this.imageContainerForegroundDecoration,
    );
  }

  @override
  ThemeExtension<TrackListAppBarStyle> lerp(
    ThemeExtension<TrackListAppBarStyle>? other,
    double t,
  ) {
    if (other is! TrackListAppBarStyle) {
      return this;
    }

    return TrackListAppBarStyle(
      systemUiOverlayStyle: t < 0.5
          ? systemUiOverlayStyle
          : other.systemUiOverlayStyle,
      fullscreenAppBarCollapsedColor: Color.lerp(
        fullscreenAppBarCollapsedColor,
        other.fullscreenAppBarCollapsedColor,
        t,
      ),
      contentsOnlyAppBarCollapsedColor: Color.lerp(
        contentsOnlyAppBarCollapsedColor,
        other.contentsOnlyAppBarCollapsedColor,
        t,
      ),
      backgroundContainerDecoration: BoxDecoration.lerp(
        backgroundContainerDecoration,
        other.backgroundContainerDecoration,
        t,
      ),
      imageContainerDecoration: BoxDecoration.lerp(
        imageContainerDecoration,
        other.imageContainerDecoration,
        t,
      ),
      imageContainerForegroundDecoration: BoxDecoration.lerp(
        imageContainerForegroundDecoration,
        other.imageContainerForegroundDecoration,
        t,
      ),
    );
  }
}

@immutable
class PlayerPaneStyle extends ThemeExtension<PlayerPaneStyle> {
  const PlayerPaneStyle({
    this.containerDecoration,
    this.appBarForegroundColor,
    this.trackNumberTextStyle,
    this.trackTitleTextStyle,
    this.trackDescriptionTextStyle,
  });

  final BoxDecoration? containerDecoration;
  final Color? appBarForegroundColor;
  final TextStyle? trackNumberTextStyle;
  final TextStyle? trackTitleTextStyle;
  final TextStyle? trackDescriptionTextStyle;

  factory PlayerPaneStyle.light(ColorScheme colorScheme) => PlayerPaneStyle(
    containerDecoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          colorScheme.primaryContainer,
          colorScheme.primary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      borderRadius: BorderRadius.circular(24.0),
    ),
    appBarForegroundColor: colorScheme.surface,
    trackNumberTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: colorScheme.surface,
      shadows: [
        Shadow(
          color: colorScheme.shadow,
          offset: Offset(0.0, 1.5),
          blurRadius: 4.0,
        ),
      ],
    ),
    trackTitleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: colorScheme.surface,
      shadows: [
        Shadow(
          color: colorScheme.shadow,
          offset: Offset(0.0, 1.5),
          blurRadius: 4.0,
        ),
      ],
    ),
    trackDescriptionTextStyle: TextStyle(
      color: colorScheme.surface,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          color: colorScheme.shadow,
          offset: Offset(0.0, 1.5),
          blurRadius: 4.0,
        ),
      ],
    ),
  );

  factory PlayerPaneStyle.dark(ColorScheme colorScheme) => PlayerPaneStyle(
    containerDecoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          colorScheme.primaryContainer.blend(Colors.black, 70),
          Colors.black,
        ],
        stops: [0.0, 0.6],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(24.0),
    ),
    appBarForegroundColor: colorScheme.onPrimary,
    trackNumberTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
      shadows: [
        Shadow(
          color: colorScheme.shadow,
          offset: Offset(0.0, 1.5),
          blurRadius: 4.0,
        ),
      ],
    ),
    trackTitleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
      shadows: [
        Shadow(
          color: colorScheme.shadow,
          offset: Offset(0.0, 1.5),
          blurRadius: 4.0,
        ),
      ],
    ),
    trackDescriptionTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
      shadows: [
        Shadow(
          color: colorScheme.shadow,
          offset: Offset(0.0, 1.5),
          blurRadius: 4.0,
        ),
      ],
    ),
  );

  @override
  PlayerPaneStyle copyWith({
    BoxDecoration? containerDecoration,
    Color? appBarForegroundColor,
    TextStyle? trackNumberTextStyle,
    TextStyle? trackTitleTextStyle,
    TextStyle? trackDescriptionTextStyle,
  }) {
    return PlayerPaneStyle(
      containerDecoration: containerDecoration ?? this.containerDecoration,
      appBarForegroundColor:
          appBarForegroundColor ?? this.appBarForegroundColor,
      trackNumberTextStyle: trackNumberTextStyle ?? this.trackNumberTextStyle,
      trackTitleTextStyle: trackTitleTextStyle ?? this.trackTitleTextStyle,
      trackDescriptionTextStyle:
          trackDescriptionTextStyle ?? this.trackDescriptionTextStyle,
    );
  }

  @override
  ThemeExtension<PlayerPaneStyle> lerp(
    ThemeExtension<PlayerPaneStyle>? other,
    double t,
  ) {
    if (other is! PlayerPaneStyle) {
      return this;
    }

    return PlayerPaneStyle(
      containerDecoration: BoxDecoration.lerp(
        containerDecoration,
        other.containerDecoration,
        t,
      ),
      appBarForegroundColor: Color.lerp(
        appBarForegroundColor,
        other.appBarForegroundColor,
        t,
      ),
      trackNumberTextStyle: TextStyle.lerp(
        trackNumberTextStyle,
        other.trackNumberTextStyle,
        t,
      ),
      trackTitleTextStyle: TextStyle.lerp(
        trackTitleTextStyle,
        other.trackTitleTextStyle,
        t,
      ),
      trackDescriptionTextStyle: TextStyle.lerp(
        trackDescriptionTextStyle,
        other.trackDescriptionTextStyle,
        t,
      ),
    );
  }
}

@immutable
class FloatingMiniPlayerPlayPauseButtonStyle
    extends ThemeExtension<FloatingMiniPlayerPlayPauseButtonStyle> {
  const FloatingMiniPlayerPlayPauseButtonStyle({
    this.decoration,
    this.iconColor,
  });

  final BoxDecoration? decoration;
  final Color? iconColor;

  factory FloatingMiniPlayerPlayPauseButtonStyle.light(
    ColorScheme colorScheme,
  ) => FloatingMiniPlayerPlayPauseButtonStyle(
    decoration: BoxDecoration(
      color: colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(16.0),
      border: Border(
        top: BorderSide(
          width: 4,
          color: colorScheme.shadow,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        right: BorderSide(
          width: 4,
          color: colorScheme.shadow,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        bottom: BorderSide(
          width: 8,
          color: colorScheme.shadow,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        left: BorderSide(
          width: 4,
          color: colorScheme.shadow,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
    ),
    iconColor: colorScheme.onSecondaryContainer,
  );

  factory FloatingMiniPlayerPlayPauseButtonStyle.dark(
    ColorScheme colorScheme,
  ) => FloatingMiniPlayerPlayPauseButtonStyle(
    decoration: BoxDecoration(
      color: colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        width: 2,
        strokeAlign: BorderSide.strokeAlignOutside,
        color: colorScheme.secondary,
      ),
    ),
    iconColor: colorScheme.onSecondaryContainer,
  );

  @override
  FloatingMiniPlayerPlayPauseButtonStyle copyWith({
    BoxDecoration? decoration,
    Color? iconColor,
  }) {
    return FloatingMiniPlayerPlayPauseButtonStyle(
      decoration: decoration ?? this.decoration,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ThemeExtension<FloatingMiniPlayerPlayPauseButtonStyle> lerp(
    ThemeExtension<FloatingMiniPlayerPlayPauseButtonStyle>? other,
    double t,
  ) {
    if (other is! FloatingMiniPlayerPlayPauseButtonStyle) {
      return this;
    }

    return FloatingMiniPlayerPlayPauseButtonStyle(
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
    );
  }
}

@immutable
class FloatingMiniPlayerTrackInfoButton
    extends ThemeExtension<FloatingMiniPlayerTrackInfoButton> {
  const FloatingMiniPlayerTrackInfoButton({
    this.decoration,
    this.trackNumberTextStyle,
    this.trackNameTextStyle,
  });

  final BoxDecoration? decoration;
  final TextStyle? trackNumberTextStyle;
  final TextStyle? trackNameTextStyle;

  factory FloatingMiniPlayerTrackInfoButton.light(ColorScheme colorScheme) =>
      FloatingMiniPlayerTrackInfoButton(
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16.0),
          border: Border(
            top: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            right: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            bottom: BorderSide(
              width: 8,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            left: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
      );

  factory FloatingMiniPlayerTrackInfoButton.dark(ColorScheme colorScheme) =>
      FloatingMiniPlayerTrackInfoButton(
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: colorScheme.secondary,
          ),
        ),
      );

  @override
  FloatingMiniPlayerTrackInfoButton copyWith({
    BoxDecoration? decoration,
    TextStyle? trackNumberTextStyle,
    TextStyle? trackNameTextStyle,
  }) {
    return FloatingMiniPlayerTrackInfoButton(
      decoration: decoration ?? this.decoration,
      trackNumberTextStyle: trackNumberTextStyle ?? this.trackNumberTextStyle,
      trackNameTextStyle: trackNameTextStyle ?? this.trackNameTextStyle,
    );
  }

  @override
  ThemeExtension<FloatingMiniPlayerTrackInfoButton> lerp(
    ThemeExtension<FloatingMiniPlayerTrackInfoButton>? other,
    double t,
  ) {
    if (other is! FloatingMiniPlayerTrackInfoButton) {
      return this;
    }

    return FloatingMiniPlayerTrackInfoButton(
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
      trackNumberTextStyle: TextStyle.lerp(
        trackNumberTextStyle,
        other.trackNumberTextStyle,
        t,
      ),
      trackNameTextStyle: TextStyle.lerp(
        trackNameTextStyle,
        other.trackNameTextStyle,
        t,
      ),
    );
  }
}

@immutable
class TranscriptPaneStyle extends ThemeExtension<TranscriptPaneStyle> {
  const TranscriptPaneStyle({
    this.decoration,
  });

  final BoxDecoration? decoration;

  factory TranscriptPaneStyle.light(ColorScheme colorScheme) =>
      TranscriptPaneStyle(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
          border: Border(
            top: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            right: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            bottom: BorderSide(
              width: 12,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            left: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
      );

  factory TranscriptPaneStyle.dark(ColorScheme colorScheme) =>
      TranscriptPaneStyle(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24.0),
        ),
      );

  @override
  TranscriptPaneStyle copyWith({
    BoxDecoration? decoration,
  }) {
    return TranscriptPaneStyle(
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  ThemeExtension<TranscriptPaneStyle> lerp(
    ThemeExtension<TranscriptPaneStyle>? other,
    double t,
  ) {
    if (other is! TranscriptPaneStyle) {
      return this;
    }

    return TranscriptPaneStyle(
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
    );
  }
}

@immutable
class PlayerScreenControlsStyle
    extends ThemeExtension<PlayerScreenControlsStyle> {
  const PlayerScreenControlsStyle({
    this.decoration,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.iconColor,
  });

  final BoxDecoration? decoration;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final Color? iconColor;

  factory PlayerScreenControlsStyle.light(ColorScheme colorScheme) =>
      PlayerScreenControlsStyle(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.0),
          border: Border(
            top: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            right: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            bottom: BorderSide(
              width: 8,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            left: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
        mainAxisSpacing: 24.0,
        crossAxisSpacing: 24.0,
        iconColor: colorScheme.primary,
      );

  factory PlayerScreenControlsStyle.dark(ColorScheme colorScheme) =>
      PlayerScreenControlsStyle(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: colorScheme.primary.blend(colorScheme.onSurface, 50),
          ),
        ),
        mainAxisSpacing: 24.0,
        crossAxisSpacing: 24.0,
        iconColor: colorScheme.primary,
      );

  @override
  PlayerScreenControlsStyle copyWith({
    BoxDecoration? decoration,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    Color? iconColor,
  }) {
    return PlayerScreenControlsStyle(
      decoration: decoration ?? this.decoration,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ThemeExtension<PlayerScreenControlsStyle> lerp(
    ThemeExtension<PlayerScreenControlsStyle>? other,
    double t,
  ) {
    if (other is! PlayerScreenControlsStyle) {
      return this;
    }

    return PlayerScreenControlsStyle(
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
      mainAxisSpacing: lerpDouble(mainAxisSpacing, other.mainAxisSpacing, t),
      crossAxisSpacing: lerpDouble(crossAxisSpacing, other.crossAxisSpacing, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
    );
  }
}

@immutable
class OpenTranscriptButtonStyle
    extends ThemeExtension<OpenTranscriptButtonStyle> {
  const OpenTranscriptButtonStyle({
    this.decoration,
    this.foregroundColor,
  });

  final BoxDecoration? decoration;
  final Color? foregroundColor;

  factory OpenTranscriptButtonStyle.light(ColorScheme colorScheme) =>
      OpenTranscriptButtonStyle(
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(16.0),
          border: Border(
            top: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            right: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            bottom: BorderSide(
              width: 8,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            left: BorderSide(
              width: 4,
              color: colorScheme.shadow,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
        foregroundColor: colorScheme.onSecondary,
      );

  factory OpenTranscriptButtonStyle.dark(ColorScheme colorScheme) =>
      OpenTranscriptButtonStyle(
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16.0),
        ),
      );

  @override
  OpenTranscriptButtonStyle copyWith({
    BoxDecoration? decoration,
    Color? foregroundColor,
  }) {
    return OpenTranscriptButtonStyle(
      decoration: decoration ?? this.decoration,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  @override
  ThemeExtension<OpenTranscriptButtonStyle> lerp(
    ThemeExtension<OpenTranscriptButtonStyle>? other,
    double t,
  ) {
    if (other is! OpenTranscriptButtonStyle) {
      return this;
    }

    return OpenTranscriptButtonStyle(
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
    );
  }
}

// This theme extension is being used instead of setting the [SliderTheme]
// because extracting values for the the progress slider didn't work well. Also,
// there are other sliders that'll need to be styled differently anyway, so they
// might as well all be handled the same way.
@immutable
class PlayerScreenSliderStyle extends ThemeExtension<PlayerScreenSliderStyle> {
  const PlayerScreenSliderStyle({
    this.trackHeight,
    this.thumbRadius,
    this.glowRadius,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.overlayColor,
    this.overlayRadius,
    this.sliderTickMarkShape,
    this.thumbColor,
    this.elevation,
  });

  final double? trackHeight;
  final double? thumbRadius;
  final double? glowRadius;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? overlayColor;
  final double? overlayRadius;
  final SliderTickMarkShape? sliderTickMarkShape;
  final Color? thumbColor;
  final double? elevation;

  factory PlayerScreenSliderStyle.light(ColorScheme colorScheme) =>
      PlayerScreenSliderStyle(
        trackHeight: 8.0,
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.shadow,
        sliderTickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: colorScheme.primary,
        thumbRadius: 12.0,
        elevation: 0.0,
        overlayColor: colorScheme.primary.withAlpha(50),
        overlayRadius: 24.0,
      );

  factory PlayerScreenSliderStyle.dark(ColorScheme colorScheme) =>
      PlayerScreenSliderStyle(
        trackHeight: 8.0,
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.surfaceBright,
        sliderTickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: colorScheme.primary,
        thumbRadius: 12.0,
        elevation: 0.0,
        overlayColor: colorScheme.primary.withAlpha(50),
        overlayRadius: 24.0,
      );

  @override
  PlayerScreenSliderStyle copyWith({
    double? trackHeight,
    double? thumbRadius,
    double? glowRadius,
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? overlayColor,
    double? overlayRadius,
    SliderTickMarkShape? sliderTickMarkShape,
    Color? thumbColor,
    double? elevation,
  }) {
    return PlayerScreenSliderStyle(
      trackHeight: trackHeight ?? this.trackHeight,
      thumbRadius: thumbRadius ?? this.thumbRadius,
      glowRadius: glowRadius ?? this.glowRadius,
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      overlayColor: overlayColor ?? this.overlayColor,
      overlayRadius: overlayRadius ?? this.overlayRadius,
      sliderTickMarkShape: sliderTickMarkShape ?? this.sliderTickMarkShape,
      thumbColor: thumbColor ?? this.thumbColor,
      elevation: elevation ?? this.elevation,
    );
  }

  @override
  ThemeExtension<PlayerScreenSliderStyle> lerp(
    ThemeExtension<PlayerScreenSliderStyle>? other,
    double t,
  ) {
    if (other is! PlayerScreenSliderStyle) {
      return this;
    }

    return PlayerScreenSliderStyle(
      trackHeight: lerpDouble(trackHeight, other.trackHeight, t),
      thumbRadius: lerpDouble(thumbRadius, other.thumbRadius, t),
      glowRadius: lerpDouble(glowRadius, other.glowRadius, t),
      activeTrackColor: Color.lerp(activeTrackColor, other.activeTrackColor, t),
      inactiveTrackColor: Color.lerp(
        inactiveTrackColor,
        other.inactiveTrackColor,
        t,
      ),
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t),
      overlayRadius: lerpDouble(overlayRadius, other.overlayRadius, t),
      sliderTickMarkShape: t < 0.5
          ? sliderTickMarkShape
          : other.sliderTickMarkShape, // Doesn't support lerp.
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t),
      elevation: lerpDouble(elevation, other.elevation, t),
    );
  }
}

@immutable
class TranscriptProgressSliderStyle
    extends ThemeExtension<TranscriptProgressSliderStyle> {
  const TranscriptProgressSliderStyle({
    this.trackHeight,
    this.thumbRadius,
    this.glowRadius,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.overlayColor,
    this.overlayRadius,
    this.sliderTickMarkShape,
    this.thumbColor,
    this.elevation,
  });

  final double? trackHeight;
  final double? thumbRadius;
  final double? glowRadius;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? overlayColor;
  final double? overlayRadius;
  final SliderTickMarkShape? sliderTickMarkShape;
  final Color? thumbColor;
  final double? elevation;

  factory TranscriptProgressSliderStyle.light(ColorScheme colorScheme) =>
      TranscriptProgressSliderStyle(
        trackHeight: 4.0,
        activeTrackColor: colorScheme.secondary,
        inactiveTrackColor: colorScheme.secondaryContainer,
        sliderTickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: colorScheme.secondary,
        thumbRadius: 8.0,
        elevation: 0.0,
        overlayColor: colorScheme.secondaryContainer.withAlpha(50),
        overlayRadius: 12.0,
      );

  factory TranscriptProgressSliderStyle.dark(ColorScheme colorScheme) =>
      TranscriptProgressSliderStyle(
        trackHeight: 4.0,
        activeTrackColor: colorScheme.secondary,
        inactiveTrackColor: colorScheme.secondaryContainer,
        sliderTickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: colorScheme.secondary,
        thumbRadius: 8.0,
        elevation: 0.0,
        overlayColor: colorScheme.secondaryContainer.withAlpha(50),
        overlayRadius: 12.0,
      );

  @override
  TranscriptProgressSliderStyle copyWith({
    double? trackHeight,
    double? thumbRadius,
    double? glowRadius,
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? overlayColor,
    double? overlayRadius,
    SliderTickMarkShape? sliderTickMarkShape,
    Color? thumbColor,
    double? elevation,
  }) {
    return TranscriptProgressSliderStyle(
      trackHeight: trackHeight ?? this.trackHeight,
      thumbRadius: thumbRadius ?? this.thumbRadius,
      glowRadius: glowRadius ?? this.glowRadius,
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      overlayColor: overlayColor ?? this.overlayColor,
      overlayRadius: overlayRadius ?? this.overlayRadius,
      sliderTickMarkShape: sliderTickMarkShape ?? this.sliderTickMarkShape,
      thumbColor: thumbColor ?? this.thumbColor,
      elevation: elevation ?? this.elevation,
    );
  }

  @override
  ThemeExtension<TranscriptProgressSliderStyle> lerp(
    ThemeExtension<TranscriptProgressSliderStyle>? other,
    double t,
  ) {
    if (other is! TranscriptProgressSliderStyle) {
      return this;
    }

    return TranscriptProgressSliderStyle(
      trackHeight: lerpDouble(trackHeight, other.trackHeight, t),
      thumbRadius: lerpDouble(thumbRadius, other.thumbRadius, t),
      glowRadius: lerpDouble(glowRadius, other.glowRadius, t),
      activeTrackColor: Color.lerp(activeTrackColor, other.activeTrackColor, t),
      inactiveTrackColor: Color.lerp(
        inactiveTrackColor,
        other.inactiveTrackColor,
        t,
      ),
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t),
      overlayRadius: lerpDouble(overlayRadius, other.overlayRadius, t),
      sliderTickMarkShape: t < 0.5
          ? sliderTickMarkShape
          : other.sliderTickMarkShape, // Doesn't support lerp.
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t),
      elevation: lerpDouble(elevation, other.elevation, t),
    );
  }
}

@immutable
class TranscriptScreenStyle extends ThemeExtension<TranscriptScreenStyle> {
  const TranscriptScreenStyle({
    this.backgroundColor,
    this.bottomPaddingFactor,
    this.appBarElevation,
    this.appBarScrolledUnderElevation,
  });

  final Color? backgroundColor;
  final double? bottomPaddingFactor;
  final double? appBarElevation;
  final double? appBarScrolledUnderElevation;

  static const defaultBottomPaddingFactor = 0.3;

  factory TranscriptScreenStyle.light(ColorScheme colorScheme) =>
      TranscriptScreenStyle(
        backgroundColor: colorScheme.secondaryContainer,
        appBarElevation: 0.0,
        appBarScrolledUnderElevation: 0.0,
      );

  factory TranscriptScreenStyle.dark(ColorScheme colorScheme) =>
      TranscriptScreenStyle(
        backgroundColor: colorScheme.secondaryContainer,
        appBarElevation: 0.0,
        appBarScrolledUnderElevation: 0.0,
      );

  @override
  TranscriptScreenStyle copyWith({
    Color? backgroundColor,
    double? bottomPaddingFactor,
    double? appBarElevation,
    double? appBarScrolledUnderElevation,
  }) {
    return TranscriptScreenStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bottomPaddingFactor: bottomPaddingFactor ?? this.bottomPaddingFactor,
      appBarElevation: appBarElevation ?? this.appBarElevation,
      appBarScrolledUnderElevation:
          appBarScrolledUnderElevation ?? this.appBarScrolledUnderElevation,
    );
  }

  @override
  ThemeExtension<TranscriptScreenStyle> lerp(
    ThemeExtension<TranscriptScreenStyle>? other,
    double t,
  ) {
    if (other is! TranscriptScreenStyle) {
      return this;
    }

    return TranscriptScreenStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      bottomPaddingFactor: lerpDouble(
        bottomPaddingFactor,
        other.bottomPaddingFactor,
        t,
      ),
      appBarElevation: lerpDouble(appBarElevation, other.appBarElevation, t),
      appBarScrolledUnderElevation: lerpDouble(
        appBarScrolledUnderElevation,
        other.appBarScrolledUnderElevation,
        t,
      ),
    );
  }
}

@immutable
class TranscriptLineWidgetStyle
    extends ThemeExtension<TranscriptLineWidgetStyle> {
  const TranscriptLineWidgetStyle({
    this.activeColor,
    this.inactiveColor,
    this.speakerNameTextStyle,
    this.speakerNameTranslationTextStyle,
    this.transcriptTextStyle,
    this.translationTextStyle,
    this.splashColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.animationDuration,
    this.padding,
    this.horizontalSpacing,
    this.verticalSpacing,
  });

  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? speakerNameTextStyle;
  final TextStyle? speakerNameTranslationTextStyle;
  final TextStyle? transcriptTextStyle;
  final TextStyle? translationTextStyle;
  final Color? splashColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final Duration? animationDuration;
  final double? padding;
  final double? horizontalSpacing;
  final double? verticalSpacing;

  factory TranscriptLineWidgetStyle.light(ColorScheme colorScheme) =>
      TranscriptLineWidgetStyle(
        inactiveColor: colorScheme.secondaryContainer,
        activeColor: colorScheme.secondaryContainer.darken(5),
        borderRadius: 16.0,
        borderColor: colorScheme.secondaryContainer.darken(50),
        borderWidth: 2.0,
        splashColor: colorScheme.secondary.withAlpha(128),
        speakerNameTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        speakerNameTranslationTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer.blend(
            colorScheme.secondaryContainer,
            50,
          ),
          fontWeight: FontWeight.bold,
        ),
        transcriptTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        translationTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer.blend(
            colorScheme.secondaryContainer,
            50,
          ),
          fontWeight: FontWeight.bold,
        ),
      );

  factory TranscriptLineWidgetStyle.dark(ColorScheme colorScheme) =>
      TranscriptLineWidgetStyle(
        inactiveColor: colorScheme.secondaryContainer,
        activeColor: colorScheme.secondaryContainer.darken(4),
        borderRadius: 16.0,
        borderColor: colorScheme.secondaryContainer.darken(8),
        borderWidth: 2.0,
        splashColor: colorScheme.secondary.withAlpha(128),
        speakerNameTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        speakerNameTranslationTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer.blend(
            colorScheme.secondaryContainer,
            50,
          ),
          fontWeight: FontWeight.bold,
        ),
        transcriptTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
        translationTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer.blend(
            colorScheme.secondaryContainer,
            50,
          ),
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  TranscriptLineWidgetStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    TextStyle? speakerNameTextStyle,
    TextStyle? speakerNameTranslationTextStyle,
    TextStyle? transcriptTextStyle,
    TextStyle? translationTextStyle,
    Color? splashColor,
    Color? borderColor,
    double? borderRadius,
    double? borderWidth,
    Duration? animationDuration,
    double? padding,
    double? horizontalSpacing,
    double? verticalSpacing,
  }) {
    return TranscriptLineWidgetStyle(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      speakerNameTextStyle: speakerNameTextStyle ?? this.speakerNameTextStyle,
      speakerNameTranslationTextStyle:
          speakerNameTranslationTextStyle ??
          this.speakerNameTranslationTextStyle,
      transcriptTextStyle: transcriptTextStyle ?? this.transcriptTextStyle,
      translationTextStyle: translationTextStyle ?? this.translationTextStyle,
      splashColor: splashColor ?? this.splashColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      animationDuration: animationDuration ?? this.animationDuration,
      padding: padding ?? this.padding,
      horizontalSpacing: horizontalSpacing ?? this.horizontalSpacing,
      verticalSpacing: verticalSpacing ?? this.verticalSpacing,
    );
  }

  @override
  ThemeExtension<TranscriptLineWidgetStyle> lerp(
    ThemeExtension<TranscriptLineWidgetStyle>? other,
    double t,
  ) {
    if (other is! TranscriptLineWidgetStyle) {
      return this;
    }

    return TranscriptLineWidgetStyle(
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t),
      speakerNameTextStyle: TextStyle.lerp(
        speakerNameTextStyle,
        other.speakerNameTextStyle,
        t,
      ),
      speakerNameTranslationTextStyle: TextStyle.lerp(
        speakerNameTranslationTextStyle,
        other.speakerNameTranslationTextStyle,
        t,
      ),
      transcriptTextStyle: TextStyle.lerp(
        transcriptTextStyle,
        other.transcriptTextStyle,
        t,
      ),
      translationTextStyle: TextStyle.lerp(
        translationTextStyle,
        other.translationTextStyle,
        t,
      ),
      splashColor: Color.lerp(splashColor, other.splashColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      padding: lerpDouble(padding, other.padding, t),
      horizontalSpacing: lerpDouble(
        horizontalSpacing,
        other.horizontalSpacing,
        t,
      ),
      verticalSpacing: lerpDouble(verticalSpacing, other.verticalSpacing, t),
    );
  }
}

@immutable
class TranscriptScreenButtonStyle
    extends ThemeExtension<TranscriptScreenButtonStyle> {
  const TranscriptScreenButtonStyle({
    this.buttonStyle,
  });

  final ButtonStyle? buttonStyle;

  factory TranscriptScreenButtonStyle.light(ColorScheme colorScheme) =>
      TranscriptScreenButtonStyle(
        buttonStyle: IconButton.styleFrom(
          foregroundColor: colorScheme.onSecondaryContainer,
          backgroundColor: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  factory TranscriptScreenButtonStyle.dark(ColorScheme colorScheme) =>
      TranscriptScreenButtonStyle(
        buttonStyle: IconButton.styleFrom(
          foregroundColor: colorScheme.onSecondaryContainer,
          backgroundColor: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  @override
  TranscriptScreenButtonStyle copyWith({
    ButtonStyle? buttonStyle,
  }) {
    return TranscriptScreenButtonStyle(
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }

  @override
  ThemeExtension<TranscriptScreenButtonStyle> lerp(
    ThemeExtension<TranscriptScreenButtonStyle>? other,
    double t,
  ) {
    if (other is! TranscriptScreenButtonStyle) {
      return this;
    }

    return TranscriptScreenButtonStyle(
      buttonStyle: ButtonStyle.lerp(buttonStyle, other.buttonStyle, t),
    );
  }
}

@immutable
class TranscriptScreenToggleStyle
    extends ThemeExtension<TranscriptScreenToggleStyle> {
  const TranscriptScreenToggleStyle({
    this.active,
    this.inactive,
    this.disabled,
  });

  final ButtonStyle? active;
  final ButtonStyle? inactive;
  final ButtonStyle? disabled;

  factory TranscriptScreenToggleStyle.light(ColorScheme colorScheme) =>
      TranscriptScreenToggleStyle(
        active: IconButton.styleFrom(
          foregroundColor: colorScheme.onSecondary,
          backgroundColor: colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inactive: IconButton.styleFrom(
          foregroundColor: colorScheme.onSecondaryContainer,
          backgroundColor: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            width: 2.0,
            color: colorScheme.secondary,
          ),
        ),
        disabled: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  factory TranscriptScreenToggleStyle.dark(ColorScheme colorScheme) =>
      TranscriptScreenToggleStyle(
        active: IconButton.styleFrom(
          foregroundColor: colorScheme.onSecondary,
          backgroundColor: colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inactive: IconButton.styleFrom(
          foregroundColor: colorScheme.onSecondaryContainer,
          backgroundColor: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            width: 2.0,
            color: colorScheme.secondary,
          ),
        ),
        disabled: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  @override
  TranscriptScreenToggleStyle copyWith({
    ButtonStyle? active,
    ButtonStyle? inactive,
    ButtonStyle? disabled,
  }) {
    return TranscriptScreenToggleStyle(
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  ThemeExtension<TranscriptScreenToggleStyle> lerp(
    ThemeExtension<TranscriptScreenToggleStyle>? other,
    double t,
  ) {
    if (other is! TranscriptScreenToggleStyle) {
      return this;
    }

    return TranscriptScreenToggleStyle(
      active: ButtonStyle.lerp(active, other.active, t),
      inactive: ButtonStyle.lerp(inactive, other.inactive, t),
      disabled: ButtonStyle.lerp(disabled, other.disabled, t),
    );
  }
}
