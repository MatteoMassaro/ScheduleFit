import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/database/schedule_fit_database.dart';
import 'package:schedule_fit/enums/schedule_fit_colors.dart';
import 'package:schedule_fit/enums/schedule_fit_days_of_week.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:schedule_fit/providers/page_provider.dart';

import '../enums/schedule_fit_pages.dart';
import '../providers/exercise_info_provider.dart';
import '../widgets/schedule_fit_drawer.dart';
import '../widgets/schedule_fit_exercise_card.dart';
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
  List<int> daysOfWeek = getDaysOfWeek();

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
          AppLocalizations.of(context)?.mioAllenamento ?? '',
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

              ///Exercise Card List
              Accordion(
                headerBackgroundColor: Colors.blueAccent,
                headerPadding: const EdgeInsets.all(10),
                contentBackgroundColor: Colors.white,
                children: [
                  AccordionSection(
                    index: 1,
                    isOpen: true,
                    headerBackgroundColor:
                        getAppColors(AppColors.primaryColor),
                    header: Text(
                      AppLocalizations.of(context)!.oggi,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    content: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: todayExercises.map((exercise) {
                        return ScheduleFitExerciseCard(
                          id: exercise.id ?? -1,
                          nomeEsercizio: exercise.nomeEsercizio,
                          categoriaEsercizio: exercise.categoriaEsercizio,
                          immagine: exercise.immagine,
                          serieTotali: exercise.serieTotali,
                          serieCompletate: exercise.serieCompletate,
                          giorniSettimana: exercise.giorniSettimana,
                          onDelete: () {
                            exerciseInfoProvider
                                .deleteExercise(exercise.id ?? -1);
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  /// Days Of Week Accordions
                  ...List.generate(7, (index) {
                    int day = daysOfWeek[index];
                    var filteredExercises =
                        exerciseInfoProvider.exerciseList
                            .where(
                              (exercise) =>
                                  exercise.giorniSettimana.contains(day),
                            )
                            .toList();

                    if (filteredExercises.isEmpty) {
                      return AccordionSection(
                        header: Container(),
                        content: Container(),
                      );
                    }

                    return AccordionSection(
                      index: index + 2,
                      headerBackgroundColor:
                          getAppColors(AppColors.primaryColor),
                      header: Text(
                        getDayOfWeekTranslated(context, day),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      content: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: filteredExercises.map((exercise) {
                          return ScheduleFitExerciseCard(
                            id: exercise.id ?? -1,
                            nomeEsercizio: exercise.nomeEsercizio,
                            categoriaEsercizio:
                                exercise.categoriaEsercizio,
                            immagine: exercise.immagine,
                            serieTotali: exercise.serieTotali,
                            serieCompletate: exercise.serieCompletate,
                            giorniSettimana: exercise.giorniSettimana,
                            onDelete: () {
                              exerciseInfoProvider
                                  .deleteExercise(exercise.id ?? -1);
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }).where((section) => section.index != 0),
                ],
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showExercisesDialog,
        tooltip: AppLocalizations.of(context)?.creaScheda,
        child: const Icon(Icons.add),
      ),
    );
  }
}
