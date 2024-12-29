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
  /// **'Info'**
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

  /// No description provided for @descrizioneApp.
  ///
  /// In it, this message translates to:
  /// **'Crea i tuoi programmi di allenamento  per tenere traccia ogni giorno dei tuoi progressi!'**
  String get descrizioneApp;

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
