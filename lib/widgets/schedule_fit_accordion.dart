import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/widgets/schedule_fit_exercise_card.dart';
import 'package:table_calendar/table_calendar.dart';

import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_days_of_week.dart';
import '../l10n/app_localizations.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/theme_provider.dart';

class ScheduleFitAccordion extends StatelessWidget {
  const ScheduleFitAccordion({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> daysOfWeek = getDaysOfWeek();

    return Consumer<ExerciseInfoProvider>(
      builder: (context, exerciseInfoProvider, child) => Accordion(
        headerBackgroundColor: Colors.blueAccent,
        headerPadding: const EdgeInsets.all(10),
        contentBackgroundColor:
            ThemeProvider.getColor(AppColors.accordionBackgroundColor),
        children: [
          /// Days Of Week Accordions
          ...List.generate(9, (index) {
            int day = index < 8 ? daysOfWeek[index] : -1;
            final exercises = switch (index) {
              0 => exerciseInfoProvider.getTodayExercises(DateTime.now()),
              8 => exerciseInfoProvider.getNotAssignedExercises(),
              _ => exerciseInfoProvider.getPeriodicExercises(day)
            };

            if (exercises.isEmpty) {
              return AccordionSection(
                header: Container(),
                content: Container(),
              );
            }

            return index < 8
                ? AccordionSection(
                    index: index + 1,
                    headerBackgroundColor:
                        ThemeProvider.getColor(AppColors.primaryColor),
                    header: Text(
                      getDayOfWeekTranslatedFromInt(context, day),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ThemeProvider.getColor(
                              AppColors.accordionTextHeaderColor)),
                    ),
                    content: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: exercises.map((exercise) {
                        return ScheduleFitExerciseCard(
                          id: exercise.id ?? -1,
                          nomeEsercizio: exercise.nomeEsercizio,
                          categoriaEsercizio: exercise.categoriaEsercizio,
                          immagine: exercise.immagine,
                          serieTotali: exercise.serieTotali,
                          serieCompletate: exercise.serieCompletate,
                          giorniSettimana: exercise.giorniSettimana.isNotEmpty
                              ? exercise.giorniSettimana
                                  .map((giorno) => giorno == 0
                                      ? isSameDay(DateTime.now(), exercise.data)
                                          ? giorno
                                          : null
                                      : giorno)
                                  .toList()
                              : [],
                          onDelete: () {
                            exerciseInfoProvider
                                .deleteExercise(exercise.id ?? -1);
                          },
                          onlyView: true,
                          todayExercise: index == 0 ? true : false,
                        );
                      }).toList(),
                    ),
                  )
                : AccordionSection(
                    index: index + 1,
                    headerBackgroundColor:
                        ThemeProvider.getColor(AppColors.primaryColor),
                    header: Text(
                      AppLocalizations.of(context)!.nonAssegnati,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ThemeProvider.getColor(
                              AppColors.accordionTextHeaderColor)),
                    ),
                    content: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: exercises.map((exercise) {
                        return ScheduleFitExerciseCard(
                          id: exercise.id ?? -1,
                          nomeEsercizio: exercise.nomeEsercizio,
                          categoriaEsercizio: exercise.categoriaEsercizio,
                          immagine: exercise.immagine,
                          serieTotali: exercise.serieTotali,
                          serieCompletate: exercise.serieCompletate,
                          giorniSettimana: exercise.giorniSettimana
                              .map((giorno) => giorno == 0
                                  ? isSameDay(DateTime.now(), exercise.data)
                                      ? giorno
                                      : -1
                                  : giorno)
                              .toList(),
                          onDelete: () {
                            exerciseInfoProvider
                                .deleteExercise(exercise.id ?? -1);
                          },
                          onlyView: true,
                          todayExercise: index == 0 ? true : false,
                        );
                      }).toList(),
                    ),
                  );
          }).where((section) => section.index != 0),
        ],
      ),
    );
  }
}
