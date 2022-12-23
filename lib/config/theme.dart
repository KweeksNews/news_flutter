import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

mixin THEME {
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xffdd9933),
      primaryContainer: Color(0xffdeb059),
      secondary: Color(0xff8d9440),
      secondaryContainer: Color(0xffbfc39b),
      tertiary: Color(0xff616247),
      tertiaryContainer: Color(0xffbcbca8),
      appBarColor: Color(0xffbfc39b),
      error: Color(0xffb00020),
    ),
    usedColors: 2,
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    blendLevel: 30,
    appBarStyle: FlexAppBarStyle.background,
    tooltipsMatchBackground: true,
    lightIsWhite: true,
    useMaterial3: true,
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Quicksand',
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      blendTextTheme: false,
      inputDecoratorUnfocusedHasBorder: false,
      bottomNavigationBarShowSelectedLabels: false,
      bottomNavigationBarShowUnselectedLabels: false,
      navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
  );

  static ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xffdeb059),
      primaryContainer: Color(0xffc78d20),
      secondary: Color(0xffafb479),
      secondaryContainer: Color(0xff82883d),
      tertiary: Color(0xff81816c),
      tertiaryContainer: Color(0xff5a5a35),
      appBarColor: Color(0xff82883d),
      error: Color(0xffcf6679),
    ),
    usedColors: 2,
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.background,
    tooltipsMatchBackground: true,
    darkIsTrueBlack: true,
    useMaterial3: true,
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Quicksand',
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
      blendTextTheme: false,
      inputDecoratorUnfocusedHasBorder: false,
      bottomNavigationBarShowSelectedLabels: false,
      bottomNavigationBarShowUnselectedLabels: false,
      navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
  );
}
