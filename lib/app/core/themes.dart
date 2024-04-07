import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData atlassianThemeDataLight() {
  // Adjusted color palette for better contrast
  const Color primaryColor = Color(0xFF0052CC); // Atlassian Blue, remains high contrast
  const Color secondaryColor = Color(0xFF4C9AFF); // Lighter blue, acceptable for large text
  const Color errorColor = Color(0xFFE53935); // Adjusted for better visibility
  const Color backgroundColor = Color(0xFFFFFFFF); // White background for higher contrast
  const Color textColor = Color(0xFF172B4D); // Dark text for better readability
  const Color surfaceColor = Color(0xFFF4F5F7); // Light grey, adjusted for contrast

  // Typography with increased default size for better readability
  TextTheme textTheme = GoogleFonts.latoTextTheme().copyWith(
    bodyText1: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.normal),
    bodyText2: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.normal),
    headline6: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
  );

  // ElevatedButton Theme with higher contrast text
  final ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      textStyle: TextStyle(fontSize: 18),
    ),
  );

  // OutlinedButton Theme with adjusted border color for better visibility
  final OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: textColor,
      side: BorderSide(color: primaryColor, width: 2),
      textStyle: TextStyle(fontSize: 18),
    ),
  );

  // TextButton Theme for better visibility
  final TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
      textStyle: TextStyle(fontSize: 18),
    ),
  );

  // AppBar Theme adjusted for better contrast
  final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: textColor,
    titleTextStyle: textTheme.headline6?.copyWith(color: textColor),
  );

  // Input (TextField) Theme with adjusted borders for better visibility
  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    labelStyle: TextStyle(color: textColor),
    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
    fillColor: surfaceColor,
    filled: true,
  );

  // Card Theme with slight elevation change for better discernibility
  final CardTheme cardTheme = CardTheme(
    color: surfaceColor,
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  );

  // Adjusting other themes for consistency and accessibility
  final SnackBarThemeData snackBarTheme = SnackBarThemeData(
    backgroundColor: primaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  );

  final DialogTheme dialogTheme = DialogTheme(
    backgroundColor: surfaceColor,
    titleTextStyle: textTheme.headline6,
    contentTextStyle: textTheme.bodyText1,
  );

  final MaterialBannerThemeData bannerTheme = MaterialBannerThemeData(
    backgroundColor: secondaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  );

  // Return the ThemeData with adjustments
  return ThemeData(
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: appBarTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonThemeData,
    textButtonTheme: textButtonThemeData,
    cardTheme: cardTheme,
    inputDecorationTheme: inputDecorationTheme,
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: textColor,
      surface: surfaceColor,
      onSurface: textColor,
    ),
    snackBarTheme: snackBarTheme,
    dialogTheme: dialogTheme,
    bannerTheme: bannerTheme,
  );
}

ThemeData atlassianThemeDataDark() {
  // Similar adjustments for the dark theme for consistency and accessibility
  const Color primaryColor = Color(0xFF4C9AFF);
  const Color secondaryColor = Color(0xFF0052CC);
  const Color errorColor = Color(0xFFE53935);
  const Color backgroundColor = Color(0xFF121212); // Even darker for better contrast in dark mode
  const Color textColor = Color(0xFFFFFFFF);
  const Color surfaceColor = Color(0xFF253858);

  TextTheme textTheme = GoogleFonts.latoTextTheme().apply(
    bodyColor: textColor,
    displayColor: textColor,
  ).copyWith(
    bodyText1: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.normal),
    bodyText2: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.normal),
    headline6: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
  );

  final ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      textStyle: TextStyle(fontSize: 18),
    ),
  );

  final OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: textColor,
      side: BorderSide(color: primaryColor, width: 2),
      textStyle: TextStyle(fontSize: 18),
    ),
  );

  final TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
      textStyle: TextStyle(fontSize: 18),
    ),
  );

  final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: textColor,
    titleTextStyle: textTheme.headline6?.copyWith(color: textColor),
  );

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    labelStyle: TextStyle(color: textColor),
    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
    fillColor: backgroundColor,
    filled: true,
  );

  final CardTheme cardTheme = CardTheme(
    color: surfaceColor,
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  );

  final SnackBarThemeData snackBarTheme = SnackBarThemeData(
    backgroundColor: primaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  );

  final DialogTheme dialogTheme = DialogTheme(
    backgroundColor: surfaceColor,
    titleTextStyle: textTheme.headline6,
    contentTextStyle: textTheme.bodyText1,
  );

  final MaterialBannerThemeData bannerTheme = MaterialBannerThemeData(
    backgroundColor: secondaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  );

  return ThemeData(
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: appBarTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonThemeData,
    textButtonTheme: textButtonThemeData,
    cardTheme: cardTheme,
    inputDecorationTheme: inputDecorationTheme,
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ).copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: textColor,
      surface: surfaceColor,
      onSurface: textColor,
    ),
    snackBarTheme: snackBarTheme,
    dialogTheme: dialogTheme,
    bannerTheme: bannerTheme,
  );
}
