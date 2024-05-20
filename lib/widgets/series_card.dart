import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class SeriesCard extends StatefulWidget {
  const SeriesCard({super.key});

  @override
  State<SeriesCard> createState() => _CardState();
}

class _CardState extends State<SeriesCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
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
