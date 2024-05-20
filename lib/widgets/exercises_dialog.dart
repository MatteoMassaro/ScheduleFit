import 'package:flutter/material.dart';
import 'package:schedule_fit/screens/create_card_screen.dart';

import '../icon_assets.dart';
import '../l10n/app_localizations.dart';

class ExercisesDialog extends StatefulWidget {
  const ExercisesDialog({super.key});

  @override
  State<ExercisesDialog> createState() => _ExercisesDialogState();
}

class _ExercisesDialogState extends State<ExercisesDialog> {
  Route _createRoute(String muscleIconName, String muscleIconPath) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CreateCardScreen(
          muscleIconName: muscleIconName, muscleIconPath: muscleIconPath),
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
      backgroundColor: const Color(0xFF556EAA),
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
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xFFfbc24c)),
                    ),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).push(
                        _createRoute(AppLocalizations.of(context)!
                            .nomeMuscolo(iconData['name']!), iconData['path']!))
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
