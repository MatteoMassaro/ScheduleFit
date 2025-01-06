// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_fit_database.dart';

// ignore_for_file: type=lint
class $ExerciseInfoTable extends ExerciseInfo
    with TableInfo<$ExerciseInfoTable, ExerciseInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeEsercizioMeta =
      const VerificationMeta('nomeEsercizio');
  @override
  late final GeneratedColumn<String> nomeEsercizio = GeneratedColumn<String>(
      'nome_esercizio', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoriaEsercizioMeta =
      const VerificationMeta('categoriaEsercizio');
  @override
  late final GeneratedColumn<String> categoriaEsercizio =
      GeneratedColumn<String>('categoria_esercizio', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 50),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _immagineMeta =
      const VerificationMeta('immagine');
  @override
  late final GeneratedColumn<String> immagine = GeneratedColumn<String>(
      'immagine', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _serieTotaliMeta =
      const VerificationMeta('serieTotali');
  @override
  late final GeneratedColumn<int> serieTotali = GeneratedColumn<int>(
      'serie_totali', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _serieCompletateMeta =
      const VerificationMeta('serieCompletate');
  @override
  late final GeneratedColumn<int> serieCompletate = GeneratedColumn<int>(
      'serie_completate', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _giorniSettimanaMeta =
      const VerificationMeta('giorniSettimana');
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String>
      giorniSettimana = GeneratedColumn<String>(
              'giorni_settimana', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<int>>(
              $ExerciseInfoTable.$convertergiorniSettimana);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nomeEsercizio,
        categoriaEsercizio,
        immagine,
        serieTotali,
        serieCompletate,
        giorniSettimana,
        data
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_info';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome_esercizio')) {
      context.handle(
          _nomeEsercizioMeta,
          nomeEsercizio.isAcceptableOrUnknown(
              data['nome_esercizio']!, _nomeEsercizioMeta));
    } else if (isInserting) {
      context.missing(_nomeEsercizioMeta);
    }
    if (data.containsKey('categoria_esercizio')) {
      context.handle(
          _categoriaEsercizioMeta,
          categoriaEsercizio.isAcceptableOrUnknown(
              data['categoria_esercizio']!, _categoriaEsercizioMeta));
    } else if (isInserting) {
      context.missing(_categoriaEsercizioMeta);
    }
    if (data.containsKey('immagine')) {
      context.handle(_immagineMeta,
          immagine.isAcceptableOrUnknown(data['immagine']!, _immagineMeta));
    } else if (isInserting) {
      context.missing(_immagineMeta);
    }
    if (data.containsKey('serie_totali')) {
      context.handle(
          _serieTotaliMeta,
          serieTotali.isAcceptableOrUnknown(
              data['serie_totali']!, _serieTotaliMeta));
    }
    if (data.containsKey('serie_completate')) {
      context.handle(
          _serieCompletateMeta,
          serieCompletate.isAcceptableOrUnknown(
              data['serie_completate']!, _serieCompletateMeta));
    }
    context.handle(_giorniSettimanaMeta, const VerificationResult.success());
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseInfoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      nomeEsercizio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_esercizio'])!,
      categoriaEsercizio: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}categoria_esercizio'])!,
      immagine: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}immagine'])!,
      serieTotali: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}serie_totali'])!,
      serieCompletate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}serie_completate'])!,
      giorniSettimana: $ExerciseInfoTable.$convertergiorniSettimana.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}giorni_settimana'])!),
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
    );
  }

  @override
  $ExerciseInfoTable createAlias(String alias) {
    return $ExerciseInfoTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $convertergiorniSettimana =
      const IntegerListConverter();
}

class ExerciseInfoData extends DataClass
    implements Insertable<ExerciseInfoData> {
  int? id;
  String nomeEsercizio;
  String categoriaEsercizio;
  String immagine;
  int serieTotali;
  int serieCompletate;
  List<int> giorniSettimana;
  DateTime data;
  ExerciseInfoData(
      {this.id,
      required this.nomeEsercizio,
      required this.categoriaEsercizio,
      required this.immagine,
      required this.serieTotali,
      required this.serieCompletate,
      required this.giorniSettimana,
      required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['nome_esercizio'] = Variable<String>(nomeEsercizio);
    map['categoria_esercizio'] = Variable<String>(categoriaEsercizio);
    map['immagine'] = Variable<String>(immagine);
    map['serie_totali'] = Variable<int>(serieTotali);
    map['serie_completate'] = Variable<int>(serieCompletate);
    {
      map['giorni_settimana'] = Variable<String>(
          $ExerciseInfoTable.$convertergiorniSettimana.toSql(giorniSettimana));
    }
    map['data'] = Variable<DateTime>(data);
    return map;
  }

  ExerciseInfoCompanion toCompanion(bool nullToAbsent) {
    return ExerciseInfoCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nomeEsercizio: Value(nomeEsercizio),
      categoriaEsercizio: Value(categoriaEsercizio),
      immagine: Value(immagine),
      serieTotali: Value(serieTotali),
      serieCompletate: Value(serieCompletate),
      giorniSettimana: Value(giorniSettimana),
      data: Value(data),
    );
  }

  factory ExerciseInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseInfoData(
      id: serializer.fromJson<int?>(json['id']),
      nomeEsercizio: serializer.fromJson<String>(json['nomeEsercizio']),
      categoriaEsercizio:
          serializer.fromJson<String>(json['categoriaEsercizio']),
      immagine: serializer.fromJson<String>(json['immagine']),
      serieTotali: serializer.fromJson<int>(json['serieTotali']),
      serieCompletate: serializer.fromJson<int>(json['serieCompletate']),
      giorniSettimana: serializer.fromJson<List<int>>(json['giorniSettimana']),
      data: serializer.fromJson<DateTime>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'nomeEsercizio': serializer.toJson<String>(nomeEsercizio),
      'categoriaEsercizio': serializer.toJson<String>(categoriaEsercizio),
      'immagine': serializer.toJson<String>(immagine),
      'serieTotali': serializer.toJson<int>(serieTotali),
      'serieCompletate': serializer.toJson<int>(serieCompletate),
      'giorniSettimana': serializer.toJson<List<int>>(giorniSettimana),
      'data': serializer.toJson<DateTime>(data),
    };
  }

  ExerciseInfoData copyWith(
          {Value<int?> id = const Value.absent(),
          String? nomeEsercizio,
          String? categoriaEsercizio,
          String? immagine,
          int? serieTotali,
          int? serieCompletate,
          List<int>? giorniSettimana,
          DateTime? data}) =>
      ExerciseInfoData(
        id: id.present ? id.value : this.id,
        nomeEsercizio: nomeEsercizio ?? this.nomeEsercizio,
        categoriaEsercizio: categoriaEsercizio ?? this.categoriaEsercizio,
        immagine: immagine ?? this.immagine,
        serieTotali: serieTotali ?? this.serieTotali,
        serieCompletate: serieCompletate ?? this.serieCompletate,
        giorniSettimana: giorniSettimana ?? this.giorniSettimana,
        data: data ?? this.data,
      );
  ExerciseInfoData copyWithCompanion(ExerciseInfoCompanion data) {
    return ExerciseInfoData(
      id: data.id.present ? data.id.value : this.id,
      nomeEsercizio: data.nomeEsercizio.present
          ? data.nomeEsercizio.value
          : this.nomeEsercizio,
      categoriaEsercizio: data.categoriaEsercizio.present
          ? data.categoriaEsercizio.value
          : this.categoriaEsercizio,
      immagine: data.immagine.present ? data.immagine.value : this.immagine,
      serieTotali:
          data.serieTotali.present ? data.serieTotali.value : this.serieTotali,
      serieCompletate: data.serieCompletate.present
          ? data.serieCompletate.value
          : this.serieCompletate,
      giorniSettimana: data.giorniSettimana.present
          ? data.giorniSettimana.value
          : this.giorniSettimana,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseInfoData(')
          ..write('id: $id, ')
          ..write('nomeEsercizio: $nomeEsercizio, ')
          ..write('categoriaEsercizio: $categoriaEsercizio, ')
          ..write('immagine: $immagine, ')
          ..write('serieTotali: $serieTotali, ')
          ..write('serieCompletate: $serieCompletate, ')
          ..write('giorniSettimana: $giorniSettimana, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nomeEsercizio, categoriaEsercizio,
      immagine, serieTotali, serieCompletate, giorniSettimana, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseInfoData &&
          other.id == this.id &&
          other.nomeEsercizio == this.nomeEsercizio &&
          other.categoriaEsercizio == this.categoriaEsercizio &&
          other.immagine == this.immagine &&
          other.serieTotali == this.serieTotali &&
          other.serieCompletate == this.serieCompletate &&
          other.giorniSettimana == this.giorniSettimana &&
          other.data == this.data);
}

class ExerciseInfoCompanion extends UpdateCompanion<ExerciseInfoData> {
  Value<int?> id;
  Value<String> nomeEsercizio;
  Value<String> categoriaEsercizio;
  Value<String> immagine;
  Value<int> serieTotali;
  Value<int> serieCompletate;
  Value<List<int>> giorniSettimana;
  Value<DateTime> data;
  ExerciseInfoCompanion({
    this.id = const Value.absent(),
    this.nomeEsercizio = const Value.absent(),
    this.categoriaEsercizio = const Value.absent(),
    this.immagine = const Value.absent(),
    this.serieTotali = const Value.absent(),
    this.serieCompletate = const Value.absent(),
    this.giorniSettimana = const Value.absent(),
    this.data = const Value.absent(),
  });
  ExerciseInfoCompanion.insert({
    this.id = const Value.absent(),
    required String nomeEsercizio,
    required String categoriaEsercizio,
    required String immagine,
    this.serieTotali = const Value.absent(),
    this.serieCompletate = const Value.absent(),
    required List<int> giorniSettimana,
    this.data = const Value.absent(),
  })  : nomeEsercizio = Value(nomeEsercizio),
        categoriaEsercizio = Value(categoriaEsercizio),
        immagine = Value(immagine),
        giorniSettimana = Value(giorniSettimana);
  static Insertable<ExerciseInfoData> custom({
    Expression<int>? id,
    Expression<String>? nomeEsercizio,
    Expression<String>? categoriaEsercizio,
    Expression<String>? immagine,
    Expression<int>? serieTotali,
    Expression<int>? serieCompletate,
    Expression<String>? giorniSettimana,
    Expression<DateTime>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nomeEsercizio != null) 'nome_esercizio': nomeEsercizio,
      if (categoriaEsercizio != null) 'categoria_esercizio': categoriaEsercizio,
      if (immagine != null) 'immagine': immagine,
      if (serieTotali != null) 'serie_totali': serieTotali,
      if (serieCompletate != null) 'serie_completate': serieCompletate,
      if (giorniSettimana != null) 'giorni_settimana': giorniSettimana,
      if (data != null) 'data': data,
    });
  }

  ExerciseInfoCompanion copyWith(
      {Value<int?>? id,
      Value<String>? nomeEsercizio,
      Value<String>? categoriaEsercizio,
      Value<String>? immagine,
      Value<int>? serieTotali,
      Value<int>? serieCompletate,
      Value<List<int>>? giorniSettimana,
      Value<DateTime>? data}) {
    return ExerciseInfoCompanion(
      id: id ?? this.id,
      nomeEsercizio: nomeEsercizio ?? this.nomeEsercizio,
      categoriaEsercizio: categoriaEsercizio ?? this.categoriaEsercizio,
      immagine: immagine ?? this.immagine,
      serieTotali: serieTotali ?? this.serieTotali,
      serieCompletate: serieCompletate ?? this.serieCompletate,
      giorniSettimana: giorniSettimana ?? this.giorniSettimana,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nomeEsercizio.present) {
      map['nome_esercizio'] = Variable<String>(nomeEsercizio.value);
    }
    if (categoriaEsercizio.present) {
      map['categoria_esercizio'] = Variable<String>(categoriaEsercizio.value);
    }
    if (immagine.present) {
      map['immagine'] = Variable<String>(immagine.value);
    }
    if (serieTotali.present) {
      map['serie_totali'] = Variable<int>(serieTotali.value);
    }
    if (serieCompletate.present) {
      map['serie_completate'] = Variable<int>(serieCompletate.value);
    }
    if (giorniSettimana.present) {
      map['giorni_settimana'] = Variable<String>($ExerciseInfoTable
          .$convertergiorniSettimana
          .toSql(giorniSettimana.value));
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseInfoCompanion(')
          ..write('id: $id, ')
          ..write('nomeEsercizio: $nomeEsercizio, ')
          ..write('categoriaEsercizio: $categoriaEsercizio, ')
          ..write('immagine: $immagine, ')
          ..write('serieTotali: $serieTotali, ')
          ..write('serieCompletate: $serieCompletate, ')
          ..write('giorniSettimana: $giorniSettimana, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $SeriesInfoTable extends SeriesInfo
    with TableInfo<$SeriesInfoTable, SeriesInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeriesInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idEsercizioMeta =
      const VerificationMeta('idEsercizio');
  @override
  late final GeneratedColumn<int> idEsercizio = GeneratedColumn<int>(
      'id_esercizio', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exercise_info (id)'));
  static const VerificationMeta _ripetizioniMeta =
      const VerificationMeta('ripetizioni');
  @override
  late final GeneratedColumn<int> ripetizioni = GeneratedColumn<int>(
      'ripetizioni', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _pesoMeta = const VerificationMeta('peso');
  @override
  late final GeneratedColumn<double> peso = GeneratedColumn<double>(
      'peso', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _unitaMisuraMeta =
      const VerificationMeta('unitaMisura');
  @override
  late final GeneratedColumn<String> unitaMisura = GeneratedColumn<String>(
      'unita_misura', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _completataMeta =
      const VerificationMeta('completata');
  @override
  late final GeneratedColumn<bool> completata = GeneratedColumn<bool>(
      'completata', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completata" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, idEsercizio, ripetizioni, peso, unitaMisura, completata];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'series_info';
  @override
  VerificationContext validateIntegrity(Insertable<SeriesInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_esercizio')) {
      context.handle(
          _idEsercizioMeta,
          idEsercizio.isAcceptableOrUnknown(
              data['id_esercizio']!, _idEsercizioMeta));
    }
    if (data.containsKey('ripetizioni')) {
      context.handle(
          _ripetizioniMeta,
          ripetizioni.isAcceptableOrUnknown(
              data['ripetizioni']!, _ripetizioniMeta));
    }
    if (data.containsKey('peso')) {
      context.handle(
          _pesoMeta, peso.isAcceptableOrUnknown(data['peso']!, _pesoMeta));
    }
    if (data.containsKey('unita_misura')) {
      context.handle(
          _unitaMisuraMeta,
          unitaMisura.isAcceptableOrUnknown(
              data['unita_misura']!, _unitaMisuraMeta));
    } else if (isInserting) {
      context.missing(_unitaMisuraMeta);
    }
    if (data.containsKey('completata')) {
      context.handle(
          _completataMeta,
          completata.isAcceptableOrUnknown(
              data['completata']!, _completataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SeriesInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeriesInfoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      idEsercizio: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_esercizio']),
      ripetizioni: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ripetizioni'])!,
      peso: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}peso'])!,
      unitaMisura: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unita_misura'])!,
      completata: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completata'])!,
    );
  }

  @override
  $SeriesInfoTable createAlias(String alias) {
    return $SeriesInfoTable(attachedDatabase, alias);
  }
}

class SeriesInfoData extends DataClass implements Insertable<SeriesInfoData> {
  int? id;
  int? idEsercizio;
  int ripetizioni;
  double peso;
  String unitaMisura;
  bool completata;
  SeriesInfoData(
      {this.id,
      this.idEsercizio,
      required this.ripetizioni,
      required this.peso,
      required this.unitaMisura,
      required this.completata});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || idEsercizio != null) {
      map['id_esercizio'] = Variable<int>(idEsercizio);
    }
    map['ripetizioni'] = Variable<int>(ripetizioni);
    map['peso'] = Variable<double>(peso);
    map['unita_misura'] = Variable<String>(unitaMisura);
    map['completata'] = Variable<bool>(completata);
    return map;
  }

  SeriesInfoCompanion toCompanion(bool nullToAbsent) {
    return SeriesInfoCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idEsercizio: idEsercizio == null && nullToAbsent
          ? const Value.absent()
          : Value(idEsercizio),
      ripetizioni: Value(ripetizioni),
      peso: Value(peso),
      unitaMisura: Value(unitaMisura),
      completata: Value(completata),
    );
  }

  factory SeriesInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeriesInfoData(
      id: serializer.fromJson<int?>(json['id']),
      idEsercizio: serializer.fromJson<int?>(json['idEsercizio']),
      ripetizioni: serializer.fromJson<int>(json['ripetizioni']),
      peso: serializer.fromJson<double>(json['peso']),
      unitaMisura: serializer.fromJson<String>(json['unitaMisura']),
      completata: serializer.fromJson<bool>(json['completata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idEsercizio': serializer.toJson<int?>(idEsercizio),
      'ripetizioni': serializer.toJson<int>(ripetizioni),
      'peso': serializer.toJson<double>(peso),
      'unitaMisura': serializer.toJson<String>(unitaMisura),
      'completata': serializer.toJson<bool>(completata),
    };
  }

  SeriesInfoData copyWith(
          {Value<int?> id = const Value.absent(),
          Value<int?> idEsercizio = const Value.absent(),
          int? ripetizioni,
          double? peso,
          String? unitaMisura,
          bool? completata}) =>
      SeriesInfoData(
        id: id.present ? id.value : this.id,
        idEsercizio: idEsercizio.present ? idEsercizio.value : this.idEsercizio,
        ripetizioni: ripetizioni ?? this.ripetizioni,
        peso: peso ?? this.peso,
        unitaMisura: unitaMisura ?? this.unitaMisura,
        completata: completata ?? this.completata,
      );
  SeriesInfoData copyWithCompanion(SeriesInfoCompanion data) {
    return SeriesInfoData(
      id: data.id.present ? data.id.value : this.id,
      idEsercizio:
          data.idEsercizio.present ? data.idEsercizio.value : this.idEsercizio,
      ripetizioni:
          data.ripetizioni.present ? data.ripetizioni.value : this.ripetizioni,
      peso: data.peso.present ? data.peso.value : this.peso,
      unitaMisura:
          data.unitaMisura.present ? data.unitaMisura.value : this.unitaMisura,
      completata:
          data.completata.present ? data.completata.value : this.completata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeriesInfoData(')
          ..write('id: $id, ')
          ..write('idEsercizio: $idEsercizio, ')
          ..write('ripetizioni: $ripetizioni, ')
          ..write('peso: $peso, ')
          ..write('unitaMisura: $unitaMisura, ')
          ..write('completata: $completata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, idEsercizio, ripetizioni, peso, unitaMisura, completata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeriesInfoData &&
          other.id == this.id &&
          other.idEsercizio == this.idEsercizio &&
          other.ripetizioni == this.ripetizioni &&
          other.peso == this.peso &&
          other.unitaMisura == this.unitaMisura &&
          other.completata == this.completata);
}

class SeriesInfoCompanion extends UpdateCompanion<SeriesInfoData> {
  Value<int?> id;
  Value<int?> idEsercizio;
  Value<int> ripetizioni;
  Value<double> peso;
  Value<String> unitaMisura;
  Value<bool> completata;
  SeriesInfoCompanion({
    this.id = const Value.absent(),
    this.idEsercizio = const Value.absent(),
    this.ripetizioni = const Value.absent(),
    this.peso = const Value.absent(),
    this.unitaMisura = const Value.absent(),
    this.completata = const Value.absent(),
  });
  SeriesInfoCompanion.insert({
    this.id = const Value.absent(),
    this.idEsercizio = const Value.absent(),
    this.ripetizioni = const Value.absent(),
    this.peso = const Value.absent(),
    required String unitaMisura,
    this.completata = const Value.absent(),
  }) : unitaMisura = Value(unitaMisura);
  static Insertable<SeriesInfoData> custom({
    Expression<int>? id,
    Expression<int>? idEsercizio,
    Expression<int>? ripetizioni,
    Expression<double>? peso,
    Expression<String>? unitaMisura,
    Expression<bool>? completata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idEsercizio != null) 'id_esercizio': idEsercizio,
      if (ripetizioni != null) 'ripetizioni': ripetizioni,
      if (peso != null) 'peso': peso,
      if (unitaMisura != null) 'unita_misura': unitaMisura,
      if (completata != null) 'completata': completata,
    });
  }

  SeriesInfoCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? idEsercizio,
      Value<int>? ripetizioni,
      Value<double>? peso,
      Value<String>? unitaMisura,
      Value<bool>? completata}) {
    return SeriesInfoCompanion(
      id: id ?? this.id,
      idEsercizio: idEsercizio ?? this.idEsercizio,
      ripetizioni: ripetizioni ?? this.ripetizioni,
      peso: peso ?? this.peso,
      unitaMisura: unitaMisura ?? this.unitaMisura,
      completata: completata ?? this.completata,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idEsercizio.present) {
      map['id_esercizio'] = Variable<int>(idEsercizio.value);
    }
    if (ripetizioni.present) {
      map['ripetizioni'] = Variable<int>(ripetizioni.value);
    }
    if (peso.present) {
      map['peso'] = Variable<double>(peso.value);
    }
    if (unitaMisura.present) {
      map['unita_misura'] = Variable<String>(unitaMisura.value);
    }
    if (completata.present) {
      map['completata'] = Variable<bool>(completata.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesInfoCompanion(')
          ..write('id: $id, ')
          ..write('idEsercizio: $idEsercizio, ')
          ..write('ripetizioni: $ripetizioni, ')
          ..write('peso: $peso, ')
          ..write('unitaMisura: $unitaMisura, ')
          ..write('completata: $completata')
          ..write(')'))
        .toString();
  }
}

abstract class _$ScheduleFitDatabase extends GeneratedDatabase {
  _$ScheduleFitDatabase(QueryExecutor e) : super(e);
  $ScheduleFitDatabaseManager get managers => $ScheduleFitDatabaseManager(this);
  late final $ExerciseInfoTable exerciseInfo = $ExerciseInfoTable(this);
  late final $SeriesInfoTable seriesInfo = $SeriesInfoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [exerciseInfo, seriesInfo];
}

typedef $$ExerciseInfoTableCreateCompanionBuilder = ExerciseInfoCompanion
    Function({
  Value<int?> id,
  required String nomeEsercizio,
  required String categoriaEsercizio,
  required String immagine,
  Value<int> serieTotali,
  Value<int> serieCompletate,
  required List<int> giorniSettimana,
  Value<DateTime> data,
});
typedef $$ExerciseInfoTableUpdateCompanionBuilder = ExerciseInfoCompanion
    Function({
  Value<int?> id,
  Value<String> nomeEsercizio,
  Value<String> categoriaEsercizio,
  Value<String> immagine,
  Value<int> serieTotali,
  Value<int> serieCompletate,
  Value<List<int>> giorniSettimana,
  Value<DateTime> data,
});

final class $$ExerciseInfoTableReferences extends BaseReferences<
    _$ScheduleFitDatabase, $ExerciseInfoTable, ExerciseInfoData> {
  $$ExerciseInfoTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SeriesInfoTable, List<SeriesInfoData>>
      _seriesInfoRefsTable(_$ScheduleFitDatabase db) =>
          MultiTypedResultKey.fromTable(db.seriesInfo,
              aliasName: $_aliasNameGenerator(
                  db.exerciseInfo.id, db.seriesInfo.idEsercizio));

  $$SeriesInfoTableProcessedTableManager get seriesInfoRefs {
    final manager = $$SeriesInfoTableTableManager($_db, $_db.seriesInfo)
        .filter((f) => f.idEsercizio.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_seriesInfoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExerciseInfoTableFilterComposer
    extends Composer<_$ScheduleFitDatabase, $ExerciseInfoTable> {
  $$ExerciseInfoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeEsercizio => $composableBuilder(
      column: $table.nomeEsercizio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoriaEsercizio => $composableBuilder(
      column: $table.categoriaEsercizio,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get immagine => $composableBuilder(
      column: $table.immagine, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get serieTotali => $composableBuilder(
      column: $table.serieTotali, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get serieCompletate => $composableBuilder(
      column: $table.serieCompletate,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
      get giorniSettimana => $composableBuilder(
          column: $table.giorniSettimana,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  Expression<bool> seriesInfoRefs(
      Expression<bool> Function($$SeriesInfoTableFilterComposer f) f) {
    final $$SeriesInfoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.seriesInfo,
        getReferencedColumn: (t) => t.idEsercizio,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SeriesInfoTableFilterComposer(
              $db: $db,
              $table: $db.seriesInfo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExerciseInfoTableOrderingComposer
    extends Composer<_$ScheduleFitDatabase, $ExerciseInfoTable> {
  $$ExerciseInfoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeEsercizio => $composableBuilder(
      column: $table.nomeEsercizio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoriaEsercizio => $composableBuilder(
      column: $table.categoriaEsercizio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get immagine => $composableBuilder(
      column: $table.immagine, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get serieTotali => $composableBuilder(
      column: $table.serieTotali, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get serieCompletate => $composableBuilder(
      column: $table.serieCompletate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get giorniSettimana => $composableBuilder(
      column: $table.giorniSettimana,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));
}

class $$ExerciseInfoTableAnnotationComposer
    extends Composer<_$ScheduleFitDatabase, $ExerciseInfoTable> {
  $$ExerciseInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomeEsercizio => $composableBuilder(
      column: $table.nomeEsercizio, builder: (column) => column);

  GeneratedColumn<String> get categoriaEsercizio => $composableBuilder(
      column: $table.categoriaEsercizio, builder: (column) => column);

  GeneratedColumn<String> get immagine =>
      $composableBuilder(column: $table.immagine, builder: (column) => column);

  GeneratedColumn<int> get serieTotali => $composableBuilder(
      column: $table.serieTotali, builder: (column) => column);

  GeneratedColumn<int> get serieCompletate => $composableBuilder(
      column: $table.serieCompletate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>, String> get giorniSettimana =>
      $composableBuilder(
          column: $table.giorniSettimana, builder: (column) => column);

  GeneratedColumn<DateTime> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  Expression<T> seriesInfoRefs<T extends Object>(
      Expression<T> Function($$SeriesInfoTableAnnotationComposer a) f) {
    final $$SeriesInfoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.seriesInfo,
        getReferencedColumn: (t) => t.idEsercizio,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SeriesInfoTableAnnotationComposer(
              $db: $db,
              $table: $db.seriesInfo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExerciseInfoTableTableManager extends RootTableManager<
    _$ScheduleFitDatabase,
    $ExerciseInfoTable,
    ExerciseInfoData,
    $$ExerciseInfoTableFilterComposer,
    $$ExerciseInfoTableOrderingComposer,
    $$ExerciseInfoTableAnnotationComposer,
    $$ExerciseInfoTableCreateCompanionBuilder,
    $$ExerciseInfoTableUpdateCompanionBuilder,
    (ExerciseInfoData, $$ExerciseInfoTableReferences),
    ExerciseInfoData,
    PrefetchHooks Function({bool seriesInfoRefs})> {
  $$ExerciseInfoTableTableManager(
      _$ScheduleFitDatabase db, $ExerciseInfoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String> nomeEsercizio = const Value.absent(),
            Value<String> categoriaEsercizio = const Value.absent(),
            Value<String> immagine = const Value.absent(),
            Value<int> serieTotali = const Value.absent(),
            Value<int> serieCompletate = const Value.absent(),
            Value<List<int>> giorniSettimana = const Value.absent(),
            Value<DateTime> data = const Value.absent(),
          }) =>
              ExerciseInfoCompanion(
            id: id,
            nomeEsercizio: nomeEsercizio,
            categoriaEsercizio: categoriaEsercizio,
            immagine: immagine,
            serieTotali: serieTotali,
            serieCompletate: serieCompletate,
            giorniSettimana: giorniSettimana,
            data: data,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            required String nomeEsercizio,
            required String categoriaEsercizio,
            required String immagine,
            Value<int> serieTotali = const Value.absent(),
            Value<int> serieCompletate = const Value.absent(),
            required List<int> giorniSettimana,
            Value<DateTime> data = const Value.absent(),
          }) =>
              ExerciseInfoCompanion.insert(
            id: id,
            nomeEsercizio: nomeEsercizio,
            categoriaEsercizio: categoriaEsercizio,
            immagine: immagine,
            serieTotali: serieTotali,
            serieCompletate: serieCompletate,
            giorniSettimana: giorniSettimana,
            data: data,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExerciseInfoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({seriesInfoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (seriesInfoRefs) db.seriesInfo],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (seriesInfoRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ExerciseInfoTableReferences
                            ._seriesInfoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExerciseInfoTableReferences(db, table, p0)
                                .seriesInfoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idEsercizio == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExerciseInfoTableProcessedTableManager = ProcessedTableManager<
    _$ScheduleFitDatabase,
    $ExerciseInfoTable,
    ExerciseInfoData,
    $$ExerciseInfoTableFilterComposer,
    $$ExerciseInfoTableOrderingComposer,
    $$ExerciseInfoTableAnnotationComposer,
    $$ExerciseInfoTableCreateCompanionBuilder,
    $$ExerciseInfoTableUpdateCompanionBuilder,
    (ExerciseInfoData, $$ExerciseInfoTableReferences),
    ExerciseInfoData,
    PrefetchHooks Function({bool seriesInfoRefs})>;
typedef $$SeriesInfoTableCreateCompanionBuilder = SeriesInfoCompanion Function({
  Value<int?> id,
  Value<int?> idEsercizio,
  Value<int> ripetizioni,
  Value<double> peso,
  required String unitaMisura,
  Value<bool> completata,
});
typedef $$SeriesInfoTableUpdateCompanionBuilder = SeriesInfoCompanion Function({
  Value<int?> id,
  Value<int?> idEsercizio,
  Value<int> ripetizioni,
  Value<double> peso,
  Value<String> unitaMisura,
  Value<bool> completata,
});

final class $$SeriesInfoTableReferences extends BaseReferences<
    _$ScheduleFitDatabase, $SeriesInfoTable, SeriesInfoData> {
  $$SeriesInfoTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExerciseInfoTable _idEsercizioTable(_$ScheduleFitDatabase db) =>
      db.exerciseInfo.createAlias(
          $_aliasNameGenerator(db.seriesInfo.idEsercizio, db.exerciseInfo.id));

  $$ExerciseInfoTableProcessedTableManager? get idEsercizio {
    if ($_item.idEsercizio == null) return null;
    final manager = $$ExerciseInfoTableTableManager($_db, $_db.exerciseInfo)
        .filter((f) => f.id($_item.idEsercizio!));
    final item = $_typedResult.readTableOrNull(_idEsercizioTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SeriesInfoTableFilterComposer
    extends Composer<_$ScheduleFitDatabase, $SeriesInfoTable> {
  $$SeriesInfoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ripetizioni => $composableBuilder(
      column: $table.ripetizioni, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get peso => $composableBuilder(
      column: $table.peso, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitaMisura => $composableBuilder(
      column: $table.unitaMisura, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completata => $composableBuilder(
      column: $table.completata, builder: (column) => ColumnFilters(column));

  $$ExerciseInfoTableFilterComposer get idEsercizio {
    final $$ExerciseInfoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idEsercizio,
        referencedTable: $db.exerciseInfo,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseInfoTableFilterComposer(
              $db: $db,
              $table: $db.exerciseInfo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SeriesInfoTableOrderingComposer
    extends Composer<_$ScheduleFitDatabase, $SeriesInfoTable> {
  $$SeriesInfoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ripetizioni => $composableBuilder(
      column: $table.ripetizioni, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get peso => $composableBuilder(
      column: $table.peso, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitaMisura => $composableBuilder(
      column: $table.unitaMisura, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completata => $composableBuilder(
      column: $table.completata, builder: (column) => ColumnOrderings(column));

  $$ExerciseInfoTableOrderingComposer get idEsercizio {
    final $$ExerciseInfoTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idEsercizio,
        referencedTable: $db.exerciseInfo,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseInfoTableOrderingComposer(
              $db: $db,
              $table: $db.exerciseInfo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SeriesInfoTableAnnotationComposer
    extends Composer<_$ScheduleFitDatabase, $SeriesInfoTable> {
  $$SeriesInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ripetizioni => $composableBuilder(
      column: $table.ripetizioni, builder: (column) => column);

  GeneratedColumn<double> get peso =>
      $composableBuilder(column: $table.peso, builder: (column) => column);

  GeneratedColumn<String> get unitaMisura => $composableBuilder(
      column: $table.unitaMisura, builder: (column) => column);

  GeneratedColumn<bool> get completata => $composableBuilder(
      column: $table.completata, builder: (column) => column);

  $$ExerciseInfoTableAnnotationComposer get idEsercizio {
    final $$ExerciseInfoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idEsercizio,
        referencedTable: $db.exerciseInfo,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseInfoTableAnnotationComposer(
              $db: $db,
              $table: $db.exerciseInfo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SeriesInfoTableTableManager extends RootTableManager<
    _$ScheduleFitDatabase,
    $SeriesInfoTable,
    SeriesInfoData,
    $$SeriesInfoTableFilterComposer,
    $$SeriesInfoTableOrderingComposer,
    $$SeriesInfoTableAnnotationComposer,
    $$SeriesInfoTableCreateCompanionBuilder,
    $$SeriesInfoTableUpdateCompanionBuilder,
    (SeriesInfoData, $$SeriesInfoTableReferences),
    SeriesInfoData,
    PrefetchHooks Function({bool idEsercizio})> {
  $$SeriesInfoTableTableManager(
      _$ScheduleFitDatabase db, $SeriesInfoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeriesInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeriesInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeriesInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<int?> idEsercizio = const Value.absent(),
            Value<int> ripetizioni = const Value.absent(),
            Value<double> peso = const Value.absent(),
            Value<String> unitaMisura = const Value.absent(),
            Value<bool> completata = const Value.absent(),
          }) =>
              SeriesInfoCompanion(
            id: id,
            idEsercizio: idEsercizio,
            ripetizioni: ripetizioni,
            peso: peso,
            unitaMisura: unitaMisura,
            completata: completata,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<int?> idEsercizio = const Value.absent(),
            Value<int> ripetizioni = const Value.absent(),
            Value<double> peso = const Value.absent(),
            required String unitaMisura,
            Value<bool> completata = const Value.absent(),
          }) =>
              SeriesInfoCompanion.insert(
            id: id,
            idEsercizio: idEsercizio,
            ripetizioni: ripetizioni,
            peso: peso,
            unitaMisura: unitaMisura,
            completata: completata,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SeriesInfoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({idEsercizio = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idEsercizio) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idEsercizio,
                    referencedTable:
                        $$SeriesInfoTableReferences._idEsercizioTable(db),
                    referencedColumn:
                        $$SeriesInfoTableReferences._idEsercizioTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SeriesInfoTableProcessedTableManager = ProcessedTableManager<
    _$ScheduleFitDatabase,
    $SeriesInfoTable,
    SeriesInfoData,
    $$SeriesInfoTableFilterComposer,
    $$SeriesInfoTableOrderingComposer,
    $$SeriesInfoTableAnnotationComposer,
    $$SeriesInfoTableCreateCompanionBuilder,
    $$SeriesInfoTableUpdateCompanionBuilder,
    (SeriesInfoData, $$SeriesInfoTableReferences),
    SeriesInfoData,
    PrefetchHooks Function({bool idEsercizio})>;

class $ScheduleFitDatabaseManager {
  final _$ScheduleFitDatabase _db;
  $ScheduleFitDatabaseManager(this._db);
  $$ExerciseInfoTableTableManager get exerciseInfo =>
      $$ExerciseInfoTableTableManager(_db, _db.exerciseInfo);
  $$SeriesInfoTableTableManager get seriesInfo =>
      $$SeriesInfoTableTableManager(_db, _db.seriesInfo);
}
