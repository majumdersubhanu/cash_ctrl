import 'package:cash_ctrl/application/providers.dart';
import 'package:cash_ctrl/core/prefs.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:cash_ctrl/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await setupLocator();

  // getIt<AppPrefs>().clear();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: List.from(providers),
      child: MaterialApp.router(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'Cash Ctrl',
        theme: atlassianThemeDataLight(),
        darkTheme: atlassianThemeDataDark(),
        themeMode: ThemeMode.system,
        routerConfig: AppRouter().config(),
      ),
    );
  }
}
