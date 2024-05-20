import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/screens/home_screen.dart';

import 'l10n/app_localizations.dart';
import 'l10n/locale_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF556EAA)),
      useMaterial3: true,
      fontFamily: 'Cooper Hewitt',
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
          color: Color(0xFF556EAA), foregroundColor: Colors.white));

  final ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF556EAA), brightness: Brightness.dark),
      useMaterial3: true,
      fontFamily: 'Cooper Hewitt',
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
          color: Color(0xFF556EAA), foregroundColor: Colors.white));

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return MaterialApp(
            title: 'ScheduleFit',
            supportedLocales: AppLocalizations.supportedLocales,
            locale: provider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: Builder(
              builder: (context) {
                final localizations = AppLocalizations.of(context);
                final title =
                    localizations?.mioAllenamento ?? 'Il mio allenamento';
                return HomePage(title: title);
              },
            ));
      });
}
