import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get info => 'Info';

  @override
  String get versione => 'Versión: ';

  @override
  String get autore => 'Autor: ';

  @override
  String get descrizioneApp => '¡Crea tus propios programas de entrenamiento para seguir tu progreso todos los días!';

  @override
  String get chiudi => 'CERCA';

  @override
  String get lingua => 'Idioma';

  @override
  String get italiano => 'Italian';

  @override
  String get inglese => 'Inglés';

  @override
  String get francese => 'Francés';

  @override
  String get spagnolo => 'Español';

  @override
  String get tedesco => 'Alemán';

  @override
  String get contatti => 'Contactos';

  @override
  String get instagram => 'Instagram';

  @override
  String get email => 'Email';

  @override
  String get sitoWeb => 'Sitio web';

  @override
  String get eliminaScheda => 'BORRAR TARJETA';

  @override
  String get eliminaSchedaDialog => 'Borrar tarjeta';

  @override
  String get apriScheda => 'ABRIR TARJETA';

  @override
  String get serieCompletate => 'Serie completa: ';

  @override
  String get confermaEliminaScheda => '¿Estás seguro de que deseas eliminar la tarjeta?';

  @override
  String get si => 'SÍ';

  @override
  String get annulla => 'CANCELAR';

  @override
  String get scegliGruppoMuscolare => 'Elegir grupo muscular';

  @override
  String nomeMuscolo(String nomeMuscolo) {
    String _temp0 = intl.Intl.selectLogic(
      nomeMuscolo,
      {
        'adduttori': 'Aductores',
        'bicipiti': 'Bíceps',
        'bicipitiFemorali': 'Isquiotibiales',
        'brachioradiale': 'Braquiorradial',
        'deltoidi': 'Deltoides',
        'dorsali': 'Dorsales',
        'glutei': 'Glúteos',
        'lombari': 'Lumbar',
        'obliquiEsterni': 'Oblicuos externos',
        'obliquiInterni': 'Oblicuos internos',
        'pettorali': 'Pectorales',
        'polpacci': 'Pantorrillas',
        'quadricipiti': 'Cuádriceps',
        'rettoAddominale': 'Recto abdominal',
        'trapezio': 'Trapecio',
        'tricipiti': 'Tríceps',
        'other': 'Otro',
      },
    );
    return '$_temp0';
  }

  @override
  String get creaScheda => 'Crear tarjeta';

  @override
  String get mioAllenamento => 'Mi entrenamiento';

  @override
  String get calendario => 'Calendario';

  @override
  String get inserisciTitolo => 'Introduce el título';

  @override
  String get aggiungiSerie => 'AÑADIR SERIE';

  @override
  String get salva => 'GUARDAR';

  @override
  String serie(Object numero) {
    return 'Serie $numero';
  }

  @override
  String get numeroRipetizioni => 'Número de repeticiones';

  @override
  String get eliminaSerie => 'ELIMINAR SERIE';
}
