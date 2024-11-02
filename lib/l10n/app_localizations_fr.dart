import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([super.locale = 'fr']);

  @override
  String get info => 'Info';

  @override
  String get versione => 'Version: ';

  @override
  String get autore => 'Auteur: ';

  @override
  String get descrizioneApp => 'Créez vos propres programmes d\'entraînement pour suivre vos progrès au quotidien !';

  @override
  String get chiudi => 'FERMER';

  @override
  String get lingua => 'Langue';

  @override
  String get italiano => 'Italien';

  @override
  String get inglese => 'Anglais';

  @override
  String get francese => 'Français';

  @override
  String get spagnolo => 'Espagnol';

  @override
  String get tedesco => 'Allemand';

  @override
  String get contatti => 'Contacts';

  @override
  String get instagram => 'Instagram';

  @override
  String get email => 'Email';

  @override
  String get sitoWeb => 'Site web';

  @override
  String get eliminaScheda => 'SUPPRIMER L\'ONGLET';

  @override
  String get eliminaSchedaDialog => 'Supprimer l\'onglet';

  @override
  String get apriScheda => 'ONGLET OUVERTE';

  @override
  String get serieCompletate => 'Série terminée: ';

  @override
  String get confermaEliminaScheda => 'Êtes-vous sûr de vouloir supprimer l\'onglet?';

  @override
  String get si => 'OUI';

  @override
  String get annulla => 'ANNULLER';

  @override
  String get scegliGruppoMuscolare => 'Choisir un groupe musculaire';

  @override
  String nomeMuscolo(String nomeMuscolo) {
    String temp0 = intl.Intl.selectLogic(
      nomeMuscolo,
      {
        'adduttori': 'Adducteurs',
        'bicipiti': 'Biceps',
        'bicipitiFemorali': 'Ischio-jambiers',
        'brachioradiale': 'Brachioradial',
        'deltoidi': 'Deltoïdes',
        'dorsali': 'Dorsaux',
        'glutei': 'Fessiers',
        'lombari': 'Lombaires',
        'obliquiEsterni': 'Obliques externes',
        'obliquiInterni': 'Obliques internes',
        'pettorali': 'Pectoraux',
        'polpacci': 'Mollets',
        'quadricipiti': 'Quadriceps',
        'rettoAddominale': 'Grand droit de l\'abdomen',
        'trapezio': 'Trapèze',
        'tricipiti': 'Triceps',
        'other': 'Autre',
      },
    );
    return temp0;
  }

  @override
  String get creaScheda => 'Créer une carte';

  @override
  String get mioAllenamento => 'Mon entrainement';

  @override
  String get calendario => 'Calendrier';

  @override
  String get inserisciTitolo => 'Entrez le titre';

  @override
  String get aggiungiSerie => 'AJOUTER UNE SÉRIE';

  @override
  String get salva => 'ENREGISTRER';

  @override
  String serie(Object numero) {
    return 'Série $numero';
  }

  @override
  String get numeroRipetizioni => 'Nombre de répétitions';

  @override
  String get eliminaSerie => 'SUPPRIMER LA SÉRIE';

  @override
  String get suggerimentoAggiungiScheda => 'Cliquez sur \'+\' pour ajouter un onglet';

  @override
  String get erroreCaricamentoSchede => 'Erreur lors du chargement des cartes';
}
