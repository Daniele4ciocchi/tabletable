import 'package:flutter/material.dart';
import 'package:tabletable/presentation/widgets/customTimePicker.dart';

import '../../data/models/prenotazione.dart';

class ModificaPrenotazioneScreen extends StatefulWidget {
  final Prenotazione? prenotazione;

  const ModificaPrenotazioneScreen({super.key, this.prenotazione});

  @override
  State<ModificaPrenotazioneScreen> createState() =>
      _ModificaPrenotazioneScreenState();
}

class _ModificaPrenotazioneScreenState
    extends State<ModificaPrenotazioneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _personeController = TextEditingController();
  final _dettagliController = TextEditingController();
  late DateTime _dataOra;

  @override
  void initState() {
    super.initState();
    final p = widget.prenotazione;
    _nomeController.text = p?.nome ?? '';
    _personeController.text = p?.numeroPersone.toString() ?? '';
    _dettagliController.text = p?.dettagli ?? '';
    _dataOra = p?.dataOra ?? DateTime.now();
  }

  @override
  void dispose() {
    _dettagliController.dispose();
    _nomeController.dispose();
    _personeController.dispose();
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
        dataOra: _dataOra,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifica prenotazione')),
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
                controller: _dettagliController,
                decoration: const InputDecoration(
                  labelText: 'Dettagli',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Orario: '),
                  // mostra data e ora e inserisci un pulsante per aprire il time picker
                  TextButton(
                    onPressed: () async {
                      final time = await showDialog<TimeOfDay>(
                        context: context,
                        builder: (_) => CustomTimePickerDialog(
                          initialTime: TimeOfDay.fromDateTime(_dataOra),
                          onTimeSelected: (t) => Navigator.pop(context, t),
                        ),
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
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _conferma, child: const Text('Salva')),
            ],
          ),
        ),
      ),
    );
  }
}
