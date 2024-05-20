import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key});

  @override
  State<ExerciseCard> createState() => _CardState();
}

class _CardState extends State<ExerciseCard> {
  _openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF556EAA),
          title: Center(
              child: Text(
            AppLocalizations.of(context)!.eliminaSchedaDialog,
            style: const TextStyle(color: Colors.white),
          )),
          content: Text(AppLocalizations.of(context)!.confermaEliminaScheda,
              style: const TextStyle(color: Color(0xFFfbc24c), fontSize: 15)),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
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
    return Center(
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(15),
        color: const Color(0xFF556EAA),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Row(children: [
                Text("Allenamento spalle",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Color(0xFFfbc24c))),
                Spacer(),
                Icon(
                  Icons.fitness_center,
                  size: 50,
                ),
              ]),
              Row(children: [
                Text(AppLocalizations.of(context)!.serieCompletate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, color: Colors.white)),
                const SizedBox(width: 5),
                const Text("0/10",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ]),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.eliminaScheda,
                        style: const TextStyle(color: Colors.red)),
                    onPressed: () {
                      _openDialog();
                    },
                  ),
                  TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.apriScheda,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      /* ... */
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
