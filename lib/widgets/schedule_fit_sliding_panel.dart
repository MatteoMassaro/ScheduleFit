import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:schedule_fit/widgets/schedule_fit_calendar.dart';
import 'package:schedule_fit/widgets/schedule_fit_exercise_card.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/theme_provider.dart';

class ScheduleFitSlidingPanel extends StatefulWidget {
  const ScheduleFitSlidingPanel({super.key});

  @override
  State<ScheduleFitSlidingPanel> createState() =>
      _ScheduleFitSlidingPanelState();
}

class _ScheduleFitSlidingPanelState extends State<ScheduleFitSlidingPanel> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<ExerciseInfoData> periodicExercises = context
        .read<ExerciseInfoProvider>()
        .getPeriodicExercises(_selectedDate.weekday);

    List<ExerciseInfoData> exercisesByDate =
        context.read<ExerciseInfoProvider>().getExercisesByDate(_selectedDate);

    List<ExerciseInfoData> totalExercises = [
      ...{...periodicExercises, ...exercisesByDate}
    ];

    return SlidingUpPanel(
      backdropEnabled: true,
      color: ThemeProvider.getColor(AppColors.primaryColor) ??
          const Color(0xFF556EAA),
      isDraggable: totalExercises.isNotEmpty ? true : false,
      minHeight: 200,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      renderPanelSheet: false,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      panel: Container(
        decoration: ShapeDecoration(
          color: ThemeProvider.getColor(AppColors.primaryColor) ??
              const Color(0xFF556EAA),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ///Drag Bar
            Container(
              alignment: Alignment.center,
              height: 30.0,
              decoration: ShapeDecoration(
                color: ThemeProvider.getColor(AppColors.primaryColor) ??
                    const Color(0xFF556EAA),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 0.5,
              color: Colors.transparent,
            ),

            ///Exercise Card List
            totalExercises.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      padding: periodicExercises.isEmpty
                          ? const EdgeInsets.only(bottom: 10)
                          : null,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ScheduleFitExerciseCard(
                          id: totalExercises[index].id ?? -1,
                          nomeEsercizio: totalExercises[index].nomeEsercizio,
                          categoriaEsercizio:
                              totalExercises[index].categoriaEsercizio,
                          immagine: totalExercises[index].immagine,
                          serieTotali: totalExercises[index].serieTotali,
                          serieCompletate:
                              totalExercises[index].serieCompletate,
                          giorniSettimana: totalExercises[index]
                              .giorniSettimana
                              .map((giorno) => giorno == 0
                                  ? isSameDay(DateTime.now(),
                                          totalExercises[index].data)
                                      ? giorno
                                      : -1
                                  : giorno)
                              .toList(),
                          onDelete: null,
                          onlyView: true,
                          todayExercise: _selectedDate.day == DateTime.now().day,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0.5,
                          color: Colors.transparent,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: totalExercises.length,
                    ),
                  )
                : Container(),

            ///No Exercises Text
            periodicExercises.isEmpty && exercisesByDate.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      AppLocalizations.of(context)!.nessunEsercizio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            ThemeProvider.getColor(AppColors.noExercisesColor),
                      ),
                    ))
                : Container(),
          ],
        ),
      ),
      body: Column(
        children: [
          ///Calendar
          Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: ThemeProvider.getColor(AppColors.primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(1, 8),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ]),
              child: ScheduleFitCalendar(
                onDaySelected: (selectedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
                },
              )),
        ],
      ),
    );
  }
}
