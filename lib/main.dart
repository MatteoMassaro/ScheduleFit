import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/widgets/exercises_dialog.dart';
import 'package:schedule_fit/widgets/exercise_card.dart';
import 'package:schedule_fit/widgets/app_drawer.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void _showExercisesDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ExercisesDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style:
              const TextStyle(fontFamily: 'Cooper Hewitt', color: Colors.white),
        ),
        /* actions: const [
          LocaleSwitcherWidget(),
          SizedBox(width: 12),
        ],
        */
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Column(
          children: <Widget>[
            ExerciseCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showExercisesDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
