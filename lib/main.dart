import 'package:cash_ctrl/app/core/themes.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  runApp(
    GetMaterialApp(
      color: Colors.white,
      title: "Cash Ctrl",
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      // theme: ThemeData.light(useMaterial3: true).copyWith(
      //   textTheme: GoogleFonts.openSansTextTheme(),
      //   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0052CC)),
      //   inputDecorationTheme: InputDecorationTheme(
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //     // filled: true,
      //     isDense: true,
      //   ),
      // ),
      // darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
      //   textTheme: GoogleFonts.openSansTextTheme(
      //     ThemeData.dark().textTheme,
      //   ),
      //   colorScheme: ColorScheme.fromSeed(
      //       seedColor: const Color(0xFF0052CC), brightness: Brightness.dark),
      //   inputDecorationTheme: InputDecorationTheme(
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //     // filled: true,
      //     isDense: true,
      //   ),
      // ),
      theme: atlassianThemeDataLight(),
      darkTheme: atlassianThemeDataDark(),
    ),
  );
}
