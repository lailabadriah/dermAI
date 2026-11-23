import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color blush = Color(0xFFF7DDE5);
  static const Color pink = Color(0xFFF3B7C6);
  static const Color rose = Color(0xFFE59EB8);
  static const Color nude = Color(0xFFE8D8CC);
  static const Color softPeach = Color(0xFFFDE9E7);
  static const Color ink = Color(0xFF1B1A1F);
  static const Color muted = Color(0xFF6C6670);
  static const Color cream = Color(0xFFFCF8F6);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: pink,
        brightness: Brightness.light,
        primary: pink,
        secondary: rose,
        surface: Colors.white,
        background: cream,
      ),
      textTheme: GoogleFonts.manropeTextTheme().copyWith(
        headlineLarge: GoogleFonts.manrope(
          fontWeight: FontWeight.w700,
          color: ink,
        ),
        headlineMedium: GoogleFonts.manrope(
          fontWeight: FontWeight.w700,
          color: ink,
        ),
        titleLarge: GoogleFonts.manrope(
          fontWeight: FontWeight.w600,
          color: ink,
        ),
        bodyLarge: GoogleFonts.manrope(
          fontWeight: FontWeight.w500,
          color: ink,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontWeight: FontWeight.w400,
          color: muted,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cream,
        foregroundColor: ink,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: pink,
      ),
    );

    return base.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: blush),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: blush),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: pink, width: 1.5),
        ),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFF1E7EA), thickness: 1),
    );
  }
}
