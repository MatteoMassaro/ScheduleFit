import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it')
  ];

  /// No description provided for @info.
  ///
  /// In it, this message translates to:
  /// **'Circa ScheduleFit'**
  String get info;

  /// No description provided for @versione.
  ///
  /// In it, this message translates to:
  /// **'Versione: '**
  String get versione;

  /// No description provided for @autore.
  ///
  /// In it, this message translates to:
  /// **'Autore: '**
  String get autore;

  /// No description provided for @valutami.
  ///
  /// In it, this message translates to:
  /// **'Valutami'**
  String get valutami;

  /// No description provided for @politicaRiservatezza.
  ///
  /// In it, this message translates to:
  /// **'Politica sulla riservatezza'**
  String get politicaRiservatezza;

  /// No description provided for @cerca.
  ///
  /// In it, this message translates to:
  /// **'Cerca'**
  String get cerca;

  /// No description provided for @chiudi.
  ///
  /// In it, this message translates to:
  /// **'CHIUDI'**
  String get chiudi;

  /// No description provided for @lingua.
  ///
  /// In it, this message translates to:
  /// **'Lingua'**
  String get lingua;

  /// No description provided for @italiano.
  ///
  /// In it, this message translates to:
  /// **'Italiano'**
  String get italiano;

  /// No description provided for @inglese.
  ///
  /// In it, this message translates to:
  /// **'Inglese'**
  String get inglese;

  /// No description provided for @francese.
  ///
  /// In it, this message translates to:
  /// **'Francese'**
  String get francese;

  /// No description provided for @spagnolo.
  ///
  /// In it, this message translates to:
  /// **'Spagnolo'**
  String get spagnolo;

  /// No description provided for @tedesco.
  ///
  /// In it, this message translates to:
  /// **'Tedesco'**
  String get tedesco;

  /// No description provided for @contatti.
  ///
  /// In it, this message translates to:
  /// **'Contatti'**
  String get contatti;

  /// No description provided for @instagram.
  ///
  /// In it, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @email.
  ///
  /// In it, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @sitoWeb.
  ///
  /// In it, this message translates to:
  /// **'Sito web'**
  String get sitoWeb;

  /// No description provided for @eliminaScheda.
  ///
  /// In it, this message translates to:
  /// **'ELIMINA SCHEDA'**
  String get eliminaScheda;

  /// No description provided for @eliminaSchedaDialog.
  ///
  /// In it, this message translates to:
  /// **'Elimina scheda'**
  String get eliminaSchedaDialog;

  /// No description provided for @apriScheda.
  ///
  /// In it, this message translates to:
  /// **'APRI SCHEDA'**
  String get apriScheda;

  /// No description provided for @serieCompletate.
  ///
  /// In it, this message translates to:
  /// **'Serie completate: '**
  String get serieCompletate;

  /// No description provided for @serieTotali.
  ///
  /// In it, this message translates to:
  /// **'Serie totali: '**
  String get serieTotali;

  /// No description provided for @confermaEliminaScheda.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare la scheda?'**
  String get confermaEliminaScheda;

  /// No description provided for @si.
  ///
  /// In it, this message translates to:
  /// **'SI'**
  String get si;

  /// No description provided for @annulla.
  ///
  /// In it, this message translates to:
  /// **'ANNULLA'**
  String get annulla;

  /// No description provided for @scegliGruppoMuscolare.
  ///
  /// In it, this message translates to:
  /// **'Scegli gruppo muscolare'**
  String get scegliGruppoMuscolare;

  /// No description provided for @nomeMuscolo.
  ///
  /// In it, this message translates to:
  /// **'{nomeMuscolo, select, adduttori {Adduttori} bicipiti {Bicipiti} bicipitiFemorali {Bicipiti femorali} brachioradiale {Brachioradiale} deltoidi {Deltoidi} dorsali {Dorsali} glutei {Glutei} lombari {Lombari} obliquiEsterni {Obliqui esterni} obliquiInterni {Obliqui interni} pettorali {Pettorali} polpacci {Polpacci} quadricipiti {Quadricipiti} rettoAddominale {Retto addominale} trapezio {Trapezio} tricipiti {Tricipiti} other {Altro}}'**
  String nomeMuscolo(String nomeMuscolo);

  /// No description provided for @creaScheda.
  ///
  /// In it, this message translates to:
  /// **'Crea scheda'**
  String get creaScheda;

  /// No description provided for @modificaScheda.
  ///
  /// In it, this message translates to:
  /// **'Modifica scheda'**
  String get modificaScheda;

  /// No description provided for @visualizzaScheda.
  ///
  /// In it, this message translates to:
  /// **'Visualizza scheda'**
  String get visualizzaScheda;

  /// No description provided for @mioAllenamento.
  ///
  /// In it, this message translates to:
  /// **'Il mio allenamento'**
  String get mioAllenamento;

  /// No description provided for @calendario.
  ///
  /// In it, this message translates to:
  /// **'Calendario'**
  String get calendario;

  /// No description provided for @inserisciTitolo.
  ///
  /// In it, this message translates to:
  /// **'Inserisci titolo'**
  String get inserisciTitolo;

  /// No description provided for @aggiungiSerie.
  ///
  /// In it, this message translates to:
  /// **'AGGIUNGI SERIE'**
  String get aggiungiSerie;

  /// No description provided for @salva.
  ///
  /// In it, this message translates to:
  /// **'SALVA'**
  String get salva;

  /// No description provided for @serie.
  ///
  /// In it, this message translates to:
  /// **'Serie {numero}'**
  String serie(Object numero);

  /// No description provided for @numeroRipetizioni.
  ///
  /// In it, this message translates to:
  /// **'Numero ripetizioni'**
  String get numeroRipetizioni;

  /// No description provided for @eliminaSerie.
  ///
  /// In it, this message translates to:
  /// **'ELIMINA SERIE'**
  String get eliminaSerie;

  /// No description provided for @suggerimentoAggiungiScheda.
  ///
  /// In it, this message translates to:
  /// **'Clicca su \'+\' per aggiungere una scheda'**
  String get suggerimentoAggiungiScheda;

  /// No description provided for @erroreCaricamentoSchede.
  ///
  /// In it, this message translates to:
  /// **'Errore nel caricamento delle schede'**
  String get erroreCaricamentoSchede;

  /// No description provided for @mese.
  ///
  /// In it, this message translates to:
  /// **'Mese'**
  String get mese;

  /// No description provided for @anno.
  ///
  /// In it, this message translates to:
  /// **'Anno'**
  String get anno;

  /// No description provided for @nessunEsercizio.
  ///
  /// In it, this message translates to:
  /// **'Nessun esercizio'**
  String get nessunEsercizio;

  /// No description provided for @conferma.
  ///
  /// In it, this message translates to:
  /// **'CONFERMA'**
  String get conferma;

  /// No description provided for @giorniAllenamento.
  ///
  /// In it, this message translates to:
  /// **'Giorni dell\'allenamento'**
  String get giorniAllenamento;

  /// No description provided for @lunedi.
  ///
  /// In it, this message translates to:
  /// **'lunedì'**
  String get lunedi;

  /// No description provided for @martedi.
  ///
  /// In it, this message translates to:
  /// **'martedì'**
  String get martedi;

  /// No description provided for @mercoledi.
  ///
  /// In it, this message translates to:
  /// **'mercoledì'**
  String get mercoledi;

  /// No description provided for @giovedi.
  ///
  /// In it, this message translates to:
  /// **'giovedì'**
  String get giovedi;

  /// No description provided for @venerdi.
  ///
  /// In it, this message translates to:
  /// **'venerdì'**
  String get venerdi;

  /// No description provided for @sabato.
  ///
  /// In it, this message translates to:
  /// **'sabato'**
  String get sabato;

  /// No description provided for @domenica.
  ///
  /// In it, this message translates to:
  /// **'domenica'**
  String get domenica;

  /// No description provided for @ogni.
  ///
  /// In it, this message translates to:
  /// **'Ogni'**
  String get ogni;

  /// No description provided for @oggi.
  ///
  /// In it, this message translates to:
  /// **'Oggi'**
  String get oggi;

  /// No description provided for @nonAssegnati.
  ///
  /// In it, this message translates to:
  /// **'Non assegnati'**
  String get nonAssegnati;

  /// No description provided for @impostazioni.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get impostazioni;

  /// No description provided for @notifiche.
  ///
  /// In it, this message translates to:
  /// **'Notifiche'**
  String get notifiche;

  /// No description provided for @tema.
  ///
  /// In it, this message translates to:
  /// **'Tema'**
  String get tema;

  /// No description provided for @inizioAllenamento.
  ///
  /// In it, this message translates to:
  /// **'INIZIO ALLENAMENTO'**
  String get inizioAllenamento;

  /// No description provided for @iniziaAllenamento.
  ///
  /// In it, this message translates to:
  /// **'INIZIA ALLENAMENTO'**
  String get iniziaAllenamento;

  /// No description provided for @sospendiAllenamento.
  ///
  /// In it, this message translates to:
  /// **'SOSPENDI ALLENAMENTO'**
  String get sospendiAllenamento;

  /// No description provided for @riprendiAllenamento.
  ///
  /// In it, this message translates to:
  /// **'RIPRENDI ALLENAMENTO'**
  String get riprendiAllenamento;

  /// No description provided for @terminaAllenamento.
  ///
  /// In it, this message translates to:
  /// **'TERMINA ALLENAMENTO'**
  String get terminaAllenamento;

  /// No description provided for @confermaTerminaAllenamento.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler terminare l\'allenamento?'**
  String get confermaTerminaAllenamento;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
