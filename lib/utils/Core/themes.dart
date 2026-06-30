import 'package:flutter/material.dart';
import 'package:versea/utils/Core/app_colors.dart';

class AppThemes {
  ThemeData darkTheme = _darkThemeMode1;
  ThemeData lightTheme = _lightThemeMode1;
}

ThemeData _darkThemeMode1 = ThemeData.dark().copyWith(
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: DarkAppColors2.neutralColor),
  ),
  colorScheme: ColorScheme.dark(),
);

ThemeData _lightThemeMode1 = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: LightAppColors.neutralColor),
  ),
  colorScheme: ColorScheme.light(),
);
