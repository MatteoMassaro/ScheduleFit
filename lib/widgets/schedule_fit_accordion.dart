import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/widgets/schedule_fit_exercise_card.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_days_of_week.dart';
import '../l10n/app_localizations.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/theme_provider.dart';

class ScheduleFitAccordion extends StatelessWidget {
  final List<ExerciseInfoData> todayExercises;

  const ScheduleFitAccordion({super.key, required this.todayExercises});

  @override
  Widget build(BuildContext context) {
    ExerciseInfoProvider exerciseInfoProvider =
        context.read<ExerciseInfoProvider>();
    List<int> daysOfWeek = getDaysOfWeek();

    return Accordion(
      headerBackgroundColor: Colors.blueAccent,
      headerPadding: const EdgeInsets.all(10),
      contentBackgroundColor:
          ThemeProvider.getColor(AppColors.accordionBackgroundColor),
      children: [
        AccordionSection(
          index: 1,
          isOpen: true,
          headerBackgroundColor: ThemeProvider.getColor(AppColors.primaryColor),
          header: Text(
            AppLocalizations.of(context)!.oggi,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    ThemeProvider.getColor(AppColors.accordionTextHeaderColor)),
          ),
          content: todayExercises.isNotEmpty
              ?

              ///Exercise Card List
              ListView(
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
                        exerciseInfoProvider.deleteExercise(exercise.id ?? -1);
                      },
                      onlyView: true,
                    );
                  }).toList(),
                )
              :

              ///No Exercises Text
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    AppLocalizations.of(context)!.nessunEsercizio,
                    style: TextStyle(
                        color:
                            ThemeProvider.getColor(AppColors.noExercisesColor)),
                  ),
                ),
        ),

        /// Days Of Week Accordions
        ...List.generate(7, (index) {
          int day = daysOfWeek[index];
          var filteredExercises = exerciseInfoProvider.exerciseList
              .where(
                (exercise) => exercise.giorniSettimana.contains(day),
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
                ThemeProvider.getColor(AppColors.primaryColor),
            header: Text(
              getDayOfWeekTranslated(context, day),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ThemeProvider.getColor(
                      AppColors.accordionTextHeaderColor)),
            ),
            content: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: filteredExercises.map((exercise) {
                return ScheduleFitExerciseCard(
                  id: exercise.id ?? -1,
                  nomeEsercizio: exercise.nomeEsercizio,
                  categoriaEsercizio: exercise.categoriaEsercizio,
                  immagine: exercise.immagine,
                  serieTotali: exercise.serieTotali,
                  serieCompletate: exercise.serieCompletate,
                  giorniSettimana: exercise.giorniSettimana,
                  onDelete: () {
                    exerciseInfoProvider.deleteExercise(exercise.id ?? -1);
                  },
                  onlyView: true,
                );
              }).toList(),
            ),
          );
        }).where((section) => section.index != 0),
      ],
    );
  }
}
