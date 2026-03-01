class Prenotazione {
  int? id; // id autoincrement nel DB
  String nome;
  int numeroPersone;
  DateTime dataOra;

  Prenotazione({
    this.id,
    required this.nome,
    required this.numeroPersone,
    required this.dataOra,
  });

  // Converti in Map per inserimento nel DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'numeroPersone': numeroPersone,
      'dataOra': dataOra.toIso8601String(),
    };
  }

  // Crea oggetto dalla mappa del DB
  factory Prenotazione.fromMap(Map<String, dynamic> map) {
    return Prenotazione(
      id: map['id'],
      nome: map['nome'],
      numeroPersone: map['numeroPersone'],
      dataOra: DateTime.parse(map['dataOra']),
    );
  }
}
