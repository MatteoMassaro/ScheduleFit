import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
  }

  void _showExercisesDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ExercisesDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            widget.title,
            style:
            const TextStyle(fontFamily: 'Cooper Hewitt', color: Colors.white),
          )),
      drawer: const AppDrawer(),
      body: const Center(
        child: Column(
          children: <Widget>[
            ExerciseCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showExercisesDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}