import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../l10n/app_localizations.dart';
import '../providers/exercise_info_provider.dart';

class ExerciseCard extends StatefulWidget {
  int id;
  String nomeEsercizio;
  String categoriaEsercizio;
  String immagine;
  int serieCompletate;
  int serieTotali;
  final Function onDelete;

  ExerciseCard(
      {super.key,
      required this.id,
      required this.nomeEsercizio,
      required this.categoriaEsercizio,
      required this.immagine,
      required this.serieCompletate,
      required this.serieTotali,
      required this.onDelete});

  @override
  State<ExerciseCard> createState() => _CardState();
}

class _CardState extends State<ExerciseCard> {
  late DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
  }

  Future<void> _deleteExercise(int id) async {
    await _dbHelper.deleteExerciseInfo(id);
    widget.onDelete();
    setState(() {});
  }

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
              onPressed: () {
                _deleteExercise(widget.id);
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
      return Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          color: const Color(0xFF556EAA),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(children: [
                  Text(widget.nomeEsercizio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 25, color: Color(0xFFfbc24c))),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (widget.categoriaEsercizio),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFFfbc24c),
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
                  ),
                ]),
                Row(children: [
                  Text(AppLocalizations.of(context)!.serieCompletate,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 15, color: Colors.white)),
                  const SizedBox(width: 5),
                  Text(exerciseInfoProvider.serieCompletate.toString(),
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 15, color: Colors.white)),
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
    });
  }
}
