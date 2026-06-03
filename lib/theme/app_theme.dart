import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Mode Colors
  static const Color bgLight = Color(0xFFF5F2EC);
  static const Color bg2Light = Color(0xFFEDEAE3);
  static const Color bg3Light = Color(0xFFE3DFD7);
  static const Color inkLight = Color(0xFF1A1814);
  static const Color ink2Light = Color(0xFF4A4640);
  static const Color ink3Light = Color(0xFF807A72);
  static const Color paperLight = Color(0xFFFDFAF5);
  static const Color cardBgLight = Color(0xFFFDFAF5);

  // Dark Mode Colors
  static const Color bgDark = Color(0xFF141210);
  static const Color bg2Dark = Color(0xFF1C1A17);
  static const Color bg3Dark = Color(0xFF242119);
  static const Color inkDark = Color(0xFFF5F2EC);
  static const Color ink2Dark = Color(0xFFC8C4BC);
  static const Color ink3Dark = Color(0xFF7A766E);
  static const Color paperDark = Color(0xFF1C1A17);
  static const Color cardBgDark = Color(0xFF1C1A17);

  // Common
  static const Color orange = Color(0xFFE8470A);
  static const Color orangeDark = Color(0xFFFF5A1A);
  static Color orangeDim(bool isDark) =>
      (isDark ? orangeDark : orange).withOpacity(0.1);
  static Color orangeMid(bool isDark) =>
      (isDark ? orangeDark : orange).withOpacity(0.2);

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
      isDark ? Colors.white.withOpacity(0.10) : const Color(0xFF1A1814).withOpacity(0.12);
  static Color lineStrong(bool isDark) =>
      isDark ? Colors.white.withOpacity(0.20) : const Color(0xFF1A1814).withOpacity(0.25);

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
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgDark,
    colorScheme: const ColorScheme.dark(primary: orangeDark),
  );
}
