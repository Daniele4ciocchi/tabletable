class Food {
  int? id;
  String nome;
  int numeroPersone;
  String dettagli;
  DateTime dataOra;

  Food({
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
