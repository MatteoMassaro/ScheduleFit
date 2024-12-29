import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get info => 'Info';

  @override
  String get versione => 'Versione: ';

  @override
  String get autore => 'Autore: ';

  @override
  String get descrizioneApp => 'Crea i tuoi programmi di allenamento  per tenere traccia ogni giorno dei tuoi progressi!';

  @override
  String get chiudi => 'CHIUDI';

  @override
  String get lingua => 'Lingua';

  @override
  String get italiano => 'Italiano';

  @override
  String get inglese => 'Inglese';

  @override
  String get francese => 'Francese';

  @override
  String get spagnolo => 'Spagnolo';

  @override
  String get tedesco => 'Tedesco';

  @override
  String get contatti => 'Contatti';

  @override
  String get instagram => 'Instagram';

  @override
  String get email => 'Email';

  @override
  String get sitoWeb => 'Sito web';

  @override
  String get eliminaScheda => 'ELIMINA SCHEDA';

  @override
  String get eliminaSchedaDialog => 'Elimina scheda';

  @override
  String get apriScheda => 'APRI SCHEDA';

  @override
  String get serieCompletate => 'Serie completate: ';

  @override
  String get confermaEliminaScheda => 'Sei sicuro di voler eliminare la scheda?';

  @override
  String get si => 'SI';

  @override
  String get annulla => 'ANNULLA';

  @override
  String get scegliGruppoMuscolare => 'Scegli gruppo muscolare';

  @override
  String nomeMuscolo(String nomeMuscolo) {
    String _temp0 = intl.Intl.selectLogic(
      nomeMuscolo,
      {
        'adduttori': 'Adduttori',
        'bicipiti': 'Bicipiti',
        'bicipitiFemorali': 'Bicipiti femorali',
        'brachioradiale': 'Brachioradiale',
        'deltoidi': 'Deltoidi',
        'dorsali': 'Dorsali',
        'glutei': 'Glutei',
        'lombari': 'Lombari',
        'obliquiEsterni': 'Obliqui esterni',
        'obliquiInterni': 'Obliqui interni',
        'pettorali': 'Pettorali',
        'polpacci': 'Polpacci',
        'quadricipiti': 'Quadricipiti',
        'rettoAddominale': 'Retto addominale',
        'trapezio': 'Trapezio',
        'tricipiti': 'Tricipiti',
        'other': 'Altro',
      },
    );
    return '$_temp0';
  }

  @override
  String get creaScheda => 'Crea scheda';

  @override
  String get modificaScheda => 'Modifica scheda';

  @override
  String get mioAllenamento => 'Il mio allenamento';

  @override
  String get calendario => 'Calendario';

  @override
  String get inserisciTitolo => 'Inserisci titolo';

  @override
  String get aggiungiSerie => 'AGGIUNGI SERIE';

  @override
  String get salva => 'SALVA';

  @override
  String serie(Object numero) {
    return 'Serie $numero';
  }

  @override
  String get numeroRipetizioni => 'Numero ripetizioni';

  @override
  String get eliminaSerie => 'ELIMINA SERIE';

  @override
  String get suggerimentoAggiungiScheda => 'Clicca su \'+\' per aggiungere una scheda';

  @override
  String get erroreCaricamentoSchede => 'Errore nel caricamento delle schede';
}
