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

    // Primo passaggio: carica tutte le prenotazioni senza rimpiazzo
    for (final id in _box!.keys.cast<int>()) {
      final dati = Map<String, dynamic>.from(_box!.get(id)!);
      prenotazioni.add(
        Prenotazione(
          id: id,
          nome: dati['nome'] as String,
          numeroPersone: dati['numeroPersone'] as int,
          dettagli: dati['dettagli'] as String? ?? '',
          telefono: dati['telefono'] as String? ?? '',
          dataOra: DateTime.parse(dati['dataOra'] as String),
        ),
      );
    }

    // Secondo passaggio: collega rimpiazzo per ID
    for (final p in prenotazioni) {
      final dati = Map<String, dynamic>.from(_box!.get(p.id)!);
      final rimpiazzoId = dati['rimpiazzoId'];
      if (rimpiazzoId != null) {
        p.rimpiazzo = prenotazioni
            .where((r) => r.id == (rimpiazzoId as int))
            .firstOrNull;
      }
    }

    prenotazioni.sort((a, b) => a.dataOra.compareTo(b.dataOra));
    return prenotazioni;
  }

  /// Restituisce solo le prenotazioni di oggi.
  /// Stesso pattern di readAll(), ma con un filtro sulla data.
  List<Prenotazione> readToday() {
    final oggi = DateTime.now();
    return readAll().where((p) {
      return p.dataOra.year == oggi.year &&
          p.dataOra.month == oggi.month &&
          p.dataOra.day == oggi.day;
    }).toList();
  }

  List<Prenotazione> readForDate(DateTime data) {
    return readAll().where((p) {
      return p.dataOra.year == data.year &&
          p.dataOra.month == data.month &&
          p.dataOra.day == data.day;
    }).toList();
  }

  Future<void> update(Prenotazione p) => _box!.put(p.id, p.toMap());

  Future<void> delete(int id) => _box!.delete(id);
}
