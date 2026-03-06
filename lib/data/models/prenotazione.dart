class Prenotazione {
  static int _copertiTotali = 20;

  int? id;
  String nome;
  int numeroPersone;
  String dettagli;
  String telefono;
  DateTime dataOra;

  Prenotazione({
    this.id,
    required this.nome,
    required this.numeroPersone,
    this.dettagli = '',
    this.telefono = '',
    required this.dataOra,
  });

  Map<String, dynamic> toMap() => {
    'nome': nome,
    'numeroPersone': numeroPersone,
    'dettagli': dettagli,
    'telefono': telefono,
    'dataOra': dataOra.toIso8601String(),
  };

  static set copertiTotali(int value) {
    _copertiTotali = value;
  }

  static get copertiTotali => _copertiTotali;
}
