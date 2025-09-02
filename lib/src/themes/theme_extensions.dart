import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This theme extension is also used to set the scaffold color on the track
/// list screen.
@immutable
class TrackListPaneStyle extends ThemeExtension<TrackListPaneStyle> {
  const TrackListPaneStyle({
    this.decoration,
  });

  final BoxDecoration? decoration;

  @override
  TrackListPaneStyle copyWith({
    BoxDecoration? containerDecoration,
  }) {
    return TrackListPaneStyle(
      decoration: containerDecoration ?? this.decoration,
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

  @override
  PlayerScreenControlsStyle copyWith({
    BoxDecoration? containerDecoration,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    Color? foregroundColor,
  }) {
    return PlayerScreenControlsStyle(
      decoration: containerDecoration ?? this.decoration,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      iconColor: foregroundColor ?? this.iconColor,
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
