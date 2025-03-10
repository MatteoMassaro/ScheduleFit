import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get info => 'Acerca de ScheduleFit';

  @override
  String get versione => 'Versión: ';

  @override
  String get autore => 'Autor: ';

  @override
  String get valutami => 'Califícame';

  @override
  String get politicaRiservatezza => 'Política de privacidad';

  @override
  String get cerca => 'Buscar';

  @override
  String get chiudi => 'Cerca';

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
  String get eliminaScheda => 'Borrar tarjeta';

  @override
  String get apriScheda => 'Abrir tarjeta';

  @override
  String get serieCompletate => 'Serie completa: ';

  @override
  String get serieTotali => 'Serie total: ';

  @override
  String get confermaEliminaScheda => '¿Estás seguro de que deseas eliminar la tarjeta?';

  @override
  String get si => 'Sí';

  @override
  String get annulla => 'Cancelar';

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
  String get modificaScheda => 'Editar tarjeta';

  @override
  String get visualizzaScheda => 'Ver tarjeta';

  @override
  String get mioAllenamento => 'Mi entrenamiento';

  @override
  String get calendario => 'Calendario';

  @override
  String get inserisciTitolo => 'Introduce el título';

  @override
  String get aggiungiSerie => 'Añadir serie';

  @override
  String get salva => 'Guardar';

  @override
  String serie(Object numero) {
    return 'Serie $numero';
  }

  @override
  String get numeroRipetizioni => 'Número de repeticiones';

  @override
  String get eliminaSerie => 'Eliminar serie';

  @override
  String get suggerimentoAggiungiScheda => 'Haga clic en \'+\' para agregar una tarjeta';

  @override
  String get erroreCaricamentoSchede => 'Error al cargar tarjetas';

  @override
  String get mese => 'Mes';

  @override
  String get anno => 'Año';

  @override
  String get nessunEsercizio => 'Sin ejercicio';

  @override
  String get conferma => 'Confirma';

  @override
  String get giorniAllenamento => 'Jornadas de entrenamiento';

  @override
  String get lunedi => 'lunes';

  @override
  String get martedi => 'martes';

  @override
  String get mercoledi => 'miércoles';

  @override
  String get giovedi => 'jueves';

  @override
  String get venerdi => 'viernes';

  @override
  String get sabato => 'sábado';

  @override
  String get domenica => 'domingo';

  @override
  String get ogni => 'Todos los';

  @override
  String get oggi => 'Hoy';

  @override
  String get nonAssegnati => 'No asignado';

  @override
  String get impostazioni => 'Ajustes';

  @override
  String get notifiche => 'Notificaciones';

  @override
  String get tema => 'Tema';

  @override
  String get inizioAllenamento => 'Comenzar a entrenar';

  @override
  String get iniziaAllenamento => 'Iniciar entrenamiento';

  @override
  String get sospendiAllenamento => 'Suspender entrenamiento';

  @override
  String get riprendiAllenamento => 'Reanudar entrenamiento';

  @override
  String get terminaAllenamento => 'Finalizar entrenamiento';

  @override
  String get confermaTerminaAllenamento => '¿Estás seguro de que quieres finalizar el entrenamiento?';

  @override
  String get allenamentoInCorso => 'Entrenamiento en progreso';

  @override
  String get sospendi => 'Suspender';

  @override
  String get riprendi => 'Reanudar';

  @override
  String get termina => 'Finalizar';
}
