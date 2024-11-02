import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:schedule_fit/models/exercise_info.dart';

import '../database/database_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/exercise_card.dart';
import '../widgets/exercises_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseHelper _dbHelper;
  List<ExerciseInfo> _exerciseList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
    _scrollController.addListener(_scrollListener);
    _updatePage();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // Puoi aggiungere altre logiche di scorrimento qui se necessario
    }
  }

  void _updatePage() async {
    await _getExercises();
    setState(() {});
  }

  Future<void> _getExercises() async {
    // Recupera tutti gli esercizi dal database e li salva in _exerciseList
    _exerciseList = await _dbHelper.getAllExerciseInfo();
  }

  void _showExercisesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ExercisesDialog(
          onSave: _updatePage,
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
      drawer: AppDrawer(onSave: _updatePage),
      body: _exerciseList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)?.suggerimentoAggiungiScheda ??
                      'Clicca su \'+\' per aggiungere una scheda',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: _exerciseList.length,
              itemBuilder: (context, index) {
                final exerciseInfo = _exerciseList[index];
                return ExerciseCard(
                  id: exerciseInfo.id!,
                  nomeEsercizio: exerciseInfo.nomeEsercizio,
                  categoriaEsercizio: exerciseInfo.categoriaEsercizio,
                  immagine: exerciseInfo.immagine,
                  serieTotali: exerciseInfo.serieTotali,
                  serieCompletate: exerciseInfo.serieCompletate,
                  onDelete: _updatePage,
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
