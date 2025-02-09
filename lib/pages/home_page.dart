import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/database/schedule_fit_database.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:schedule_fit/providers/page_provider.dart';

import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_pages.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/schedule_fit_accordion.dart';
import '../widgets/schedule_fit_drawer.dart';
import '../widgets/schedule_fit_exercises_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ExerciseInfoProvider _exerciseInfoProvider;
  late PageProvider _pageProvider;
  late List<ExerciseInfoData> todayExercises;

  @override
  void initState() {
    super.initState();
    _pageProvider = context.read<PageProvider>();
    _exerciseInfoProvider = context.read<ExerciseInfoProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageProvider.setCurrentPage(Pages.mioAllenamento.name);
      _exerciseInfoProvider.loadExercises();
    });
  }

  ///Show Exercises Dialog
  void _showExercisesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScheduleFitExercisesDialog(
          onSave: () {
            _exerciseInfoProvider.loadExercises();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.mioAllenamento,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      drawer: ScheduleFitDrawer(
        onSave: () {
          _exerciseInfoProvider.loadExercises();
        },
      ),
      body: Consumer<ExerciseInfoProvider>(
        builder: (context, exerciseInfoProvider, child) {
          todayExercises = exerciseInfoProvider.getTodayExercises();

          return exerciseInfoProvider.exerciseList.isEmpty
              ?
              ///Text Tip
              Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      AppLocalizations.of(context)
                              ?.suggerimentoAggiungiScheda ??
                          '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
              :
              ///Days Of Week Accordions
              ScheduleFitAccordion(todayExercises: todayExercises);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showExercisesDialog,
        tooltip: AppLocalizations.of(context)!.creaScheda,
        backgroundColor: ThemeProvider.getColor(AppColors.primaryColor),
        child: Icon(
          Icons.add,
          color: ThemeProvider.getColor(AppColors.pageBackgroundColor),
        ),
      ),
    );
  }
}
