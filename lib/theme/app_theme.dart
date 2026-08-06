import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Mode Colors
  static const Color bgLight = Color(0xFFF7F5F0);
  static const Color bg2Light = Color(0xFFEFECE6);
  static const Color bg3Light = Color(0xFFE5E1D8);
  static const Color inkLight = Color(0xFF141311);
  static const Color ink2Light = Color(0xFF3D3A34);
  static const Color ink3Light = Color(0xFF757065);
  static const Color paperLight = Color(0xFFFFFFFF);
  static const Color cardBgLight = Color(0xFFFFFFFF);

  // Dark Mode Colors
  static const Color bgDark = Color(0xFF0F0E0C);
  static const Color bg2Dark = Color(0xFF161512);
  static const Color bg3Dark = Color(0xFF1E1C18);
  static const Color inkDark = Color(0xFFF7F5F0);
  static const Color ink2Dark = Color(0xFFD0CBC2);
  static const Color ink3Dark = Color(0xFF8C867B);
  static const Color paperDark = Color(0xFF161512);
  static const Color cardBgDark = Color(0xFF161512);

  // Accent Colors
  static const Color orange = Color(0xFFE8470A);
  static const Color orangeDark = Color(0xFFFF5A1A);
  static const Color cyanAccent = Color(0xFF00B4D8);
  static const Color greenAccent = Color(0xFF10B981);

  // Layout & Component Tokens
  static const double maxContentWidth = 1200.0;
  static const double cardRadius = 8.0;

  static Color orangeDim(bool isDark) =>
      (isDark ? orangeDark : orange).withValues(alpha: 0.12);
  static Color orangeMid(bool isDark) =>
      (isDark ? orangeDark : orange).withValues(alpha: 0.25);

  static Color bg(bool isDark) => isDark ? bgDark : bgLight;
  static Color bg2(bool isDark) => isDark ? bg2Dark : bg2Light;
  static Color bg3(bool isDark) => isDark ? bg3Dark : bg3Light;
  static Color ink(bool isDark) => isDark ? inkDark : inkLight;
  static Color ink2(bool isDark) => isDark ? ink2Dark : ink2Light;
  static Color ink3(bool isDark) => isDark ? ink3Dark : ink3Light;
  static Color paper(bool isDark) => isDark ? paperDark : paperLight;
  static Color cardBg(bool isDark) => isDark ? cardBgDark : cardBgLight;
  static Color acc(bool isDark) => isDark ? orangeDark : orange;

  static Color line(bool isDark) =>
      isDark ? Colors.white.withValues(alpha: 0.10) : const Color(0xFF141311).withValues(alpha: 0.12);
  static Color lineStrong(bool isDark) =>
      isDark ? Colors.white.withValues(alpha: 0.20) : const Color(0xFF141311).withValues(alpha: 0.25);

  // Text styles
  static TextStyle display(bool isDark, {double size = 64}) => GoogleFonts.bebasNeue(
        fontSize: size,
        letterSpacing: size * 0.02,
        color: ink(isDark),
        height: 0.95,
      );

  static TextStyle mono(bool isDark, {double size = 12}) => GoogleFonts.ibmPlexMono(
        fontSize: size,
        color: ink3(isDark),
      );

  static TextStyle body(bool isDark, {double size = 16, FontWeight weight = FontWeight.w400}) =>
      GoogleFonts.epilogue(
        fontSize: size,
        color: ink(isDark),
        fontWeight: weight,
        height: 1.6,
      );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: bgLight,
    colorScheme: const ColorScheme.light(primary: orange),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgDark,
    colorScheme: const ColorScheme.dark(primary: orangeDark),
    useMaterial3: true,
  );
}
