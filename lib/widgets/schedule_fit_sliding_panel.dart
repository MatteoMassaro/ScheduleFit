import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:schedule_fit/widgets/schedule_fit_calendar.dart';
import 'package:schedule_fit/widgets/schedule_fit_exercise_card.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../providers/exercise_info_provider.dart';

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
    List<ExerciseInfoData> exerciseList =
        context.read<ExerciseInfoProvider>().getExercisesForDate(_selectedDate);

    return SlidingUpPanel(
      isDraggable: exerciseList.isNotEmpty ? true : false,
      minHeight: 200,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      renderPanelSheet: false,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      panel: Container(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(blurRadius: 5.0, spreadRadius: 2.0, color: Colors.black12)
          ],
          shape: RoundedRectangleBorder(
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
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
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
            exerciseList.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ScheduleFitExerciseCard(
                          id: exerciseList[index].id ?? -1,
                          nomeEsercizio: exerciseList[index].nomeEsercizio,
                          categoriaEsercizio:
                              exerciseList[index].categoriaEsercizio,
                          immagine: exerciseList[index].immagine,
                          serieTotali: exerciseList[index].serieTotali,
                          serieCompletate: exerciseList[index].serieCompletate,
                          giorniSettimana: exerciseList[index].giorniSettimana,
                          onDelete: null,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0.5,
                          color: Colors.transparent,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: exerciseList.length,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      AppLocalizations.of(context)?.nessunEsercizio ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
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
                  color: getAppColors(AppColors.primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
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
