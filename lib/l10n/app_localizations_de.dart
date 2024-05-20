import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([super.locale = 'de']);

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
    String temp0 = intl.Intl.selectLogic(
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
    return temp0;
  }

  @override
  String get creaScheda => 'Karte erstellen';

  @override
  String get mioAllenamento => 'Mein training';

  @override
  String get calendario => 'Kalender';

  @override
  String get inserisciTitolo => 'Titel eingeben';

  @override
  String get aggiungiSerie => 'REIHE HINZUFÜGEN';

  @override
  String get salva => 'SPEICHERN';
}
