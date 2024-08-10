import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          background: Colors.white,
          error: Colors.red,
          onTertiary: Colors.orange),
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData.dark(useMaterial3: true);
  }
}
