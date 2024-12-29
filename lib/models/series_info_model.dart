class SeriesInfoModel {
  int? id;
  int? idEsercizio;
  int ripetizioni;
  double peso;
  String unitaMisura;
  bool completata;

  SeriesInfoModel(
      {this.id,
      this.idEsercizio,
      required this.ripetizioni,
      required this.peso,
      required this.unitaMisura,
      required this.completata});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idEsercizio': idEsercizio,
      'ripetizioni': ripetizioni,
      'peso': peso,
      'unitaMisura': unitaMisura,
      'completata': completata
    };
  }

  factory SeriesInfoModel.fromMap(Map<String, dynamic> map) {
    return SeriesInfoModel(
        id: map['id'],
        idEsercizio: map['idEsercizio'],
        ripetizioni: map['ripetizioni'],
        peso: map['peso'],
        unitaMisura: map['unitaMisura'],
        completata: map['completata'] == 1);
  }
}
