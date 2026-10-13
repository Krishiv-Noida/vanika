import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class VanikaTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: VanikaColors.bgDark,
      primaryColor: VanikaColors.brand500,
      colorScheme: const ColorScheme.dark(
        primary: VanikaColors.brand500,
        secondary: VanikaColors.brand300,
        surface: VanikaColors.bgDarkElevated,
        surfaceContainerHighest: VanikaColors.cardDark,
        onPrimary: Colors.white,
        onSurface: VanikaColors.textLight,
        error: VanikaColors.danger,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: VanikaColors.textLight,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: VanikaColors.textLight,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: VanikaColors.textLight,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: VanikaColors.textLight,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: VanikaColors.textLight,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: VanikaColors.textLight,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: VanikaColors.textMuted,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: VanikaColors.textLight,
        ),
        iconTheme: const IconThemeData(color: VanikaColors.textLight),
      ),
      cardTheme: CardThemeData(
        color: VanikaColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: VanikaColors.cardBorder, width: 1),
        ),
      ),
    );
  }
}
