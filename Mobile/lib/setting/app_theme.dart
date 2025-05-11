import 'package:flutter/material.dart';

ThemeData createHighContrastLightTheme(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final double sw = size.width;
  final double sh = size.height;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: sw * 0.05, // 상대 폰트 크기
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: sw * 0.042, color: Colors.black, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: sw * 0.037, color: Colors.black87),
      titleLarge: TextStyle(fontSize: sw * 0.048, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(sw * 0.03)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: sw * 0.005),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: sw * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sw * 0.03),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Colors.black),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sw * 0.03),
      ),
    ),
  );
}

ThemeData createHighContrastDarkTheme(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final double sw = size.width;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      onPrimary: Colors.black,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: sw * 0.05,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: sw * 0.042, color: Colors.white, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: sw * 0.037, color: Colors.white70),
      titleLarge: TextStyle(fontSize: sw * 0.048, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(sw * 0.03)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: sw * 0.005),
      ),
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: sw * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sw * 0.03),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Colors.white),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1A1A1A),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sw * 0.03),
      ),
    ),
  );
}
