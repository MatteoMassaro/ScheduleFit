import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([super.locale = 'it']);

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
    String temp0 = intl.Intl.selectLogic(
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
    return temp0;
  }

  @override
  String get creaScheda => 'Crea scheda';

  @override
  String get mioAllenamento => 'Il mio allenamento';

  @override
  String get calendario => 'Calendario';
}
