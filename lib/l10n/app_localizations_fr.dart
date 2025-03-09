import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get info => 'À propos de ScheduleFit';

  @override
  String get versione => 'Version: ';

  @override
  String get autore => 'Auteur: ';

  @override
  String get valutami => 'Évaluez-moi';

  @override
  String get politicaRiservatezza => 'Politique de confidentialité';

  @override
  String get cerca => 'Près';

  @override
  String get chiudi => 'Fermer';

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
  String get eliminaScheda => 'Supprimer l\'onglet';

  @override
  String get apriScheda => 'Onglet ouverte';

  @override
  String get serieCompletate => 'Série terminée: ';

  @override
  String get serieTotali => 'Série totale: ';

  @override
  String get confermaEliminaScheda => 'Êtes-vous sûr de vouloir supprimer l\'onglet?';

  @override
  String get si => 'Oui';

  @override
  String get annulla => 'Annuller';

  @override
  String get scegliGruppoMuscolare => 'Choisir un groupe musculaire';

  @override
  String nomeMuscolo(String nomeMuscolo) {
    String _temp0 = intl.Intl.selectLogic(
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
    return '$_temp0';
  }

  @override
  String get creaScheda => 'Créer une carte';

  @override
  String get modificaScheda => 'Modifier la carte';

  @override
  String get visualizzaScheda => 'Voir la carte';

  @override
  String get mioAllenamento => 'Mon entrainement';

  @override
  String get calendario => 'Calendrier';

  @override
  String get inserisciTitolo => 'Entrez le titre';

  @override
  String get aggiungiSerie => 'Ajouter une série';

  @override
  String get salva => 'Enregistrer';

  @override
  String serie(Object numero) {
    return 'Série $numero';
  }

  @override
  String get numeroRipetizioni => 'Nombre de répétitions';

  @override
  String get eliminaSerie => 'Supprimer la série';

  @override
  String get suggerimentoAggiungiScheda => 'Cliquez sur \'+\' pour ajouter un onglet';

  @override
  String get erroreCaricamentoSchede => 'Erreur lors du chargement des cartes';

  @override
  String get mese => 'Mois';

  @override
  String get anno => 'Année';

  @override
  String get nessunEsercizio => 'Pas d\'exercice';

  @override
  String get conferma => 'Confirmer';

  @override
  String get giorniAllenamento => 'Journées de entrainement';

  @override
  String get lunedi => 'lundi';

  @override
  String get martedi => 'mardi';

  @override
  String get mercoledi => 'mercredi';

  @override
  String get giovedi => 'jeudi';

  @override
  String get venerdi => 'vendredi';

  @override
  String get sabato => 'samedi';

  @override
  String get domenica => 'dimanche';

  @override
  String get ogni => 'Tous les';

  @override
  String get oggi => 'Aujourd\'hui';

  @override
  String get nonAssegnati => 'Non attribué';

  @override
  String get impostazioni => 'Paramètres';

  @override
  String get notifiche => 'Notifications';

  @override
  String get tema => 'Thème';

  @override
  String get inizioAllenamento => 'Commencer la formation';

  @override
  String get iniziaAllenamento => 'Démarrer la formation';

  @override
  String get sospendiAllenamento => 'Arrêter la formation';

  @override
  String get riprendiAllenamento => 'Reprendre la formation';

  @override
  String get terminaAllenamento => 'Fin de la formation';

  @override
  String get confermaTerminaAllenamento => 'Etes-vous sûr de vouloir mettre fin à l\'entraînement?';

  @override
  String get allenamentoInCorso => 'Formation en cours';

  @override
  String get sospendi => 'Arrêter';

  @override
  String get riprendi => 'Reprendre';

  @override
  String get termina => 'Fin';
}
