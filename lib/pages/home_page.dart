import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';

import '../providers/exercise_info_provider.dart';
import '../widgets/schedule_fit_drawer.dart';
import '../widgets/schedule_fit_exercise_card.dart';
import '../widgets/schedule_fit_exercises_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ExerciseInfoProvider _exerciseInfoProvider;

  @override
  void initState() {
    super.initState();
    _exerciseInfoProvider = context.read<ExerciseInfoProvider>();
    _exerciseInfoProvider.loadExercises();
  }

  ///Show Exercises Dialog
  void _showExercisesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScheduleFitExercisesDialog(
          onSave: () {
            _exerciseInfoProvider.loadExercises();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      drawer: ScheduleFitDrawer(
        onSave: () {
          _exerciseInfoProvider.loadExercises();
        },
      ),
      body: Consumer<ExerciseInfoProvider>(
        builder: (context, provider, child) {
          return provider.exerciseList.isEmpty
              ?
              ///Text Tip
              Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      AppLocalizations.of(context)
                              ?.suggerimentoAggiungiScheda ??
                          '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
              :
              ///Exercise Card List
              ListView.builder(
                  itemCount: provider.exerciseList.length,
                  itemBuilder: (context, index) {
                    return ScheduleFitExerciseCard(
                      id: provider.exerciseList[index].id ?? -1,
                      nomeEsercizio: provider.exerciseList[index].nomeEsercizio,
                      categoriaEsercizio:
                          provider.exerciseList[index].categoriaEsercizio,
                      immagine: provider.exerciseList[index].immagine,
                      serieTotali: provider.exerciseList[index].serieTotali,
                      serieCompletate:
                          provider.exerciseList[index].serieCompletate,
                      onDelete: () {
                        provider.deleteExercise(
                            provider.exerciseList[index].id ?? -1);
                      },
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showExercisesDialog,
        tooltip: AppLocalizations.of(context)?.creaScheda,
        child: const Icon(Icons.add),
      ),
    );
  }
}
