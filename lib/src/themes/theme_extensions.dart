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
