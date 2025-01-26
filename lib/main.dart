import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_app_info.dart';
import 'package:schedule_fit/enums/schedule_fit_colors.dart';
import 'package:schedule_fit/pages/home_page.dart';
import 'package:schedule_fit/providers/exercise_info_provider.dart';
import 'package:schedule_fit/providers/page_provider.dart';
import 'package:schedule_fit/providers/series_info_provider.dart';
import 'package:schedule_fit/providers/theme_provider.dart';

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

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            Provider<ScheduleFitDatabase>.value(
              value: database,
            ),
            ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
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
            ///Light Theme
            final ThemeData lightTheme = ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: ThemeProvider.getColor(AppColors.primaryColor) ??
                        const Color(0xFF556EAA)),
                useMaterial3: true,
                fontFamily: getAppInfo(AppInfo.fontFamily),
                brightness: Brightness.light,
                scaffoldBackgroundColor:
                ThemeProvider.getColor(AppColors.pageBackgroundColor),
                appBarTheme: AppBarTheme(
                    color: ThemeProvider.getColor(AppColors.primaryColor) ??
                        const Color(0xFF556EAA),
                    foregroundColor: Colors.white));

            ///Dark Theme
            final ThemeData darkTheme = ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: ThemeProvider.getColor(AppColors.primaryColor) ??
                        const Color(0xFF556EAA),
                    brightness: Brightness.dark),
                scaffoldBackgroundColor:
                ThemeProvider.getColor(AppColors.pageBackgroundColor),
                useMaterial3: true,
                fontFamily: getAppInfo(AppInfo.fontFamily),
                brightness: Brightness.dark,
                appBarTheme: AppBarTheme(
                    color: ThemeProvider.getColor(AppColors.primaryColor) ??
                        const Color(0xFF556EAA),
                    foregroundColor: Colors.white));

            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: ThemeProvider.getColor(AppColors.primaryColor),
              statusBarIconBrightness: ThemeProvider().isLightMode
                  ? Brightness.light
                  : Brightness.dark,
              statusBarBrightness: ThemeProvider().isLightMode
                  ? Brightness.dark
                  : Brightness.light,
            ));
            final localeProvider = Provider.of<LocaleProvider>(context);
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
                title: getAppInfo(AppInfo.appName),
                supportedLocales: AppLocalizations.supportedLocales,
                locale: localeProvider.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeProvider.themeMode,
                debugShowCheckedModeBanner: false,
                home: Builder(builder: (context) => const HomePage()));
          });
}
