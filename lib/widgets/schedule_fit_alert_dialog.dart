import 'package:flutter/material.dart';

import '../enums/schedule_fit_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class ScheduleFitAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onPressed;

  const ScheduleFitAlertDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeProvider.getColor(AppColors.primaryColor),
      title: Center(
        child: Text(
          title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ThemeProvider.getColor(AppColors.secondaryColor),
            fontSize: 15),
      ),
      actions: <Widget>[
        ///Confirm Button
        TextButton(
          onPressed: () => onPressed(),
          child: Text(AppLocalizations.of(context)!.si,
              style: const TextStyle(color: Colors.white)),
        ),

        ///Close Button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.annulla,
            style:
                TextStyle(color: ThemeProvider.getColor(AppColors.cancelColor)),
          ),
        ),
      ],
    );
  }
}
