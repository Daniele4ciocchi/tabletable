class Fornitore {
  int? id;
  String nome;
  String descrizione;
  String telefono;

  Fornitore({
    this.id,
    required this.nome,
    required this.descrizione,
    required this.telefono,
  });

  Map<String, dynamic> toMap() => {
    'nome': nome,
    'descrizione': descrizione,
    'telefono': telefono,
  };
}
