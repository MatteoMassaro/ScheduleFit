import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([super.locale = 'en']);

  @override
  String get info => 'Info';

  @override
  String get versione => 'Version: ';

  @override
  String get autore => 'Author: ';

  @override
  String get descrizioneApp => 'Create your own training programs to track your progress every day!';

  @override
  String get chiudi => 'CLOSE';

  @override
  String get lingua => 'Language';

  @override
  String get italiano => 'Italian';

  @override
  String get inglese => 'English';

  @override
  String get francese => 'French';

  @override
  String get spagnolo => 'Spanish';

  @override
  String get tedesco => 'German';

  @override
  String get contatti => 'Contacts';

  @override
  String get instagram => 'Instagram';

  @override
  String get email => 'Email';

  @override
  String get sitoWeb => 'Website';

  @override
  String get eliminaScheda => 'DELETE CARD';

  @override
  String get eliminaSchedaDialog => 'Delete card';

  @override
  String get apriScheda => 'OPEN CARD';

  @override
  String get serieCompletate => 'Completed series: ';

  @override
  String get confermaEliminaScheda => 'Are you sure you want to delete the card?';

  @override
  String get si => 'YES';

  @override
  String get annulla => 'CANCEL';

  @override
  String get scegliGruppoMuscolare => 'Choose muscle group';

  @override
  String nomeMuscolo(String nomeMuscolo) {
    String temp0 = intl.Intl.selectLogic(
      nomeMuscolo,
      {
        'adduttori': 'Adductors',
        'bicipiti': 'Biceps',
        'bicipitiFemorali': 'Hamstrings',
        'brachioradiale': 'Brachioradialis',
        'deltoidi': 'Deltoids',
        'dorsali': 'Lats',
        'glutei': 'Glutes',
        'lombari': 'Lower back',
        'obliquiEsterni': 'External obliques',
        'obliquiInterni': 'Internal obliques',
        'pettorali': 'Pectorals',
        'polpacci': 'Calves',
        'quadricipiti': 'Quadriceps',
        'rettoAddominale': 'Rectus abdominis',
        'trapezio': 'Trapezius',
        'tricipiti': 'Triceps',
        'other': 'Other',
      },
    );
    return temp0;
  }

  @override
  String get creaScheda => 'Create card';

  @override
  String get mioAllenamento => 'My training';

  @override
  String get calendario => 'Calendar';

  @override
  String get inserisciTitolo => 'Enter title';

  @override
  String get aggiungiSerie => 'ADD SERIES';

  @override
  String get salva => 'SAVE';

  @override
  String serie(Object numero) {
    return 'Series $numero';
  }

  @override
  String get numeroRipetizioni => 'Number of repetitions';

  @override
  String get eliminaSerie => 'DELETE SERIES';

  @override
  String get suggerimentoAggiungiScheda => 'Click on \'+\' to add a tab';

  @override
  String get erroreCaricamentoSchede => 'Error loading cards';
}
