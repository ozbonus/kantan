import 'package:flutter/material.dart';

@immutable
class PlayerScreenContainerStyle
    extends ThemeExtension<PlayerScreenContainerStyle> {
  const PlayerScreenContainerStyle({
    this.decoration,
    this.foregroundDecoration,
  });

  final BoxDecoration? decoration;
  final BoxDecoration? foregroundDecoration;

  @override
  PlayerScreenContainerStyle copyWith({
    BoxDecoration? decoration,
    BoxDecoration? foregroundDecoration,
  }) {
    return PlayerScreenContainerStyle(
        decoration: decoration ?? this.decoration,
        foregroundDecoration:
            foregroundDecoration ?? this.foregroundDecoration);
  }

  @override
  ThemeExtension<PlayerScreenContainerStyle> lerp(
      ThemeExtension<PlayerScreenContainerStyle>? other, double t) {
    if (other is! PlayerScreenContainerStyle) {
      return this;
    }
    return PlayerScreenContainerStyle(
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
      foregroundDecoration: BoxDecoration.lerp(
          foregroundDecoration, other.foregroundDecoration, t),
    );
  }
}
