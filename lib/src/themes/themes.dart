import 'package:flex_color_scheme/flex_color_scheme.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.mandyRed,
  applyElevationOverlayColor: false,
  fontFamily: 'Atkinson Hyperlegible Next',
  subThemesData: FlexSubThemesData(
    interactionEffects: true,
    splashType: FlexSplashType.inkSparkle,
  ),
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.mandyRed,
  applyElevationOverlayColor: false,
  fontFamily: 'Atkinson Hyperlegible Next',
  variant: FlexSchemeVariant.fidelity,
  subThemesData: FlexSubThemesData(
    interactionEffects: true,
    splashType: FlexSplashType.inkSparkle,
  ),
);
