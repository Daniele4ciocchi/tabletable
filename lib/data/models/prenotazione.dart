class Prenotazione {
  int? id;
  String nome;
  int numeroPersone;
  String dettagli;
  String telefono;
  Prenotazione? rimpiazzo;
  DateTime dataOra;

  Prenotazione({
    this.id,
    required this.nome,
    required this.numeroPersone,
    this.dettagli = '',
    this.telefono = '',
    this.rimpiazzo,
    required this.dataOra,
  });

  Map<String, dynamic> toMap() => {
    'nome': nome,
    'numeroPersone': numeroPersone,
    'dettagli': dettagli,
    'telefono': telefono,
    'dataOra': dataOra.toIso8601String(),
    'rimpiazzoId': rimpiazzo?.id,
  };
}
