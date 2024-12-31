import 'package:flutter/material.dart';
import 'package:schedule_fit/pages/edit_card_page.dart';

import '../enums/schedule_fit_colors.dart';
import '../icon_assets.dart';
import '../l10n/app_localizations.dart';

class ScheduleFitExercisesDialog extends StatefulWidget {
  final Function onSave;

  const ScheduleFitExercisesDialog({super.key, required this.onSave});

  @override
  State<ScheduleFitExercisesDialog> createState() =>
      _ScheduleFitExercisesDialogState();
}

class _ScheduleFitExercisesDialogState
    extends State<ScheduleFitExercisesDialog> {
  ///Create Route
  Route _createRoute(String muscleIconName, String muscleIconPath) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EditCardPage(
          id: -1,
          nomeEsercizio: '',
          nomeMuscolo: muscleIconName,
          immagineMuscolo: muscleIconPath,
          serieTotali: 0,
          serieCompletate: 0,
          onSave: widget.onSave),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: getAppColors(AppColors.primaryColor),
      title: Center(
          child: Text(
        AppLocalizations.of(context)!.scegliGruppoMuscolare,
        style: const TextStyle(color: Colors.white),
      )),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: IconAssets.icons.length,
          itemBuilder: (context, index) {
            final iconData = IconAssets.icons[index];
            return Column(
              children: [
                ListTile(
                  leading: Image.asset(iconData['path']!),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      AppLocalizations.of(context)!
                          .nomeMuscolo(iconData['name']!),
                      style: TextStyle(
                          fontSize: 20,
                          color: getAppColors(AppColors.secondaryColor)),
                    ),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).push(_createRoute(
                        AppLocalizations.of(context)!
                            .nomeMuscolo(iconData['name']!),
                        iconData['path']!))
                  },
                ),
                const SizedBox(height: 20)
              ],
            );
          },
        ),
      ),
      actions: <Widget>[
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
  }
}
