import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get info => 'About ScheduleFit';

  @override
  String get versione => 'Version: ';

  @override
  String get autore => 'Author: ';

  @override
  String get valutami => 'Rate me';

  @override
  String get politicaRiservatezza => 'Privacy policy';

  @override
  String get cerca => 'Search';

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
  String get serieTotali => 'Total series: ';

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
    String _temp0 = intl.Intl.selectLogic(
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
    return '$_temp0';
  }

  @override
  String get creaScheda => 'Create card';

  @override
  String get modificaScheda => 'Edit card';

  @override
  String get visualizzaScheda => 'View card';

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

  @override
  String get mese => 'Month';

  @override
  String get anno => 'Year';

  @override
  String get nessunEsercizio => 'No exercise';

  @override
  String get conferma => 'CONFIRM';

  @override
  String get giorniAllenamento => 'Training days';

  @override
  String get lunedi => 'monday';

  @override
  String get martedi => 'tuesday';

  @override
  String get mercoledi => 'wednesday';

  @override
  String get giovedi => 'thursday';

  @override
  String get venerdi => 'friday';

  @override
  String get sabato => 'saturday';

  @override
  String get domenica => 'sunday';

  @override
  String get ogni => 'Every';

  @override
  String get oggi => 'Today';

  @override
  String get impostazioni => 'Settings';

  @override
  String get notifiche => 'Notifications';

  @override
  String get tema => 'Theme';

  @override
  String get inizioAllenamento => 'TRAINING START';

  @override
  String get iniziaAllenamento => 'START TRAINING';

  @override
  String get sospendiAllenamento => 'PAUSE TRAINING';

  @override
  String get riprendiAllenamento => 'RESUME TRAINING';

  @override
  String get terminaAllenamento => 'END TRAINING';

  @override
  String get confermaTerminaAllenamento => 'Are you sure you want to finish your training?';
}
