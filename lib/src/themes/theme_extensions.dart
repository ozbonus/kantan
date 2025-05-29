import 'dart:ui';
import 'package:flutter/material.dart';

@immutable
class PlayerScreenContainerStyle
    extends ThemeExtension<PlayerScreenContainerStyle> {
  const PlayerScreenContainerStyle({
    this.decoration,
    this.foregroundDecoration,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.iconColor,
  });

  final BoxDecoration? decoration;
  final BoxDecoration? foregroundDecoration;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final Color? iconColor;

  @override
  PlayerScreenContainerStyle copyWith({
    BoxDecoration? decoration,
    BoxDecoration? foregroundDecoration,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    Color? iconColor,
  }) {
    return PlayerScreenContainerStyle(
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ThemeExtension<PlayerScreenContainerStyle> lerp(
    ThemeExtension<PlayerScreenContainerStyle>? other,
    double t,
  ) {
    if (other is! PlayerScreenContainerStyle) {
      return this;
    }

    return PlayerScreenContainerStyle(
      decoration: BoxDecoration.lerp(
        decoration,
        other.decoration,
        t,
      ),
      foregroundDecoration: BoxDecoration.lerp(
        foregroundDecoration,
        other.foregroundDecoration,
        t,
      ),
      mainAxisSpacing: lerpDouble(
        mainAxisSpacing,
        other.mainAxisSpacing,
        t,
      ),
      crossAxisSpacing: lerpDouble(
        crossAxisSpacing,
        other.crossAxisSpacing,
        t,
      ),
      iconColor: Color.lerp(
        iconColor,
        other.iconColor,
        t,
      ),
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
      inactiveTrackColor:
          Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t),
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
      inactiveTrackColor:
          Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t),
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
    this.appBarElevation,
    this.appBarScrolledUnderElevation,
  });

  final Color? backgroundColor;
  final double? appBarElevation;
  final double? appBarScrolledUnderElevation;

  @override
  TranscriptScreenStyle copyWith({
    Color? backgroundColor,
    double? appBarElevation,
    double? appBarScrolledUnderElevation,
  }) {
    return TranscriptScreenStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
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
      appBarElevation: lerpDouble(appBarElevation, other.appBarElevation, t),
      appBarScrolledUnderElevation: lerpDouble(
          appBarScrolledUnderElevation, other.appBarScrolledUnderElevation, t),
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
  }) {
    return TranscriptLineWidgetStyle(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      speakerNameTextStyle: speakerNameTextStyle ?? this.speakerNameTextStyle,
      speakerNameTranslationTextStyle: speakerNameTranslationTextStyle ??
          this.speakerNameTranslationTextStyle,
      transcriptTextStyle: transcriptTextStyle ?? this.transcriptTextStyle,
      translationTextStyle: translationTextStyle ?? this.translationTextStyle,
      splashColor: splashColor ?? this.splashColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
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
      speakerNameTextStyle:
          TextStyle.lerp(speakerNameTextStyle, other.speakerNameTextStyle, t),
      speakerNameTranslationTextStyle: TextStyle.lerp(
          speakerNameTranslationTextStyle,
          other.speakerNameTranslationTextStyle,
          t),
      transcriptTextStyle:
          TextStyle.lerp(transcriptTextStyle, other.transcriptTextStyle, t),
      translationTextStyle:
          TextStyle.lerp(translationTextStyle, other.translationTextStyle, t),
      splashColor: Color.lerp(splashColor, other.splashColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
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
  });

  final ButtonStyle? active;
  final ButtonStyle? inactive;

  @override
  TranscriptScreenToggleStyle copyWith({
    ButtonStyle? active,
    ButtonStyle? inactive,
  }) {
    return TranscriptScreenToggleStyle(
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
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
    );
  }
}

@immutable
class TranscriptScreenSwitchStyle
    extends ThemeExtension<TranscriptScreenSwitchStyle> {
  const TranscriptScreenSwitchStyle({
    this.data,
  });

  final SwitchThemeData? data;

  @override
  TranscriptScreenSwitchStyle copyWith({
    SwitchThemeData? data,
  }) {
    return TranscriptScreenSwitchStyle(
      data: data ?? this.data,
    );
  }

  @override
  ThemeExtension<TranscriptScreenSwitchStyle> lerp(
    ThemeExtension<TranscriptScreenSwitchStyle>? other,
    double t,
  ) {
    if (other is! TranscriptScreenSwitchStyle) {
      return this;
    }

    return TranscriptScreenSwitchStyle(
      data: SwitchThemeData.lerp(data, other.data, t),
    );
  }
}// 