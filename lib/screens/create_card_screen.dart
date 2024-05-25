import 'package:flutter/material.dart';
import 'package:schedule_fit/widgets/series_card.dart';

import '../l10n/app_localizations.dart';

class CreateCardScreen extends StatefulWidget {
  final String muscleIconName;
  final String muscleIconPath;

  const CreateCardScreen(
      {super.key, required this.muscleIconName, required this.muscleIconPath});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  late TextEditingController _textEditingController;
  List<int> cards = [];
  bool _isSaveButtonEnabled = false;

  void _removeSeries(int index) {
    setState(() {
      cards.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _addCard() {
    setState(() {
      cards.add(cards.length + 1);
    });
  }

  void _saveChanges() {
    // Logica per salvare le modifiche
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.creaScheda),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (widget.muscleIconName),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFFfbc24c),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Image.asset(
                            widget.muscleIconPath,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: TextField(
                          controller: _textEditingController,
                          maxLength: 30,
                          maxLines: 3,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 30, color: Color(0xFFfbc24c)),
                          decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.inserisciTitolo,
                              hintStyle: const TextStyle(color: Colors.grey),
                              counterText: "",
                              border: InputBorder.none),
                          onChanged: (text) {
                            setState(() {
                              _isSaveButtonEnabled = text.isNotEmpty;
                              if (text.isNotEmpty) {
                                final newText =
                                    text.substring(0, 1).toUpperCase() +
                                        text.substring(1);
                                _textEditingController.value = TextEditingValue(
                                  text: newText,
                                  selection: TextSelection.collapsed(
                                      offset: newText.length),
                                );
                              }
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return SeriesCard(
                      index: index + 1,
                      onDelete: () => _removeSeries(index),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 65),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: const Color(0xFF556EAA),
                          padding: const EdgeInsets.all(10)),
                      onPressed: _addCard,
                      child: Text(AppLocalizations.of(context)!.aggiungiSerie,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.grey,
                          fixedSize: const Size(150, 65),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: Colors.green),
                      onPressed: _isSaveButtonEnabled ? _saveChanges : null,
                      child: Text(AppLocalizations.of(context)!.salva,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
