import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_app_info.dart';
import 'package:schedule_fit/pages/home_page.dart';
import 'package:schedule_fit/providers/exercise_info_provider.dart';
import 'package:schedule_fit/providers/page_provider.dart';
import 'package:schedule_fit/providers/series_info_provider.dart';

import 'database/schedule_fit_database.dart';
import 'l10n/app_localizations.dart';
import 'providers/locale_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final db = ScheduleFitDatabase();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  final ScheduleFitDatabase database;

  MyApp({super.key, required this.database});

  final ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF556EAA)),
      useMaterial3: true,
      fontFamily: getAppInfo(AppInfo.fontFamily),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
          color: Color(0xFF556EAA), foregroundColor: Colors.white));

  final ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF556EAA), brightness: Brightness.dark),
      useMaterial3: true,
      fontFamily: getAppInfo(AppInfo.fontFamily),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
          color: Color(0xFF556EAA), foregroundColor: Colors.white));

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            Provider<ScheduleFitDatabase>.value(
              value: database,
            ),
            ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ChangeNotifierProvider(
                create: (_) => PageProvider(
                    AppLocalizations.of(context)?.mioAllenamento ?? '')),
            ChangeNotifierProxyProvider<ScheduleFitDatabase,
                ExerciseInfoProvider>(
              create: (context) => ExerciseInfoProvider(
                  Provider.of<ScheduleFitDatabase>(context, listen: false)),
              update: (context, db, previous) => ExerciseInfoProvider(db),
            ),
            ChangeNotifierProxyProvider<ScheduleFitDatabase,
                SeriesInfoProvider>(
              create: (context) => SeriesInfoProvider(
                  Provider.of<ScheduleFitDatabase>(context, listen: false)),
              update: (context, db, previous) => SeriesInfoProvider(db),
            ),
          ],
          builder: (context, child) {
            final provider = Provider.of<LocaleProvider>(context);
            return MaterialApp(
                title: getAppInfo(AppInfo.appName),
                supportedLocales: AppLocalizations.supportedLocales,
                locale: provider.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.system,
                home: Builder(
                  builder: (context) {
                    final localizations = AppLocalizations.of(context);
                    final title = localizations?.mioAllenamento ?? '';
                    return HomePage(title: title);
                  },
                ));
          });
}
