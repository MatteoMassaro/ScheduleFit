import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/schedule_fit_colors.dart';
import '../l10n/app_localizations.dart';
import '../pages/edit_card_page.dart';
import '../providers/exercise_info_provider.dart';

class ScheduleFitExerciseCard extends StatefulWidget {
  final int id;
  final String nomeEsercizio;
  final String categoriaEsercizio;
  final String immagine;
  final int serieCompletate;
  final int serieTotali;
  final List<int> giorniSettimana;
  final Function? onDelete;

  const ScheduleFitExerciseCard({
    super.key,
    required this.id,
    required this.nomeEsercizio,
    required this.categoriaEsercizio,
    required this.immagine,
    required this.serieCompletate,
    required this.serieTotali,
    required this.giorniSettimana,
    required this.onDelete,
  });

  @override
  State<ScheduleFitExerciseCard> createState() => _CardState();
}

class _CardState extends State<ScheduleFitExerciseCard> {
  bool _isPressed = false;

  ///Open Dialog
  _openDialog(ExerciseInfoProvider exerciseInfoProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: getAppColors(AppColors.primaryColor),
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.eliminaScheda,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          content: Text(
            AppLocalizations.of(context)!.confermaEliminaScheda,
            style: TextStyle(
                color: getAppColors(AppColors.secondaryColor), fontSize: 15),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                widget.onDelete!();
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.si,
                  style: const TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.annulla,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseInfoProvider>(
      builder: (context, exerciseInfoProvider, child) {
        return GestureDetector(
          onLongPress: () {
            setState(() {
              _isPressed = !_isPressed;
            });
          },
          child: Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: _isPressed
                ? getAppColors(AppColors.primaryColor)?.withOpacity(0.7)
                : getAppColors(AppColors.primaryColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: <Widget>[
                  ///Info
                  Row(
                    children: [
                      ///Exercise Name & Completed Series
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.nomeEsercizio,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 25,
                                color: getAppColors(AppColors.secondaryColor)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                              '${AppLocalizations.of(context)!.serieCompletate}${widget.serieCompletate}/${widget.serieTotali}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white)),
                        ],
                      ),
                      const Spacer(),

                      ///Exercise Category
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .nomeMuscolo(widget.categoriaEsercizio.toLowerCase()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: getAppColors(AppColors.secondaryColor),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Image.asset(
                            widget.immagine,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ///Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      widget.onDelete != null
                          ? GestureDetector(
                              onTap: () {
                                _openDialog(exerciseInfoProvider);
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.eliminaScheda,
                                  style: const TextStyle(color: Colors.red)),
                            )
                          : Container(),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCardPage(
                                id: widget.id,
                                nomeEsercizio: widget.nomeEsercizio,
                                nomeMuscolo: widget.categoriaEsercizio,
                                immagineMuscolo: widget.immagine,
                                serieTotali: widget.serieTotali,
                                serieCompletate: widget.serieCompletate,
                                giorniSettimana: widget.giorniSettimana,
                                onSave: () {
                                  exerciseInfoProvider.loadExercises();
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.apriScheda,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
