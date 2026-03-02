class Prenotazione {
  final int? id;
  final String nome;
  final int numeroPersone;
  final String dettagli;
  final DateTime dataOra;

  const Prenotazione({
    this.id,
    required this.nome,
    required this.numeroPersone,
    this.dettagli = '',
    required this.dataOra,
  });

  Map<String, dynamic> toMap() => {
    'nome': nome,
    'numeroPersone': numeroPersone,
    'dettagli': dettagli,
    'dataOra': dataOra.toIso8601String(),
  };
}
