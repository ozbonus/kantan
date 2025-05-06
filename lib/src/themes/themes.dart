import 'package:flutter/material.dart';
import 'package:kantan/config.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: Config.primary,
  brightness: Brightness.light,
  contrastLevel: -1.0,
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
