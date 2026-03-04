import 'package:tabletable/data/models/fornitore.dart';

class Spesa {
  int? id;
  Fornitore? fornitore;
  String alimento;
  String dettagli;
  double? prezzo;
  DateTime dataOra;

  Spesa({
    this.id,
    this.fornitore,
    required this.alimento,
    this.dettagli = '',
    this.prezzo,
    required this.dataOra,
  });

  Map<String, dynamic> toMap() => {
    'fornitoreId': fornitore?.id,
    'alimento': alimento,
    'dettagli': dettagli,
    'prezzo': prezzo,
    'dataOra': dataOra.toIso8601String(),
  };
}
