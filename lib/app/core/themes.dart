import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

ThemeData atlassianThemeDataLight() {
  const Color primaryColor = Color(0xFF0052CC);
  const Color secondaryColor = Color(0xFF4C9AFF);
  const Color errorColor = Color(0xFFE53935);
  const Color backgroundColor = Color(0xFFFFFFFF);
  const Color textColor = Color(0xFF172B4D);
  const Color surfaceColor = Color(0xFFF4F5F7);

  TextTheme textTheme = GoogleFonts.latoTextTheme().copyWith(
    titleLarge: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.normal),
  );

  ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: (Colors.white),
    backgroundColor: (primaryColor),
    textStyle: (const TextStyle(fontSize: 18)),
  );

  ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: (textColor),
    side: (const BorderSide(color: primaryColor, width: 2)),
    textStyle: (const TextStyle(fontSize: 18)),
  );

  ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: (primaryColor),
    textStyle: (const TextStyle(fontSize: 18)),
  );

  AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: textColor,
    titleTextStyle: textTheme.titleLarge?.copyWith(color: textColor),
  );

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    labelStyle: const TextStyle(color: textColor),
    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
    fillColor: surfaceColor,
    filled: true,
  );

  CardTheme cardTheme = CardTheme(
    color: surfaceColor,
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  );

  SnackBarThemeData snackBarTheme = const SnackBarThemeData(
    backgroundColor: primaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  );

  DialogTheme dialogTheme = DialogTheme(
    backgroundColor: surfaceColor,
    titleTextStyle: textTheme.titleLarge,
    contentTextStyle: textTheme.bodyLarge,
  );

  MaterialBannerThemeData bannerTheme = const MaterialBannerThemeData(
    backgroundColor: secondaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: textColor,
      surface: surfaceColor,
      onSurface: textColor,
    ),
    textTheme: textTheme,
    appBarTheme: appBarTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
    textButtonTheme: TextButtonThemeData(style: textButtonStyle),
    cardTheme: cardTheme,
    inputDecorationTheme: inputDecorationTheme,
    snackBarTheme: snackBarTheme,
    dialogTheme: dialogTheme,
    bannerTheme: bannerTheme,
  );
}

ThemeData atlassianThemeDataDark() {
  const Color primaryColor = Color(0xFF4C9AFF);
  const Color secondaryColor = Color(0xFF0052CC);
  const Color errorColor = Color(0xFFE53935);
  const Color backgroundColor = Color(0xFF121212);
  const Color textColor = Color(0xFFFFFFFF);
  const Color surfaceColor = Color(0xFF253858);

  TextTheme textTheme = GoogleFonts.latoTextTheme()
      .apply(
        bodyColor: textColor,
        displayColor: textColor,
      )
      .copyWith(
        titleLarge: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
        bodyLarge:
            GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.normal),
        bodyMedium:
            GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.normal),
      );

  ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: (Colors.white),
    backgroundColor: (primaryColor),
    textStyle: (const TextStyle(fontSize: 18)),
  );

  ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: (textColor),
    side: (const BorderSide(color: primaryColor, width: 2)),
    textStyle: (const TextStyle(fontSize: 18)),
  );

  ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: (primaryColor),
    textStyle: (const TextStyle(fontSize: 18)),
  );

  AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: textColor,
    titleTextStyle: textTheme.titleLarge?.copyWith(color: textColor),
  );

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    labelStyle: const TextStyle(color: textColor),
    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
    fillColor: backgroundColor,
    filled: true,
  );

  CardTheme cardTheme = CardTheme(
    color: surfaceColor,
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  );

  SnackBarThemeData snackBarTheme = const SnackBarThemeData(
    backgroundColor: primaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  );

  DialogTheme dialogTheme = DialogTheme(
    backgroundColor: surfaceColor,
    titleTextStyle: textTheme.titleLarge,
    contentTextStyle: textTheme.bodyLarge,
  );

  MaterialBannerThemeData bannerTheme = const MaterialBannerThemeData(
    backgroundColor: secondaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: textColor,
      surface: surfaceColor,
      onSurface: textColor,
    ),
    textTheme: textTheme,
    appBarTheme: appBarTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
    textButtonTheme: TextButtonThemeData(style: textButtonStyle),
    cardTheme: cardTheme,
    inputDecorationTheme: inputDecorationTheme,
    snackBarTheme: snackBarTheme,
    dialogTheme: dialogTheme,
    bannerTheme: bannerTheme,
  );
}
