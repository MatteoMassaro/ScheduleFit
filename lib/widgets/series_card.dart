import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/providers/exercise_info_provider.dart';

import '../l10n/app_localizations.dart';

class SeriesCard extends StatefulWidget {
  final int index;
  final VoidCallback onDelete;

  const SeriesCard({
    super.key,
    required this.index,
    required this.onDelete,
  });

  @override
  State<SeriesCard> createState() => _CardState();
}

class _CardState extends State<SeriesCard> {
  bool _switchValue = false;
  final List<String> _unitaMisuraList = ['Kg', 'Lbs'];
  String _unitaMisuraSelezionata = 'Kg';

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseInfoProvider>(
        builder: (context, exerciseInfoProvider, child) {
      return Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
          color: const Color(0xFF556EAA),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Row(children: [
                  Text(AppLocalizations.of(context)!.serie(widget.index),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 25, color: Color(0xFFfbc24c))),
                  const Spacer(),
                  Switch(
                    value: _switchValue,
                    onChanged: (newValue) {
                      setState(() {
                        if (newValue == true) {
                          exerciseInfoProvider.increaseCompletedSeries();
                        } else {
                          exerciseInfoProvider.decreaseCompletedSeries();
                        }
                        _switchValue = newValue;
                      });
                    },
                  ),
                ]),
                Row(children: [
                  Text(AppLocalizations.of(context)!.numeroRipetizioni,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 15, color: Colors.white)),
                  const SizedBox(width: 10),
                  const SizedBox(
                    height: 50,
                    width: 130,
                    child: TextField(
                      maxLength: 10,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20, color: Color(0xFFfbc24c)),
                      decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: TextStyle(color: Colors.grey),
                          counterText: "",
                          border: InputBorder.none),
                    ),
                  )
                ]),
                Row(children: [
                  DropdownButton<String>(
                    value: _unitaMisuraSelezionata,
                    onChanged: (String? newValue) {
                      setState(() {
                        _unitaMisuraSelezionata = newValue!;
                      });
                    },
                    items: _unitaMisuraList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(
                    height: 50,
                    width: 130,
                    child: TextField(
                      maxLength: 10,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20, color: Color(0xFFfbc24c)),
                      decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: TextStyle(color: Colors.grey),
                          counterText: "",
                          border: InputBorder.none),
                    ),
                  )
                ]),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: widget.onDelete,
                      child: Text(AppLocalizations.of(context)!.eliminaSerie,
                          style: const TextStyle(color: Colors.red)),
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
