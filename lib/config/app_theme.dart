import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: color141218,
      colorScheme: const ColorScheme.light(),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      fontFamily: GoogleFonts.rubik().fontFamily,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 15)),
            textStyle: const MaterialStatePropertyAll(TextStyle(
              color: colorFFFBF2,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )),
            backgroundColor: const MaterialStatePropertyAll(color10A37F)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        hintStyle: const TextStyle(color: color92979E),
        fillColor: colorC0C0C0.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: color141218.withOpacity(0.05), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color141218.withOpacity(0.05), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color141218.withOpacity(0.05), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color141218.withOpacity(0.05), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ));

  static ThemeData darkTheme = ThemeData(
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.dark(),
      scaffoldBackgroundColor: color141218,
      useMaterial3: true,
      fontFamily: GoogleFonts.rubik().fontFamily,
      appBarTheme: const AppBarTheme(backgroundColor: color141218),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 15)),
            textStyle: const MaterialStatePropertyAll(TextStyle(
              color: colorFFFBF2,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )),
            backgroundColor: const MaterialStatePropertyAll(color4F378B)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        hintStyle: const TextStyle(color: color92979E),
        fillColor: color343541.withOpacity(0.5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: color141218.withOpacity(0.05), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color141218.withOpacity(0.05), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color141218.withOpacity(0.05), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color141218.withOpacity(0.05), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ));
}
