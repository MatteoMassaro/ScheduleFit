import 'package:flutter/material.dart';

import '../icon_assets.dart';
import '../l10n/app_localizations.dart';

class ExercisesDialog extends StatefulWidget {
  const ExercisesDialog({super.key});

  @override
  State<ExercisesDialog> createState() => _ExercisesDialogState();
}

class _ExercisesDialogState extends State<ExercisesDialog> {
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
                  onTap: () => {},
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
