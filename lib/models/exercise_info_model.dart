class ExerciseInfoModel {
  int? id;
  String nomeEsercizio;
  String categoriaEsercizio;
  String immagine;
  int serieTotali;
  int serieCompletate;

  ExerciseInfoModel(
      {this.id,
      required this.nomeEsercizio,
      required this.categoriaEsercizio,
      required this.immagine,
      required this.serieTotali,
      required this.serieCompletate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeEsercizio': nomeEsercizio,
      'immagine': immagine,
      'categoriaEsercizio': categoriaEsercizio,
      'serieTotali': serieTotali,
      'serieCompletate': serieCompletate,
    };
  }

  factory ExerciseInfoModel.fromMap(Map<String, dynamic> map) {
    return ExerciseInfoModel(
      id: map['id'],
      nomeEsercizio: map['nomeEsercizio'],
      immagine: map['immagine'],
      categoriaEsercizio: map['categoriaEsercizio'],
      serieTotali: map['serieTotali'],
      serieCompletate: map['serieCompletate'],
    );
  }
}
