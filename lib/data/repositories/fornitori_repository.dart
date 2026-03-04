import 'package:hive_flutter/hive_flutter.dart';

import '../models/fornitore.dart';

class FornitoriRepository {
  static const _kBoxName = 'fornitori';

  static final FornitoriRepository instance = FornitoriRepository._();
  FornitoriRepository._();

  Box<Map>? _box;

  Future<void> init() async {
    _box = await Hive.openBox<Map>(_kBoxName);
  }

  Future<int> create(Fornitore f) => _box!.add(f.toMap());

  List<Fornitore> readAll() {
    final fornitori = <Fornitore>[];

    for (final id in _box!.keys.cast<int>()) {
      final raw = _box!.get(id);
      if (raw == null) continue;
      try {
        final dati = Map<String, dynamic>.from(raw);
        fornitori.add(
          Fornitore(
            id: id,
            nome: dati['nome'] as String,
            descrizione: dati['descrizione'] as String,
            telefono: dati['telefono'] as String,
          ),
        );
      } catch (_) {
        continue;
      }
    }

    fornitori.sort((a, b) => a.nome.compareTo(b.nome));
    return fornitori;
  }

  Fornitore? read(int id) {
    final dati = _box!.get(id);
    if (dati == null) return null;

    return Fornitore(
      id: id,
      nome: dati['nome'] as String,
      descrizione: dati['descrizione'] as String,
      telefono: dati['telefono'] as String,
    );
  }

  Future<void> update(Fornitore f) => _box!.put(f.id!, f.toMap());

  Future<void> delete(int id) => _box!.delete(id);
}
