import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get info => 'Info';

  @override
  String get versione => 'Ausführung: ';

  @override
  String get autore => 'Autor: ';

  @override
  String get descrizioneApp => 'Erstellen Sie Ihre eigenen Trainingsprogramme, um Ihre Fortschritte jeden Tag zu verfolgen!';

  @override
  String get chiudi => 'SCHLIESSEN';

  @override
  String get lingua => 'Sprache';

  @override
  String get italiano => 'Italienisch';

  @override
  String get inglese => 'Englisch';

  @override
  String get francese => 'Französisch';

  @override
  String get spagnolo => 'Spanisch';

  @override
  String get tedesco => 'Deutsch';

  @override
  String get contatti => 'Kontakte';

  @override
  String get instagram => 'Instagram';

  @override
  String get email => 'Email';

  @override
  String get sitoWeb => 'Webseite';

  @override
  String get eliminaScheda => 'KARTE LÖSCHEN';

  @override
  String get eliminaSchedaDialog => 'Karte löschen';

  @override
  String get apriScheda => 'KARTE ÖFFNEN';

  @override
  String get serieCompletate => 'Abgeschlossene serie: ';

  @override
  String get confermaEliminaScheda => 'Sind Sie sicher, dass Sie die Karte löschen möchten?';

  @override
  String get si => 'JA';

  @override
  String get annulla => 'STORNIEREN';

  @override
  String get scegliGruppoMuscolare => 'Wählen sie eine muskelgruppe';

  @override
  String nomeMuscolo(String nomeMuscolo) {
    String _temp0 = intl.Intl.selectLogic(
      nomeMuscolo,
      {
        'adduttori': 'Adduktoren',
        'bicipiti': 'Bizeps',
        'bicipitiFemorali': 'Beinbeuger',
        'brachioradiale': 'Brachioradialis',
        'deltoidi': 'Deltamuskeln',
        'dorsali': 'Rückenmuskeln',
        'glutei': 'Gluteus',
        'lombari': 'Lendenmuskeln',
        'obliquiEsterni': 'Äußere schrägen Bauchmuskeln',
        'obliquiInterni': 'Innere schrägen Bauchmuskeln',
        'pettorali': 'Brustmuskeln',
        'polpacci': 'Wadenmuskeln',
        'quadricipiti': 'Quadrizeps',
        'rettoAddominale': 'Gerade Bauchmuskeln',
        'trapezio': 'Trapezmuskel',
        'tricipiti': 'Trizeps',
        'other': 'Andere',
      },
    );
    return '$_temp0';
  }

  @override
  String get creaScheda => 'Karte erstellen';

  @override
  String get modificaScheda => 'Karte bearbeiten';

  @override
  String get mioAllenamento => 'Mein training';

  @override
  String get calendario => 'Kalender';

  @override
  String get inserisciTitolo => 'Titel eingeben';

  @override
  String get aggiungiSerie => 'SERIE HINZUFÜGEN';

  @override
  String get salva => 'SPEICHERN';

  @override
  String serie(Object numero) {
    return 'Serie $numero';
  }

  @override
  String get numeroRipetizioni => 'Anzahl der wiederholungen';

  @override
  String get eliminaSerie => 'SERIE LÖSCHEN';

  @override
  String get suggerimentoAggiungiScheda => 'Klicken sie auf \'+\' um eine registerkarte hinzuzufügen';

  @override
  String get erroreCaricamentoSchede => 'Fehler beim laden der karten';

  @override
  String get mese => 'Monat';

  @override
  String get anno => 'Jahr';

  @override
  String get nessunEsercizio => 'Keine übung';
}
