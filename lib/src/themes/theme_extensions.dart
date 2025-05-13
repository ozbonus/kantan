import 'package:flutter/material.dart';

@immutable
class PlayerScreenContainerStyle
    extends ThemeExtension<PlayerScreenContainerStyle> {
  const PlayerScreenContainerStyle({
    this.decoration,
  });

  final BoxDecoration? decoration;

  @override
  PlayerScreenContainerStyle copyWith({
    BoxDecoration? decoration,
  }) {
    return PlayerScreenContainerStyle(
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  ThemeExtension<PlayerScreenContainerStyle> lerp(
      ThemeExtension<PlayerScreenContainerStyle>? other, double t) {
    if (other is! PlayerScreenContainerStyle) {
      return this;
    }
    return PlayerScreenContainerStyle(
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
    );
  }
}
