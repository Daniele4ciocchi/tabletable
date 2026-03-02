import 'package:hive_flutter/hive_flutter.dart';

import '../models/prenotazione.dart';

class PrenotazioniRepository {
  static const _kBoxName = 'prenotazioni';

  static final PrenotazioniRepository instance = PrenotazioniRepository._();
  PrenotazioniRepository._();

  Box<Map>? _box;

  Future<void> init() async {
    _box = await Hive.openBox<Map>(_kBoxName);
  }

  Future<int> create(Prenotazione p) => _box!.add(p.toMap());

  List<Prenotazione> readAll() {
    final prenotazioni = <Prenotazione>[];

    for (final id in _box!.keys.cast<int>()) {
      final dati = Map<String, dynamic>.from(_box!.get(id)!);
      prenotazioni.add(
        Prenotazione(
          id: id,
          nome: dati['nome'] as String,
          numeroPersone: dati['numeroPersone'] as int,
          dataOra: DateTime.parse(dati['dataOra'] as String),
        ),
      );
    }

    prenotazioni.sort((a, b) => a.dataOra.compareTo(b.dataOra));
    return prenotazioni;
  }

  Future<void> delete(int id) => _box!.delete(id);
}
