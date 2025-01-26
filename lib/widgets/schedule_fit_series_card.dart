import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/providers/exercise_info_provider.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/series_info_provider.dart';
import '../providers/theme_provider.dart';

class ScheduleFitSeriesCard extends StatefulWidget {
  final int index;
  final VoidCallback onDelete;
  final int ripetizioni;
  final String unitaMisura;
  final double peso;
  final bool completata;
  int serieCompletate;
  final ValueChanged<Map<String, dynamic>> onUpdate;

  ScheduleFitSeriesCard({
    super.key,
    required this.index,
    required this.onDelete,
    required this.ripetizioni,
    required this.unitaMisura,
    required this.peso,
    required this.completata,
    required this.serieCompletate,
    required this.onUpdate,
  });

  @override
  State<ScheduleFitSeriesCard> createState() => _ScheduleFitSeriesCardState();
}

class _ScheduleFitSeriesCardState extends State<ScheduleFitSeriesCard> {
  late bool _switchValue;
  late String _unitaMisuraSelezionata;
  late TextEditingController _ripetizioniController;
  late TextEditingController _pesoController;
  late List<SeriesInfoData> seriesList = [];

  @override
  void initState() {
    super.initState();
    _switchValue = widget.completata;
    _unitaMisuraSelezionata = widget.unitaMisura;
    _ripetizioniController =
        TextEditingController(text: widget.ripetizioni.toString());
    _pesoController = TextEditingController(text: widget.peso.toString());
  }

  @override
  void dispose() {
    _ripetizioniController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  ///Update Values
  void _updateValues() {
    seriesList = context.read<SeriesInfoProvider>().seriesList;
    setState(() {
      seriesList[widget.index].ripetizioni =
          int.tryParse(_ripetizioniController.text) ?? 0;
      seriesList[widget.index].unitaMisura = _unitaMisuraSelezionata;
      seriesList[widget.index].peso =
          double.tryParse(_pesoController.text) ?? 0.0;
      seriesList[widget.index].completata = _switchValue;
    });
    final updatedValues = {'serieCompletate': widget.serieCompletate};
    widget.onUpdate(updatedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseInfoProvider>(
        builder: (context, exerciseInfoProvider, child) {
      return Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
          color: ThemeProvider.getColor(AppColors.primaryColor),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                ///Title & Switch
                Row(children: [
                  Text(AppLocalizations.of(context)!.serie(widget.index + 1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor))),
                  const Spacer(),
                  Switch(
                    value: _switchValue,
                    onChanged: (newValue) {
                      setState(() {
                        _switchValue = newValue;
                        newValue
                            ? widget.serieCompletate++
                            : widget.serieCompletate--;
                        _updateValues();
                      });
                    },
                  ),
                ]),

                ///Number Of Repetitions
                Row(children: [
                  Text('${AppLocalizations.of(context)!.numeroRipetizioni}:',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 130,
                    child: TextField(
                      controller: _ripetizioniController,
                      maxLength: 10,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor)),
                      decoration: const InputDecoration(
                          hintText: '0',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.grey),
                          counterText: "",
                          border: InputBorder.none),
                      onChanged: (value) {
                        _updateValues();
                      },
                    ),
                  )
                ]),

                ///Weight
                Row(children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      value: _unitaMisuraSelezionata,
                      dropdownColor:
                          ThemeProvider.getColor(AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                      onChanged: (String? newValue) {
                        setState(() {
                          _unitaMisuraSelezionata = newValue!;
                          _updateValues();
                        });
                      },
                      items: ['Kg', 'Lbs']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 130,
                    child: TextField(
                      controller: _pesoController,
                      maxLength: 10,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor)),
                      decoration: const InputDecoration(
                          hintText: '0',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.grey),
                          counterText: "",
                          border: InputBorder.none),
                      onChanged: (value) {
                        _updateValues();
                      },
                    ),
                  )
                ]),
                const SizedBox(height: 5),

                ///Delete Button
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: widget.onDelete,
                      child: Text(AppLocalizations.of(context)!.eliminaSerie,
                          style: TextStyle(
                              color: ThemeProvider.getColor(
                                  AppColors.cancelColor))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
