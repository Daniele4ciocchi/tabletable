import 'package:flutter/material.dart';

import '../../data/models/prenotazione.dart';

/// Apre la schermata di aggiunta e restituisce la [Prenotazione] inserita,
/// oppure `null` se l'utente torna indietro senza confermare.
Future<Prenotazione?> apriSchermataAggiungi(
  BuildContext context, {
  DateTime? initialDate,
}) {
  return Navigator.push<Prenotazione>(
    context,
    MaterialPageRoute(
      builder: (_) => PrenotazioneFormScreen(initialDate: initialDate),
    ),
  );
}

/// Apre la schermata di modifica e restituisce la [Prenotazione] modificata,
/// oppure `null` se l'utente torna indietro senza confermare.
Future<Prenotazione?> apriSchermataModifica(
  BuildContext context,
  Prenotazione prenotazione,
) {
  return Navigator.push<Prenotazione>(
    context,
    MaterialPageRoute(
      builder: (_) => PrenotazioneFormScreen(prenotazione: prenotazione),
    ),
  );
}

/// Schermata unificata per aggiungere o modificare una prenotazione.
///
/// Se [prenotazione] è `null` si è in modalità aggiunta; altrimenti modifica.
class PrenotazioneFormScreen extends StatefulWidget {
  final Prenotazione? prenotazione;
  final DateTime? initialDate;

  const PrenotazioneFormScreen({
    super.key,
    this.prenotazione,
    this.initialDate,
  });

  @override
  State<PrenotazioneFormScreen> createState() => _PrenotazioneFormScreenState();
}

class _PrenotazioneFormScreenState extends State<PrenotazioneFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _personeController = TextEditingController();
  final _dettagliController = TextEditingController();
  final _telefonoController = TextEditingController();
  late DateTime _dataOra;

  final List<TimeOfDay> _orariPredefiniti = [
    const TimeOfDay(hour: 19, minute: 30),
    const TimeOfDay(hour: 20, minute: 0),
    const TimeOfDay(hour: 20, minute: 30),
    const TimeOfDay(hour: 21, minute: 0),
    const TimeOfDay(hour: 21, minute: 30),
    const TimeOfDay(hour: 22, minute: 0),
  ];

  bool get _isModifica => widget.prenotazione != null;

  @override
  void initState() {
    super.initState();
    final p = widget.prenotazione;
    _nomeController.text = p?.nome ?? '';
    _personeController.text = p?.numeroPersone.toString() ?? '';
    _dettagliController.text = p?.dettagli ?? '';
    _telefonoController.text = p?.telefono ?? '';
    _dataOra = p?.dataOra ?? widget.initialDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _personeController.dispose();
    _dettagliController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _conferma() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      Prenotazione(
        id: widget.prenotazione?.id,
        nome: _nomeController.text.trim(),
        numeroPersone: int.parse(_personeController.text.trim()),
        dettagli: _dettagliController.text.trim(),
        telefono: _telefonoController.text.trim(),
        dataOra: _dataOra,
      ),
    );
  }

  void _setOrario(int ore, int minuti) {
    setState(() {
      _dataOra = DateTime(
        _dataOra.year,
        _dataOra.month,
        _dataOra.day,
        ore,
        minuti,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isModifica ? 'Modifica prenotazione' : 'Nuova prenotazione',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Inserisci un nome'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _personeController,
                decoration: const InputDecoration(
                  labelText: 'Numero persone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v?.trim() ?? '');
                  if (n == null || n <= 0) return 'Inserisci un numero valido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Telefono',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dettagliController,
                decoration: const InputDecoration(
                  labelText: 'Dettagli',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Data: '),
                  TextButton(
                    onPressed: () async {
                      final scelto = await showDatePicker(
                        context: context,
                        initialDate: _dataOra,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (scelto != null) {
                        setState(() {
                          _dataOra = DateTime(
                            scelto.year,
                            scelto.month,
                            scelto.day,
                            _dataOra.hour,
                            _dataOra.minute,
                          );
                        });
                      }
                    },
                    child: Text(
                      '${_dataOra.day}/${_dataOra.month}/${_dataOra.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Orario: '),
                  TextButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_dataOra),
                      );
                      if (time != null) {
                        setState(() {
                          _dataOra = DateTime(
                            _dataOra.year,
                            _dataOra.month,
                            _dataOra.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    },
                    child: Text(
                      '${_dataOra.hour.toString().padLeft(2, '0')}:${_dataOra.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _orariPredefiniti.map((p) {
                  return InputChip(
                    label: Text(
                      '${p.hour.toString().padLeft(2, '0')}:${p.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    onPressed: () => _setOrario(p.hour, p.minute),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: _conferma,
                child: Text(_isModifica ? 'Salva' : 'Aggiungi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
