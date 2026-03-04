import 'package:hive_flutter/hive_flutter.dart';

import '../models/spesa.dart';
import 'fornitori_repository.dart';

class SpesaRepository {
  static const _kBoxName = 'spese';

  static final SpesaRepository instance = SpesaRepository._();
  SpesaRepository._();

  Box<Map>? _box;

  Future<void> init() async {
    _box = await Hive.openBox<Map>(_kBoxName);
  }

  Future<int> create(Spesa s) => _box!.add(s.toMap());

  List<Spesa> readAll() {
    final spese = <Spesa>[];

    for (final id in _box!.keys.cast<int>()) {
      final dati = Map<String, dynamic>.from(_box!.get(id)!);
      spese.add(
        Spesa(
          id: id,
          fornitore: dati['fornitoreId'] != null
              ? FornitoriRepository.instance.read(dati['fornitoreId'] as int)
              : null,
          alimento: dati['alimento'] as String,
          dettagli: dati['dettagli'] as String? ?? '',
          dataOra: DateTime.parse(dati['dataOra'] as String),
        ),
      );
    }

    spese.sort((a, b) => a.dataOra.compareTo(b.dataOra));
    return spese;
  }

  List<Spesa> readForFornitore(int fornitoreId) {
    return readAll().where((s) => s.fornitore?.id == fornitoreId).toList();
  }

  List<Spesa> readForDate(DateTime data) {
    return readAll().where((s) {
      return s.dataOra.year == data.year &&
          s.dataOra.month == data.month &&
          s.dataOra.day == data.day;
    }).toList();
  }

  Future<void> update(Spesa s) => _box!.put(s.id!, s.toMap());

  Future<void> delete(int id) => _box!.delete(id);
}
