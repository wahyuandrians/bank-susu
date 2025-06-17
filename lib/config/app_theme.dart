import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFFE0F2F7),
    primaryColorLight: const Color(0xFFF1FAFC),
    primaryColorDark: const Color(0xFF90CAF9),
    canvasColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF81D4FA),
      secondary: const Color(0xFF4FC3F7),
      surface: Colors.white,
      background: const Color(0xFFF8F8F8),
      error: Colors.red[600]!,
      onPrimary: Colors.blueGrey[800]!,
      onSecondary: Colors.white,
      onSurface: Colors.blueGrey[800]!,
      onBackground: Colors.blueGrey[800]!,
      onError: Colors.white,
      brightness: Brightness.light,
    ),

    fontFamily: 'Roboto',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[900],
      ),
      displayMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[900],
      ),
      headlineLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: Colors.blueGrey[800],
      ),
      headlineMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey[800],
      ),
      titleLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey[700],
      ),
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.blueGrey[700]),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.blueGrey[600]),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFE0F2F7),
      foregroundColor: Colors.blueGrey[800],
      elevation: 2.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.blueGrey[800],
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardTheme(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF81D4FA),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        elevation: 4.0,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blueGrey[700],
        side: BorderSide(color: Colors.blueGrey[300]!, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF4FC3F7),
      foregroundColor: Colors.white,
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.blueGrey[200]!, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: const Color(0xFF81D4FA),
          width: 2.0,
        ), // Menggunakan warna primary secara eksplisit
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red[600]!, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red[600]!, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      labelStyle: TextStyle(color: Colors.blueGrey[500]),
      hintStyle: TextStyle(color: Colors.blueGrey[300]),
      prefixIconColor: Colors.blueGrey[400],
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFFE0F2F7),
      selectedItemColor: const Color(0xFF2196F3),
      unselectedItemColor: Colors.blueGrey[500],
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
