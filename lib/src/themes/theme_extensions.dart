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
// because extracting values for the the progress slider didn't work well.
@immutable
class SliderStyle extends ThemeExtension<SliderStyle> {
  const SliderStyle({
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
  SliderStyle copyWith({
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
    return SliderStyle(
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
  ThemeExtension<SliderStyle> lerp(
    ThemeExtension<SliderStyle>? other,
    double t,
  ) {
    if (other is! SliderStyle) {
      return this;
    }

    return SliderStyle(
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
